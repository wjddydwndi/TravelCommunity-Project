<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box}

.wrapper{
	width:100%;
	height:100%;
}

/*폼태그 가운데 갖다박기*/
#logForm{
	width:760px;
	height:360px;
	position:absolute;
	left:50%;
	top:30%;
	margin-left:-380px;
	margin-top:-100px;
}

/* Full-width input fields */
input[type=text], input[type=password]{
  width: 50%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus{
  background-color: #ddd;
  outline: none;
}

hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

/* Set a style for all buttons */
button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  opacity: 0.9;
  display: block;
  margin-left: auto;
  margin-right: auto;
}

button:hover {
  opacity:1;
}

/* Extra styles for the cancel button */
.cancelbtn {
  padding: 14px 20px;
  background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn, .signupbtn {
  float: left;
  width: 10%;
  display: block;
  margin-left: auto;
  margin-right: auto;
}

/* Add padding to container elements */
.container .passContainer {
  padding: 16px;
  width:70%;
  display: block;
  margin-left: auto;
  margin-right: auto;
  position:float;
}

.clearfix{
	width:50%;
	margin:0 auto;
	position:float;
	text-align:"center";
}
.clearfix button{
	width:50%;
	float:left;
}
/* Clear floats */
.clearfix::after {
  content: "";
  clear: both;
  display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
  .cancelbtn, .signupbtn {
     width: 100%;
  }
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(function(){
	$("button[name='findID']").click(function(){
		//alert("아이디 찾기!!");
		findID();
	});
	$("button[name='resetPass']").click(function(){
		//alert("비밀번호 찾기!!");
		resetPass();
	});
	$("button[name='findIdCancel']").click(function(){
		history.back();
	});
	$("button[name='resetPassCancel']").click(function(){
		history.back();
	});
});

function findID(){
	//alert($($("form[name='findID']").find("input[name='member_name']")).val());
	//alert($($("form[name='findID']").find("input[name='email']")).val());
	
	$.ajax({
		url:"/findAccount/findID",
		type:"get",
		data:{
			"member_name":$($("form[name='findID']").find("input[name='member_name']")).val(),
			"email":$($("form[name='findID']").find("input[name='email']")).val()
		},
		success:function(result){
			var json = JSON.parse(result);
			//alert(json.id);
			$("div[name='IdPrintZone']").html("");
			$("div[name='IdPrintZone']").append("<h2 style='color:red'>입력정보로 등록된 ID : "+json.id+"</h2>");
		}
	});
}


function resetPass(){
	//alert($($("form[name='resetPass']").find("input[name='id']")).val());
	//alert($($("form[name='resetPass']").find("input[name='email']")).val());
	$.ajax({
		url:"/findAccount/resetPass",
		type:"post",
		data:{
			"id":$($("form[name='resetPass']").find("input[name='id']")).val(),
			"email":$($("form[name='resetPass']").find("input[name='email']")).val()
		},
		success:function(result){
			//alert(result);
			var json = JSON.parse(result);
			//alert(json.resultCode);
			if(json.resultCode == "1"){
				alert("비밀번호 초기화에 성공하였습니다. (비밀번호는 ID 값으로 변경됩니다.)");
				location.href="/chimper/chimper/index.jsp";
			}else{
				alert("비밀번호 초기화 실패!! 입력정보를 확인하세요!");
				$($("form[name='resetPass']").find("input[name='id']")).val("");
				$($("form[name='resetPass']").find("input[name='email']")).val("");
			}
		}
	});
	
}



</script>
<body>
<div class="wrapper">
	<form name="findID">
	  <div class="container">
	    <h1 align="center">Find ID</h1>
	    <hr>
		
		<div align="center">
	    <input type="text" placeholder="이름을 입력해주세요" name="member_name" required>
	    <input type="text" placeholder="이메일을 입력해주세요" name="email" required>

	    <div class="clearfix">
	      <button type="button" class="signupbtn" name="findID">Confirm</button>
	      <button type="button" class="cancelbtn" name="findIdCancel">cancel</button>
	    </div>
	    <div name="IdPrintZone"></div>
	    </div>
	  </div>
	</form>
	<br><br><br><br>
	<form name="resetPass">
	  <div class="passContainer">
	    <h1 align="center">Password 초기화</h1>
	    <hr>
		
		<div align="center">
	    <input type="text" placeholder="아이디를 입력해주세요" name="id" required>
	    <input type="text" placeholder="이메일을 입력해주세요" name="email" required>
	 
		
		
	    <div class="clearfix">
	      <button type="button" class="signupbtn" name="resetPass">Confirm</button>
	      <button type="button" class="cancelbtn" name="resetPassCancel">cancel</button>
	    </div>
	    </div>
	  </div>
	</form>
</div>

</body>
</html>
