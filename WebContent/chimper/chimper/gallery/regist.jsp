	<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/chimper/chimper/commons/menuBar.jsp" %>
<%
	if(member==null){
		out.print("<script>");
		out.print("alert('로그인이 필요한 페이지 입니다');");
		out.print("location.href='/gallerys';");
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


</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
var flag=false;//파일이 등록되었는 지를 판별
var filesArray = new Array();
var dt = new DataTransfer();

$(function(){
	$($("input[type='button']")[0]).click(function(){
		regist();
	});
    $("#myFile").change(function(e){
        $("#view").html("");    //미리 보기 이미지 초기화
        preview(this, e);   //미리 보기
        checkFile(this);     
    });
});

class PreviewFile{
    constructor(index, ev){ //index, event
        this.index=index;
        this.ev=ev;
        this.img;
        this.tempArray=[];
        
        this.load(); //메서드 호출
    }    
    load(){
        var reader = new FileReader();
        reader.onload=()=>{
            console.log("e.target.files :", this.ev.target.files);
            this.img=document.createElement("img");
            this.img.style.width=100+"px";
            this.img.style.height=80+"px";
            this.img.src=reader.result;
            this.img.addEventListener("click", ()=>{
                this.del();
            });
            document.querySelector("#view").appendChild(this.img);
        };
        reader.readAsDataURL(this.ev.target.files[this.index]); //선택된 파일 로드
    }
    del(){
        $(this.img).remove();    //이미지 삭제
        dt.items.remove(0);    //dt 요소 삭제
        console.log(this.index+" 삭제 후 dt의 길이는 ", dt.items.length);
        
        this.ev.target.files = dt.files;//dt를 filesList에 반영하기 
        this.ev.target.onchage=null; //remove event listener
    }
}


function preview(obj, e){
    var len=e.target.files.length;
    for(var i=0;i<len;i++){
        var previewFile=new PreviewFile(i , e);    
        filesArray.push(e.target.files[i]); //객체 담기
        dt.items.add(e.target.files[i]); //dt에 담기
    }
}


function deleteFile(){
	reset($('#myFile'));
	flag=false;
}

function regist(){
	if(flag==false){
		alert("사진을 등록 해주세요");
		return;
	}
	
	$(".fileupload").attr({
		method:"post",
		action:"/gallerys"
	});
	$(".fileupload").submit();
	
}



function checkFile(obj){
	if(obj.files.length<1){
		flag=false;
	}else{
		flag=true;
	}	
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

<div class="container">
  <form class="fileupload" enctype=multipart/form-data>
    <input type="text" name="gallery_title" placeholder="글제목을 입력해주세요" >
    
	
	<p>
	<div class="image-container">
		<p>
			
			<div>
			   	<div id="view"></div>
  			  	<input type="file" id="myFile"  name="myFile" multiple="multiple" style="width:100%;margin:auto;"/>
				<button onclick="deleteFile()" style="margin:auto;float:left;background:dodgerblue;">Reset file</button>
			</div>
		<p>
		
		<p>
	</div>
    <textarea name="gallery_content" placeholder="내용을 입력해주세요"  style="width:100%;resize:none;border:1;overflow:hidden;text-overflow:ellipsis;" rows=10></textarea>
<p>
	<div class="Wbt">
	    <input type="button" value="글 등록" style="width:100%;background:dodgerblue;">
	    <input type="button" value="목록" style="width:100%;background:dodgerblue;" onClick="javascript:location.href='/gallerys'" >

  	</div>
  </form>
</div>


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
