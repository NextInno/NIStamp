<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> Welcome To &amp; Stamp </title>
<link href="../../js/jqGrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
<link href="../../js/jqGrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="../../js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';
	if(Session_No == 'null') {
		document.location.href = "Login.jsp";
	}
	else{
		$('#MemberGrid').jqGrid({
			caption: '회원 목록'
			, url: '../../Controller/Member/MemberList.jsp'
			, mtype: 'POST'
			, datatype: 'JSON'
			, colNames: [ 'No', '이름', '생일', '성별', '휴대폰', '전화' ]
	        , colModel: [
	                { name: 'No', index: 'No', width: 60, hidden: true },
	                { name: 'Name', index: 'Name', width: 100 },
	                { name: 'Birth', index: 'Birth', width: 130, align: 'center' },
	                { name: 'Gender', index: 'Gender', width: 70, align: 'center' },
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
			, ondblClickRow: function (rowid, rowIndex, cellIndex, event) {
	            var rowdata = $('#MemberGrid').getRowData(rowid);
	            location.href = '../Member/MemberInsert.jsp?no=' + rowdata.No;
	        }
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
		//$('#MemberGrid').trigger('reloadGrid');
		$('#searchbtn').click(function() {
			alert($('#fromdate').val());
			alert($('#todate').val());
			$('#MemberGrid').setGridParam({
	            url: '../../Controller/Member/MemberList.jsp'
	            , datatype: 'json'
	            , mtype: 'post'
	            , page: 1
	            , postData: {
	                FromDate: $('#fromdate').val(),
	                ToDate: $('#todate').val()
	            }
	        }).trigger("reloadGrid");
		});
	}
});
</script>
</head>
<body>
<div>
	<input id="searchbtn" type="button" value="검색" /><br><br>
	<label>일자</label>
	<input id="fromdate" class="datepicker" value="" /> ~ <input id="todate" class="datepicker" value="" /><br><br> 
</div>
<table id="MemberGrid"></table>
<div id="MemberGridPager"></div>
</body>
</html>