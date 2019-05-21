<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/chimper/chimper/commons/menuBar.jsp"%>
<%
	if (member == null) {
		out.print("<script>");
		out.print("alert('로그인이 필요한 페이지 입니다');");
		out.print("location.href='/review/list';");
		out.print("</script>");
	}
%>            
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
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
/*구글맵 관련 css*/
#map {
	height: 300px;
	width: 1100px;
	margin: auto;
}

html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

#description {
	font-family: Roboto;
	font-size: 15px;
	font-weight: 300;
}

#infowindow-content .title {
	font-weight: bold;
}

#infowindow-content {
	display: none;
}

#map #infowindow-content {
	display: inline;
}

.pac-card {
	margin: 10px 10px 0 0;
	border-radius: 2px 0 0 2px;
	box-sizing: border-box;
	-moz-box-sizing: border-box;
	outline: none;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
	background-color: #fff;
	font-family: Roboto;
}

#pac-container {
	padding-bottom: 12px;
	margin-right: 12px;
}

.pac-controls {
	display: inline-block;
	padding: 5px 11px;
}

.pac-controls label {
	font-family: Roboto;
	font-size: 13px;
	font-weight: 300;
}

#pac-input {
	background-color: #fff;
	font-family: Roboto;
	font-size: 15px;
	font-weight: 300;
	margin-left: 12px;
	padding: 0 11px 0 13px;
	text-overflow: ellipsis;
	width: 400px;
}

#pac-input:focus {
	border-color: #4d90fe;
}

#title {
	color: #fff;
	background-color: #4d90fe;
	font-size: 25px;
	font-weight: 500;
	padding: 6px 12px;
}

#target {
	width: 345px;
}

/*글 입력 관련 css*/
body {
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box;
}

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

input[type=submit] {
	background-color: #4CAF50;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color: #45a049;
}

.container2 {
	width: 800px;
	height: 600px;
	border-radius: 5px;
	background-color: #f2f2f2;
	padding: 20px;
	margin: auto;
}
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

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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


		<div class="site-blocks-cover inner-page-cover overlay"
			style="background-image: url(/chimper/chimper/images/gallary.png);"
			data-aos="fade" data-stellar-background-ratio="0.5">
			<div class="container">
				<div
					class="row align-items-center justify-content-center text-center">

					<div class="col-md-12" data-aos="fade-up" data-aos-delay="400">

						<div class="row justify-content-center mb-4">
							<div class="col-md-8 text-center">
								<h1>review</h1>
								<p class="lead mb-5">여행지 후기</p>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	<!-- 구글맵 -->
	<input id="pac-input" class="controls" type="text"
		placeholder="Search Box">
	<div id="map"></div>
	<script>
		var pathArray = []; //path요소들이 모인 배열 
		
		function initAutocomplete() {
			var myLatlng = new google.maps.LatLng(37.20959739504577,126.97947084903717);
			
			var map = new google.maps.Map(document.getElementById('map'), {
				center : myLatlng,
				zoom : 13,
				mapTypeId : 'roadmap'
			});

			// Create the search box and link it to the UI element.
			var input = document.getElementById('pac-input');
			var searchBox = new google.maps.places.SearchBox(input);
			map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

			// Bias the SearchBox results towards current map's viewport.
			map.addListener('bounds_changed', function() {
				searchBox.setBounds(map.getBounds());
			});

			var markers = [];
			// Listen for the event fired when the user selects a prediction and retrieve
			// more details for that place.
			searchBox.addListener('places_changed', function() {
				var places = searchBox.getPlaces();
				console.log("검색 결과 수 : "+places.length);
				if (places.length == 0) {
					return;
				}

				// Clear out the old markers.
				markers.forEach(function(marker) {
					marker.setMap(null);
				});
				markers = [];

				// For each place, get the icon, name and location.
				var bounds = new google.maps.LatLngBounds();
				places.forEach(function(place) {
					console.log("유저가 검색한 장소는 : "+place.name);
					console.log("유저가 검색한 장소는 : "+place.geometry.location.lat());
					console.log("유저가 검색한 장소는 : "+place.geometry.location.lng());
					if (!place.geometry) {
						console.log("Returned place contains no geometry");
						return;
					}
					var icon = {
						url : place.icon,
						size : new google.maps.Size(71, 71),
						origin : new google.maps.Point(0, 0),
						anchor : new google.maps.Point(17, 34),
						scaledSize : new google.maps.Size(25, 25)
					};      
					
					// Create a marker for each place.
					markers.push(new google.maps.Marker({
						map : map,
						icon : icon,
						title : place.name,
						position : place.geometry.location,
						lati : place.geometry.location.lat(),
						longi : place.geometry.location.lng()
					}
					));

					if (place.geometry.viewport) {
						// Only geocodes have viewport.
						bounds.union(place.geometry.viewport);
					} else {
						bounds.extend(place.geometry.location);
					}
				});
				map.fitBounds(bounds);
				
				//path요소(이름,위도,경도) 한건 
			 	for(var i=0; i<markers.length; i++){
					google.maps.event.addListener(markers[i], 'click', function(event) {

						//유저가 선택한 path 미리보기
						var str1 = "onMouseOver=\"this.style.background='pink'; this.style.cursor='pointer';\"" 
						var str2 = "onMouseOut=\"this.style.background=''\""
						$("#PathView").append("<input type='text' onClick='delPath(this)' name='path_name' value='"+this.title+"' readonly='readonly' style='width:200px;'"+str1+str2+">");
						//alert(this.title+" : "+this.lati+","+this.longi);
						
						$("input[name='lati']").val(this.lati);
						$("input[name='longi']").val(this.longi);
						$("input[name='path_name2']").val(this.title);
						
						var lati = $("input[name='lati']").val();
						var longi = $("input[name='longi']").val();
						var path_name = $("input[name='path_name2']").val();

						var pathArgs = {};	
						pathArgs["lati"] = this.lati;
						pathArgs["longi"] = this.longi;
						pathArgs["path_name"] = this.title;		
						
						pathArray.push(pathArgs);
						console.log("배열의 길이는 : ",pathArray.length);
			
						console.log(JSON.stringify(pathArray));
						//$("textarea[name='selectedPath']").val(JSON.stringify(pathArray));
						$("input[name='selectedPath']").val(JSON.stringify(pathArray));
					}); //click event end
				} // for문 end
			});
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAYiYfY2sFXhY8kDegX6a13yO0dbezojRU&callback&libraries=places&callback=initAutocomplete"
		async defer></script>

	<!-- 글 입력 폼 -->
	<div class="container">
		<form name="form" enctype="multipart/form-data">
			<div>
				<h4>내가 간 곳</h4>
				<div id="PathView"></div>
			</div>
			<div>
				<h4>내가 선택한 이미지</h4>
				<div id="preView"></div>
			</div>
			<input type="hidden" name="lati"> 
			<input type="hidden" name="longi"> 
			<input type="hidden" name="path_name2">
			<input type="hidden" name="selectedPath">
			<!-- <textarea name="selectedPath" rows="5" cols="50"></textarea> -->
			<input type="hidden" name="member.member_id" value=<%=member.getMember_id()%>>
			<br> 
			<label for="lname">제목</label> 
			<input type="text" id="review_title" name="review_title" placeholder="제목"> 
			<label for="subject">내용</label>
			<textarea id="subject" name="review_content"
				placeholder="글 내용을 입력해 주세요" style="height: 200px"></textarea>
			<!-- 파일업로드 -->
			<input type="file" id="myFile" name="myfile" multiple="multiple" />
		</form>
		<input type="button" value="글 등록">
	</div>
	<p id="lat"></p> 
    <p id="lng"></p> 

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

var filesArray = new Array();
dt = new DataTransfer();

class PreviewFile{
	constructor(index, ev){ //index, event
		this.index = index;
		this.ev = ev;
		this.img;

		this.load(); //메서드 호출
	}
	load(){
		var reader = new FileReader();
		reader.onload=()=>{
			console.log("e.target.files : ", this.ev.target.files);
			this.img = document.createElement("img");
			this.img.style.width = 100+"px";
			this.img.style.height = 100+"px";
			this.img.src = reader.result;
			this.img.addEventListener("click", ()=>{
				this.del();
			});
			document.querySelector("#preView").appendChild(this.img);
		};
		reader.readAsDataURL(this.ev.target.files[this.index]); //선택된 파일 로드
	}
	//선택한 이미지 삭제
	del(){
		$(this.img).remove(); //이미지 미리보기에서 삭제
		dt.items.remove(0); //dt요소 삭제(순서는 중요하지 않고 갯수만!)

		this.ev.target.files = dt.files; //dt를 filesList에 반영하기!!!!!
		this.ev.target.onchange = null; //remove event listener
	}
}

$(function(){
	$("#myFile").change(function(e){
		$("#preView").html(""); //미리보기 이미지 초기화
		preview(this, e); //미리 보기
	});
	$("input[type='button']").click(function(){
		regist();
	});
});

//미리보기 
function preview(obj, e){
	var len = e.target.files.length;
	for(var i=0; i<len; i++){
		var previewFile = new PreviewFile(i, e);
		filesArray.push(e.target.files[i]); //객체를 배열에 담기
		dt.items.add(e.target.files[i]); //dt에 담기
	}
}

//글 등록
function regist() {
	$("form").attr({
		action : "/review/write",
		method : "post"
	});
	$("form").submit();
}

//path 삭제(유저선택보기)
function delPath(obj){
	for(var i=0; i<pathArray.length; i++){
		var json = pathArray[i];
		if(obj.value == json.path_name){
			console.log(i+"번째에서 발견");
			pathArray.splice(i,1); //배열 지워주기
			$(obj).remove();  //path 미리보기 지워주기
		}
	}
	//DB로 보내질 input type=text 비워주기11
	$("input[name='selectedPath']").val(JSON.stringify(pathArray));
	if(pathArray.length == 0){
		$("input[name='selectedPath']").val("");
	}
}

</script>
</body>
</html>
