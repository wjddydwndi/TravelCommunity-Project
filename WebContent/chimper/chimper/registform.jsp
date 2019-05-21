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
.container {
  padding: 16px;
  width:70%;
  display: block;
  margin-left: auto;
  margin-right: auto;
}
.container .clearfix{
	width:70%;
	margin:0 auto;
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
var flag1=false;//아이디 중복체크 스위치
var flag2=false;//비밀번호, 이름 스위치
var flag3=false;//이메일 중복체크 스위치
var flag4=false;//인증 시간초 관련 스위치
//인증 시간초 관련 스위치
var time;
var min=5;
var sec=0;
var st;

$(function(){
	time=document.getElementById("time");
	showTimeText();
	$($("button")[0]).click(function(){
		idCheck();
		showNotice();
	});

	$($("button")[1]).click(function(){
		emailCheck();
		showNotice();
	});

	$($("button")[3]).click(function(){
		checkVal();
		lastCheck();
		showNotice();
	});
})

//////////////////////////////////////////////아이디 중복체크////////////////////////////////////////////////
function idCheck(){
	
	$.ajax({
		url:"/members/check",
		type:"get",
		data:{
			id:$("input[name='id']").val()
		},
		success:function(result){
			if(result==0){
				alert("사용할 수 있는 아이디 입니다.");
				flag1=true;
				showNotice();
			}else{ 
				alert("사용할 수 없는 아이디 입니다.");
				flag=false;
				showNotice();
			}
		}
		
	});
}
//////////////////////////////////////////////이메일 중복체크////////////////////////////////////////////////
function emailCheck(){
	
	$.ajax({
		url:"/members/check",
		type:"get",
		data:{
			email:$("input[name='email']").val()
		},
		success:function(result){
			if(result==0){
				alert("입력하신 이메일로 인증번호가 발송되었습니다.");
				flag4=true;
				execute();
				
			}else{ 
				alert("사용할 수 없는 이메일주소입니다.");
				flag3=false;
				showNotice();
			}
		}
		
	});
}

function passKeyBt(){
	var passKey2 =  $("input[name='key']").val();
	$.ajax({
		url:"/members/passKey/"+passKey2,
		type:"GET",
		success:function(result){
			if(result==1){
				flag3=true;
				alert("이메일이 인증되었습니다.")
				showNotice();
			}else{
				flag3=false;
				alert("이메일을 다시 인증해주세요.");
			}
		}
	});
}

//////////////////////////////// 중복체크 후, 아이디,이메일을 변경했을 경우/////////////////////////////////////////
function inputIdCheck(){
	flag1=false;
	showNotice();
}
function inputEmailCheck(){
	flag3=false;
	showNotice();
}


/////////////////////////////////////////회원가입전 전체적인 체크//////////////////////////////////////////////
function checkVal(){
	if(!$("input[name='id']").val()){
		alert("아이디를 입력해주세요");
		return flag1=false;
	}

	if(flag=false){
		alert("아이디 중복체크를 해주세요.");
		return flag1=false;
	}

	if(!$("input[name='pass']").val()){
		alert("비밀번호를 입력해주세요");
		return flag2=false;
	}

	if($("input[name='pass']").val() !=$("input[name='pass2']").val()){
		alert("비밀번호를 동일하게 입력해주세요.");
		return flag2=false;
	}else{
		return flag2=true;
	}

	if(!$("input[name='name']").val()){
		alert("이름을 입력해주세요");
		return flag2=false;
	}

	if(!$("input[name='email']").val()){
		alert("이메일을 입력해주세요");
		return flag3=false;
	}

	if(flag3==false){
		alert("올바른 인증번호를 입력해주세요.");
		return flag3=false;
	}
}

function lastCheck(){
	if(flag1==true && flag2==true && flag3==true){
		$("#registForm").attr({
			method:"post",
			action:"/members/insert"
		});
		$("#registForm").submit();
	}
}

function showNotice(){
	if(flag1==true){
		$($("h5")[0]).text("checked");
		$($("h5")[0]).css("color","green");
	}else{
		$($("h5")[0]).text("please check");
		$($("h5")[0]).css("color","red");
	}
	if(flag3==true){
		$($("h5")[1]).text("checked");
		$($("h5")[1]).css("color","green");
	}else{
		$($("h5")[1]).text("please check");
		$($("h5")[1]).css("color","red");
	}
	
}
///////////// 인증번호 시간 ////////////////////////////////
function execute(){

	if(flag4){
		st=setInterval("timeWatch()",1000);
		
	}else{
		clearTimeout(st);
	}
}
function timeWatch(){
	sec--;

	if(sec<0){
		min--;
		sec=59;
	}
	if(min<0){
		clearTimeout(st);
		min=0;
		sec=0;

		//인증번호 초기화
		$.ajax({
			url:"/members/resetKey",
			type:"GET",
			success:function(result){
				alert(result);
				alert("이메일을 다시 인증해주세요.");
				flag4=false;
				min=5;
				sec=0;
				showTimeText();
			}
		});
	}
	showTimeText();
}

function getTimeString(n){
	if(n<10){
		n="0"+n;
	}
	return n;
}

function showTimeText(){
	time.innerText=getTimeString(min)+":"+getTimeString(sec);
}


</script>
<body>
<div class="wrapper">
	<form id="registForm">
	  <div class="container">
	    <h1 align="center">R E G I S T</h1>
	    <hr>
		
		<div align="center">
	    <input type="text" placeholder="아이디를 입력해주세요" name="id" onkeydown="inputIdCheck()" required>
	     <button type="button" name="ckeckId" style="width:100px">중복체크</button>
	   	<h5 style="color:red">please check</h5>
	    
	    <input type="password" placeholder="비밀번호를 입력해주세요" name="pass" required>
	    <input type="password" placeholder="비밀번호를 입력해주세요" name="pass2" required>
	    <input type="text" placeholder="이름을 입력해주세요" name="member_name" required>
	    <input type="text" placeholder="이메일을 입력해주세요" name="email" required>
		<button type="button" name="ckeckEmail" style="width:100px"onkeydown="inputEmailCheck()">인증번호 받기</button>
		   	<h5 style="color:red">please check</h5>
		<input type="text" style="width:30%;" placeholder="인증번호를 입력해주세요." name="key">
		<h2 id="time">05:00</h2>
		
		<button type="button" name="passkeyBt" style="width:100px" onClick="passKeyBt()">인증</button>
	
	    <div class="clearfix">
	      <button type="button" class="signupbtn" name="regist">Regist</button>
	      <button type="button" class="cancelbtn" name="cancel">cancel</button>
	      
	    </div>
	    </div>
	  </div>
	</form>
</div>

</body>
</html>
