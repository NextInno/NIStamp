<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
	            	//$("#CategoryBig > option:selected").text(json.data.CategoryBig);
	        		//$("#CategoryMiddle > option:selected").text(json.data.CategoryMiddle);
	        		$('#cate1').val(json.data.CategoryBig);
	        		alert($('#cate1').val() + ', ' + json.data.CategoryBig);
	        		$("#Name").val(json.data.Name);
	        		$("#Price").val(json.data.Price);
	        		$("#Contents").val(json.data.Contents);
	        	    $('input[name="Saving"][value = '+json.data.Saving+']').attr('checked',true);
	        	    
	        		if(json.data.Saving == "0" ) {
	        			$("#SavingArea").show();
	        			$("#SavingInput").val(json.data.SavingInput);
	        		} else {
	        			$("#SavingArea").hide();
	        		}
	        		
	        	    $('input[name="Exchange"][value = '+json.data.Exchange+']').attr('checked',true);
	        		
	        		if(json.data.Exchange == "0"){
	        			$("#ExchangeArea").show();
		        	    $("#ExchangeInput").val(json.data.ExchangeInput);
	        		}else{		
	        			$("#ExchangeArea").hide();
	        		}
	        		 
	            },
	            error:function(json) {
	            	alert('등록시 입력 값을 확인해주세요!');
	            	alert('에러.\n' + json.data.Result);
	            }
			});
		} else {
			no = null;
		}
		
		//카테고리 로드 
		$.ajax({
			url: '../../Controller/Product/CategoryLoad.jsp',
	        type: 'POST',
	        dataType: 'JSON',
	        jsonp: 'insert',
	        data: { 
		   		'BigCategory' : '#'
	   		 },
	   		success:function(json) {
	   			//alert('123');
                $.each(json, function(idx, val) {
                	alert(idx + ', ' + val);
                });
	   			alert(json);
                
	 	    	var $CategoryBig = $('#CategoryBig');
                $CategoryBig.append($('<option value="">선택해주세요</option>'));
                for (var i = 0; i < json.rows.length; i++) {
                	alert('3');
                	/*
                	if($('#cate1').val() == json.rows[i].No) {
                        $CategoryBig.append($('<option value="' + json.rows[i].No + '" selected="selected">' + json.rows[i].CategoryName + '</option>'));
                    } else {
                        $CategoryBig.append($('<option value="' + json.rows[i].No + '">' + json.rows[i].CategoryName + '</option>'));
                    }
                	*/
                }
                alert('4');
	 	    },
	 	    error:function(json){
	 	    	alert('통신에러입니다..');
	     	}
	 	});
		
		//카테고리 선택 
		$('#CategoryBig').on('change',function(){
			if($(this).val() == 0){
				$('#CategoryMiddle').html("<option>2차 카테고리</option>");
			}
			else{
				$('#CategoryMiddle').html("");
				$.ajax({
					url: '../../Controller/Product/CategoryLoad.jsp',
			        type: 'POST',
			        dataType: 'JSON',
			        jsonp: 'insert',
			        data: { 
			        	'BigCategory' :$('#CategoryBig').val()
			   		 },
			   		success:function(json) {
			   			var temp ='';
			   			var TempMenuNo = -1;
			   			if( json.rows.length !=0 ){
			   				for(i = 0 ; i < json.rows.length; i++){
				 	    		var temp = "<option value='" + json.rows[i].No + "'>" + json.rows[i].CategoryName + "</option>";
				 	    		$('#CategoryMiddle').append(temp);
				 	    	}
			   				TempMenuNo = json.rows[0].No;
			   			}else{
			   				$('#CategoryMiddle').append("<option value ='-1'>등록된 메뉴가 없습니다.</option>");
			   			}
			 	    	
			 	    	$.ajax({
							url: '../../Controller/Product/CategoryMiddleLoad.jsp',
					        type: 'POST',
					        dataType: 'JSON',
					        jsonp: 'insert',
					        data: { 
						   		'BigCategory' : $('#CategoryBig').val()
						   		,'MiddleCategory' : $('#CategoryMiddle').first('option').val()
					   		 },
					   		success:function(json) {
								//alert("")
					 	    	
					 	    },
					 	    error:function(json){
					 	    	alert('통신에러입니다..');
					     	
					     	}
					 	 });
			 	    },
			 	    error:function(json){
			 	    	alert('통신에러입니다..');
			     	
			     	}
			 	 });
			}
			
		});
		
		if($('input[name="Saving"]:checked').val() == "0"){
			$("#SavingArea").show();
		}
		$("#SavingUse").click(function(){
			$("#SavingArea").show();
		});
		$("#SavingUnuse").click(function(){
			$("#SavingArea").hide();
			$("#SavingInput").val(0);
		});
		
		if($('input[name="Exchange"]:checked').val() == "0"){
			$("#ExchangeArea").show();
		}		
		$("#ExchangeUse").click(function(){
			$("#ExchangeArea").show();
		});
		$("#ExchangeUnuse").click(function(){
			$("#ExchangeArea").hide();
			$("#ExchangeInput").val(0);
		});
		
		//저장 할 때
		$("#insert").click(function(){
			var CategoryBig = $("#CategoryBig").val();
			var CategoryMiddle = $("#CategoryMiddle").val();
			var Name = $("#Name").val();
			var Price = $("#Price").val();
			var Contents = $("#Contents").val();
			var Saving = $('input[name="Saving"]:checked').val();
			var SavingInput = $("#SavingInput").val();
			var Exchange = $('input[name="Exchange"]:checked').val();
			var ExchangeInput = $("#ExchangeInput").val();
			var Image = $('#Image').val().split('\\');
			var ImageName = Image[Image.length-1];

			
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
					, 'ImageName' : ImageName
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
	<select id='CategoryBig' class='CategoryBig'>
	</select>
	<input type="hidden" id="cate1" value="" />
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='CategoryMiddleName' class = 'text-justify'>
	2차카테고리 :
	</label>
	<select id='CategoryMiddle' class='CategoryMiddle'>
		<option>2차 카테고리</option>
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
	<label for='Saving' class = 'text-justify'>
	적립가능여부 :
	</label>
	<label for='SavingUse'>
	사용
	</label>
	<input type='radio' id ='SavingUse' class='SavingUse' name = 'Saving' value = '0' checked>
	<label for='savingUnuse'>
	미사용
	</label>
	<input type='radio' id ='SavingUnuse' class='SavingUnuse' name = 'Saving' value = '1'>
</div>	
<div class='col-sm-12 col-xs-12' id="SavingArea">
	<label for='SavingInput' class = 'text-justify'>
	적립금액 :
	</label>
	<input type='text' id ='SavingInput' class='SavingInput' name = 'SavingInput'>
</div>
<div class='col-sm-12 col-xs-12'>
	<label for='Exchange' class = 'text-justify'>
	교환가능여부 : 
	</label>
	<label for='ExchangeUse'>
	사용
	</label>
	<input type='radio' id ='ExchangeUse' class='ExchangeUse' name = 'Exchange' value = '0' checked>
	<label for='ExchangeUnuse' >
	미사용
	</label>
	<input type='radio' id ='ExchangeUnuse' class='ExchangeUnuse' name = 'Exchange' value = '1'>
</div>
<div class='col-sm-12 col-xs-12' id="ExchangeArea">
	<label for='ExchangeInput' class = 'text-justify'>
	교환금액 :
	</label>
	<input type='text' id ='ExchangeInput' class='ExchangeInput' name = 'ExchangeInput'>
</div>
<div class ='col-sm-4 col-xs-12'>
	<button id='insert' class='btn btn-default col-sm-4 col-xs-5'>입력</button>
	<button id='cancel' class='btn btn-default col-sm-4 col-xs-5'>취소</button>
</div>

</body>
</html>