<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}
form {border: 3px solid #f1f1f1;}

input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

button {
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
}

button:hover {
  opacity: 0.8;
}

.cancelbtn {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
}

.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
}

img.avatar {
  width: 40%;
  border-radius: 50%;
}

.container {
  padding: 16px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

/* Change styles for span and cancel button on extra small screens */
@media screen and (max-width: 300px) {
  span.psw {
     display: block;
     float: none;
  }
  .cancelbtn {
     width: 100%;
  }
}
</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(function(){
		$($("button")[0]).click(function(){
			login();
		});
		$($("button")[1]).click(function(){
			history.back();
		});
	});

	function login(){
		$("form[name='loginForm']").attr({
			"method":"get",
			"action":"/login"
		});
		$("form[name='loginForm']").submit();
	}
</script>
<body>
<%@ include file="/chimper/common/menuBar.jsp" %>
<div name="LoginContainer">
	<h2>Login Form</h2>
	
	<form name="loginForm">
	
	  <div class="container">
	    <label for="uname"><b>ID</b></label>
	    <input type="text" placeholder="Enter ID" name="id" required>
	
	    <label for="psw"><b>Password</b></label>
	    <input type="password" placeholder="Enter Password" name="pass" required>
	        
	    <button type="button" name="loginbt">Login</button>
	  </div>
	
	  <div class="container" style="background-color:#f1f1f1">
	    <button type="button" class="cancelbtn">Cancel</button>
	  </div>
	</form>
</div>
</body>
</html>
