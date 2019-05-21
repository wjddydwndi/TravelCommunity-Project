<%@page import="com.tour.model.bulletin.domain.BulletinMember"%>
<%@page import="com.tour.model.review.domain.Good"%>
<%@page import="com.tour.model.review.domain.Path"%>
<%@page import="com.tour.model.review.domain.Image"%>
<%@page import="java.util.List"%>
<%@page import="com.tour.model.review.domain.Review"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	BulletinMember member = (BulletinMember)request.getSession().getAttribute("member");
	Review review = (Review)request.getAttribute("review");
	List imageList = review.getImage();
	List pathList = review.getPaths();
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title>Places Search Box</title>
<link type="text/css" rel="stylesheet" href="/static/css/reviewMap.css"/>
<link type="text/css" rel="stylesheet" href="/static/css/reviewImage.css"/>
<link type="text/css" rel="stylesheet" href="/static/css/reviewContent.css"/>
<link type="text/css" rel="stylesheet" href="/static/css/reviewComment.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var replyPlay = false;
//비동기로 코멘트 요청하기
$(function(){
	commentList();
	doDisplay();
	getGood();
	alert("넘어온 이미지 갯수 : "+<%= imageList.size()%>+"\n넘어온 path의 갯수 : "+<%= pathList.size()%>);
	$($("button[name='commentRegist']")).click(function(){ //댓글 등록 버튼
		commentRegist();
	});
});

//이 글의 댓글 목록 전체 가져오기
function commentList(){
	$.ajax({
		url:"/review_comments/"+<%= review.getReview_id()%>,
		type:"get",
		data:{
			"review.review_id":<%= review.getReview_id()%>
		},
		success:function(result){
			renderList(result);
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
				$(".good-area").append("<button type='button' onClick='delGood("+good.good_id+")'>좋아요 취소</button>");	
			}else{
				$(".good-area").html("");
				$(".good-area").append("<button type='button' onClick='addGood()'>좋아요</button>");
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
function renderList(jsonArray){
	//alert("넘어온 list의 갯수 : "+jsonArray.length);
	$(".comment-area").html("");
	$(".comment-area").append("<table width='100%' border='1'>");
	$(".comment-area").append("<tr>");
	$(".comment-area").append("<th style='width:20%'>작성자</th>");
	$(".comment-area").append("<th style='width:40%'>댓글 내용</th>");
	$(".comment-area").append("<th style='width:20%'>작성일</th>");
	$(".comment-area").append("<th style='width:20%'></th>");
	$(".comment-area").append("</tr>");
	for(var i=0; i<jsonArray.length; i++){
		var obj = jsonArray[i];
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
	}
	$(".comment-area").append("</table>");
}

//댓글 등록
function commentRegist(){
	$.ajax({
		url:"/rest/review_comments",
		type:"post",
		data:{
			"review.review_id":$($("form[name='regist-area']").find("input[name='review.review_id']")).val(),
			"member.member_id":$($("form[name='regist-area']").find("input[name='member.member_id']")).val(),
			review_comment_content:$($("form[name='regist-area']").find("input[name='review_comment_content']")).val()	
		},
		success:function(result){
			commentList();
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
				commentList();
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
				commentList();
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
	alert("수정 버튼 클릭");
	location.href="/review/edit?review_id="+review_id;
}

//이글 전체를 삭제하기 -> 동기로 진행, 삭제 후 목록으로 이동
function delReview(review_id){
	alert(review_id+"번 글 삭제 버튼 클릭");
	location.href="/review/delete?review_id="+review_id;
}

function doDisplay(){
	var reply = document.getElementById("reply");

	if(replyPlay == false){
		reply.style.display == "none";
	}
}

</script>

</head>
<body>
<h3>여행 제목 : <%= review.getReview_title() %></h3>

<div id="googleMap" style="width:100%;height:400px;"></div>

<h2 style="text-align:center">여행후기 이미지파일들!!!!!</h2>

<div class="container">
 
 <%for(int i =0; i<imageList.size(); i++){ %>
 <% Image image = (Image)imageList.get(i); %>
  <div class="mySlides">
    <div class="numbertext"><%=(i+1)%>/<%=imageList.size() %></div>
    <img src="/data/<%= image.getFile_name() %>" style="width:600px; height:400px;">
  </div>
  <%} %>
    
  <a class="prev" onclick="plusSlides(-1)">❮</a>
  <a class="next" onclick="plusSlides(1)">❯</a>

  <div class="caption-container">
    <p id="caption"></p>
  </div>

  <div class="row">
	 <%for(int i =0; i<imageList.size(); i++){ %>
	 <% Image image = (Image)imageList.get(i); %>
	  <div class="column">
	    <img class="demo cursor"  src="/data/<%= image.getFile_name() %>" style="width:100%" onclick="currentSlide(<%=i+1 %>)" alt="<%= review.getImage().get(i).getFile_name() %>">
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
    <input type="button" value="목록" onClick="location.href='/client/index.jsp'">
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
  	<button type="button" name="commentRegist">등록</button>
  </form>
  </div>
</div>
<div class="comment-area">
</div>
<table>
  <tr>
    <th>No</th>
    <th>작성자</th>
    <th>댓글 내용</th>
    <th>작성일</th>
  </tr>
  
  <c:set var="curPos" value="${pager.curPos}"/>
  <c:set var="num" value="${pager.num}"/>
	 <c:forEach var="review_comment" items="${review_commentList}" begin="${pager.curPos}" end="${pager.curPos+pager.pageSize-1}">
	    <tr onMouseOver="this.style.background='pink'; this.style.cursor='pointer';" onMouseOut="this.style.background=''">
	    <td>${num}</td>
	    <c:if test="${review.member.member_id == review_comment.member.member_id}">
	    	<td>${review_comment.member.member_name} [작성자]</td>
	    </c:if>
	    <c:if test="${review.member.member_id != review_comment.member.member_id}">
	    	<td>${review_comment.member.member_name}</td>
	    </c:if>
	    <td>${review_comment.review_comment_content}</td>
	    <td>${review_comment.review_comment_regdate.substring(0,10)}</td>
		<c:set var="num" value="${num-1}"/>  
	  	</tr>
	  	<tr><td colsplan="4"><div id="reply"></div></td></tr>
	  	<tr></tr>
  	</c:forEach>
  	<tr>
		<td colspan="4" align="center">
		<c:if test="${pager.firstPage-1>0}">
			<a href="/review/detail?currentPage=${pager.firstPage-1}">
				◀
			</a>
		</c:if>
		<c:if test="${pager.firstPage==1}">
			<a href="javascript:alert('첫번째 페이지입니다.');">
				◀
			</a>
		</c:if>	
		<c:forEach begin="${pager.firstPage}" end="${pager.lastPage}" var="i">	
			<c:if test="${i<=pager.totalPage}">		
				<a href="/review/detail?currentPage=${i}">[${i}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${pager.lastPage<pager.totalPage}">
			<a href="/review/detail?currentPage=${pager.lastPage+1}">
				▶
			</a>
		</c:if>
		<c:if test="${pager.lastPage+1>pager.totalPage}">
			<a href="javascript:alert('마지막 페이지입니다.');">
				▶
			</a>
		</c:if>	
		</td>
	</tr>
</table>

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



<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCxIHZ8_HXr7g0SJnLdknYfFgMsmBv2V2A&callback=myMap"></script>
</body>
</html>