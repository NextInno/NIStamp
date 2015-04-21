<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>고객 등록</title>
<link href="../js/datePicker/jquery-ui.css" rel="stylesheet" type="text/css" />
<link href="../js/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
<link href="/resources/demos/style.css" rel="stylesheet" />
<script src="../js/datePicker/jquery-1.10.2.js"></script> 
<script src="../js/ui/1.11.4/jquery-ui.js"></script>
<script src="../js/datePicker/jquery.ui.datepicker.ko.js" type="text/javascript"></script>

<script>
$(document).ready(function() {
	$('#insert').click(function(){
		var Name = $('#memberName').val();
		var PhoneNum = $('#memberPhoneNumber').val();
		var BirthDay = $('#memberBirthDay').val();
		var Gender = $('input[name="gender"]:checked').val();
		var TelNum = $('#memberTelNumber').val();
		alert(Gender);
		
		$.ajax({
            type: 'POST',
            dataType: 'jsonp',
            jsonp: 'insert',
            data: { 
        	    'Name': Name
        	    , 'PhoneNum': PhoneNum
        	    ,'Gender' : Gender
        	    , 'BirthDay' : BirthDay
				, 'TelNum' : TelNum
		    },
            url: '../jsp/MemberInsert.jsp',
            // jsonp 값을 전달할 때 사용되는 파라미터 변수명
            // 이 속성을 생략하면 callback 파라미터 변수명으로 전달된다.
            success:function(json) {		        	 
        	    alert('<%=(String)session.getAttribute("Store_No")%>');
            },
            error:function(){
        	    alert('입력값이 잘못되었습니다.');
            }
        });
	});
	$('#cancel').click(function(){
		window.location.href = 'MemberInfo.jsp';
	});
	$('.datepicker').datepicker({
	    dateFormat: 'yyyy-mm-dd',
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    weekHeader: 'Wk',
	    changeMonth: true, //월 변경가능
	    changeYear: true, //년 변경가능
	    showMonthAfterYear: true, //년 뒤에 월 표시
	    buttonImageOnly: true, //이미지표시  
	    buttonText: '날짜를 선택하세요',
	    autoSize: true, //오토리사이즈(body등 상위태그의 설정에 따른다)
	    buttonImage: '../../js/datePicker/calendar.gif', //이미지주소
	    showOn: "both" //엘리먼트와 이미지 동시 사용
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