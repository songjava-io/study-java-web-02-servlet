<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	</head>
	<body>
		<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
<%
	// 현재 페이지에 들어올 때 파라메터의 값을 boardSeq 변수에 담음.
	String boardSeq = request.getParameter("boardSeq");
	String title = "";
	String contents = "";
	// 파라메터 필수 체크 값이 없으면 뒤로가기 처리.
	if (boardSeq != null && !boardSeq.isEmpty()) {
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
			while (rs.next()) {
				title = rs.getString("TITLE");
				contents = rs.getString("CONTENTS");
			}
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
	}

%>			
		<form action="/board/save.jsp" method="post">
			<input type="hidden" name="boardSeq" 
				value="<%=boardSeq%>" />
			<div class="mb-3">
				<label for="title" class="form-label">제목</label>
				<input type="text" class="form-control"
					name="title" id="title" value="<%=title%>" placeholder="게시글의 제목">
			</div>
			<div class="mb-3">
				<label for="contents" class="form-label">내용</label>
				<textarea class="form-control" 
					name="contents" 
					id="contents"
					rows="3"><%=contents%></textarea>
			</div>
			<button type="submit" class="btn btn-primary">등록하기</button>
		</form>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	</body>
</html>