package example.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import example.domain.Board;
import example.service.BoardService;

public class BoardDetailServlet extends HttpServlet {

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
			
			// 게시물 목록 jsp를 호출하면서 req, resp 보낸다.
			
			req.getRequestDispatcher("/WEB-INF/jsp/board/detail.jsp")
			
			.forward(req, resp);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
