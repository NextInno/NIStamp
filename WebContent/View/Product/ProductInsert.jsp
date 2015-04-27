<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>상품 등록</title>
<script src="//code.jquery.com/jquery-1.10.2.js"></script> 

<script>
$(document).ready(function(){
	$("#insert").click(function(){
		var pCategory1 = $("#pCategory1 option").val();
		var pCategory2 = $("#pCategory2").val();
		var pName = $("#pName").val();
		var pPrice = $("#pPrice").val();
		var pContents = $("#pContents").val();
		
		//alert(pCategory1);
		//alert(pCategory2);
		//alert(pName);
		//alert(pPrice);
		//alert(pContents);
		
		$.ajax({
			type: 'POST',
			dataType: 'jsonp',
			jsonp: 'insert',
			url: '../..Controller/Product/ProductInsert.jsp',
			data:{
				 'pCategory1' : pCategory1
				,'pCategory2' : pCategory2
				,'pName' : pName
				,'pPrice' : pPrice
				,'pContents' : pContents
				, 'no' : no
			},
            // jsonp 값을 전달할 때 사용되는 파라미터 변수명
            // 이 속성을 생략하면 callback 파라미터 변수명으로 전달된다.
            success: function(json){
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
            	alert('입력 값을 확인해주세요!');
            }
		})
	});

	
});
	
</script>

</head>
<body>
<table width="100%" border="1px" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center">
			<select id='pCategory1' class='pCategory1'>
				<option>1</option>
			</select> 
		</td>
		<td align="center">
			<select id='pCategory2' class='pCategory2'>
				<option>2</option>
			</select> 
		</td>
		<td align="center">상품명 </td>
		<td align="center"><input type='text' id='pName' class='pName'></td>
		<td align="center">상품 가격</td>
		<td align="center"><input type='text' id='pPrice' class='pPrice'></td>
	</tr>
	<tr>	
		<td align="center">상품 설명</td>
		<td align="center" colspan="5">
			<textarea id="pContents" class="pContents"></textarea>	
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