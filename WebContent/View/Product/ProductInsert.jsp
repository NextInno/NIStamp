<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>상품 등록</title>
<script src="../../js/datePicker/jquery-1.10.2.js"></script> 
<script src="../../js/datePicker/jquery-ui.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../css/MenuBtn.css" rel="stylesheet" type ="text/css"/>

<script>
$(document).ready(function(){
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';
	var no = '<%= request.getParameter("no")%>';
	
	if(Session_No == 'null') {
		document.location.href = "../Home/Login.jsp";
	} else{
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
	            success: function(json){
	            	$("#CategoryBig").val(json.data.CategoryBig);
	        		$("#CategoryMiddle").val(json.data.CategoryMiddle);
	        		$("#Name").val(json.data.Name);
	        		$("#Price").val(json.data.Price);
	        		$("#Contents").val(json.data.Contents);
	            },
	            error:function(){
	            	alert('입력 값을 확인해주세요!');
	            }
			});
		} else {
			no = null;
		}
		
		$("#insert").click(function(){
			var CategoryBig = $("#CategoryBig").val();
			var CategoryMiddle = $("#CategoryMiddle").val();
			var Name = $("#Name").val();
			var Price = $("#Price").val();
			var Contents = $("#Contents").val();
			var Saving = $('input[name="saving"]:checked').val();
			var SavingInput = $("#savingInput").val();
			var Exchange = $('input[name="exchange"]:checked').val();
			var ExchangeInput = $("#exchangeInput").val();			
			
			if(CategoryBig == "") {
				alert("카테고리를 입력하세요.");
				return;
			}
			if(CategoryMiddle == "") {
				alert("카테고리를 입력하세요.");
				return;
			}
			if(Name == "") {
				alert("상품명을 입력하세요.");
				return;
			}
			if(Price == "") {
				alert("상품가격을 입력하세요.");
				return;
			}
			
			$.ajax({
				type: 'POST',
				dataType: 'jsonp',
				jsonp: 'insert',
				url: '../../Controller/Product/ProductInsert.jsp',
				data: {
					  'CategoryBig' : CategoryBig
					, 'CategoryMiddle' : CategoryMiddle
					, 'Name' : Name
					, 'Price' : Price
					, 'Contents' : Contents
					, 'Saving' : Saving
					, 'SavingInput' : SavingInput
					, 'Exchange' : Exchange
					, 'ExchangeInput' : ExchangeInput
					, 'no' : no
				},
	            success: function(json) {
	            	if(json.data.Result == "Success") {
		            	var message = confirm("상품 리스트로 돌아가시겠습니까?");
		            	
		            	if(message == true) {
		            		alert("success");
		            		window.location.href="../Product/ProductList.jsp";
		            	} else {
		            		alert('에러.\n' + json.data.Result);
		            	}
	            	} else {
	            		alert('에러.\n' + json.data.Result);
	            	}
	            },
	            error:function(json) {
	            	alert('등록시 입력 값을 확인해주세요!');
	            	alert('에러.\n' + json.data.Result);
	            }
			})
		});
		$("#cancel").click(function() {
			window.location.href="../Product/ProductList.jsp";
		});

		if($('input[name="saving"]:checked').val() == "0"){
			$("#savingArea").show();
		}
		$("#savingUse").click(function(){
			$("#savingArea").show();
		});
		$("#savingUnuse").click(function(){
			$("#savingArea").hide();
		});
		
		if($('input[name="exchange"]:checked').val() == "0"){
			$("#exchangeArea").show();
		}		
		$("#exchangeUse").click(function(){
			$("#exchangeArea").show();
		});
		$("#exchangeUnuse").click(function(){
			$("#exchangeArea").hide();
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
<div class='col-sm-12 col-xs-12'>
	<label for='CategoryBigName' class = 'text-justify'>
	1차카테고리 :
	</label>
	<select id='CategoryBig' class='CategoryBig'>
		<option>1</option>
	</select>
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='CategoryMiddleName' class = 'text-justify'>
	2차카테고리 :
	</label>
	<select id='CategoryMiddle' class='CategoryMiddle'>
		<option>2</option>
	</select> 
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='ProductName' class = 'text-justify'>
	상품이름 :
	</label>
	<input type='text' id='Name' class='Name'>
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='ProductPrice' class = 'text-justify'>
	상품가격 :
	</label>
	<input type='text' id='Price' class='Price'> 
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='ProductImg' class = 'text-justify'>
	상품이미지 :
	</label>
	<input type="file" id="Image" class="Image">
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='ProductContents' class = 'text-justify'>
	상품설명 :
	</label>
	<textarea id="Contents" class="Contents"></textarea>
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='saving' class = 'text-justify'>
	적립가능여부 :
	</label>
	<label for='savingUse'>
	사용
	</label>
	<input type='radio' id ='savingUse' class='savingUse' name = 'saving' value = '0' checked>
	<label for='savingUnuse'>
	미사용
	</label>
	<input type='radio' id ='savingUnuse' class='savingUnuse' name = 'saving' value = '1'>
</div>	
<div class='col-sm-12 col-xs-12' id="savingArea">
	<label for='savingInput' class = 'text-justify'>
	적립금액 :
	</label>
	<input type='text' id ='savingInput' class='savingInput' name = 'savingInput'>
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='exchange' class = 'text-justify'>
	교환가능여부 :
	</label>
	<label for='exchangeUse'>
	사용
	</label>
	<input type='radio' id ='exchangeUse' class='exchangeUse' name = 'exchange' value = '0' checked>
	<label for='exchangeUnuse' >
	미사용
	</label>
	<input type='radio' id ='exchangeUnuse' class='exchangeUnuse' name = 'exchange' value = '1'>
</div>
<div class='col-sm-12 col-xs-12' id="exchangeArea">
	<label for='exchangeInput' class = 'text-justify'>
	교환금액 :
	</label>
	<input type='text' id ='exchangeInput' class='exchangeInput' name = 'exchangeInput'>
</div>
<div class ='col-sm-4 col-xs-12'>
	<button id='insert' class='btn btn-default col-sm-4 col-xs-5'>입력</button>
	<button id='cancel' class='btn btn-default col-sm-4 col-xs-5'>취소</button>
</div>

</body>
</html>