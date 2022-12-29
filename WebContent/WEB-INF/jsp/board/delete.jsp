<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 현재 페이지에 들어올 때 파라메터의 값을 boardSeq 변수에 담음.
	String boardSeq = request.getParameter("boardSeq");
	// 파라메터 필수 체크 값이 없으면 뒤로가기 처리.
	if (boardSeq == null || boardSeq.isEmpty()) {
		out.println("<script>");
		out.println("alert('게시물 번호가 없습니다.');");
		out.println("history.back(-1);");
		out.println("</script>");
		return;
	}
	// DB에 접속을 하고 위에 내용을 저장하는 소스 구현
	Connection connection = null;
	ResultSet rs = null;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		// 데이터베이스 접속을 위한 정보 set
		String jdbcUrl = "jdbc:mysql://localhost:3306/profile";
		// db설치시 기입한 접속정보 set
		String user = "root";
		String password = "1234";
		// db 접속 커넥션을 획득
		connection = DriverManager.getConnection(jdbcUrl, user, password);
		String sql = "SELECT BOARD_SEQ, TITLE, CONTENTS, REG_DATE FROM T_BOARD " + 
			"WHERE BOARD_SEQ = " + boardSeq;
		// DB 커넥션 소스를 구현해야되요.
		Statement stmt = connection.createStatement();
		rs = stmt.executeQuery(sql);
		boolean delete = false;
		while (rs.next()) {
			delete = true;
		}
		// 삭제대상인경우
		if (delete) {
			String deleteSql = "DELETE FROM T_BOARD WHERE BOARD_SEQ = " + boardSeq;
			Statement stmt2 = connection.createStatement();
			int result = stmt2.executeUpdate(deleteSql);
			if (result == 0) {
				// 삭제가안된경우
				out.println("<script>");
				out.println("alert('게시물 삭제를 실패하였습니다.');");
				out.println("history.back(-1);");
				out.println("</script>");
			} else {
				// 삭제가된경우
				out.println("<script>");
				out.println("alert('게시물 삭제가 성공하였습니다.');");
				out.println("location.href = '/board/list.jsp';");
				out.println("</script>");
			}
			stmt2.close();
		}
%>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			// ResultSet 연결을 종료
			if (rs != null) {
				rs.close();
			}
			// db 커넥션 연결을 종료
			if (connection != null) {
				connection.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>