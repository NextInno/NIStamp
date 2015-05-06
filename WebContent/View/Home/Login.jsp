<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
<link href="../../css/header.css" rel="stylesheet" type="text/css"/>
<script src="../../js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
	<% String Session_No = null; %> 
	
	$('#loginbtn').click(function(){
		var id = $('#id').val();
		var pw = $('#password').val();
		//alert(id + pw);
	    $.ajax({
            type: 'POST',
            dataType: 'jsonp',
            data: { 'Id': id , 'Pw':pw },
            url: '../../Controller/Home/Login.jsp',
            jsonp: 'login',
            success:function(json) {
				alert(json.data.Id + "님 반갑습니다.");
				alert(json.data.Result);
				window.location.href = "Index.jsp";
            },
            error:function(json){
        	    alert('에러.\n' + json.data.Result);
            }
        });	
	})
});
</script>
</head>
<body>
	<div id = "header"><a href="#" class="logo">Logo</a></div>
	<div id = "container">
		<div class="loginArea">
			<p><span> ID : </span><input type="text" id="id" value="" placeholder = "Admin" ></p>
			<p><span> PassWord : </span><input type="password" id="password" placeholder = "Admin1!" ></p>
			<p><button id = "loginbtn">link</button></p>
		</div>
	</div>
</body>
</html>