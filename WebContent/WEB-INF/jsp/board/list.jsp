<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	</head>
	<body>
		<%@ include file="/WEB-INF/jsp/common/header.jsp" %>
		<h2>로그인 이름 : ${sessionScope.LOGIN_USER.userName}</h2>
		<a href="/login">세션 로그인하기</a>
		<a href="/logout">세션 로그아웃</a>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">등록일자</th>
				</tr>
			</thead>
			<tbody>
				<!-- 게시물 목록을 반복 -->
				<c:forEach var="board" items="${boardList}">
				<tr>
					<th scope="row">${board.boardSeq}</th>
					<td>
						<a href="/board/detail?boardSeq=${board.boardSeq}">
							${board.title}
						</a>
					</td>
					<td>${board.regDate}</td>
				</tr>
				</c:forEach>
				<!-- 게시물 데이터가 없는경우 -->
				<c:if test="${boardList.size() == 0}">
				<tr>
					<td colspan="3">게시물이 존재하지 않습니다.</td>
				</tr>
				</c:if>
			</tbody>
		</table>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	</body>
</html>