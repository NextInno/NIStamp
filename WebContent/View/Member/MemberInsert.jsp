<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>고객 등록</title>
<link href="../../js/datePicker/jquery-ui.css" rel="stylesheet" type="text/css" />
<link href="../../js/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src="../../js/datePicker/jquery-1.10.2.js"></script> 
<script src="../../js/datePicker/jquery.ui.datepicker.js" type="text/javascript"></script>

<script>
$(document).ready(function() {
	var no = '<%= request.getParameter("no")%>';
	if(no != '' && no != 'null'){
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
		$('.datepicker').datepicker();
		$('#cancel').click(function(){
			window.location.assign('../Home/Index.jsp');
		});
		
		$('#LogOut').on('click',function(){
			var LogOutMessage = confirm("정말 로그아웃하시겠습니까?");
			if(LogOutMessage){
				location.href= '../../Controller/Home/LogOut.jsp'
			}
					
		})
	}
	
});
</script>
</head>
<body>
<div id = 'header' class='clearfix'>
	<div id='IdArea' class='col-sm-12 col-xs-12 text-right clearfix'>
		<strong><%=session.getAttribute("ID")%></strong>님이 <strong>로그인</strong>하셨습니다.&nbsp;&nbsp;&nbsp;
		<button id = 'LogOut' class='btn btn-default'>로그아웃</button>
	</div>
	<div id = 'NavButton' class = 'col-sm-12 col-xs-12'>
		<input type = 'button' id = 'NavBtn' class = 'btn btn-default col-xs-12' value = '메뉴'/>
	</div>
	<div id = 'Nav' class= 'col-sm-12 col-xs-12 clearfix'>
		<a href= '../Home/Index.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>홈</a>
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>적립하기</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>교환상품등록</a>
		<a href= '../Product/ProductList.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>상품목록</a>
		<a href= '../Store/StoreCondiction.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>매장현황</a>
	</div>
	<br/>
</div>
<div id = 'container' class='col-sm-12 col-xs-12'>
	<div class = 'col-sm-12 col-xs-12 clearfix'>
		<label for='memberName' class = 'text-justify'>
			이름 : 
		</label>
		<input type='text' id ='memberName' class='memberName'>
	</div>
	<div class = 'col-sm-12 col-xs-12'>
		<label for='genderMale'>
			성별  : 남
		</label>
		<input type='radio' id ='genderMale' class='genderMale' name = 'gender' value = '0' checked>
		<label for='genderFemale' >
			여
		</label>
		 <input type='radio' id ='genderFemale' class='genderFemale' name = 'gender' value = '1'>
		
	</div>
	<div class = 'col-sm-12 col-xs-12'>
		<label for=memberPhoneNumber>휴대폰번호 : </label>
		<input type='text' id ='memberPhoneNumber' class='memberPhoneNumber'>
	</div>
	<div class = 'col-sm-12 col-xs-12'>
		<label for='memberBirthDay'>생년월일 :</label>
		<input type='text' id ='memberBirthDay' class='datepicker memberBirthDay'>

	</div>
	<div class = 'col-sm-4 col-xs-12'>
		<label for='memberTelNumber'>전화번호 : </label>
		<input type = 'text' id = 'memberTelNumber' class='memberTelNumber'>
		
	</div>
	<div class = 'col-sm-12 col-xs-12'>
		<p><button id='insert' class='insert btn btn-default col-sm-1 col-xs-5'>입력</button><button id='cancel' class='cancel btn btn-default col-sm-push-1 col-xs-push-2 col-sm-1 col-xs-5 '>취소</button></p>
	</div>

</div>

</body>
</html>