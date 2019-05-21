<%@page import="com.tour.model.gallery.domain.Gallery_image"%>
<%@page import="com.tour.model.gallery.domain.Gallery"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/chimper/chimper/commons/menuBar.jsp" %>

<%
	Gallery gallery = null;
	if(request.getAttribute("gallery")!=null){
		gallery = (Gallery)request.getAttribute("gallery");
	}
	if(member==null){
		out.print("<script>");
		out.print("alert('로그인이 필요한 페이지 입니다');");
		out.print("location.href='/chimper/chimper/index.jsp';");
		out.print("</script>");
	}
%>

<!DOCTYPE html>
<html>
<head>
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
.gallery_column img:hover {
  opacity: 1;
}

/* Clear floats after the columns */
.gallery_row:after {
  content: "";
  display: table;
  clear: both;
}
/* The expanding image container */
.gallery_container {
  position: relative;
  display: none;
}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
function myFunction(imgs) {
	  var expandImg = document.getElementById("expandedImg");
	  var imgText = document.getElementById("imgtext");
	  expandImg.src = imgs.src;
	  imgText.innerHTML = imgs.alt;
	  expandImg.parentElement.style.display = "block";
	}


$(function(){
	getComment();	
	$("button[name=''ct-bt]").click(function(){
		registComment();
	});
});

/////////////   Comment ////////////////////
function registComment(){
	$.ajax({
		url:"/comment",
		type:"post",
		data:{
			gallery_id:$("input[name='gallery_id']").val(),
			content:$("input[name='content']").val()
		},
		success:function(result){
			if(result==1){
				getComment();
			}
		}
	});
	$("input[name='content']").val("");
}

function getComment(){
	var gallery_id=$("input[name='gallery_id']").val();
	$.ajax({
		url:"/comment/"+gallery_id,
		type:"get",
		success:function(result){
			createComment(result);	
		}
	});
}

function createComment(obj){
	$(".comment-area").html("");
	
	var str="";

	for(var i = 0; i<obj.length; i++){
		var comment=obj[i];
		str+= "<div style='width:10%;float:left;margin-right:10px;'>"+comment.member.member_name+"</div>";
		str+="<div style='width:70%;float:left;margin-right:10px;' onClick='editComment("+JSON.stringify(comment)+")' id='"+comment.member.member_id+"'>"+comment.content+"</div>";
		str+="<div style='width:10%;float:left;margin-right:10px;'>"+obj[i].regdate.substring(0,10)+"</div>";	

		if(comment.member.member_id==<%=member.getMember_id()%>){
			str+="<div style='width:5px;float:left;margin-right:10px;' onClick='deleteComment("+JSON.stringify(comment)+")'>x</div>";
		}
	}
	$(".comment-area").append(str);
}


function editComment(obj){
	
	var text="";
	
	if(<%=member.getMember_id()%>==obj.member.member_id){
		text=prompt("댓글 내용을 입력해주세요");	
		alert("text = "+text,"obj.comment_id="+obj.comment_id);
		
		if(text!=null){
	 		$.ajax({
				url:"/comment",
				type:"post",
				data:{ 
					"_method":"PUT",
					comment_id:obj.comment_id,
					content:text
				},
				success:function(result){
					getComment();
				}
			});
		}
	}
}

function deleteComment(obj){
	
	var flag=false;
	var comment_id=obj.comment_id;
	
	if(<%=member.getMember_id()%>==obj.member.member_id){
		flag=confirm("정말 삭제하시겠습니까?");	
		//alert(flag);
		if(flag==true){
	 		$.ajax({
				url:"/comment/"+comment_id,
				type:"DELETE",
				success:function(result){
					getComment();
					$(".comment-area").trigger("reset");
				}
			});
	 	}
	}
}
</script>
</head>
<body>
<div class="site-wrap" style="width:100%;">

    <div class="site-mobile-menu">
      <div class="site-mobile-menu-header">
        <div class="site-mobile-menu-close mt-3">
          <span class="icon-close2 js-menu-toggle"></span>
        </div>
      </div>
      <div class="site-mobile-menu-body"></div>
    </div>
   
     


  

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



	<div class="container" style=" border-radius: 5px;background-color: WHITE	;padding:10px;width:100%;">
		
	  		<input type="hidden" name="gallery_id" value="<%=gallery.getGallery_id()%>">
		    <p style="width: 70%;padding: 12px;margin-top: 6px;margin-bottom: 16px;resize: vertical;color:black;margin:auto;text-align:right"><%=gallery.getGallery_regdate().substring(0, 10) %>
		    <br>
	
	<div style="text-align:center">
	  <h2><%=gallery.getGallery_title() %></h2>
	  <p>Click on the images below:</p>
	</div>
	
	<!-- The four columns -->
	<div style="box-sizing: border-box;">
		<div style="  margin: 0;font-family: Arial;">
			<div class="gallery_row"	style="width:100%;height:150px;overflow-x:scroll;">	 
	<%	List imageList=gallery.getGallery_images();
			for(int i=0; i<imageList.size(); i++){		
				Gallery_image gallery_image=(Gallery_image)imageList.get(i);		
	%>
				  <div class="gallery_column" style=" float: left;width: 10%;padding: 10px;">
				  		<img src="/chimper/chimper/uploadFile/<%=gallery_image.getFilename()%>" style="width:100px;height:80px;float:left" onclick="myFunction(this);" style="  opacity: 0.8; cursor: pointer; ">
				  </div>
			<%} %>
			  
			</div>
		</div>
	</div>
	
	<div class="gallery_container">
	  <img id="expandedImg" style="width:100%;text-align:center;"onclick="this.parentElement.style.display='none'">
	  <div id="imgtext" style="position: absolute;bottom: 15px;left: 15px;color: black;font-size: 20px;text-align:center;"><%=gallery.getGallery_content() %></div>
	</div>
	
			<br>
			<br>
		   	<p style="text-align:center;"><%=gallery.getGallery_content() %></p>
		   	
		<br>
		<br>
			<div class="comment-container" style="width:100%;text-align:center;">
				<div  style="width:80%;margin:auto;">
						<input type="text" name="content" style="display:inline-block;vertical-align:middle;width:85%;height:50px;font-size:15px;background:white;color:black;border:1px solid black;border-radius: 5%;"/><!--
						--><button id="ct-bt"  style="display:inline-block;vertical-align:middle;width:15%;height:50px;font-size:15px;background:white;color:black;border:1px solid black;border-radius: 5%;" onClick="registComment()">댓글등록</button>
				</div>
				<div class="comment-area" style="width:80%;margin:auto;overflow:hidden;"></div>
			</div>
		<br>
		<br>
	
	</div>
</div>
<!-- Footer~~ -->

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
