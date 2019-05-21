<%@page import="com.tour.model.bulletin.domain.MemberLevel"%>
<%@page import="com.tour.model.bulletin.domain.BulletinMember"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/chimper/chimper/loginForm.jsp" %>
<%@ include file="/common/sessionCheck.jsp" %>

<%


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="/chimper/chimper/js/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		$("span[name='loginOut']").click(function(){
			loginOut();
		});
	});

	function loginOut(){
		var bt_name = $("span[name='loginOut']").text();
		if(bt_name == "로그인"){
			document.getElementById("id01").style.display="block";
		}else{
			location.href="/login/logout.jsp?buttonName="+bt_name;
		}
	}
</script>
<body>
    <div class="border-bottom top-bar py-2">
     <div class="container">
       <div class="row">
         <div class="col-md-6">
           <p class="mb-0">
             <!--<span class="mr-3"><strong>Phone:</strong> <a href="tel://#">01071299513</a></span>  -->
             <!-- <span><strong>Email:</strong> <a href="#">phh_92@naver.com</a></span> -->
           </p>
         </div>
         <div class="col-md-6">
           <ul class="social-media">
             <li><span>* 접속자 구분 : <%if((BulletinMember)request.getSession().getAttribute("member")==null){ %>손님&nbsp;&nbsp; |<%}else{%><%=member.getMemberLevel().getMember_level() %>&nbsp;&nbsp; |</span></li>
             <li><span>&nbsp;&nbsp; 반갑습니다&nbsp;&nbsp; <%=member.getId() %> 님&nbsp;&nbsp; | &nbsp;&nbsp;</span></li>
             <%} %>&nbsp;&nbsp;
             <li><a href="#"><span name="loginOut"><%if((BulletinMember)request.getSession().getAttribute("member")==null){ %>로그인<%}else{ %>로그아웃<%} %></span></a></li>
           </ul>
         </div>
       </div>
     </div> 
   </div>
   <header class="site-navbar py-4 bg-white" role="banner" style="z-index: 0;">
   
<div class="container">
 <div class="row align-items-center">
    
    <div class="col-11 col-xl-2">
      <h1 class="mb-0 site-logo"><a href="/chimper/chimper/index.jsp" class="text-black h2 mb-0">KorT</a></h1>
    </div>
    <div class="col-12 col-md-10 d-none d-xl-block">
      <nav class="site-navigation position-relative text-right" role="navigation">

        <ul class="site-menu js-clone-nav mr-auto d-none d-lg-block">
          <li class="active"><a href="/chimper/chimper/index.jsp">Home</a></li>
          <li><a href="/review/list">여행 후기</a></li>
          <li><a href="/gallerys">갤러리</a></li>
          <li><a href="/board/list">자유게시판</a></li>
          <li><a href="/qnaBoards">고객센터</a></li>
          <%if(member_level_id == 2) {%>
          <li><a href="/members">회원관리</a></li>
          <%System.out.println("member" + member); %>
          <%}else if(member_level_id == 0 || member_level_id == 1){ %>
          	<li><a href="/myBoards?member_id=<%=member.getMember_id()%>">MyPage</a></li>
          <%} %>
        </ul>
      </nav>
    </div>
      <div class="d-inline-block d-xl-none ml-md-0 mr-auto py-3" style="position: relative; top: 3px;"><a href="#" class="site-menu-toggle js-menu-toggle text-black"><span class="icon-menu h3"></span></a></div>

          </div>

        </div>
      </div>
      
    </header>
</body>
</html>