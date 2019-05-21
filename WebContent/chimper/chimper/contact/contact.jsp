<%@page import="com.tour.common.board.Pager"%>
<%@page import="com.tour.common.board.ReviewPager"%>
<%@page import="com.tour.model.domain.QnABoard"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	Object[] objects = (Object[])request.getAttribute("objects");
	List<QnABoard> qnaBoardList = (List<QnABoard>)objects[0];
	Pager pager = (Pager)objects[1];
	System.out.println("boardList 길이 : "+qnaBoardList.size());
	System.out.println("가져온 Pager : "+pager);
	pager.init(request, qnaBoardList.size());
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
		table {
		  border-collapse: collapse;
		  border-spacing: 0;
		  width: 100%;
		  border: 1px solid #ddd;
		  margin-top:2%;
		}
		
		tr {
		  border:1px solid gray;
		}
		
		th, td {
		  text-align: left;
		  padding: 16px;
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


          <div class="d-inline-block d-xl-none ml-md-0 mr-auto py-3" style="position: relative; top: 3px;"><a href="#" class="site-menu-toggle js-menu-toggle text-black"><span class="icon-menu h3"></span></a></div>

          </div>

        </div>
      </div>
      
    </header>

  

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

            <form style="width:100%" name="qnaBoardsForm">
              
              <h2 style="margin-bottom:30px;">게시물 목록</h2> 
					* 전체 글 개수 : <%=qnaBoardList.size() %><br>
					
					<table style="width:100%">
					  <tr>
					    <th>No</th>
					    <th>글 제목</th>
					    <th>작성자</th>
					    <th>작성일</th>
					    <th>조회수</th>
					  </tr>
					  <%
					  	int num=pager.getNum();
					  	System.out.println("num" + num);
					    int curPos = pager.getCurPos();
					  
					  	for(int i=0; i<pager.getPageSize(); i++){
					  		if(num<1)break;
					  	    QnABoard qnaBoard = qnaBoardList.get(curPos++);
					  	    System.out.println("리스트에서 뽑은 qnaboard : "+qnaBoard.getQnaBoard_type_id());
					  %>
					  	<%
					  	if(qnaBoard.getQnaBoard_type_id().equals("1")){%>
						  <tr bgcolor="pink">
						    <td style="width:10%"><%=num-- %></td>
						    <td style="width:50%"><b>공지</b>&nbsp;&nbsp;&nbsp;&nbsp;<a href="/upHit?qnaBoard_id=<%=qnaBoard.getQnaBoard_id()%>"><%=qnaBoard.getQnaBoard_title() %></a></td>
						    <td style="width:15%"><%=qnaBoard.getQnaBoard_writer() %></td>
						    <td style="width:15%"><%=qnaBoard.getQnaBoard_regdate().substring(0,10)%></td>
						    <td style="width:10%"><%=qnaBoard.getQnaBoard_hit() %></td>
						  </tr>
						  <%}else{%>
						  		 <tr>
								    <td style="width:10%"><%=num-- %></td>
								    <td style="width:50%"><a href="/upHit?qnaBoard_id=<%=qnaBoard.getQnaBoard_id()%>">
								    										<%if(qnaBoard.getQnaBoard_privacy_id().equals("1")){%>
								    											<b>[비밀글]</b>  
								    										<%}%>
								    										<%if(qnaBoard.getAnswerState()!=null){ %>
									    										<%if(qnaBoard.getAnswerState().equals("등록")){%>
									    											<b>[답변완료]</b>   
									    										<%}%>
								    										<%}%>
								    										<%=qnaBoard.getQnaBoard_title() %>
								    									</a></td>
								    <td style="width:15%"><%=qnaBoard.getQnaBoard_writer() %></td>
								    <td style="width:15%"><%=qnaBoard.getQnaBoard_regdate().substring(0,10)%></td>
								    <td style="width:10%"><%=qnaBoard.getQnaBoard_hit() %></td>
								  </tr>
						  <%} %>
					  <%} %>
					  <tr>
					  	<td colspan="5" bgcolor="#f2f2f2">
						  	<%for(int i=pager.getFirstPage(); i<=pager.getLastPage(); i++){ %>
						  	<%if(i>pager.getTotalPage())break; %>
						  	<a href="/qnaBoards?currentPage=<%=i%>">[<%=i %>]</a>
						  	<%} %>
					  	</td>
					  </tr>
					  <tr>
					  	<%if(member!=null){ %>
					  	<td colspan="5"><input type="button" name="bt_regist" value="글 쓰기"/></td>
					  	<%} %>
					  </tr>
			</form>
					  <tr>
					  	<form name="searchForm">
					  		<select style="width:150px; height:52px;" name="searchMode">
					  			<option value="0">제목</option>
					  			<option value="1">제목+내용</option>
					  		</select>&nbsp;&nbsp;
					  		<input type="text" name="searchWord" placeholder="검색어 입력..." style="width:300px;"/>&nbsp;&nbsp;
					  		<input type="button" name="bt_search" value="검색"/>
					  	</form>
					  </tr>
					</table>
  
            
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
				$("input[name='bt_regist']").click(function(){
					goRegistForm();
				});
				$("input[name='bt_search']").click(function(){
					//alert("찾기!!");
					searchQnaBoard();
				});
			});
			
			function goRegistForm(){
				//alert("goRegistForm()");
				location.href="/chimper/chimper/contact/registForm.jsp";
			}

			function searchQnaBoard(){
				var searchWord = $("input[name='searchWord']").val();
				var searchMode = $("select[name='searchMode']").val();
				if(searchWord==""){
					alert("검색어를 입력해주세요!");
				}else{
					alert("검색 모드 : "+searchMode);
					alert("검색 단어 : "+searchWord);
					$("form[name='searchForm']").attr({
						action:"/searchQnaBoards",
						type:"get"
					});
					$("form[name='searchForm']").submit();
				}
			}
			
	</script>
    
  </body>
</html>