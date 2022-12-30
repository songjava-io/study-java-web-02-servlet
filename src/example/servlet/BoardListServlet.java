package example.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import example.domain.Board;
import example.domain.User;
import example.service.BoardService;

public class BoardListServlet extends HttpServlet {

	private static final long serialVersionUID = -9206316189905969040L;
	
	private BoardService boardService = new BoardService();
	
	@Override
	protected void doGet(HttpServletRequest req, 
		HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			User loginUser = (User) req.getSession().getAttribute("LOGIN_USER");
			
			if (loginUser != null) {
				System.out.println("loginUserName : " + loginUser.getUserName());
			}
			
			// 검색조건 파라메터
			String query = req.getParameter("query");
			
			Map<String, Object> paramMap = new HashMap<>();
			
			paramMap.put("query", query);
			
			// 서비스를 호출해서 게시물 목록을 리턴 받
			List<Board> boardList = boardService.selectBoardList(paramMap);
			
			// reuqest에 boardList 키에 boardList 변수의 값을 저장 (set)
			req.setAttribute("boardList", boardList);
			// 게시물 목록 jsp를 호출하면서 req, resp 보낸다.
			req.getRequestDispatcher("/WEB-INF/jsp/board/list.jsp")
			.forward(req, resp);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
