<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>매장입력</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"> 
<script src="//code.jquery.com/jquery-1.10.2.js"></script> 
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script src="../datePicker/jquery.ui.datepicker.ko.js" type="text/javascript"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<script>
$(function(){
	$('#insert').click(function(){
		var StoreOwnerName = $('#StoreOwnerName').val();
		var StoreName = $('#StoreName').val();
		var StoreAccount = $('#StoreAccount').val();
		var StorePassword = $('#StorePassword').val();
		var StoreAddress = $('#StoreAddress').val();
		var StoreTel = $('#StoreTel').val();
		var StorePhone = $('#StorePhone').val();
		var StoreFax = $('#StoreFax').val();
		var StoreCompanyNo = $('#StoreCompanyNo').val();
			
		$.ajax({
	        url: '../jsp/StoreInsert.jsp',
	        type: 'POST',
	        dataType: 'jsonp',
	        jsonp: 'insert',
	        data: { 
		    'StoreOwnerName': StoreOwnerName ,
		    'StoreName': StoreName  ,
		    'StoreAccount' : StoreAccount,
		    'StorePassword' : StorePassword ,
		    'StoreTel' : StoreTel,
		    'StoreAddress' : StoreAddress,
		    'StorePhone':StorePhone,
		    'StoreFax':StoreFax,
		    'StoreCompanyNo':StoreCompanyNo
	    },
	    success:function(json) {		        	 
	        alert('입력이 완료되었습니다.');
	    },
	    error:function(json){
	    	alert('입력값이 잘못되었습니다.');
	    	
	    }}); 
	});
	$('#cancel').click(function(){
		window.location.href = 'MemberInfo.jsp';
	});
})
</script>
</head>
<body>
	<div class = 'row'>
		<span class='LabelName'>점주 성함 : </span>
		<input type = 'text' class='StoreOwnerName' id = 'StoreOwnerName' placeholder = '점주님 성함을 입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>스토어 명 : </span>
		<input type = 'text' class='StoreName' id = 'StoreName' placeholder = '스토어명을 입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>스토어 아이디 : </span>
		<input type = 'text' class='StoreAccount' id = 'StoreAccount' placeholder = '스토어아이디를 입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>스토어 비밀번호 : </span>
		<input type = 'password' class='StorePassword' id = 'StorePassword' placeholder = '스토어 비밀번호를 입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>스토어 비밀번호 확인 : </span>
		<input type = 'password' class='StoreRePassword' placeholder = '스토어비밀번호를 재입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>스토어 주소 : </span>
		<input type = 'text' class='StoreAddress' id = 'StoreAddress'  placeholder = '스토어 전화번호를 입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>스토어 전화번호 : </span>
		<input type = 'text' class='StoreTel' id = 'StoreTel'  placeholder = '스토어 전화번호를 입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>스토어 휴대폰번호 : </span>
		<input type = 'text' class='StorePhone' id = 'StorePhone' placeholder = '스토어 휴대폰번호를 입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>스토어 팩스번호 : </span>
		<input type = 'text' class='StoreFax' id = 'StoreFax' placeholder = 'Fax번호를 입력해주세요'/>
	</div>
	<div class = 'row'>
		<span class='LabelName'>사업자 번호 : </span>
		<input type = 'text' class='StoreCompanyNo' id = 'StoreCompanyNo' placeholder = 'Fax번호를 입력해주세요'/>
	</div>
	<div class='row'>
		<button id='insert'>입력</button>
	</div>
		
</body>
</html>