<%@ page contentType="text/html; charset=UTF-8"%>

<%
	String buttonName = request.getParameter("buttonName");
	System.out.println(buttonName);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
<%if(buttonName.equals("로그아웃")){
	System.out.println("session 을 종료하고 Logout 합니다.");
	request.getSession().invalidate();
%>
	location.href="/chimper/chimper/index.jsp";
<%}%>
</script>
<body>

</body>
</html>