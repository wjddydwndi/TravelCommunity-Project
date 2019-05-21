<%@page import="com.tour.common.board.ReviewPager"%>
<%@page import="com.tour.model.gallery.domain.Gallery_image"%>
<%@page import="com.tour.model.gallery.domain.Gallery"%>
<%@page import="java.util.List"%>
<%@page import="com.tour.common.board.Pager"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	List galleryList =null;
	ReviewPager pager = null;
	
	
	if(request.getAttribute("galleryList")!=null && request.getAttribute("pager")!=null){
		 galleryList=(List)request.getAttribute("galleryList");
		 pager = (ReviewPager)request.getAttribute("pager");
	} 
	
	if(request.getAttribute("message")!=null){
		String message=(String)request.getAttribute("message");
		out.print("<script>");
		out.print("alert('"+message+"');");
		out.print("</script>");
	}
	
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
 var index = null;//검색 select-value

 
 $(document).ready(function(){
	 $("input[name='searchBt']").click(function(){
		 search();
	});

	$("#searchType").change(function(){
		var select = $("select option:selected").val();
		index=select;
	});
 });


/* //검색 종류 선택
function selectKey(select){
 	alert(select);

 	if(select==0){
 		index = select;
 	}else if(select==1){
 		index = select;
 	}else if(select==2){
 		index = select;
 	}else if(select==3){
 		index = select;
 	}
 
 } */

function search(){
	$("input[name='searchText']").text("");
	 
	$(".selectForm").attr({
		method:"get",
		action:"/search"
	});
	$(".selectForm").submit();
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
   
     
    <%@ include file="/chimper/chimper/commons/menuBar.jsp" %>

  

    <div class="site-blocks-cover inner-page-cover overlay" style="background-image: url(/chimper/chimper/images/gallary.png);" data-aos="fade" data-stellar-background-ratio="0.5">
      <div class="container">
        <div class="row align-items-center justify-content-center text-center">

          <div class="col-md-12" data-aos="fade-up" data-aos-delay="400">
                        
            <div class="row justify-content-center mb-4">
              <div class="col-md-8 text-center">
                <h1>Gallary</h1>
                <p class="lead mb-5">여행지에서의 모습을 보여주세요</p>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>  



    <section class="site-section">
      
      <div class="container">
        <div class="row">
        
        
<%
		int curPos = pager.getCurPos();
		int num = pager.getNum();
	
		for(int i =1; i<=pager.getPageSize(); i++){ 
			if(num<1){break;}
			Gallery gallery=(Gallery)galleryList.get(curPos++);
			Gallery_image image =(Gallery_image)gallery.getGallery_images().get(0);
			
%>
          <!-- 게시판  게시물 -->
         
          <div class="col-md-6 col-lg-4 mb-4">
            <a href="/gallerys/<%=gallery.getGallery_id()%>" class="media-1">
              <img src="/chimper/chimper/uploadFile/<%=image.getFilename() %>" style="width:90%;height:250px;" alt="Image" class="img-fluid">
              <div class="media-1-content">
              
                <h2><%=gallery.getGallery_title() %></h2>
              	<input type="hidden" value="<%=num--%>">
                <span class="category">HIT : <%=gallery.getGallery_hit() %></span><br>
                <span class="category"><%=gallery.getMember().getId()%></span>
              </div>
            </a>
          </div>
<% 	}%>
	
        </div>
  	  </div>
    </section>
	
	<table style="padding:6px;width:100%; text-align:center;">
	

		<tr>
			<td 	>
			<%if(pager.getFirstPage()-1<1){ %>
				<a href="javascript:alert('처음 페이지입니다.')">◁</a>
			<%}else{ %>
				<a href="/gallerys?currentPage=<%=pager.getFirstPage()-1%>">◁</a>
			<%} %>
			
			<%for(int i =pager.getFirstPage(); i<pager.getLastPage(); i++){ %>
				<%if(i>pager.getTotalPage()){break;} %>
					<a href="/gallerys?currentPage=<%=i %>" >
						[<%=i %>]
					</a>
				<%} %>
				
			<%if(pager.getLastPage()+1<pager.getTotalPage()) {%>
				<a href="/gallerys?currentPage=<%=pager.getLastPage()+1%>">▷</a>
			<%}else{ %>
				<a href="javascript:alert('마지막 페이지입니다.')">▷</a>	
			<%}%>
			</td>
		</tr>	

		
	</table>
	<form class="selectForm">
	   <div style="padding:6px;width:100%; text-align:center;"  >
			<select style="width:10%;height:50px;font-size:15px;align:center;" name="searchType" id="searchType" value="">
				<option value="0">선택해주세요</option>
				<option value="1">전체검색</option>
				<option value="2">글제목</option>
				<option value="3">작성자</option>
			</select>
			<input  style="width:50%;height:50px" type="text" name="searchText" placeholder="검색어를 입력해주세요" class="search"/>
			
		
			  <input type="button" style="width:10%;height:50px;font-size:15px;background:white;color:black;border:1px solid black;" name="searchBt" value="검색">
			  <input type="button" style="width:10%;height:50px;font-size:15px;background:white;color:black;border:1px solid black;" onClick="javascript:location.href='/chimper/chimper/gallery/regist.jsp'" value="글쓰기">
		</div>	
	</form>

	
    <footer class="site-footer">
      <div class="container">
        <div class="row">
          <div class="col-md-9">
            <div class="row">
              <div class="col-md-3">
                <h2 class="footer-heading mb-4">Quick Links</h2>
                <ul class="list-unstyled">
                  <li><a href="#">About Us</a></li>
                  <li><a href="#">Services</a></li>
                  <li><a href="#">Testimonials</a></li>
                  <li><a href="#">Contact Us</a></li>
                </ul>
              </div>
              <div class="col-md-3">
                <h2 class="footer-heading mb-4">Products</h2>
                <ul class="list-unstyled">
                  <li><a href="#">About Us</a></li>
                  <li><a href="#">Services</a></li>
                  <li><a href="#">Testimonials</a></li>
                  <li><a href="#">Contact Us</a></li>
                </ul>
              </div>
              <div class="col-md-3">
                <h2 class="footer-heading mb-4">Features</h2>
                <ul class="list-unstyled">
                  <li><a href="#">About Us</a></li>
                  <li><a href="#">Services</a></li>
                  <li><a href="#">Testimonials</a></li>
                  <li><a href="#">Contact Us</a></li>
                </ul>
              </div>
              <div class="col-md-3">
                <h2 class="footer-heading mb-4">Follow Us</h2>
                <a href="#" class="pl-0 pr-3"><span class="icon-facebook"></span></a>
                <a href="#" class="pl-3 pr-3"><span class="icon-twitter"></span></a>
                <a href="#" class="pl-3 pr-3"><span class="icon-instagram"></span></a>
                <a href="#" class="pl-3 pr-3"><span class="icon-linkedin"></span></a>
              </div>
            </div>
          </div>
          <div class="col-md-3">
            <h2 class="footer-heading mb-4">Subscribe Newsletter</h2>
            <form action="#" method="post">
              <div class="input-group mb-3">
                <input type="text" class="form-control border-secondary text-white bg-transparent" placeholder="Enter Email" aria-label="Enter Email" aria-describedby="button-addon2">
                <div class="input-group-append">
                  <button class="btn btn-primary text-white" type="button" id="button-addon2">Send</button>
                </div>
              </div>
            </form>
          </div>
        </div>
        <div class="row pt-5 mt-5 text-center">
          <div class="col-md-12">
            <div class="border-top pt-5">
            <p>
            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank" >Colorlib</a>
            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            </p>
            </div>
          </div>
          
        </div>
      </div>
    </footer>
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
    
  </body>
</html>