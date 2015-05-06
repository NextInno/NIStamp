<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카테고리 목록 </title>

<link href="../../js/jqGrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
<link href="../../js/jqGrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../css/MenuBtn.css" rel="stylesheet" type ="text/css"/>
<link href="../../css/SearchArea.css" rel="stylesheet" type ="text/css"/>
<script src="../../js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<script src="../../js/datePicker/jquery-ui.js" type="text/javascript"></script>
<script src="../../js/datePicker/jquery.ui.datepicker-ko.js" type="text/javascript"></script>

<script>
$(document).ready(function() {
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';
	
	if(Session_No == 'null') {
		document.location.href = "../Home/Login.jsp";
	} else {
		$('#ProductGrid').jqGrid({
			caption: '상품 목록'
			, url: '../../Controller/Product/ProductList.jsp'
			, mtype: 'POST'
			, datatype: 'JSON'
			, postData: {
               Location: "Product"
			}
			, colNames: [ 'No', '1차 카테고리', '2차 카테고리', '상품명', '상품가격', '상품설명', '적립가능여부', '교환가능여부' ]
	        , colModel: [
					{ name: 'No', index: 'No', width: 60, hidden: true },
					{ name: 'CategoryBig', index: 'CategoryBig', width: 120 },
					{ name: 'CategoryMiddle', index: 'CategoryMiddle', width: 120 },
					{ name: 'Name', index: 'Name', width: 160 },
					{ name: 'Price', index: 'Price', width: 100, formatter: 'integer', align: 'right' },
					{ name: 'Contents', index: 'Contents', width: 200 },
					{ name: 'Saving', index: 'Saving', width: 150 },
					{ name: 'Exchange', index: 'Exchange', width: 150 } 
        		]
		    , gridview: true
            , rownumbers: true
			, rowNum: 25
			, rowList: [25, 50, 100]
			, pager: '#ProductGridPager'
			, height: 400
			, width: 'auto'
			, viewrecords: true
			, multiselect: true
			, loadonce: true
			, jsonReader: {
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
				, 'cloneToTop': false
			}
		);
		$('#refresh_ProductGrid').click(function() {
			search();
		});
		$('#Deletebtn').click(function(){
			var rowObject = $('#ProductGrid').getGridParam('selarrrow');
	        var data = "";
	        for (var i = 0; i < rowObject.length; i++) {
	            var rowdata = $('#ProductGrid').getRowData(rowObject[i]);
	            if ((i + 1) == rowObject.length) {
	                data += rowdata.No;
	            } else {
	                data += rowdata.No + ',';
	            }
	        }

	        if (rowObject.length == 0) {
	            alert('선택된 상품이 없습니다.');
	            return false;
	        } else {
	            if (!confirm(rowObject.length + '건을 삭제하시겠습니까?')) return;
				 
	            $.ajax({
	            	type: 'POST'
	                , dataType: 'jsonp'
	                , data: { 'No': data }
	                , url: '../../Controller/Product/ProductDelete.jsp'
	                , jsonp: 'delete'
	                , success: function(json) {
	    				alert('삭제 성공!');
	    				search();
	                }
	                , error: function(){
	            	    alert('삭제 실패ㅜ');
	                }
	            });
	        }
		});
		function search() {
			$('#ProductGrid').setGridParam({
	            url: '../../Controller/Product/ProductList.jsp'
	            , datatype: 'JSON'
	            , mtype: 'POST'
	            , page: 1
	            , postData: { }
	        }).trigger('reloadGrid');			
	 	}
        $("#insertpage").click(function(){
            window.location.href="../Product/ProductInsert.jsp";
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
<br>
<div class='col-sm-12 col-xs-12'>
	<table id="ProductGrid"></table>
	<div id="ProductGridPager"></div>
</div>
<br>
<div class='row col-sm-12 col-xs-1'>
   <input id="insertpage" type = 'button' value = "상품 등록">
   <input id="Deletebtn" type = 'button' value = "상품 삭제">
</div>
</body>
</html>