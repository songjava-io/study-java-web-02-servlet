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
		<div class="card text-center">
		  <div class="card-header">
		    ${board.boardSeq}
		  </div>
		  <div class="card-body">
		    <h5 class="card-title">${board.title}</h5>
		    <p class="card-text">${board.contents}</p>
		  </div>
		  <div class="card-footer text-muted">
		    ${board.regDate}
		  </div>
		</div>		
		<div class="mt-2">
			<a href="/board/list" class="btn btn-primary">목록</a>
			
			<a href="/board/form?boardSeq=${board.boardSeq}"
				 class="btn btn-secondary">편집</a>
				 
			<a href="/board/delete?boardSeq=${board.boardSeq}"
				 class="btn  btn-danger">삭제</a>
		</div> 
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	</body>
</html>