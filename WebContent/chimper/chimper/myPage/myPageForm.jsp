<%@page import="com.tour.model.review.domain.Review"%>
<%@page import="com.tour.model.gallery.domain.Gallery"%>
<%@page import="com.tour.model.bulletin.domain.BulletinBoard"%>
<%@page import="com.tour.common.board.Pager"%>
<%@page import="com.tour.model.domain.QnABoard"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Object[] objects = (Object[])request.getAttribute("objects");
	List myBoards = (List)objects[0];
	List<QnABoard> qnaBoardList = (List<QnABoard>)myBoards.get(0);
	List<BulletinBoard> bulletinBoardList = (List<BulletinBoard>)myBoards.get(1);
	List<Gallery> galleryList = (List<Gallery>)myBoards.get(2);
	List<Review> reviewList=(List<Review>)myBoards.get(3);
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
		input[type="button"] {
		  background-color: dodgerblue;
		  color: white;
		  padding: 14px 20px;
		  margin: 10px 0px;
		  border: none;
		  cursor: pointer;
		  width: 30%;
		}
		
		input[type="text"]{
			width:60%;
		}
		
	 	label{
	 		font-size:20px;
	 	}
	 	
	 	table {
	 		width:100%;
	 		border:1px solid lightgray;
	 		text-align:center;
	 		margin-bottom:30px;
	 	}
	 	
	 	
	 	tr{
	 		width:100%;
	 		border:1px solid gray;
	 		text-align:center;
	 	}
	 	
	 	td{
	 		width:10%;
	 		border:1px solid gray;
	 		text-align:center;
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
                <h1>마이 페이지</h1>
                <p class="lead mb-5">등록된 내 정보를 확인하고 수정하세요.</p>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>  


    
    <div class="site-section bg-light">
      <div class="container">
        <div class="row">

              
              <div name="MyPageContainer" style="width:100%">
					<div class="container" style="width:100%; padding:30px;" >
					<div style="width:48%;height:100%;position:float;float:left;">
					<h3>내 정보</h3>
					  <form name="myPageForm" style="width:100%; margin-top:20px;">
					  	<input type="hidden" name="member_id" value="<%=member.getMember_id() %>"/>
					  	<input type="hidden" name="member_level_id" value="<%=member.getMemberLevel().getMember_level_id() %>" />
					  	<label><b>이름</b></label>
					  	<input type="text" name="member_name" value="<%=member.getMember_name()%>" readonly/>
					  	<label><b>등급</b></label>
					  	<input type="text" name="member_level" value="<%=member.getMemberLevel().getMember_level()%>" readonly/>
					  	<label><b>ID</b></label>
					    <input type="text" name="id" value="<%=member.getId()%>" readonly>
					    <label><b>비밀번호</b></label>
					    <input type="password" name="pass" value=<%=member.getPass()%> />
					    <label><b>E-mail</b></label>
					    <input type="text" name="email" value="<%=member.getEmail()%>"/>
			
						<input type="button" name="bt_editMyInfo" value="정보 수정 하기">
						</form>
					</div>
					<div style="width:48%;height:100%;position:float;float:left;margin-left:40px;">
					<h3>내가 쓴 게시글</h3>
						<form style="width:100%; margin-top:20px;">
							<label><b>여행 후기</b></label><br>
							<table>
								<tr>
									<td>글제목</td>
									<td>작성일</td>
									<td>조회수</td>
								</tr>
								<%for(int i=0; i<reviewList.size(); i++){ %>
								<%Review review= reviewList.get(i); %>
								<tr>
									<td><a href="/review/detail?review_id=<%=review.getReview_id() %>"><%=review.getReview_title()%></a></td>
									<td><%=review.getReview_regdate().substring(0,10) %></td>
									<td><%=review.getReview_hit() %></td>
								</tr>
								<%} %>
							</table>
							<label><b>갤러리</b></label><br>
							<table>
								<tr>
									<td>글제목</td>
									<td>작성일</td>
									<td>조회수</td>
								</tr>
								<%for(int i=0; i<galleryList.size(); i++){ %>
								<%Gallery gallery = galleryList.get(i); %>
									<tr>
										<td><a href="/gallerys/<%=gallery.getGallery_id()%>"><%=gallery.getGallery_title()%></a></td>
										<td><%=gallery.getGallery_regdate().substring(0,10) %></td>
										<td><%=gallery.getGallery_hit() %></td>
									</tr>
								<%} %>
							</table>
							<label><b>자유게시판</b></label><br>
							<table>
								<tr>
									<td>글제목</td>
									<td>작성일</td>
									<td>조회수</td>
								</tr>
								<%for(int i=0; i<bulletinBoardList.size(); i++){ %>
								<%BulletinBoard bulletinBoard = bulletinBoardList.get(i); %>
									<tr>
										<td><a href="/board/detail?bulletin_board_id=<%=bulletinBoard.getBulletin_board_id()%>"><%=bulletinBoard.getBulletin_title()%></a></td>
										<td><%=bulletinBoard.getBulletin_regdate().substring(0,10) %></td>
										<td><%=bulletinBoard.getBulletin_hit() %></td>
									</tr>
								<%} %>
							</table>
							<label><b>고객센터</b></label><br>
							<table>
								<tr>
									<td>글제목</td>
									<td>작성일</td>
									<td>조회수</td>
								</tr>
								<%for(int i=0; i<qnaBoardList.size(); i++){ %>
								<%QnABoard qnaBoard = qnaBoardList.get(i); %>
									<tr>
										<td><a href="/upHit?qnaBoard_id=<%=qnaBoard.getQnaBoard_id()%>"><%=qnaBoard.getQnaBoard_title() %></a></td>
										<td><%=qnaBoard.getQnaBoard_regdate().substring(0,10) %></td>
										<td><%=qnaBoard.getQnaBoard_hit() %></td>
									</tr>
								<%} %>
							</table>
							
						</form>
					</div>
					 </div>
				</div>
 
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
	var passBefore = $($("form[name='myPageForm']").find("input[name='pass']")).val();
  
  	$(function(){
		$("input[name='bt_editMyInfo']").click(function(){
			editMyInfo();
		});
  	});

  	function editMyInfo(){
  	  	if(!confirm("수정하시겠어요?")){
			return;
  	  	}
  	  	var passNew = $($("form[name='myPageForm']").find("input[name='pass']")).val();
  	  	//alert(passBefore);
  	  	//alert(passNew);
  	  	if(passBefore != passNew){
			var passRepeat = prompt("변경할 비밀번호를 한번 더 입력해주세요.");
			if(passNew == passRepeat){
				$("form[name='myPageForm']").attr({
					action:"/editMyInfo",
					method:"post"
				});
				$("form[name='myPageForm']").submit();
			}else{
				alert("입력 비밀번호를 확인하세요!");
			}
  	  	}else{
	  	  	$("form[name='myPageForm']").attr({
				action:"/editMyInfo",
				method:"post"
			});
			$("form[name='myPageForm']").submit();
  	  	}
		
  	}	
  </script>

    
  </body>
</html>