<%@page import="java.util.List"%>

<%@page import="com.tour.model.bulletin.domain.BulletinBoard"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% BulletinBoard board = (BulletinBoard)request.getAttribute("bulletinBoard");%>
<%@ include file="/chimper/chimper/commons/menuBar.jsp" %>
<!DOCTYPE html>
<html>

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

body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=button] {
  background-color: dodgerblue;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=button]:hover {
  background-color: dodgerblue;
}

.container2 {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
  width: 60%;
  margin : auto;
}
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
</style>

<script>
$(function(){
	getCommentList(1);
});
function getCommentList(currentPage){
	 var bulletin_board_id=$($("form").find("input[name='bulletin_board_id']")).val();
	$.ajax({
		url:"/rest/bulletinComments/"+bulletin_board_id,
		type:"get",

		success:function(result){
			//alert(result[0].bulletin_comment_id);
			result.pager.currentPage = currentPage;
			rederList(result.list,result.pager);
		},
		error:function(result){
			
		}
		
	});
}
function rederList(list,pager){
	$("#table").html("");
	var tag="";
	tag+="<tr>";
	tag+="<th>NO</th>";
	tag+="<th>작성자</th>";
	tag+="<th style='width: 50%''>댓글 내용</th>";
	tag+="<th></th>";
	tag+="<th></th>";
	tag+="<th></th>";
	tag+="</tr>";
	
	var curPos = (pager.currentPage-1)*pager.pageSize;
	var num =pager.totalRecord-curPos;
	
	for(var i=0; i<pager.pageSize; i++){
		if(num<1) break;
		var comment=list[curPos++];
		
		tag+="<tr>";
		tag+="<td name='bulletin_comment_id'>"+(num--)+"</td>";
		if(comment.member.member_id == <%= board.getMember().getMember_id()%>){
			tag+="<td style='width:20%'>"+comment.member.member_name+"<b> [작성자]</b></td>";
		}else{
			tag+="<td>"+comment.member.member_name+"</td>";
		}
		tag+="<td>"+comment.content+"</td>";
		tag+="<td>"+comment.regdate+"</td>";
		
		
		<%if(member !=null){%>
		if(comment.member.member_id==<%=member.getMember_id()%>){
			
	    	tag+="<td><input type='button' value='댓글 수정' onclick='commentEdit("+comment.bulletin_comment_id+")'></td>"
	    	tag+="<td><input type='button' value='댓글 삭제' onclick='commentDelete("+comment.bulletin_comment_id+")'></td>"
		    	
		}
		<%}%>
	    tag+="</tr>";
	
	}
	tag+="<tr>";
	tag+="<td colspan='6' align='center'>";
	if(pager.firstPage-1>0){
    	tag+="<a href='javascript:getCommentList("+pager.firstPage-1+")'>◀</a>"
    }else{
      tag+="<a href='javascript:alert(\"첫번째 페이지입니다\")'>◀</a>"
    }
	for(var i=pager.firstPage; i<=pager.lastPage; i++){
		if(i>pager.totalPage) break;
		tag+="<a href='javascript:getCommentList("+i+")'>["+i+"]</a>";
	}
    if(pager.lastPage+1<pager.totalpage){
		tag+="<a href='javascript:getCommentList("+pager.lastPage+1+")'>▶</a>"
	}else{
		tag+="<a href='javascript:alert(\"마지막 페이지입니다\")'>▶</a>"
	}
    tag+="</td>";
    tag+="</tr>";
	$("#table").append(tag);
}
function boardEdit(){
 	if(!confirm("게시글을 수정하시겠습니까???")){
		return;
	}
	$("form").attr({
		method:"post",
		action:"/board/update"
	});
	$("form").submit(); 
	
/* 	var bulletin_board_id=$($("form").find("input[name='bulletin_board_id']")).val();

	$("form").attr({
		method:"get",
		action:"/board/edit?bulletin_board_id="+bulletin_board_id
	});
	$("form").submit; */
}
function boardDelete(){
	if(!confirm("게시글을 삭제하시겠습니까???")){
		return;
	}
	$("form").attr({
		method:"post",
		action:"/board/delete"
	});
	$("form").submit();
}
function commentEdit(bulletin_comment_id){

	var comment=prompt("수정할 댓글을 작성하세요");
	$.ajax({
		url : "/rest/bulletinComments",
		type : "POST",
		data :{
			_method : "put",
			content : comment,
			bulletin_comment_id : bulletin_comment_id
		},
		success : function(result){
			var json=JSON.parse(result);
			if(json.resultCode==1){
				getCommentList(1);
				//$("#content").html("");
				$("input[name='content']").val("");
			}
		},
		error : function(result){
			
		}
	});
}
function commentDelete(bulletin_comment_id){

	if(!confirm("댓글을 삭제하시겠습니까?")){
		return;
	}
	$.ajax({
		url : "/rest/bulletinComments/"+ bulletin_comment_id,
		type :"DELETE",
		data :{
			bulletin_comment_id : bulletin_comment_id
		},
		success : function(result){
			var json=JSON.parse(result);
			if(json.resultCode==1){
				getCommentList(1);
				//$("#content").html("");
	
			}
		},
		error : function(result){
			
		}
	});
}
function commentRegist(member_id,bulletin_board_id){
	//alert(bulletin_board_id);
	if(!confirm("댓글 등록하시겠습니까???")){
		return;
	}
	$.ajax({
		url:"/rest/bulletinComments",
		type:"POST",
		data:{
			"bulletinBoard.bulletin_board_id" : bulletin_board_id,
			"member.member_id" : member_id,
			content : $("input[name='content']").val()
		},
		success : function(result){
			var json = JSON.parse(result);
			getCommentList(1);
			$("input[name='content']").val("");
		},
		error :function(result){
			
		}
	});
}
</script>
<head>

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

<div class="container2">
  <form >
    <label for="fname">글 제목</label>
    <input type="text" name="writer" placeholder="작성자" value="<%=board.getMember().getMember_name()%>">
	<input type="hidden" name="member.member_id" value="<%=board.getMember().getMember_id()%>">
    <label for="lname">작성자</label>
    <input type="text" name="bulletin_title" placeholder="제목" value="<%=board.getBulletin_title()%>">
    <input type="hidden" name="bulletin_board_id" placeholder="제목" value="<%=board.getBulletin_board_id()%>">
	<label for="cname">카테고리</label>
	<%if(board.getHead().getHead_id()==1){ %>
    <select name="head.head_id" tabindex="<%=board.getHead().getHead_id() %>">
      <option value="0">머릿말 선택</option>
      <option selected="selected" value="1">여행</option>
      <option value="2">맛집</option>
    </select>
	<%} %>
	<%if(board.getHead().getHead_id()==2){ %>
    <select name="head.head_id" tabindex="<%=board.getHead().getHead_id() %>">
      <option value="0">머릿말 선택</option>
      <option value="1">여행</option>
      <option selected="selected" value="2">맛집</option>
    </select>
	<%} %>
		<%if(board.getHead().getHead_id()==0){ %>
    <select name="head.head_id" tabindex="<%=board.getHead().getHead_id() %>">
      <option selected="selected" value="0">머릿말 선택</option>
      <option value="1">여행</option>
      <option  value="2">맛집</option>
    </select>
	<%} %>
    <label for="subject">글 내용</label>
    <textarea id="subject" name="bulletin_content" placeholder="Write something.." style="height:200px"><%=board.getBulletin_content() %></textarea>
	<%if(member!=null && board.getMember().getMember_id()==member.getMember_id()){ %>
    <input type="button" value="수정" onclick="boardEdit()">
    <input type="button" value="삭제" onclick="boardDelete()">
    <%} %>
    <input type="button" value="목록보기" onclick="location.href='/board/list'">
    <p/>
    
    <%if(member!=null){ %>
    <input type="text" id="content" name="content" placeholder="댓글 달기" style="width: 60%">
    <input type="button" name="bt_reply" value="댓글 달기" onclick="commentRegist(<%=member.getMember_id()%>,<%=board.getBulletin_board_id()%>)">
    <%} %>
    <p/>
	<h2>댓글 목록</h2>
<table id="table">

</table>



  </form>
</div>

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
