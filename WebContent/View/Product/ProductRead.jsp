<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 조회</title>
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
 	var SavingValue = "";
 	var SavingText = ""; 
 	var ExchangeValue = "";
 	var ExchangeText = ""; 
	
	if(Session_No == 'null') {
		document.location.href = "../Home/Login.jsp";
	} else{
		//조회할 때 
		if(no != '' && no != 'null'){
			$.ajax({
				type: 'POST',
				dataType: 'jsonp',
				jsonp: 'insert',
				data:{
					 'no' : no
				},
				url: '../../Controller/Product/ProductRead.jsp',
	            success: function(json){

	            	$("#CategoryBigRead").text(json.data.CategoryBig);
	            	$("#CategoryMiddleRead").text(json.data.CategoryMiddle);
	        		$("#NameRead").text(json.data.Name);
	        		$("#PriceRead").text(json.data.Price);
	        		$("#ContentsRead").text(json.data.Contents);
	        	    
	        		SavingValue = json.data.Saving;
	        	  
	        	    if(SavingValue == "0"){
	        	    	SavingText = "사용";
	        	    }else{
	        	    	SavingText = "미사용";
	        	    }
	        	    
	        		$("#SavingRead").text(SavingText);
	        		
	        		if(SavingValue == "0"){
	        			$("#SavingArea").show();
	        			$("#SavingInputRead").text(json.data.SavingInput);
	        		}else{
	        			$("#SavingArea").hide();
	        		}   	   
	        	    
	        	    ExchangeValue = json.data.Exchange;
		        	  
	        	    if(ExchangeValue == "0"){
	        	    	ExchangeText = "사용";
	        	    }else{
	        	    	ExchangeText = "미사용";
	        	    }
	        	    $("#ExchangeRead").text(ExchangeText);
	        	    
	        		if(ExchangeValue == "0"){
	        			$("#ExchangeArea").show();
	        			  $("#ExchangeInputRead").text(json.data.ExchangeInput);
	        		}else{
	        			$("#ExchangeArea").hide();
	        		}
	        		 
	            },
	            error:function(){
	            	alert('조회 시 오류');
	            }
			});
		} else {
			no = null;
		}
		
		$("#edit").click(function(){
			location.href="../Product/ProductInsert.jsp?no=" + no;
		});
		$("#cancel").click(function() {
			window.location.href="../Product/ProductList.jsp";
		});
	}
});
</script>

</head>
<body>
<div id = 'header' class='clearfix'>
	<div id = 'NavButton' class = 'col-md-12'>
		<input type = 'button' id = 'NavBtn' class = 'btn btn-default col-xs-12' value = '메뉴'/>
	</div>
	<div id = 'Nav' class= 'col-md-12 clearfix'>
		<a href= '../Home/Index.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>홈</a>
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>적립하기</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>교환상품등록</a>
		<a href= '../Product/ProductList.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>상품목록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
	</div>
	<br/>
</div>



<div class='col-sm-12 col-xs-12'>
	<label for='CategoryBigName' class = 'text-justify'>
	1차카테고리 :
	</label>
	<span id="CategoryBigRead" class="CategoryBigRead"></span>
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='CategoryMiddleName' class = 'text-justify'>
	2차카테고리 :
	</label>
	<span id="CategoryMiddleRead"></span>
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='ProductName' class = 'text-justify'>
	상품이름 :
	</label>
	<span id="NameRead"></span>
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='ProductPrice' class = 'text-justify'>
	상품가격 :
	</label>
	<span id="PriceRead"></span> 
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='ProductImg' class = 'text-justify'>
	상품이미지 :
	</label>
	<span id="ImageRead"></span> 
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='ProductContents' class = 'text-justify'>
	상품설명 :
	</label>
	<span id="ContentsRead"></span> 
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='Saving' class = 'text-justify'>
	적립가능여부 :
	</label>
	<span id="SavingRead"></span> 
</div>	
<div class='col-sm-12 col-xs-12' id="SavingArea">
	<label for='SavingInput' class = 'text-justify'>
	적립금액 :
	</label>
	<span id="SavingInputRead"></span> 
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='Exchange' class = 'text-justify'>
	교환가능여부 : 
	</label>
	<span id="ExchangeRead"></span>
</div>
<div class='col-sm-12 col-xs-12' id="ExchangeArea">
	<label for='ExchangeInput' class = 'text-justify'>
	교환금액 :
	</label>
	<span id="ExchangeInputRead"></span>
</div>

<div class ='col-sm-4 col-xs-12'>
	<button id='edit' class='btn btn-default col-sm-4 col-xs-5'>수정</button>
	<button id='cancel' class='btn btn-default col-sm-4 col-xs-5'>취소</button>
</div>

</body>
</html>