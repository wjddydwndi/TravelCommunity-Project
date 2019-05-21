<%@page import="com.tour.model.bulletin.domain.BulletinMember"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/chimper/chimper/commons/menuBar.jsp" %>
<% 
	if(member==null){
		out.print("<script>");
		out.print("alert('로그인이 필요한 페이지 입니다');");
		out.print("location.href='/chimper/chimper/index.jsp';");
		out.print("</script>");
	}

%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<style>
body {
  font-family: Arial, Helvetica, sans-serif;
  background-color: white;
}

* {
  box-sizing: border-box;
}

/* Add padding to containers */
.container2 {
  padding: 16px;
  background-color: white;
   text-align: center;
   margin : auto;
   border-radius: 2px;
}

/* Full-width input fields */
input[type=text], input[type=file], textarea , select{
  width: 70%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border-radius: 2px;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=file]:focus {
  background-color: #ddd;
  outline: none;
}

/* Overwrite default styles of hr */

/* Set a style for the submit button */
.regist {
  background-color: dodgerblue;
  color: white;
  padding: 16px 20px;
  margin: 8px 0;
  border-radius: 2px;
  cursor: pointer;
  width: 20%;
  opacity: 0.9;
}

.regist:hover {
  opacity: 1;
}

/* Add a blue text color to links */
a {
  color: dodgerblue;
}

/* Set a grey background color and center the text of the "sign in" section */

</style>


<script>
	$(function(){
		$(".regist").click(function(){
			boardInsert()
			
		});

		
	});
	function boardInsert(){
		$("form[name='insert']").attr({
			method:"post",
			action:"/board/regist"
			
		});
		$("form[name='insert']").submit();
	}

</script>
</head>
<body>
<p/>
    <div class="site-blocks-cover inner-page-cover overlay" style="background-image: url(/chimper/chimper/images/contact.png);" data-aos="fade" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row align-items-center justify-content-center text-center">

          <div class="col-md-12" data-aos="fade-up" data-aos-delay="400">
                        
            <div class="row justify-content-center mb-4">
              <div class="col-md-8 text-center">
                <h1>자유 게시판</h1>
                <p class="lead mb-5">자유롭게 사람들과 소통하세요</p>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>  
<p/>
<%@ include file="/bulletinInclude/top-navi.jsp" %>
<p/>

<form name="insert">
  <div class="container">

    <select name="head.head_id">
      <option value="0">말머리 선택</option>
      <option value="1">여행</option>
      <option value="2">맛집</option>
    </select>
    <p/>
    <label for="title"><b>제목</b></label>
    <p/>
    <input type="text" placeholder="제목을 입력하세요" name="bulletin_title" required>
	<p/>
	<div id="holder"></div>
    <label for="image"><b>글 내용</b></label>
    <p>
    <div class="image-container">
        <p>
        

     <p>
   </div>
	<%if(member!=null){ %>
	<input type="hidden" name="member.member_id" value="<%=member.getMember_id()%>">
 	 <%} %>
 	 <textarea id="status" name="bulletin_content" placeholder="내용" style="height:200px"></textarea>
    <p/>
    <button type="button" class="regist" onclick="boardInsert()">등록</button>
  </div>

</form>

    <%@ include file="/chimper/chimper/commons/footer.jsp" %>

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
</body>
</html>
