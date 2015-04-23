<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고객 등록</title>
<link href="../../js/datePicker/jquery-ui.css" rel="stylesheet" type="text/css" />
<link href="../../js/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
<script src="../../js/datePicker/jquery-1.10.2.js"></script> 
<script src="../../js/datePicker/jquery.ui.datepicker.js" type="text/javascript"></script>

<script>
$(document).ready(function() {
	var no = '<%= request.getParameter("no")%>';
	if(no != ''){
		$.ajax({
            type: 'POST',
            dataType: 'jsonp',
            jsonp: 'insert',
            data: { 
        	    'no': no
		    },
		    url: '../../Controller/Member/MemberInsert.jsp',
            // jsonp 값을 전달할 때 사용되는 파라미터 변수명
            // 이 속성을 생략하면 callback 파라미터 변수명으로 전달된다.
            success:function(json) {		        	 
        	    $('#memberName').val(json.data.Name);
        	    $('#memberPhoneNumber').val(json.data.PhoneNum);
        	    $('#memberBirthDay').val(json.data.BirthDay);
        	    $('input[name="gender"][value = '+json.data.Gender+']').attr('checked',true);
        	    $('#memberTelNumber').val(json.data.TelNum);
        	    
            },
            error:function(){
        	    alert('입력값이 잘못되었습니다.');
            }
        });
	}
	$('#insert').click(function(){
		var Name = $('#memberName').val();
		var PhoneNum = $('#memberPhoneNumber').val();
		var BirthDay = $('#memberBirthDay').val();
		var Gender = $('input[name="gender"]:checked').val();
		var TelNum = $('#memberTelNumber').val();
		
		$.ajax({
            type: 'POST',
            dataType: 'jsonp',
            jsonp: 'insert',
            url: '../../Controller/Member/MemberInsert.jsp',
            data: { 
        	      'Name': Name
        	    , 'PhoneNum': PhoneNum
        	    , 'Gender' : Gender
        	    , 'BirthDay' : BirthDay
				, 'TelNum' : TelNum
				, 'no' : no
		    },
            // jsonp 값을 전달할 때 사용되는 파라미터 변수명
            // 이 속성을 생략하면 callback 파라미터 변수명으로 전달된다.
            success:function(json) {		        	 
        	    var message = confirm("메인화면으로 돌아가시겠습니까?");
        	    if(message == true){
        	    	window.location.href ="../Home/Index.jsp";
        	    }else{
        	    	window.location.reload(true);
        	    }
            },
            error:function(){
            	
        	    alert('입력값이 잘못되었습니다.1');
            }
        });
	});
	$('#cancel').click(function(){
		window.location.assign('MemberInfo.jsp');
	});
	
	alert('hello');
});
</script>
</head>
<body>
<p>
	이름  : <input type='text' id ='memberName' class='memberName'> </p>
<p>
	성별  : 남 <input type='radio' id ='genderMale' class='genderMale' name = 'gender' value = '0' checked> 여 <input type='radio' id ='genderFemale' class='genderFemale' name = 'gender' value = '1'></p>
<p>
	휴대폰번호 : <input type='text' id ='memberPhoneNumber' class='memberPhoneNumber'>
</p>
<p>
	생년월일 : <input type='text' id ='memberBirthDay' class='datepicker memberBirthDay'>
	
</p>
<p>
	전화번호 : <input type = 'text' id = 'memberTelNumber' class='memberTelNumber'>
</p>
<p><button id='insert' class='insert'>입력</button><button id='cancel' class='cancel'>취소</button></p>
</body>
</html>