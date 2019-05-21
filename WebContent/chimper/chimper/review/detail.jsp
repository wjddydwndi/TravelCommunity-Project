<%@page import="com.tour.model.bulletin.domain.BulletinMember"%>
<%@page import="com.tour.model.review.domain.Good"%>
<%@page import="com.tour.model.review.domain.Path"%>
<%@page import="com.tour.model.review.domain.Image"%>
<%@page import="java.util.List"%>
<%@page import="com.tour.model.review.domain.Review"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/chimper/chimper/commons/menuBar.jsp"%>
<%
	Review review = (Review)request.getAttribute("review");
	List imageList = review.getImage();
	List pathList = review.getPaths();
	if(member==null){
		out.print("<script>");
		out.print("alert('로그인이 필요한 페이지 입니다');");
		out.print("location.href='/chimper/chimper/index.jsp';");
		out.print("</script>");
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Chimper &mdash; Colorlib Website Template</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Quicksand:300,400,500,700,900"
	rel="stylesheet">
<link rel="stylesheet" href="/chimper/chimper/fonts/icomoon/style.css">

<link rel="stylesheet" href="/chimper/chimper/css/bootstrap.min.css">
<link rel="stylesheet" href="/chimper/chimper/css/magnific-popup.css">
<link rel="stylesheet" href="/chimper/chimper/css/jquery-ui.css">
<link rel="stylesheet" href="/chimper/chimper/css/owl.carousel.min.css">
<link rel="stylesheet"
	href="/chimper/chimper/css/owl.theme.default.min.css">

<link rel="stylesheet"
	href="/chimper/chimper/css/bootstrap-datepicker.css">

<link rel="stylesheet"
	href="/chimper/chimper/fonts/flaticon/font/flaticon.css">

<link rel="stylesheet" href="/chimper/chimper/css/aos.css">

<link rel="stylesheet" href="/chimper/chimper/css/style.css">
<link type="text/css" rel="stylesheet" href="/static/css/reviewMap.css"/>
<link type="text/css" rel="stylesheet" href="/static/css/reviewImage.css"/>
<link type="text/css" rel="stylesheet" href="/static/css/reviewContent.css"/>
<link type="text/css" rel="stylesheet" href="/static/css/reviewComment.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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


		



		<div class="site-blocks-cover inner-page-cover overlay"
			style="background-image: url(/chimper/chimper/images/contact.png);"
			data-aos="fade" data-stellar-background-ratio="0.5">
			<div class="container">
				<div
					class="row align-items-center justify-content-center text-center">

					<div class="col-md-12" data-aos="fade-up" data-aos-delay="400">

						<div class="row justify-content-center mb-4">
							<div class="col-md-8 text-center">
								<h1>여행 후기 게시판</h1>
								<p class="lead mb-5">당신의 여행 이야기를 들려주세요</p>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>



		<div class="site-section bg-light">
			<div class="container">
				<div class="row">

					<h3>글 제목 : <%= review.getReview_title() %></h3>

<div id="googleMap" style="width:100%;height:400px;"></div>

<h3 style="text-align:center">나의 여행 사진들</h3>

<div class="container">
 
 <%for(int i =0; i<imageList.size(); i++){ %>
 <% Image image = (Image)imageList.get(i); %>
  <div class="mySlides">
    <div class="numbertext"><%=(i+1)%>/<%=imageList.size() %></div>
    <img src="/chimper/chimper/uploadFile/<%= image.getFile_name() %>" style="width:600px; height:400px;">
  </div>
  <%} %>
    
  <a class="prev" onclick="plusSlides(-1)">❮</a>
  <a class="next" onclick="plusSlides(1)">❯</a>

  <div class="row">
	 <%for(int i =0; i<imageList.size(); i++){ %>
	 <% Image image = (Image)imageList.get(i); %>
	  <div class="column">
	    <img class="demo cursor"  src="/chimper/chimper/uploadFile/<%= image.getFile_name() %>" style="width:100%" onclick="currentSlide(<%=i+1 %>)" alt="<%= review.getImage().get(i).getFile_name() %>">
	  </div>
	<%} %>
  </div>
</div>
<script src="/static/js/reviewImage.js"></script>

<div class="container">
  <form name="review-area">
  	<input type="hidden" name="review_id" value=<%= review.getReview_id() %>>
    <label for="fname">작성자 : </label>
    <input type="text" name="member.member_id" style="width:150px" value="<%=review.getMember().getMember_name()%>">
    <label for="lname">작성 날짜 : </label>
    <input type="text" name="review_title" style="width:150px" value="<%= review.getReview_regdate().substring(0, 10) %>"><br>

    <label for="subject">내용</label>
    <textarea id="subject" name="review_content" style="height:500px"><%= review.getReview_content() %></textarea>

	<label>좋아요 수 : </label>
	<input type="text" name="review_good" style="width:100px"><br>
    <input type="button" value="목록" onClick="location.href='/review/list'">
    <% if(member.getMember_id() == review.getMember().getMember_id()) {%>
    <input type="button" value="수정" onClick="editReview(<%= review.getReview_id() %>)">
    <input type="button" value="삭제" onClick="delReview(<%= review.getReview_id() %>)">
    <%}else{ %>
    <div class="good-area">
    </div>
    <%} %>
  </form>
  <hr>
  <div>
  <form name="regist-area">
  	<input type="hidden" name="review.review_id" value=<%= review.getReview_id() %>>
  	<input type="hidden" name="member.member_id" value=<%= member.getMember_id() %>>
  	<input type="text" name="review_comment_content" placeholder="댓글 입력" style="width:80%">
  	<input type="button" name="commentRegist" value="등록">
  </form>
  </div>
</div>
<div class="comment-area">
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
var replyPlay = false;
//비동기로 코멘트 요청하기
$(function(){
	commentList(1);
	getGood();
	$($("input[name='commentRegist']")).click(function(){ //댓글 등록 버튼
		
		commentRegist();
	});
});

//이 글의 댓글 목록 전체 가져오기
function commentList(currentPage){
	
	$.ajax({
		url:"/review_comments/"+<%= review.getReview_id()%>,
		type:"get",
		data:{
			"review.review_id":<%= review.getReview_id()%>
		},
		success:function(result){
			result.pager.currentPage = currentPage;
			renderList(result.review_commentList, result.pager);
		},
		error:function(result){
		}
	});
}

//이 글의 좋아요 수 가져오기
function getGood(){
	var count = 0;
	var good = null;
	$.ajax({
		url:"/review/good/"+<%= review.getReview_id()%>,
		type:"get",
		success:function(goodList){
			for(var i = 0; i<goodList.length; i++){
				if(<%= member.getMember_id()%> == goodList[i].member.member_id){
					good = goodList[i];
					count++;
				}
			}
			if(count != 0){
				$(".good-area").html("");
				$(".good-area").append("<input type='hidden' value='"+good.good_id+"'>");
				$(".good-area").append("<input type='button' value='좋아요 취소' onClick='delGood("+good.good_id+")'>");	
			}else{
				$(".good-area").html("");
				$(".good-area").append("<input type='button' value='좋아요' onClick='addGood()'>");
			}
			$("input[name='review_good']").val(goodList.length);
		},
		error:function(result){
		}
	});
}


var googleMap;
var myCenter;
var map;

//구글맵
function myMap() {
	googleMap = document.getElementById("googleMap");
	myCenter = new google.maps.LatLng(37.701277, 127.015684); //대한민국
	var mapProp= {
	  center:myCenter,
	  zoom:5,
	};
	//맵 등장
	map = new google.maps.Map(googleMap,mapProp);

	//마커 등장
	<%for(int i=0; i < pathList.size(); i++){%>
		<%Path path = (Path)pathList.get(i);%>
			var marker = new google.maps.Marker({
				position : new google.maps.LatLng(<%= path.getLati()%>, <%= path.getLongi()%>),
				id : <%= path.getPath_id()%>
			});
			marker.setMap(map);				
	<%}%>
}



//댓글 목록을 화면에 출력하기
function renderList(review_commentList, pager){
	$(".comment-area").html("");
	$(".comment-area").append("<table width='100%' border='1'>");
	$(".comment-area").append("<tr>");
	$(".comment-area").append("<th style='width:20%'>작성자</th>");
	$(".comment-area").append("<th style='width:40%'>댓글 내용</th>");
	$(".comment-area").append("<th style='width:20%'>작성일</th>");
	$(".comment-area").append("<th style='width:20%'></th>");
	$(".comment-area").append("</tr>");

	var curPos = (pager.currentPage-1)*pager.pageSize;
	var num =pager.totalRecord-curPos;
	for(var i=0; i<pager.pageSize; i++){
		if(num<1) break;
		var obj = review_commentList[curPos++];
		$(".comment-area").append("<tr>");
		if(obj.member.member_id == <%= review.getMember().getMember_id()%>){
			$(".comment-area").append("<td class='comment-unit' style='width:20%'>"+obj.member.member_name+"<b> [작성자]</b></td>");
		}else{
			$(".comment-area").append("<td class='comment-unit' style='width:20%'>"+obj.member.member_name+"</td>");
		}
		$(".comment-area").append("<td style='width:40%'>"+obj.review_comment_content+"</td>");
		$(".comment-area").append("<td style='width:20%'>"+obj.review_comment_regdate.substring(0,10)+"</td>");
		if(obj.member.member_id == <%=member.getMember_id()%>){
			$(".comment-area").append("<td style='width:20%'><button name='editComment' id='"+obj.review_comment_id+"' type='button' onClick='getComment("+obj.review_comment_id+")'>수정</button><button type='button' onClick='commentDel("+obj.review_comment_id+")'>삭제</button></td>");
		}
		$(".comment-area").append("</tr>");	
		num--;
	}
	$(".comment-area").append("<tr>");
	$(".comment-area").append("<td colspan='4' align='center'>");
	if(pager.firstPage-1>0){
		  $(".comment-area").append("<a href='javascript:getCommentList("+pager.firstPage-1+")'>◀</a>");
	   }else{
		  $(".comment-area").append("<a href='javascript:alert(\"첫번째 페이지입니다\")'>◀</a>");
	   }
	for(var i=pager.firstPage; i<=pager.lastPage; i++){
		if(i>pager.totalPage) break;
		$(".comment-area").append("<a href='javascript:commentList("+i+")'>["+i+"]</a>");
		
	}
	if(pager.lastPage+1<pager.totalpage){
		$(".comment-area").append("<a href='javascript:getCommentList("+pager.lastPage+1+")'>▶</a>");
	}else{
		$(".comment-area").append("<a href='javascript:alert(\"마지막 페이지입니다\")'>▶</a>");
	}
	$(".comment-area").append("</td>");
	$(".comment-area").append("</tr>");
	
	$(".comment-area").append("</table>");

}

//댓글 등록
function commentRegist(){
	//alert("댓글 등록 버튼 클릭");
	$.ajax({
		url:"/rest/review_comments",
		type:"post",
		data:{
			"review.review_id":$($("form[name='regist-area']").find("input[name='review.review_id']")).val(),
			"member.member_id":$($("form[name='regist-area']").find("input[name='member.member_id']")).val(),
			review_comment_content:$($("form[name='regist-area']").find("input[name='review_comment_content']")).val()	
		},
		success:function(result){
			commentList(1);
			$("form[name='regist-area']").trigger("reset");
		},
		error:function(result){
		}
	});
}

//댓글 수정(비동기)
function commentEdit(review_comment_id){
	if(!confirm("정말로 수정하시겠습니까?")){
		return;
	}
	var content = prompt("수정할 댓글을 작성해주세요.");
	$.ajax({
		url:"/rest/review_comments",
		type:"POST",
		data:{
			_method : "PUT",
			review_comment_id:review_comment_id,
			review_comment_content:content
		},
		success:function(result){
			if(result.resultCode == 1){
				alert("수정 되었습니다.");
				commentList(1);
			}  
		},
		error:function(result){
		}
	}); 
}

//댓글 한건 가져오기
function getComment(review_comment_id){
	$.ajax({
		url:"/review_comment/"+review_comment_id,
		type:"GET",
		success:function(json){
			commentEdit(json.review_comment_id);
		},
		error:function(result){
		}
	});
}

//댓글 삭제(비동기)
function commentDel(review_comment_id){
	if(!confirm("정말로 삭제하시겠습니까?")){
		return;
	}
	$.ajax({
		url:"/review_comments/"+review_comment_id,
		type:"DELETE",
		success:function(result){
			if(result.resultCode == 1){
				alert("삭제 되었습니다.");
				commentList(1);
			}
		},
		error:function(result){
		}
	});
}

//[좋아요] 증가시키기
function addGood(){
	$.ajax({
		url:"/rest/review/good",
		type:"POST",
		data:{
			"member.member_id" : <%= member.getMember_id()%>,
			"review.review_id" : <%= review.getReview_id()%>
		},
		success:function(json){
			if(json.resultCode==1){
				getGood();
			}
		},
		error:function(result){
		}
	});
}

//[좋아요] 삭제시키기
function delGood(good_id){
	if(!confirm("이글의 좋아요를 취소하시겠습니까?")){
		return;
	}
	$.ajax({
		url:"/rest/review/good/"+good_id,
		type:"DELETE",
		success:function(result){
			if(result.resultCode == 1){
				getGood();
			}
		},
		error:function(result){
		}
	});
}

//이 글 전체를 수정하기
function editReview(review_id){
	//alert("수정 버튼 클릭");
	location.href="/review/edit?review_id="+review_id;
}

//이글 전체를 삭제하기 -> 동기로 진행, 삭제 후 목록으로 이동
function delReview(review_id){
	//alert(review_id+"번 글 삭제 버튼 클릭");
	location.href="/review/delete?review_id="+review_id;
}

</script>

<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>
<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCxIHZ8_HXr7g0SJnLdknYfFgMsmBv2V2A&callback=myMap">
</script>
</body>
</html>