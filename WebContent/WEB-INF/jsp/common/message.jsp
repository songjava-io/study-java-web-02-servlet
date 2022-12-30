<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		// 성공실패에 대한 값을 set
		var success = ${success};
		var nextUrl = '${nextUrl}';
		var message = '${message}';
		if (success) {
			alert(message);
			location.href = nextUrl;
		} else {
			alert(message);
			history.back(-1);
		}
	</script>
</body>
</html>