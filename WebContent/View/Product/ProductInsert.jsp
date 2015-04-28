<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 등록</title>
<script src="../../js/datePicker/jquery-1.10.2.js"></script> 
<script src="../../js/datePicker/jquery-ui.js" type="text/javascript"></script>
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../css/MenuBtn.css" rel="stylesheet" type ="text/css"/>

<script>
$(document).ready(function(){
	var no = '<%=request.getParameter("no")%>';
	//수정할 때 
	if(no != '' && no != 'null'){
		$.ajax({
			type: 'POST',
			dataType: 'jsonp',
			jsonp: 'insert',
			data:{
				'no' : no
			},
			url: '../../Controller/Product/ProductInsert.jsp', 
            // jsonp 값을 전달할 때 사용되는 파라미터 변수명
            // 이 속성을 생략하면 callback 파라미터 변수명으로 전달된다.
            success:function(jsonp){
            	$("#CategoryBig").val(json.data.CategoryBig);
        		$("#CategoryMiddle").val(json.data.CategoryMiddle);
        		$("#Name").val(json.data.Name);
        		$("#Price").val(json.data.Price);
        		$("#Contents").val(json.data.Contents);
            },
            error:function(){
            	alert('입력 값을 확인해주세요!');
            }
		})
	}else{
		no = null;
	}
	
	$("#insert").click(function(){
		var CategoryBig = $("#CategoryBig").val();
		var CategoryMiddle = $("#CategoryMiddle").val();
		var Name = $("#Name").val();
		var Price = $("#Price").val();
		var Contents = $("#Contents").val();
		
		alert(CategoryBig);
		alert(CategoryMiddle);
		alert(Name);
		alert(Price);
		alert(Contents);
		
		$.ajax({
			type: 'POST',
			dataType: 'jsonp',
			jsonp: 'insert',
			url: '../../Controller/Product/ProductInsert.jsp',
			data:{
				  'CategoryBig' : CategoryBig
				, 'CategoryMiddle' : CategoryMiddle
				, 'Name' : Name
				, 'Price' : Price
				, 'Contents' : Contents
				, 'no' : no
			},
            // jsonp 값을 전달할 때 사용되는 파라미터 변수명
            // 이 속성을 생략하면 callback 파라미터 변수명으로 전달된다.
            success:function(json){
            	var message = confirm("상품 리스트로 돌아가시겠습니까?");
            	if(message == true){
            		//window.location.href="";
            		alert("success");
            	}
            	else{
            		alert("error");
            	}
            },
            error:function(){
            	alert('등록시 입력 값을 확인해주세요!');
            }
		})
	});

	
});
	
</script>

</head>
<body>
<div id = 'header' class='clearfix'>
	<div id = 'NavButton' class = 'col-md-12'>
		<input type = 'button' id = 'NavBtn' class = 'btn btn-default col-xs-12' value = '메뉴'/>
	</div>
	<div id = 'Nav' class= 'col-md-12 clearfix'>
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>적립하기</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>교환상품등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
	</div>
	<br/>
</div>
<table width="100%" border="1px" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center">
			<select id='CategoryBig' class='CategoryBig'>
				<option>1</option>
			</select> 
		</td>
		<td align="center">
			<select id='CategoryMiddle' class='CategoryMiddle'>
				<option>2</option>
			</select> 
		</td>
		<td align="center">상품명 </td>
		<td align="center"><input type='text' id='Name' class='Name'></td>
		<td align="center">상품 가격</td>
		<td align="center"><input type='text' id='Price' class='Price'></td>
	</tr>
	<tr>	
		<td align="center">상품 설명</td>
		<td align="center" colspan="5">
			<textarea id="Contents" class="Contents"></textarea>	
		</td>
	</tr>
	<tr>
		<td align="center" colspan="6">
			<button id='insert' class='insert'>저장</button>
			<button id='cancel' class='cancel'>취소</button>
		</td>
	</tr>

</table>
</body>
</html>