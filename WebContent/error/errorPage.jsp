<%@ page contentType="text/html; charset=UTF-8"%>
<%RuntimeException e = (RuntimeException)request.getAttribute("error"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	alert("<%=e.getMessage()%>");
	history.back();
</script>
<body>
</body>
</html>