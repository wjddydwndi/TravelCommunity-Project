<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {font-family: Arial, Helvetica, sans-serif;}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  box-sizing: border-box;
}

/* Set a style for all buttons */
button {
  background-color: blue;
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

/* Extra styles for the cancel button */
.cancelbtn {
  width: auto;
  padding: 10px 18px;
  background-color: #f44336;
}

/* Center the image and position the close button */
.imgcontainer {
  text-align: center;
  margin: 24px 0 12px 0;
  position: relative;
}

.container {
  padding: 16px;
}

span.psw {
  float: right;
  padding-top: 16px;
}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 0; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
  padding-top: 60px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  z-index: 3; /* Sit on top */
  width: 30%; /* Could be more or less, depending on screen size */
}

/* The Close Button (x) */
.close {
  position: absolute;
  right: 25px;
  top: 0;
  color: #000;
  font-size: 35px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: red;
  cursor: pointer;
}

/* Add Zoom Animation */
.animate {
  -webkit-animation: animatezoom 0.6s;
  animation: animatezoom 0.6s
}

@-webkit-keyframes animatezoom {
  from {-webkit-transform: scale(0)} 
  to {-webkit-transform: scale(1)}
}
  
@keyframes animatezoom {
  from {transform: scale(0)} 
  to {transform: scale(1)}
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
<script src="/chimper/chimper/js/jquery-3.3.1.min.js"></script>
<script>
	$(function(){
		$("button[name='bt_edit']").click(function(){
			//alert("클릭");
			memberEdit();
		});
	});	

	function memberEdit(){
		if(!confirm("수정하시겠어요?")){
			return;
		}
			$("form[name='editForm']").attr({
				"action":"/editMember",
				"method":"post"
			});
			$("form[name='editForm']").submit();
		
	}
</script>
</head>
<body>

<div id="id01" class="modal">
  
  <form class="modal-content animate" name="editForm">
    <div class="imgcontainer">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
      <h1>회원 정보</h1>
    </div>
    <div class="container">
	      <input type="hidden" name="member_id" value=""/>	
	    
	      <label for="id"><b>ID</b></label>
	      <input type="text" name="id" value="" readonly>
	      <br>
	
	      <label for="pass"><b>P.W</b></label>
	      <input type="password" name="pass" value="">
	      <br>
	      
	      <label for="member_name"><b>name</b></label>
	      <input type="text" name="member_name" value="">
	      <br>
	      
	      <label for="email"><b>email</b></label>
	      <input type="text" name="email" value="">
	      <br>
	      
	      <label for="member_level_id"><b>회원 등급</b></label>&nbsp;&nbsp;&nbsp;
	      <select name="member_level_id" style="width:150px;">
			  <option value="0" name="normal">일반 회원</option>
			  <option value="1" name="manager">Manager</option>
		  </select>
	      <br>
	       
	      <button type="button" name="bt_edit">수정 하기</button>
	   	  
    </div>
  </form>
</div>

<script>
// Get the modal
var modal = document.getElementById('id01');

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>

</body>
</html>
