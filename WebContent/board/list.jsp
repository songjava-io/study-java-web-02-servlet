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
		<%@ include file="/common/header.jsp" %>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">등록일자</th>
				</tr>
			</thead>
			<tbody>
<%
	// 검색 키워드 파라메터
	String query = request.getParameter("query");
	//DB에 접속을 하고 위에 내용을 저장하는 소스 구현
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
		String sql = "SELECT BOARD_SEQ, TITLE, CONTENTS, REG_DATE FROM T_BOARD";
		// 검색조건 쿼리 추가
		if (query != null && !query.isEmpty()) {
			sql += " WHERE TITLE LIKE CONCAT('%', CONCAT('" + query + "', '%'))";
		}
		// DB 커넥션 소스를 구현해야되요.
		Statement stmt = connection.createStatement();
		rs = stmt.executeQuery(sql);
		int rowCount = 0;
		while (rs.next()) {
			rowCount++;
%>
		<tr>
			<th scope="row"><%=rs.getString("BOARD_SEQ") %></th>
			<td>
				<a href="/board/detail.jsp?boardSeq=<%=rs.getString("BOARD_SEQ") %>">
					<%=rs.getString("TITLE") %>
				</a>
			</td>
			<td><%=rs.getString("REG_DATE") %></td>
		</tr>
<%			
		}
		// 데이터가 없거나 키워드 검색이 결과가 존재하지 않음.
		if (rowCount == 0) {
%>
		<tr>
			<td colspan="3">게시물이 존재하지 않습니다.</td>
		</tr>

<%	
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
			</tbody>
		</table>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	</body>
</html>