<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�� ���</title>
    <link href="../datePicker/jquery-ui.css" rel="stylesheet" type="text/css" />
    
    <!-- <script src="../js/jquery-1.11.2.min.js" type="text/javascript"></script>
     <script src="../datePicker/jquery-ui-1.8.18.custom.min.js" type="text/javascript"></script>
    <script src="../datePicker/jquery-ui.min.js" type="text/javascript"></script>
    <script src="../datePicker/jquery.ui.datepicker.ko.js" type="text/javascript"></script>
    <script src="../datePicker/jquery.ui.datepicker.js" type="text/javascript"></script>  -->
    
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"> 
	 <script src="//code.jquery.com/jquery-1.10.2.js"></script> 
	  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	  <script src="../datePicker/jquery.ui.datepicker.ko.js" type="text/javascript"></script>
	    <link rel="stylesheet" href="/resources/demos/style.css">
	<script>
		$(function(){
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
			           data: { 'Name': Name , 'PhoneNum': PhoneNum  ,'Gender' : Gender, 'BirthDay' : BirthDay , 'TelNum' : TelNum},
			           url: '../jsp/memberinsert.jsp',
			           // jsonp ���� ������ �� ���Ǵ� �Ķ���� ������
			           // �� �Ӽ��� �����ϸ� callback �Ķ���� ���������� ���޵ȴ�.
			           jsonp: 'insert',
			           success:function(json) {		        	 
			        	  alert('<%=(String)session.getAttribute("Store_No")%>');
			           },
			           error:function(){
			        	   alert('�Է°��� �߸��Ǿ����ϴ�.');
			           }
			      });
			});
			$('#cancel').click(function(){
				window.location.href = 'memberinfo.jsp';
			});
			 $('.datepicker').datepicker({
		            dateFormat: 'yy-mm-dd',
		            monthNamesShort: ['1��', '2��', '3��', '4��', '5��', '6��', '7��', '8��', '9��', '10��', '11��', '12��'],
		            dayNamesMin: ['��', '��', 'ȭ', '��', '��', '��', '��'],
		            weekHeader: 'Wk',
		            changeMonth: true, //�� ���氡��
		            changeYear: true, //�� ���氡��
		            showMonthAfterYear: true, //�� �ڿ� �� ǥ��
		            buttonImageOnly: true, //�̹���ǥ��  
		            buttonText: '��¥�� �����ϼ���',
		            autoSize: true, //���丮������(body�� �����±��� ������ ������)
		            buttonImage: '../datePicker/calendar.gif', //�̹����ּ�
		            showOn: "both" //������Ʈ�� �̹��� ���� ���
		        }); 
			 /* $( ".datepicker" ).datepicker({ 
					 dateFormat: 'yy-mm-dd',
					 monthNamesShort: ['1��', '2��', '3��', '4��', '5��', '6��', '7��', '8��', '9��', '10��', '11��', '12��'],
					 dayNamesMin: ['��', '��', 'ȭ', '��', '��', '��', '��'],
					 weekHeader: 'Wk',
			            
			            
			            showMonthAfterYear: true, //�� �ڿ� �� ǥ��
					 changeMonth: true,
					 changeYear: true
				 }); */
			alert('hello');
		})
	</script>
</head>
<body>
<p>
	�̸�  : <input type='text' id ='memberName' class='memberName'> </p>
<p>
	����  : �� <input type='radio' id ='genderMale' class='genderMale' name = 'gender' value = '0' checked> �� <input type='radio' id ='genderFemale' class='genderFemale' name = 'gender' value = '1'></p>
<p>
	�޴�����ȣ : <input type='text' id ='memberPhoneNumber' class='memberPhoneNumber'>
</p>
<p>
	������� : <input type='text' id ='memberBirthDay' class='datepicker memberBirthDay'>
	
</p>
<p>
	��ȭ��ȣ : <input type = 'text' id = 'memberTelNumber' class='memberTelNumber'>
</p>
<p><button id='insert' class='insert'>�Է�</button><button id='cancel' class='cancel'>���</button></p>
</body>
</html>