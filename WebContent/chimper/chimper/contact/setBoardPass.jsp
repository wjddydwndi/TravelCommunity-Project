<%@page import="com.tour.common.board.ReviewPager"%>
<%@page import="com.tour.model.domain.QnABoard"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<% 
	QnABoard qnaBoard = (QnABoard)request.getAttribute("qnaBoard");
	request.getSession().setAttribute("qnaBoard", qnaBoard);
	System.out.println("가져온 게시물 : "+qnaBoard.getQnaBoard_title());
	int qnaBoard_id = qnaBoard.getQnaBoard_id();
	System.out.println("비공개글 게시물 id : "+qnaBoard_id);
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
     <style>
		input[type=text], input[type=password] {
		  width: 50%;
		  padding: 12px 20px;
		  margin: 10px 0px 0px 0px;
		  display: inline-block;
		  border: 1px solid #ccc;
		  box-sizing: border-box;
		}
		
		input[type=button] {
		  background-color: dodgerblue;
		  color: white;
		  padding: 14px 20px;
		  margin: 10px 0px 0px 0px;
		  border: none;
		  cursor: pointer;
		  width: 50%;
		}
	</style>
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
  

    <div class="site-blocks-cover inner-page-cover overlay" style="background-image: url(/chimper/chimper/images/contact.png);" data-aos="fade" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row align-items-center justify-content-center text-center">

          <div class="col-md-12" data-aos="fade-up" data-aos-delay="400">
                        
            <div class="row justify-content-center mb-4">
              <div class="col-md-8 text-center">
                <h1>고객 센터</h1>
                <p class="lead mb-5">관리자에게 질문을 남기세요</p>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>  


    
    <div class="site-section bg-light">
      <div class="container">
        <div class="row" style="text-align:center;">
            <form name="confirmPassForm" style="width:100%">
				  <h2 class="title">비공개글 암호 설정</h2><br>
				  <h5>암호를 입력하세요..</h5>
				  	<input type="hidden" name="qnaBoard_id" value="<%=qnaBoard_id%>"/>
				    <input type="password" placeholder="Enter Password" name="privacy_pass" style="width:50%" required><br>
				    <input type="button" value="확인"/><br>
				    <input type="button" value="취소"/>
            </form>
        </div>
      </div>
    </div>

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
	$(function(){
		$($("input[type='button']")[0]).click(function(){
			setPass();
		});
		$($("input[type='button']")[1]).click(function(){
			goBack();
		});
		
	});

	function setPass(){
		$("form[name='confirmPassForm']").attr({
			action:"/QnABoardPrivacyPass",
			method:"post"
		});
		$("form[name='confirmPassForm']").submit();
	}

	function goBack(){
		history.back();
	}
</script>
    
  </body>
</html>