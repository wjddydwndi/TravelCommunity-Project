<%@page import="com.tour.model.gallery.domain.Gallery_image"%>
<%@page import="com.tour.model.gallery.domain.Gallery"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Chimper &mdash; Colorlib Website Template</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Qu.icksand:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="fonts/icomoon/style.css">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/jquery-ui.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">

    <link rel="stylesheet" href="css/bootstrap-datepicker.css">

    <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

    <link rel="stylesheet" href="css/aos.css">

    <link rel="stylesheet" href="css/style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script>
$(function(){
 	getArea();
	getCity();
	getReview();
	
	getGallery();
});
function getArea(){
	$.ajax({
		url:"/rest/areas",
		type:"GET",
		success: function(result){
			fillArea(result);
		}
		
		
	});
	
	
}
function getSubArea(){
	var a=$("#area").val();
	var b=$("select[name='area']").val();
	$.ajax({
		url : "/rest/airs",
		type: "get",
		data:{
			area : $("#area").val()
		},
		success : function(result){
			//alert(result[i]);
			fillSubArea(result);
		},
		error : function(result){
			
		}
	});
}
function fillArea(area){
	var tag="";
	$("#area").html("");

	for(var i=0;i<area.length;i++){
		tag+="<option value='"+area[i]+"'>"+area[i]+"</option>";
	}
	$("#area").append(tag);
	getSubArea();
}



function fillSubArea(result){
	//alert(result.length);
	var tag="";
	for(var i=0;i<result.length;i++){
		$("#subArea").html("");
		tag+="<option value='"+result[i].subArea+"'>"+result[i].subArea+"</option>";
	}
	$("#subArea").append(tag);
	getCondition();
	getWeather();
}




function getCondition(){

	$.ajax({
		url : "/rest/airs",
		type: "get",
		data:{
			area : $("#area").val()
		},
		success : function(result){
			//alert(result[i]);
			showCondition(result);
		},
		error : function(result){
			
		}
	});
}
function showCondition(result){
	var a=$("select[name='subArea']").val();

	for(var i=0;i<result.length;i++){
		if(a==result[i].subArea){
			if(result[i].fine>0 && result[i].fine<=30){
			
				$("#air").html("<h4>미세먼지 농도"+result[i].fine+"㎍/㎥ 좋음</h4>");
			}else if(result[i].fine>=31 && result[i].fine<=50){
			
				$("#air").html("<h4>미세먼지 농도"+result[i].fine+"㎍/㎥ 보통</h4>");
			}else if(result[i].fine>=51 && result[i].fine<=100){
	
				$("#air").html("<h4>미세먼지 농도"+result[i].fine+"㎍/㎥ 나쁨</h4>");
			}else if(result[i].fine>=101){
	
				$("#air").html("<h4>미세먼지 농도"+result[i].fine+"㎍/㎥ 매우나쁨</h4>");
			}else if(result[i].fine==0){
				$("#air").html("<h4>데이터가 없습니다</h4>");

			}
			if(result[i].ultrafine>0 && result[i].ultrafine<=15){
				$("#air2").html("<h4>초미세먼지 농도"+result[i].ultrafine+"㎍/㎥ 좋음</h4>");
			}else if(result[i].ultrafine>=16 && result[i].ultrafine<=25){
				$("#air2").html("<h4>초미세먼지 농도"+result[i].ultrafine+"㎍/㎥ 보통</h4>");
			}else if(result[i].ultrafine>=26 && result[i].ultrafine<=50){
				$("#air2").html("<h4>초미세먼지 농도"+result[i].ultrafine+"㎍/㎥ 나쁨</h4>");
			}else if(result[i].ultrafine>50){
				$("#air2").html("<h4>초미세먼지 농도"+result[i].ultrafine+"㎍/㎥ 매우나쁨</h4>");
			}else if(result[i].ultrafine==0){
				$("#air2").html("<h4>데이터가 없습니다</h4>");
			}
		}
	}
}
//-----------------------------------------weather;-----------------------------------------------
function getCity(){
	$.ajax({
		url:"/rest/cities",
		type:"get",
		success:function(result){
			//alert(result[0].city);
			filCity(result);
		},
		error:function(result){
			
		}
	});
}
function filCity(result){
	var tag="";
	for(var i=0;i<result.length;i++){
		var city =result[i].city;
		$("#city").html("");
		tag+="<option value='"+city+"'>"+city+"</option>";
	}
	$("#city").append(tag);
}
function getWeather(){
	$.ajax({
		url:"/weathers",
		type:"get",
		data:{
			city: $("#area").val()
		},
		success:function(result){
			//alert(result);
			renderWeather(result);
		},
		error:function(result){
			
		}
	});
}
function renderWeather(weatherList){
	var a=0;
	var b=0;
	var c=0;
	var d=0;
	$("#weather").html("");
	for(var i=0;i<weatherList.length;i++){
		var weather = weatherList[i];
		
		if(weather.category=="SKY" && a==0){
			if(weather.fcstValue==1 && a==0){
				$("#img").attr("src","/chimper/chimper/images/weather1.png");
				a++;
		 	}else if(weather.fcstValue==2 && a==0){
		 		$("#img").attr("src","/chimper/chimper/images/weather1.png");
		 		a++;
			}else if(weather.fcstValue==3 && a==0){
				$("#img").attr("src","/chimper/chimper/images/weather2.jpg");
				a++;
			}else if(weather.fcstValue==4 && a==0){
				$("#img").attr("src","/chimper/chimper/images/weather3.jpg");
				a++;
			}
		}

		if(weather.category=="T3H" && b==0){
			$("#now_tem").html("<h4>현재온도 "+weather.fcstValue+"℃</h4>");
			b++;
		}
		if(weather.category=="TMN" && c==0){
			$("#tmn").html("<h4>최저온도"+weather.fcstValue+"℃</h4>");
			c++;
		}
		if(weather.category=="TMX" && d==0){
			$("#tmx").html("<h4>최고온도"+weather.fcstValue+"℃</h4>");
			d++;
		}
		
	}
}

//---------------여행 후기 게시글 좋아요 순으로 가져오기(비동기 방식)-----------------------------
function getReview(){
	//alert("여행후기 게시글 가져오기");
	$.ajax({
		url:"/reviews/good",
		type:"get",
		success:function(result){
			renderReview(result.reviewList);
			//alert(result.reviewList[0]);
		
		},
		error:function(result){
			
		}
	});
}

function renderReview(reviewList){

	for(var i=0; i<reviewList.length; i++){
		var review = reviewList[i];
		//alert(review.image[0].file_name);
		$("#reviewImg").attr("src","/chimper/chimper/uploadFile/"+reviewList[0].image[0].file_name);
		$("#reviewImg").attr("onClick","getDetail("+reviewList[0].review_id+")");
 		$("#reviewImg2").attr("src","/chimper/chimper/uploadFile/"+reviewList[1].image[0].file_name);
 		$("#reviewImg2").attr("onClick","getDetail("+reviewList[1].review_id+")");
		$("#reviewImg3").attr("src","/chimper/chimper/uploadFile/"+reviewList[2].image[0].file_name);
		$("#reviewImg3").attr("onClick","getDetail("+reviewList[2].review_id+")");	
	}
	$(".font-size-regular1").append("제목"+"<input type='text' value='"+reviewList[0].review_title+"' readonly>"); 
	$(".font-size-regular1").append("<input type='hidden' value='"+reviewList[0].review_id+"'readonly>"); 
	$(".font-size-regular2").append("제목"+"<input type='text' value='"+reviewList[1].review_title+"' readonly>");
	$(".font-size-regular2").append("<input type='hidden' value='"+reviewList[1].review_id+"'readonly >"); 
	$(".font-size-regular3").append("제목"+"<input type='text' value='"+reviewList[2].review_title+"' readonly>");
	$(".font-size-regular3").append("<input type='hidden' value='"+reviewList[2].review_id+"'readonly >"); 
}

function getDetail(review_id){
	if(!confirm("해당 페이지로 이동합니다.")){
		return;
	}
	location.href="/review/detail?review_id="+review_id;
}


//===================Gallery========================
	
	
	function getGallery(){
	//alert("getGallery");
	$.ajax({
		url:"/main/list",
		type:"get",
		success:function(result){
			createGallery(result);
			
		}
	});
}




function createGallery(obj){
    for(var i = 0; i<obj.length; i++){
       if(i>3){break;}
         var gallery=obj[i];
          var images=gallery.gallery_images; 
         var GalleryObj = new Gallery(images[0],i);
         $("#writer"+i+"").append("작성자"+gallery.member.id);
   }
}
class Gallery{
	
	constructor(images,index){
		//alert("이미지 파일명은??"+images.gallery_image_id);
		
		this.img= document.createElement("img");
		this.img.style.width=300+"px";
		this.img.style.height=250+"px";
		this.img.src="/chimper/chimper/uploadFile/"+images.filename+""; 
		this.img.addEventListener("click",()=>{
			var gallery_image_id=images.gallery_image_id;
			
			location.href="/gallerys/detail/"+gallery_image_id+"";

      });
      $("#gallery_image"+index+"").append(this.img);
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
	   
	
	
	<%@ include file="/chimper/chimper/commons/menuBar.jsp" %>
	
	    <div class="site-blocks-cover overlay" style="background-image: url(images/kyungbok2.png);" data-aos="fade" data-stellar-background-ratio="0.5">
	      <div class="container">
	        <div class="row align-items-center justify-content-center text-center">
	
	          <div class="col-md-12" data-aos="fade-up" data-aos-delay="400">
	                        
	            <div class="row justify-content-center mb-4">
	              <div class="col-md-8 text-center">
	                <h1>여행지 정보를 제공합니다 <br><br> <span class="typed-words"></span></h1><br>
	              </div>
	            </div>
	
	          </div>
	        </div>
	      </div>
	    </div>  
	
	
	<!-- 날씨api -->
      <section class="site-section">
         <div class="container" >

	        <div class="row">
	          <div class="col-md-6 col-lg-4">
                  <div class="p-3 box-with-humber" style="width:800px;">
                     <select style="width: 100px; height: 30px;"  name="area" id="area" onchange="getSubArea()"></select>
                     <select id="subArea" name="subArea" onchange="getCondition()" hidden="true"></select>
                     <br>
                     <h3>오늘의 날씨</h3>

                     <div>
                        <img id="img" 
                           style="width: 250px; height: 300px; float: left; margin-right: 50px;">
                        <div id="now_tem"></div>
                        <br>
                        <div id="tmx"></div>
                        <br>
                        <div id="tmn"></div>
                        <br>
                        <div id="air"></div>
                        <br>
                         <div id="air2"></div>
                     </div>
                     <br>
	          </div>
	          </div>	          
	        </div>
	      </div>
	    </section>
	    
	    

	   	 <section class="site-section bg-light">
	      <div class="container">
	        <div class="row justify-content-center">
	          <div class="col-md-8 text-center">
                  <h2 class="text-black h1 site-section-heading text-center">Travel Review Top3</h2>
               </div>
            </div>

            <div class="row"> 
            	
           
                  <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                     <div class="h-entry">
                     <img id="reviewImg" style="height:300px;width:90%;">
                        <h2 class="font-size-regular1">
                        </h2>
                     </div>
                  </div> 
			
                  <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                     <div class="h-entry">
                     <img id="reviewImg2" style="height:300px;width:90%;">
                        <h2 class="font-size-regular2">
                        </h2>
                     </div>
                  </div>

                   <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                     <div class="h-entry">
                     <img id="reviewImg3" style="height:300px;width:90%;">
                        <h2 class="font-size-regular3">
                        </h2>
                     </div>
                  </div>
                       
            </div>
   
            
            
         </div>
      </section>
	
	    <section class="site-section bg-light">
	      <div class="container">
	        <div class="row justify-content-center">
	          <div class="col-md-8 text-center">
                  <h3 class="text-black h1 site-section-heading text-center">오늘의 Gallery</h3>
               </div>
            </div>

            <div class="row">
               <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                     <div class="h-entry" id="gallery_image0">

                        <h2 id="writer0">
                        </h2>
                     </div>
                 </div>
             
             <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                     <div class="h-entry" id="gallery_image1">
   
                        <h2 id="writer1"></h2>
                     </div>
                 </div>
                 
                 <div class="col-md-6 col-lg-4 mb-4 mb-lg-4">
                     <div class="h-entry" id="gallery_image2">
        
                        <h2 id="writer2">
                        </h2>
                     </div>
                 </div>
   
               
            </div>
         </div>
      </section>

      <a href="#" class="bg-primary py-5 d-block">
         <div class="container">
            <div class="row justify-content-center">
               <div class="col-md10">
                  <h2 class="text-white">당신의 모든 여행. 이곳에 이야기를 남겨주세요</h2>
               </div>
            </div>
         </div>
      </a>
	    
	    <%@ include file="/chimper/chimper/commons/footer.jsp" %>
	  </div>
	
	  <script src="js/jquery-3.3.1.min.js"></script>
	  <script src="js/jquery-migrate-3.0.1.min.js"></script>
	  <script src="js/jquery-ui.js"></script>
	  <script src="js/popper.min.js"></script>
	  <script src="js/bootstrap.min.js"></script>
	  <script src="js/owl.carousel.min.js"></script>
	  <script src="js/jquery.stellar.min.js"></script>
	  <script src="js/jquery.countdown.min.js"></script>
	  <script src="js/jquery.magnific-popup.min.js"></script>
	  <script src="js/bootstrap-datepicker.min.js"></script>
	  <script src="js/aos.js"></script>
	
	
	  <script src="js/typed.js"></script>
	            <script>
	            var typed = new Typed('.typed-words', {
	            strings: [" 서울.."," 부산.."," 제주도.."],
	            typeSpeed: 80,
	            backSpeed: 80,
	            backDelay: 4000,
	            startDelay: 1000,
	            loop: true,
	            showCursor: true
	            });
	            </script>
	
	  <script src="js/main.js"></script>
	    
  </body>
</html>