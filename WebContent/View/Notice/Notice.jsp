<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>Welecome to &amp;Stamp</title>
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
		document.location.href = "Login.jsp";
	}
	else{
		$('#MemberGrid').jqGrid({
			caption: 'ȸ�� ���'
			, url: '../../Controller/Notice/NoticeList.jsp'
			, mtype: 'POST'
			, datatype: 'JSON'
			, colNames: [ 'No', '����', '�ۼ���' ]
	        , colModel: [
	                { name: 'No', index: 'No', width: 60, hidden: true },
	                { name: 'Title', index: 'Name', width: 150 },
	                { name: 'CreateDate', index: 'CreateDate', width: 50, align: 'center' }
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
	            location.href = '../Notice/NoticeInsert.jsp?no=' + rowdata.No;
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
		$('#Modifybtn').click(function(){
			var ModifyMemberData = $('#MemberGrid').getGridParam("Phone");
			alert(ModifyMemberData);
		});
		$('#Deletebtn').click(function(){
			var rowObject = $('#MemberGrid').getGridParam('selarrrow');
	        var data = "";
	        for (var i = 0; i < rowObject.length; i++) {
	            var rowdata = $('#MemberGrid').getRowData(rowObject[i]);
	            if ((i + 1) == rowObject.length) {
	                data += rowdata.No;
	            } else {
	                data += rowdata.No + ',';
	            }
	        }

	        if (rowObject.length == 0) {
	            alert('���õ� �ڷᰡ �����ϴ�.');
	            return false;
	        } else {
	            if (!confirm(rowObject.length + '���� �����Ͻðڽ��ϱ�?')) return;
				 
	            $.ajax({
	            	type: 'POST'
	                , dataType: 'jsonp'
	                , data: { 'No': data }
	                , url: '../../Controller/Member/MemberDelete.jsp'
	                , jsonp: 'delete'
	                , success: function(json) {
	    				alert('���� ����!');
	                }
	                , error: function(){
	            	    alert('���� ���Ф�');
	                }
	            });
	        }
	        $('#searchbtn').click();
		});
	}
});
</script>
</head>
<body>
<div id = 'header' class='clearfix'>
	<div id='IdArea' class='col-sm-12 col-xs-12 text-right clearfix'>
		<strong><%=session.getAttribute("ID")%></strong>���� <strong>�α���</strong>�ϼ̽��ϴ�.&nbsp;&nbsp;&nbsp;
		<button id = 'LogOut' class='btn btn-default'>�α׾ƿ�</button>
	</div>
	<div id = 'NavButton' class = 'col-sm-12 col-xs-12'>
		<input type = 'button' id = 'NavBtn' class = 'btn btn-default col-xs-12' value = '�޴�'/>
	</div>
	<div id = 'Nav' class= 'col-sm-12 col-xs-12 clearfix'>
		<a href= '../Home/Index.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>Ȩ</a>
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>�����ϱ�</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>ȸ�����</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>��ȯ��ǰ���</a>
		<a href= '../Product/ProductList.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>��ǰ���</a>
		<a href= '../Store/StoreCondiction.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>������Ȳ</a>
	</div>
	<br/>
</div>
<div id='container'>
	<div class='col-sm-12 col-xs-12'>
		<table id="MemberGrid" ></table>
		<div id="MemberGridPager"></div>
	</div>
	<div class='row col-sm-12 col-xs-12'>
		<input id="Modifybtn" type = 'button' value = "�� ����">
		<input id="Deletebtn" type = 'button' value = "�� ����">
	</div>
	
</div>


</body>
</html>