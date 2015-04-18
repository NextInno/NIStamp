<%@ page language="java" contentType="text/html; charset=UTF-8)" pageEncoding="UTF-8"%>

<!DOCTYPE>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> Welcome To &amp; Stamp </title>

<link href="js/jqGrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
<link href="js/jqGrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="js/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="js/jqGrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>

<script>
$(document).ready(function() {
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';
	if(Session_No == 'null'){
		document.location.href = "login.jsp";
	}
	else{
		$('#MemberGrid').jqGrid({
			caption: '회원 목록'
			, url: 'jsp/MemberData.jsp'
			, mtype: 'POST'
			, datatype: 'JSON'
			, colNames: [ 'No', '이름', '생일', '성별', '휴대폰', '전화' ]
	        , colModel: [
	                { name: 'No', index: 'No', width: 60, hidden: true },
	                { name: 'Name', index: 'Name', width: 100 },
	                { name: 'Birth', index: 'Birth', width: 130, align: 'center' },
	                { name: 'Gender', index: 'Gender', width: 70, align: 'center', formatter: gender},
	                { name: 'Phone', index: 'Phone', width: 160, align: 'center' },
	                { name: 'Tel', index: 'Tel', width: 160, align: 'center' }
        		]
		    , gridview: true
            , rownumbers: true
			, rowNum: 25
			, rowList: [25, 50, 100]
			, pager: '#MemberGridPager'
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
		}).navGrid('#MemberGridPager',
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
		
		function gender(cellval, options, rowObject) {
			var html = '<label>';
			$.each(rowObject, function (index, value) {
	            if (index == 'Gender') {
	                if(value == '0') {
	                	html += "남자</label>";
	                } else {
	                	html += "여자</label>";
	                }
	            }
	        });
			return html;
		}		
		$('#MemberGrid').trigger('reloadGrid');		
	}
});
</script>
</head>
<body>
<table id="MemberGrid"></table>
<div id="MemberGridPager"></div>
</body>
</html>

