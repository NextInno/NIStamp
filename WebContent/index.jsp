<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ page import="net.sf.json.util.JSONStringer" %>
<%@ page import="MyStamp.jqgrid" %>

<!DOCTYPE>
<html>
<head>

<%
jqgrid ij = new jqgrid();
JSONStringer js = ij.getDate();
%>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title> Welcome To & Stamp </title>

<link href="js/jqGrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
<link href="js/jqGrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script src="js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="js/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="js/jqGrid/js/i18n/grid.locale-en.js" type="text/javascript"></script>

<script>
$(document).ready(function() {
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';
	if(Session_No == 'null'){
		document.location.href = "login.jsp";
	}
	else{
		$('#MemberGrid').jqGrid({
			caption: '회원 목록'
			, mtype: 'POST'
			, datatype: 'json'
	        , colModel: [
	                   { name: 'No', index: 'No', Name: 'No', width: 60 },
	                   { name: 'Name', index: 'Name', Name: 'Name', width: 150 },
	                   { name: 'BirthDay', index: 'BirthDay', Name: 'BirthDay', width: 150 },
	                   { name: 'Gender', index: 'Gender', Name: 'Gender', width: 150 },
	                   { name: 'Phone', index: 'Phone', Name: 'Phone', width: 150 },
	                   { name: 'Tel', index: 'Tel', Name: 'Tel', width: 150 }
	                 ]
		    , gridview: true
            , rownumbers: true
			, rowNum: 25
			, rowList: [25, 50, 100]
			, pager: '#MemberGridPager'
			, height: 400
			, width: 550
			, viewrecords: true
			, multiselect: true
			, loadonce: true
		}).navGrid('#MemberGridPager',
			{ 'edit': false
				, 'add': false
				, 'del': false
				, 'search': false
				, 'refresh': true
				, 'view': false
				, 'position': 'left'
				, 'cloneToTop': false
			}
		);
		
		var mydata = eval('<%= js %>');
		for(var i = 0; i <= mydata.length; i++) {
			$.each(mydata[i], function(index, value) {
				//alert(index + ', ' + value);
			});
			$('#MemberGrid').addRowData(i + 1, mydata[i]);
		}
		$('#MemberGrid').jqGrid('reloadGrida'); 
	}
});
</script>
</head>
<body>
<table id="MemberGrid"></table>
<div id="MemberGridPager"></div>
</body>
</html>

