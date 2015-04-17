<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Login Page</title>
<link href="css/header.css" rel="stylesheet" type="text/css"/>
<script src="js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
	<% 
		String Session_No = null; 	
	%> 
	
	$('#test').click(function(){
		var id = $('#id').val();
		var pw = $('#password').val();
		//alert(id + pw);
		   $.ajax({
	           type: 'POST',
	           dataType: 'jsonp',
	           data: { 'Id': id , 'Pw':pw },
	           url: 'jsp/test.jsp',
	           // jsonp ���� ������ �� ���Ǵ� �Ķ���� ������
	           // �� �Ӽ��� �����ϸ� callback �Ķ���� ���������� ���޵ȴ�.
	           jsonp: 'login',
	           success:function(json) {
					alert(id + "�� �ݰ����ϴ�.");
	   				window.location.href = "index.jsp";
	           },
	           error:function(){
	        	   alert('���̵�� ��й�ȣ�� Ȯ�����ּ���');
	           }
	      });	
	})
});
</script>
</head>
<body>
	<div id = "header"><a href="#" class="logo">Logo</a></div>
	<div id="ip" class="ip"><p>����ּ�: kpig7.synology.me:3306</p></div>
	<div id = "container">
		<div class="loginArea">
			<p><span> ID : </span><input type="text" id="id" value="" placeholder = "Admin" ></p>
			<p><span> PassWord : </span><input type="password" id="password" placeholder = "Admin1!" ></p>
			<p><button id = "test">link</button></p>
		</div>
	</div>
	<div id='hidden'><input type='text' name='hidden_No' id='hidden_No' value = ''/></div>
</body>
</html>

