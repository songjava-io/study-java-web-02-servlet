package example.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import example.domain.Board;
import example.service.BoardService;

public class BoardFormServlet extends HttpServlet {

	private static final long serialVersionUID = -9206316189905969040L;
	
	private BoardService boardService = new BoardService();
	
	@Override
	protected void doGet(HttpServletRequest req, 
		HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 검색조건 파라메터
			String boardSeq = req.getParameter("boardSeq");
			
			// 서비스를 호출해서 게시물 상세 정보 획득
			Board board = boardService.selectBoard(boardSeq);
			
			// reuqest에 board 키에 board 변수의 값을 저장 (set)
			
			req.setAttribute("board", board);
			
			req.getRequestDispatcher("/WEB-INF/jsp/board/form.jsp")
			
			.forward(req, resp);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		// 한글 깨짐 방지 인코딩 설정
		request.setCharacterEncoding("UTF-8");
		// 게시물 번호 변수로 받음
		String boardSeq = request.getParameter("boardSeq");
		// 제목 입력 받은 값 변수에 담음
		String title = request.getParameter("title");
		// 내용
		String contents = request.getParameter("contents");
		System.out.println("title : " + title);
		System.out.println("contents : " + contents);
		// 검증
		boolean validate = true;
		// 성공여부
		boolean save = false;
		// 등록/수정 로직이 정상적으로 수행했는지 여부
		boolean success = false; 
		// 에러메세지
		String message = null;
		// null 또는 공백일 때 필수체크
		if (title == null || title.isEmpty()) {
			message = "제목을 입력해주세요.";
			validate = false;
		}
		// null 또는 공백일 때 필수체크
		if (validate && contents == null || contents.isEmpty()) {
			message = "내용을 입력해주세요.";
			validate = false;
		}
		// 모든 필수체크가 로직이 성공했다면..
		if (validate) {
			// 실제 등록/수정 쿼리를 실행하게 로직을 구현하게된다.
			Board board = new Board();
			board.setBoardSeq(boardSeq);
			board.setTitle(title);
			board.setContents(contents);
			try {
				save = boardService.save(board);
				message = save ? "게시물이 등록되었습니다." : "게시물이 업데이트 되었습니다.";
				success = true;
			} catch (SQLException e) {
				e.printStackTrace();
				message = "게시물 저장 중 DB 오류가 발생하였습니다.";
			}
		}		
		String nextUrl = "/board/list";
		
		request.setAttribute("message", message);
		request.setAttribute("success", success);
		request.setAttribute("nextUrl", nextUrl);
		// 성공 실패에 대한 메세지를 출력
		request.getRequestDispatcher("/WEB-INF/jsp/common/message.jsp")
			.forward(request, response);
		
		
	}

}
