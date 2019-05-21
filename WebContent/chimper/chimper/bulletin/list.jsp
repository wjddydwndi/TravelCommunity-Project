<%@page import="com.tour.model.bulletin.domain.BulletinBoard"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List<BulletinBoard> bulletinBoardList=(List)request.getAttribute("bulletinBoardList");

%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="/chimper/chimper/commons/menuBar.jsp" %>
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
#tableWrapper{
 margin-left: 400px;

}
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 70%;
  border: 1px solid #ddd;
  text-align: center;
}

th, td {
  text-align: left;
  padding: 16px;
}

tr:nth-child(even) {
  background-color: #f2f2f2
}
button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 150px;
}
button:hover {
  opacity: 0.8;
}
a:link {
  text-decoration: none;
}

a:link {
  color: black;
}
/* visited link */
a:visited {
  color: black;
}

/* mouse over link */
a:hover {
  color: hotpink;
}

/* selected link */
a:active {
  color: black;
}
</style>

<script>
function getDetail(bulletin_board_id){
	$("form").attr({
		method:"get",
		action:"/board/detail?bulletin_board_id="+bulletin_board_id
	});
	$("form").submit;
}
</script>
</head>
<body>
<p/>
    <div class="site-blocks-cover inner-page-cover overlay" style="background-image: url(/chimper/chimper/images/bulletin.PNG);" data-aos="fade" data-stellar-background-ratio="0.5">
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
<form>
<div id="tableWrapper">
<p/>
<h2>게시글 목록</h2>
<table>
  <tr>
    <th>No</th>
    <th style="width: 10%">말머리</th>
    <th style="width: 50%">제목</th>
    <th>작성자</th>
    <th>작성일</th>
    <th>조회수</th>
  </tr>
  <c:set var="curPos" value="${pager.curPos}"/>
  <c:set var="num" value="${pager.num}"/>
  <c:forEach var="board" items="${bulletinBoardList}" begin="${curPos}" end="${curPos+pager.pageSize-1}">
  <tr>
    <td>${num}</td>
    <td>${board.head.name}</td>
    <td><a href="/board/detail?bulletin_board_id=${board.bulletin_board_id}">${board.bulletin_title}[${commentCountArray[pager.totalRecord-num]}]</a></td>
    <td>${board.member.member_name}</td>
    <td>${board.bulletin_regdate}</td>
    <td>${board.bulletin_hit}</td>
  <c:set var="num" value="${num-1}"/>  
  </tr>
	</c:forEach>
	<tr>
		<td colspan="6" align="center">
		<c:if test="${pager.firstPage-1>0}">
			<a href="/board/list?currentPage=${pager.firstPage-1}">
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
				<a href="/board/list?currentPage=${i}">[${i}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${pager.lastPage<pager.totalPage}">
			<a href="/board/list?currentPage=${pager.lastPage+1}">
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
<!-- 불필요 컴포넌트 제거 2019-05-09 남학선 -->
<!-- <button onclick="location.href='/board/regist/regist.jsp'">등록하기</button> -->
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
