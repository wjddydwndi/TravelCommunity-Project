<%@page import="com.tour.model.bulletin.domain.BulletinMember"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<style>
.topnav {	
  margin : auto;
  width:60%;
  overflow: hidden;
  background-color: white;
}

.topnav a {
  float: left;
  color: black;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav a:hover {
  background-color: #ddd;
  color: dodgerblue;
}

.topnav a.active {
  background-color: dodgerblue;
  color: black;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<div class="topnav">
	<!-- 컴포넌트 중복 제거 2019-05-09 남학선 -->
  <!--<a class="active" href="#home">Home</a>  --> 
  <a href="/board/list">list</a>
  <a href="/chimper/chimper/bulletin/regist.jsp">regist</a>
<%--   <%if(request.getSession().getAttribute("member")==null){ %>
  <a href="/admin/login/loginForm.jsp">login</a>
<%}else{ %>
<a href="/admin/login/logout.jsp">logout</a>
<%} %> --%>
</div>
