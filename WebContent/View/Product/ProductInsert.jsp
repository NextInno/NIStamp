<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>��ǰ ���</title>
<script src="../../js/datePicker/jquery-ui.js" type="text/javascript"></script>
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../css/MenuBtn.css" rel="stylesheet" type ="text/css"/>

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
            // jsonp ���� ������ �� ���Ǵ� �Ķ���� ������
            // �� �Ӽ��� �����ϸ� callback �Ķ���� ���������� ���޵ȴ�.
            success: function(json){
            	var message = confirm("��ǰ ����Ʈ�� ���ư��ðڽ��ϱ�?");
            	if(message == true){
            		//window.location.href="";
            		alert("success");
            	}
            	else{
            		alert("error");
            	}
            },
            error:function(){
            	alert('�Է� ���� Ȯ�����ּ���!');
            }
		})
	});

	
});
	
</script>

</head>
<body>
<div id = 'header' class='clearfix'>
	<div id = 'NavButton' class = 'col-md-12'>
		<input type = 'button' id = 'NavBtn' class = 'btn btn-default col-xs-12' value = '�޴�'/>
	</div>
	<div id = 'Nav' class= 'col-md-12 clearfix'>
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>�����ϱ�</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>ȸ�����</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>��ȯ��ǰ���</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>ȸ�����</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>ȸ�����</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>ȸ�����</a>
	</div>
	<br/>
</div>
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
		<td align="center">��ǰ�� </td>
		<td align="center"><input type='text' id='pName' class='pName'></td>
		<td align="center">��ǰ ����</td>
		<td align="center"><input type='text' id='pPrice' class='pPrice'></td>
	</tr>
	<tr>	
		<td align="center">��ǰ ����</td>
		<td align="center" colspan="5">
			<textarea id="pContents" class="pContents"></textarea>	
		</td>
	</tr>
	<tr>
		<td align="center" colspan="6">
			<button id='insert' class='insert'>����</button>
			<button id='cancel' class='cancel'>���</button>
		</td>
	</tr>

</table>
</body>
</html>