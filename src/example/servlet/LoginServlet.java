package example.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import example.domain.User;
import example.service.UserService;

public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = -9206316189905969040L;
	
	private UserService userService = new UserService();
	
	@Override
	protected void doGet(HttpServletRequest req, 
		HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/jsp/login.jsp")
			.forward(req, resp);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		// 한글 깨짐 방지 인코딩 설정
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		// 검증
		boolean validate = true;
		// 등록/수정 로직이 정상적으로 수행했는지 여부
		boolean success = false; 
		// 에러메세지
		String message = null;
		// null 또는 공백일 때 필수체크
		if (id == null || id.isEmpty()) {
			message = "아이디를 입력해주세요.";
			validate = false;
		}
		// null 또는 공백일 때 필수체크
		if (validate && password == null || password.isEmpty()) {
			message = "비밀번호를 입력해주세요.";
			validate = false;
		}
		// 모든 필수체크가 로직이 성공했다면..
		if (validate) {
			User user = new User();
			user.setUserId(id);
			user.setPassword(password);
			try {
				// 실제 DB에 존재하는 회원 조회
				User selectUser = userService.selectUser(user);
				// 회원이 존재하면
				if (selectUser != null) {
					// 세션에 로그인 회원 정보를 기억시킨다.
					request.getSession().setAttribute("LOGIN_USER", selectUser);
					success = true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
		String nextUrl = "/board/list";
		
		message = success ? "로그인을 성공하였습니다." : "로그인을 실패하였습니다.";
		
		request.setAttribute("message", message);
		request.setAttribute("success", success);
		request.setAttribute("nextUrl", nextUrl);
		// 성공 실패에 대한 메세지를 출력
		request.getRequestDispatcher("/WEB-INF/jsp/common/message.jsp")
			.forward(request, response);
		
		
	}

}
