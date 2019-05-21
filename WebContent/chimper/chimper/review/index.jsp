<%@page import="java.util.List"%>
<%@ page import="com.tour.model.review.domain.Review"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<style>
table {
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
	border: 1px solid #ddd;
}

th, td {
	text-align: left;
	padding: 16px;
}

tr:nth-child(even) {
	background-color: #f2f2f2
}
		input[type=button]{
			background-color: dodgerblue;
			color: white;
			padding: 14px 20px;
			margin: 10px 0px 0px 0px;
			border: none;
			cursor: pointer;
			width: 10%;
		}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	getList();
});

//비동기 review 목록 요청
function getList(){
	$.ajax({
		url:"/reviews",
		type:"get",
		success:function(result){

		}
	});
}

//동기로 상세페이지 요청하기
function getDetail(review_id){
	location.href="/review/detail?review_id="+review_id;

}
//글쓰기 페이지 요청
function goWrite(){
	location.href="/client/write.jsp";
}
</script>
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


		<%@ include file="/chimper/chimper/commons/menuBar.jsp"%>



		<div class="site-blocks-cover inner-page-cover overlay"
			style="background-image: url(/chimper/chimper/images/review.jpg);"
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

					<form style="width: 100%">
						<h2>게시물 목록</h2>
						<p></p>
						<div class="list-area"></div>
						<table>
							<tr>
								<th>No</th>
								<th>글 제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>

							<c:set var="curPos" value="${pager.curPos}" />
							<c:set var="num" value="${pager.num}" />
							<c:forEach var="review" items="${reviewList}"
								begin="${pager.curPos}" end="${pager.curPos+pager.pageSize-1}">
								<tr onClick="getDetail(${review.review_id})"
									onMouseOver="this.style.background='pink'; this.style.cursor='pointer';"
									onMouseOut="this.style.background=''">
									<td>${num}</td>
									<td>${review.review_title} [ ${commentCountArray[pager.totalRecord-num]} ]</td>
									<td>${review.member.member_name}</td>
									<td>${review.review_regdate.substring(0,10)}</td>
									<td>${review.review_hit}</td>
									<c:set var="num" value="${num-1}" />
								</tr>
							</c:forEach>
							<tr>
								<td colspan="5" align="center"><c:if
										test="${pager.firstPage-1>0}">
										<a href="/review/list?currentPage=${pager.firstPage-1}"> ◀
										</a>
									</c:if> <c:if test="${pager.firstPage==1}">
										<a href="javascript:alert('첫번째 페이지입니다.');"> ◀ </a>
									</c:if> <c:forEach begin="${pager.firstPage}" end="${pager.lastPage}"
										var="i">
										<c:if test="${i<=pager.totalPage}">
											<a href="/review/list?currentPage=${i}">[${i}]</a>
										</c:if>
									</c:forEach> <c:if test="${pager.lastPage<pager.totalPage}">
										<a href="/review/list?currentPage=${pager.lastPage+1}"> ▶
										</a>
									</c:if> <c:if test="${pager.lastPage+1>pager.totalPage}">
										<a href="javascript:alert('마지막 페이지입니다.');"> ▶ </a>
									</c:if></td>
							</tr>
						</table>
						<input type="button" onClick="goWrite()" value="글 쓰기">
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
			getList();
		});
		
		//비동기 review 목록 요청
		function getList(){
			$.ajax({
				url:"/reviews",
				type:"get",
				success:function(result){
		
				}
			});
		}
		
		//동기로 상세페이지 요청하기
		function getDetail(review_id){
			location.href="/review/detail?review_id="+review_id;
		
		}
		//글쓰기 페이지 요청
		function goWrite(){
			location.href="/chimper/chimper/review/write.jsp";
		}
	</script>
</body>
</html>