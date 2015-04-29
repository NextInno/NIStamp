<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 목록</title>
<script src="../../js/datePicker/jquery-1.10.2.js"></script> 
<script src="../../js/datePicker/jquery-ui.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../css/MenuBtn.css" rel="stylesheet" type ="text/css"/>
<link href="../../js/jqGrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
<link href="../../js/jqGrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css"/>



<script>
$(document).ready(function(){
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';

	if(Session_No != '' && Session_No != 'null'){

		$("#ProductGrid").jqGrid({
			caption: '상품 목록'
			, url: '../../Controller/Product/ProductList.jsp'
			, mtype: 'POST'
			, dataType: 'JSON'
			, colNames: ['No', '1차카테고리', '2차카테고리', '상품명', '삼품가격', '상품설명' ]
			, colModel: [
			    { name: 'No', index: 'No', width: 60, hidden: true},
			    { name: 'CategoryBig', index: 'CategoryBig', width: 100},
			    { name: 'CategoryMiddle', index: 'CategoryMiddle', width: 100},
			    { name: 'Name', index: 'Name', width: 100},
			    { name: 'Price', index: 'Price', width: 100},
			    { name: 'Contents', index: 'Contents', width: 200},         
			 ]
			, gridView: true
			, rownumbers: true
			, rowNum: 25
			, rowList: [25,50,100]
			, pager: '#ProductGridPager'
			, height: 400
			, width: 'auto'
			, viewrecords: true
			, multiselect: true
			, loadonce: true
			, jsonReader:{
				page: 'page',
				total: 'total',
				root: 'rows',
				records: function(obj){ return obj.length; },
				repeatitems: false
			}
		}).navGrid('#ProductGridPager',
			{
				'edit': false
				, 'add': false
				, 'del': false
				, 'search': false
				, 'refresh': true
				, 'view': false
				, 'position': 'left'
				, 'cloneToTop' : false

			}
		);
		
		
	}else{
		document.location.href = "../Home/Login.jsp";
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
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>적립하기</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>교환상품등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
	</div>
	<br/>
</div>

<div>
	<table id="ProductGrid"></table>
	<div id="ProductGridPager"></div>
</div>
</body>
</html>