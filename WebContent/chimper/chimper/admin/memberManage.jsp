<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/chimper/chimper/admin/memberForm.jsp" %>
<% 
	List<BulletinMember> memberList = (List<BulletinMember>)request.getAttribute("memberList");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Chimper &mdash; Colorlib Website Template</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Quicksand:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="/chimper/chimper/fonts/icomoon/style.css">

    <link rel="stylesheet" href="/chimper/chimper/css/bootstrap.min.css">
    <link rel="stylesheet" href="/chimper/chimper/css/magnific-popup.css">
    <link rel="stylesheet" href="/chimper/chimper/css/jquery-ui.css">
    <link rel="stylesheet" href="/chimper/chimper/css/owl.carousel.min.css">
    <link rel="stylesheet" href="/chimper/chimper/css/owl.theme.default.min.css">

    <link rel="stylesheet" href="/chimper/chimper/css/bootstrap-datepicker.css">

    <link rel="stylesheet" href="/chimper/chimper/fonts/flaticon/font/flaticon.css">

    <link rel="stylesheet" href="/chimper/chimper/css/aos.css">

    <link rel="stylesheet" href="/chimper/chimper/css/style.css">
    
  </head>
  <body>
  
  <div class="site-wrap">

    <div class="site-mobile-menu">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
          <span class="icon-close2 js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div>
   
     
    <%@ include file="/chimper/chimper/commons/menuBar.jsp" %>

  

    <div class="site-blocks-cover inner-page-cover overlay" style="background-image: url(/chimper/chimper/images/gallary.png);" data-aos="fade" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row align-items-center justify-content-center text-center">

          <div class="col-md-12" data-aos="fade-up" data-aos-delay="400">                        
            <div class="row justify-content-center mb-4">
              <div class="col-md-8 text-center">
                <h1>회원 관리</h1>
                <p class="lead mb-5">회원등급과 권한을 설정합니다.</p>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>  


    
    <section class="site-section">
      
      <div class="container">
      <h3>* 전체 회원수 : <%=memberList.size() %></h3><br>
        <div class="row">
        <%for(int i=0; i<memberList.size(); i++){ %>
        <%BulletinMember getMember = memberList.get(i); %>
          <div class="col-md-6 col-lg-4 mb-4" name="member" onClick="memberWindow('<%=getMember.getMember_id()%>')">
            <a href="#" class="media-1">
              <img src="/chimper/chimper/images/rion.jpg" width="400px" alt="Image" class="img-fluid" >
              <div class="media-1-content">
                <h2>* 회원 ID : <%=getMember.getId() %></h2>
                <span class="category">* 회원 이름 : <%=getMember.getMember_name() %></span>
              </div>
            </a>
          </div>
		<%} %>
        </div>
      </div>
    </section>
    
    
     <%@ include file="/chimper/chimper/commons/footer.jsp" %>
  </div>

  <script src="/chimper/chimper/js/jquery-3.3.1.min.js"></script>
  <script src="/chimper/chimper/js/jquery-migrate-3.0.1.min.js"></script>
  <script src="/chimper/chimper/js/jquery-ui.js"></script>
  <script src="/chimper/chimper/js/popper.min.js"></script>
  <script src="/chimper/chimper/js/bootstrap.min.js"></script>
  <script src="/chimper/chimper/js/owl.carousel.min.js"></script>
  <script src="/chimper/chimper/js/jquery.stellar.min.js"></script>
  <script src="/chimper/chimper/js/jquery.countdown.min.js"></script>
  <script src="/chimper/chimper/js/jquery.magnific-popup.min.js"></script>
  <script src="/chimper/chimper/js/bootstrap-datepicker.min.js"></script>
  <script src="/chimper/chimper/js/aos.js"></script>

  <script src="/chimper/chimper/js/main.js"></script>
  <script>
	function memberWindow(member_id){
		//alert("선택한 회원 : "+member_id);
		//비동기로 member 한 회원의 정보 가져오기
		$.ajax({
			url:"/member",
			type:"get",
			data:{
				"member_id":member_id
			},
			success:function(result){
				//alert(result);
				var json = JSON.parse(result);
				//alert(json.pass);

				document.getElementById("id01").style.display="block"; 
				$("input[name='member_id']").val(json.member_id);
				$("input[name='id']").val(json.id);
				$("input[name='pass']").val(json.pass);
				$("input[name='member_name']").val(json.member_name);
				$("input[name='email']").val(json.email);
				$("select[name='member_level_id']").val(json.member_level_id);
				var member_level_id = $("select[name='member_level_id']").val();
				//alert(member_level_id);
				if(member_level_id=="1"){
					//alert("manager 입니다");
					$("select[name='member_level_id']").val("1").attr("selected", true);
				}else if(member_level_id=="0"){
					//alert("일반 회원입니다.");
					$("select[name='member_level_id']").val("0").attr("selected", true);
				}
				
			}
		});
		
	}
  </script>
    
  </body>
</html>