<%@page import="com.tour.common.board.ReviewPager"%>
<%@page import="com.tour.common.board.Pager"%>
<%@page import="com.tour.model.domain.QnABoard"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/textForm.jsp" %>

<%
	
	QnABoard qnaBoard = (QnABoard)request.getAttribute("qnaBoard");
	//request.getSession().setAttribute("qnaBoard", qnaBoard);
	
	System.out.println("detail.jsp : 가져온 qnaBoard : "+qnaBoard);
	System.out.println(qnaBoard.getAnswerState());
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
		  width: 10%;
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
        <div class="row">

              
              <div name="detailContainer" style="width:100%">
					<h2>글 상세보기</h2>
					<div class="container" style="width:100%; padding:30px;" >
					  <form name="detailForm" style="width:100%">
					  	<input type="hidden" name="qnaBoard_id" value="<%=qnaBoard.getQnaBoard_id() %>"/>
					  	<input type="hidden" name="qnaBoard_privacy_id" value="<%=qnaBoard.getQnaBoard_privacy_id() %>"/>
					  	<input type="hidden" name="qnaBoard_id" value="<%=qnaBoard.getQnaBoard_id() %>"/>
					  	<label><b>  글 제목</b></label>
					    <input type="text" name="qnaBoard_title" placeholder="Insert Title.." value="<%=qnaBoard.getQnaBoard_title()%>" readonly>
					    <label><b>  작성자</b></label>
					    <input type="text" name="qnaBoard_writer" placeholder="Writer..." value="<%=qnaBoard.getQnaBoard_writer()%>" readonly/>
					    <label><b>  작성일</b></label>
					    <input type="text" name="qnaBoard_regdate" value="<%=qnaBoard.getQnaBoard_regdate()%>" readonly/>
					    <label><b>  조회수</b></label>
					    <input type="text" name="qnaBoard_hit" value="<%=qnaBoard.getQnaBoard_hit()%>" readonly/>
					    <textarea id="content" name="qnaBoard_content" style="height:200px" readonly><%=qnaBoard.getQnaBoard_content() %></textarea>
						
						<input type="button" name="bt_goList" value="글 목록">
						<%if(member != null){ %>
							<%if(member.getId().equals(qnaBoard.getQnaBoard_writer())){ %>
							    <input type="button" name="bt_edit" value="글 수정">
							    <input type="button" name="bt_delete" value="글 삭제">
						    <%}else if(member.getMemberLevel().getMember_level_id()==2){ %>
						    	<input type="button" name="bt_delete" value="글 삭제">
						    <%} %>
					  	<%} %>
					    
					    
					  </form>
					 </div>
					<div name="container2">
					<%if(member!=null){ %>
					   <%if(member.getMemberLevel().getMember_level_id()==1 || member.getMemberLevel().getMember_level_id()==2){ %>
					   		<%if(qnaBoard.getQnaBoard_type_id().equals("2")){ %>
						   		<%if(qnaBoard.getAnswerState()==null){ %>
								  <!-- 답글관련 Form Tag -->
								  <!-- ======================================================================= -->
								  <form name="answerForm" style="width:100%; padding:30px;">
								  	<h3>▶ 답변글 입력</h3>
								  	<input type="hidden" name="qnaBoard_id" value="<%=qnaBoard.getQnaBoard_id() %>"/>
								  	<input type="text" name="answer_writer" value="<%=member.getMemberLevel().getMember_level()%>" readonly/>
								  	<textarea name="answer_content" placeholder="답변글 입력..." style="height:200px; width:100%"></textarea><br>
								  	<input type="button" name="bt_registAnswer" value="답변 등록">
								  </form>
								  <!-- ======================================================================= -->
						  		<%}else{ %>
						  			<form name="answerForm" style="width:100%; padding:30px;">
								  		<input type="hidden" name="qnaBoard_id" value="<%=qnaBoard.getQnaBoard_id() %>"/>
								  	</form>
						  		<%} %>	
						  	<%}%>
					   		<%}else{%>
					   			<%if(qnaBoard.getQnaBoard_type_id().equals("2")){ %>
						  			<form name="answerForm" style="width:100%; padding:30px;">
								  		<input type="hidden" name="qnaBoard_id" value="<%=qnaBoard.getQnaBoard_id() %>"/>
								  	</form>
								<%} %>
						  	<%} %>
				   		<%}else{%>
				   			<%if(qnaBoard.getQnaBoard_type_id().equals("2")){ %>
					  			<form name="answerForm" style="width:100%; padding:30px;">
							  		<input type="hidden" name="qnaBoard_id" value="<%=qnaBoard.getQnaBoard_id() %>"/>
							  	</form>
						<%}%>
					<%} %>
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
	$(function(){
		<%if(qnaBoard.getAnswerState()!=null){%>
			<%if(qnaBoard.getAnswerState().equals("등록")){%>
				getAnswers();
			<%}%>
		<%}%>
		$("input[name='bt_edit']").click(function(){
			goEdit();
		});
		$("input[name='bt_delete']").click(function(){
			del();
		});
		$("input[name='bt_goList']").click(function(){
			goList();
		});
		$("input[name='bt_registAnswer']").click(function(){
			//alert("댓글 등록!");
			registAnswer();
		});
	});


	//게시글 수정 요청
	//===============================================================
	function goEdit(){
		if(!confirm("게시글을 수정하시겠습니까?")){
			return;
		}
		$("form[name='detailForm']").attr({
			"method":"post",
			"action":"/chimper/chimper/contact/editForm.jsp"
		});
		$("form[name='detailForm']").submit();
	}
	//===============================================================


	
	// 게시글 삭제 요청
	//===============================================================
	function del(){
		if(!confirm("게시글을 삭제하시겠습니까?")){
			return;
		}
		if(!confirm("삭제를 하시겠습니까?")){
			return;
		}
		$("form[name='detailForm']").attr({
			"method":"get",
			"action":"/qnaBoard/doDelete"
		});
		$("form[name='detailForm']").submit();
	}
	//===============================================================


		
		
		
		
	// 게시글 목록으로 돌아가기
	//===============================================================
	function goList(){
		location.href="/qnaBoards";
	}
	//===============================================================

		
		
		
		
	// 답변글 등록요청하기
	//===============================================================
	function registAnswer(){
		if(!confirm("답변글을 등록하시겠어요?")){
			return;
		}
		$.ajax({
			"url":"/Answer",
			"type":"post",
			"data":{
				qnaBoard_id:$($("form[name='answerForm']").find("input[name='qnaBoard_id']")).val(),
				answer_content:$($("form[name='answerForm']").find("textarea[name='answer_content']")).val(),
				answer_writer:$($("form[name='answerForm']").find("input[name='answer_writer']")).val()
			},
			success:function(result){
				var json = JSON.parse(result);
				if(json.result == 1){
					alert("답변 등록 성공!");
					getAnswers();
				}else{
					alert("답변 등록 실패!!");
				}
				
			},
			error:function(result){
				alert(result);
			}
		});
	}
	//===============================================================

		
		
		
		
	// 답변글 내용 요청하기
	//===============================================================
	function getAnswers(){
		<%if(qnaBoard.getQnaBoard_type_id().equals("2")){%>
		$.ajax({
			"url":"/Answer",
			"type":"get",
			"data":{
				"qnaBoard_id":$($("form[name='answerForm']").find("input[name='qnaBoard_id']")).val()
			},
			success:function(result){
				var json = result;
				renderAnswer(json);
			}
		});
		<%}%>	
	}
	//===============================================================
	
	
	
	
	
	// 답변글 화면처리
	//===============================================================
	function renderAnswer(json){
/* 		alert("renderAnswer() : json : "+json.answer_id);
		alert("renderAnswer() : json : "+json.qnaBoard_id);
		alert("renderAnswer() : json : "+json.answer_content);
		alert("renderAnswer() : json : "+json.answer_regdate); */

		$("form[name='answerForm']").html("");
		$("form[name='answerForm']").append("<h3 name='cTitle'>▶ 답변글</h3>");
		$("form[name='answerForm']").append("<input type='hidden' name='answer_id' value='"+json.answer_id+"'/>");
		$("form[name='answerForm']").append("<input type='hidden' name='qnaBoard_id' value='"+json.qnaBoard_id+"'/>");		
		$("form[name='answerForm']").append("<input type='text' name='answer_writer' value='"+json.answer_writer+"' readonly/>");
		$("form[name='answerForm']").append("<input type='text' name='answer_regdate' value='"+json.answer_regdate.substring(0,10)+"' readonly/>");
		$("form[name='answerForm']").append("<textarea name='answer_content' style='height:200px; width:100%;' readonly>"+json.answer_content+"</textarea><br>");
		<%if(member!=null){%>
			<%if(member.getMemberLevel().getMember_level_id()==1 || member.getMemberLevel().getMember_level_id()==2){%>
				$("form[name='answerForm']").append("<input type='button' name='bt_editAnswer' value='답변 수정' style='margin-right:10px;' onClick='renderEditAnswer()' />");	
				$("form[name='answerForm']").append("<input type='button' name='bt_deleteAnswer' value='답변 삭제' onClick='deleteAnswer()'/>");		
			<%}%>
		<%}%>
	}
	//===============================================================

		
		
		
		
	//답변글 수정 PageRender
	//===============================================================
	function renderEditAnswer(){
		$($("form[name='answerForm']").find("h3[name='cTitle']")).html("▶ 답변글 수정");
		$($("form[name='answerForm']").find("textarea[name='answer_content']")).removeAttr("readonly");
		$("input[name='bt_editAnswer']").remove();	
		$("input[name='bt_deleteAnswer']").remove();
		$("form[name='answerForm']").append("<input type='button' name='bt_editAnswerConfirm' value='수정 완료' style='margin-right:10px' onClick='editAnswer()'/>");	
		$("form[name='answerForm']").append("<input type='button' name='bt_editAnswerCancel' value='취소' onClick='getAnswers()'/>");	
	}
	//===============================================================

		
		
		
	// 답변글 수정 등록 요청
	//===============================================================
	function editAnswer(){
		if(!confirm("답변을 수정하시겠습니까?")){
			return;
		}
		$.ajax({
			url:"/doUpdateAnswer",
			type:"post",
			data:{
				answer_id:$($("form[name='answerForm']").find("input[name='answer_id']")).val(),
				answer_content:$($("form[name='answerForm']").find("textarea[name='answer_content']")).val(),
				qnaBoard_id:$($("form[name='answerForm']").find("input[name='qnaBoard_id']")).val()
			},
			success:function(result){
				var json = JSON.parse(result);
				//alert(json.result);
				if(json.result == 1){
					alert("답변글 수정 성공!");
				}else{
					alert("답변글 수정 실패!");
				}
				getAnswers();
			}
		});
	}
	//===============================================================

		
		
		
	// 답변글 삭제 요청
	//===============================================================
	function deleteAnswer(){
		if(!confirm("답변을 삭제하시겠습니까?")){
			return;
		}
		$.ajax({
			url:"/doDeleteAnswer",
			type:"post",
			data:{
				answer_id : $($("form[name='answerForm']").find("input[name='answer_id']")).val(),
				qnaBoard_id:$($("form[name='answerForm']").find("input[name='qnaBoard_id']")).val()
			},
			success:function(result){
				var json = JSON.parse(result);
				if(json.result == 1){
					alert("답변글 삭제 완료!");
					$("form[name='answerForm']").html("");
					$("form[name='answerForm']").append("<h3 name='cTitle'>▶ 답변글</h3>");
					var b=<%=qnaBoard.getQnaBoard_id()%>;
					$("form[name='answerForm']").append("<input type='hidden' name='qnaBoard_id' value='"+b+"'/>");
					<%if(member!=null){%>
						var a="<%=member.getMemberLevel().getMember_level() %>";
					<%}%>
					$("form[name='answerForm']").append("<input type='text' name='answer_writer' value='"+a+"' readonly/>");
					$("form[name='answerForm']").append("<textarea name='answer_content' style='height:200px; width:100%;' placeholder='답변 글 입력...'></textarea><br>");
					$("form[name='answerForm']").append("<input type='button' name='bt_registAnswer' value='답변 등록' onClick='registAnswer()'/>");		
				}else{
					alert("답변글 삭제 실패!");
					getAnswers();
				}
				
			}
		});
	}
	//===============================================================
</script>

    
  </body>
</html>