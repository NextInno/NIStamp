<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> Welcome To &amp; Stamp </title>

<link href="../../js/jqGrid/css/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
<link href="../../js/jqGrid/jquery-ui/jquery-ui.css" rel="stylesheet" type="text/css"/>
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../js/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
<link href="../../js/datePicker/jquery-ui.css" rel="stylesheet" type="text/css" />
<link href="../../js/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" /> 
<script src="../../js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<script src="../../js/datePicker/jquery-ui.js" type="text/javascript"></script>
<script src="../../js/datePicker/jquery.ui.datepicker-ko.js" type="text/javascript"></script>
<link href="../../css/MenuBtn.css" rel="stylesheet" type ="text/css"/>
<link href="../../css/SearchArea.css" rel="stylesheet" type ="text/css"/>


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
		$('#NavBtn').click(function(){
			$('#Nav').slideToggle();
		})
		$('#searchStart').click(function(){
			$('#searchArea').slideToggle();
			$(this).css('visibility','hidden');
			
		})
		$('#searchCancel').click(function(){
			$('#searchArea').slideToggle();
			$('#searchStart').css('visibility','visible');
			
		})
		$('#searchReset').click(function(){
			$('#fromdate').val('');
            $('#todate').val('');
            $('#name').val('');
            $('#phone').val('');
            $('#birth').val('');
            $('#searchbtn').click();
			
		})
		$('.datepicker').datepicker({
		      changeMonth: true,
		      changeYear: true,
		      yearRange: "1930:2015"
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
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>적립하기</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>교환상품등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
	</div>
	<br/>
	<div class='col-md-12 col-sm-2'>
		<button type="button" id = 'searchStart' class="btn btn-default col-md-1">검색하기</button>
	</div>
	<br/>
	<div id = 'searchArea' class='clearfix'>
		<form class="form-horizontal col-md-12">
			<div class="form-inline">
			  <div class="form-group col-sm-4 col-xs-12">
			    <label for="fromdate" class = ''>검색시작일</label>
			    <input type="text" class="form-control datepicker" id="fromdate" placeholder="시작 날짜">
			  </div>
			  
			  <div class="form-group col-sm-4 col-xs-12">
			    <label for="todate" class = ''>검색종료일</label>
			    <input type="text" class="form-control datepicker" id="todate" placeholder="종료 날짜">
			  </div>
			</div>
		  <div class= 'clearfix col-xs-12 col-sm-12'></div>
		  <div class="form-group col-xs-12 col-sm-4 clearfixs" >
		    <label for="name">이름</label>
		    <input type="text" class="form-control" id="name" placeholder="이름을 입력해주세요.">
		  </div>
		  <div class= 'clearfix col-xs-12 col-sm-12'></div>
		  <div class="form-group clearfix col-xs-12 col-sm-4 clearfix">
		    <label for="phone" class = >전화번호</label>
		    <input type="text" class="form-control" id="phone" placeholder="휴대폰번호를 입력해주세요.">
		  </div>
		  <div class= 'clearfix col-xs-12 col-sm-12'></div>
		  <div class="form-group col-xs-12 col-sm-4 clearfix">
		    <label for="birth">생일</label>
		    <input type="text" class="form-control datepicker" id="birth" placeholder="생일을 입력해주세요">
		  </div>
		  <div class= 'clearfix col-xs-12 col-sm-12'></div>
		</form>
		<div class= 'clearfix col-xs-12 col-sm-12'>
			<div class = ''>
				<button type="button" id = 'searchbtn' class="btn btn-default ">검색</button>
				<button type="button" id = 'searchCancel' class="btn btn-default ">취소</button>
				<button type="button" id = 'searchReset' class="btn btn-default ">초기화</button>
			</div>
			
		</div>
		
	</div>
	
</div>
<div class='col-sm-12 col-xs-12'>
	<table id="MemberGrid" ></table>
	<div id="MemberGridPager"></div>
</div>

<div class='row col-sm-12 col-xs-12'>
	<input id = 'Modify' type = 'button' value = "고객 수정">
</div>
</body>
</html>