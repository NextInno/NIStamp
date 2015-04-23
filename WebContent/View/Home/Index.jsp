<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> Welcome To &amp; Stamp </title>
<link href="../../js/jqGrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
<link href="../../js/jqGrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="../../js/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
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
			$('#MemberGrid').setGridParam({
	            url: '../../Controller/Member/MemberList.jsp'
	            , datatype: 'JSON'
	            , mtype: 'POST'
	            , page: 1
	            , postData: {
	                FromDate: $('#fromdate').val(),
	                ToDate: $('#todate').val(),
	                Name: $('#name').val(),
	                Phone: $('#phone').val(),
	                Birth: $('#birth').val()
	            }
	        }).trigger('reloadGrid');
		});
		$('#Modify').click(function(){
			var ModifyMemberData = $('#MemberGrid').getGridParam("Phone");
			alert(ModifyMemberData);
			
		});
	}
});
</script>
</head>
<body>
<div>
	<input id="searchbtn" type="button" value="검색" /><br><br>
	<label>가입일자</label>
	<input id="fromdate" class="datepicker" value="" /> ~ <input id="todate" class="datepicker" value="" /><br><br>
	<label>이름</label>
	<input id="name" value="" /><br><br> 
	<label>전화번호</label>
	<input id="phone" value="" /><br><br>
	<label>생일</label>
	<input id="birth" value="" /><br><br> 
</div>
<table id="MemberGrid"></table>
<div id="MemberGridPager"></div>
<div class='row'>
	<input id = 'Modify' type = 'button' value = "고객 수정">
</div>
</body>
</html>