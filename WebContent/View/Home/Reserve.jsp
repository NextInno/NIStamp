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


<script>
$(document).ready(function() {
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';
	if(Session_No == 'null') {
		document.location.href = "Login.jsp";
	}
	else{
		$('#NavBtn').click(function() {
			$('#Nav').slideToggle();
		});
		$('.NumBtn').click(function() {
			var SearchNum =  $('.SearchNum').val();
			SearchNum += $(this).text();
			$('.SearchNum').val(SearchNum);
		});
		$('.NumBtnC').click(function(){
			$('.SearchNum').val('');
			var SearchNum =  $('.SearchNum').val();
			$('.SearchNum').val(SearchNum);
		});
		$('.NumBtnB').click(function(){
			var SearchNum =  $('.SearchNum').val();
			SearchNum = SearchNum.substring(0, SearchNum.length - 1);	
			$('.SearchNum').val(SearchNum);
		});
		
		$('#MemberList').jqGrid({
			caption: '회원 목록'
			, url: '../../Controller/Member/MemberList.jsp'
			, mtype: 'POST'
			, datatype: 'JSON'
			, colNames: [ 'No', '이름', '생일', '성별', '휴대폰', '전화' ]
	        , colModel: [
	                { name: 'No', key:'No', index: 'No', width: 10, hidden: true },
	                { name: 'Name', index: 'Name', width: 80 },
	                { name: 'Birth', index: 'Birth', width: 130, align: 'center' },
	                { name: 'Gender', index: 'Gender', width: 70, align: 'center' },
	                { name: 'Phone', index: 'Phone', width: 160, align: 'center' },
	                { name: 'Tel', index: 'Tel', width: 160, align: 'center' }
        		]
		    , gridview: true
            , rownumbers: true
			, rowNum: 25
			, rowList: [25, 50, 100]
			, height: 400
			, width: 'auto'
			, viewrecords: true
			, multiselect: false
			, loadonce: true
			, ondblClickRow: function (rowid, rowIndex, cellIndex, event) {
				 var ret = $("#MemberList").getRowData(rowid);
				  alert(ret.Name);
	        }
			,onClickRow: function(rowid, rowIndex, cellIndex, event){
				var ret = $("#MemberList").getRowData(rowid);
				  alert(ret.Name);
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
		$('.NumBtnS').click(function() {
			var Phone = $('.SearchNum').val();
			$('#MemberList').setGridParam({
	            url: '../../Controller/Member/MemberList.jsp'
	            , datatype: 'JSON'
	            , mtype: 'POST'
	            , page: 1
	            , postData: {
	                FromDate: null,
	                ToDate: null,
	                Name: null,
	                Phone: $('.SearchNum').val(),
	                Birth: null
	            }
	        }).trigger('reloadGrid');
			$('.PopUpPage').css('display','block');
		});
		
		$('.SelectMember').click(function(){
			var SelectData = new Array();
			$('#MemberList tr').each(function(index){
				if($(this).attr('aria-selected') == 'true'){
					for( var i  = 2 ; i < 7 ; i++){
						SelectData[i-2] = $(this).children().eq(i).text();
					}
				}
			});
			var BirthDate = SelectData[1].split('-');
			$('.Name').text(SelectData[0]);	
			$('.BirthYear').text(BirthDate[0]);
			$('.BirthMonth').text(parseInt(BirthDate[1]));
			$('.BirthDate').text(parseInt(BirthDate[2]));
			$('.Gender').text(SelectData[2]);
			$('.Phone').text(SelectData[3]);
			$('.Tel').text(SelectData[4]);
			 /*  var ret = $("#MemberList").getRowData(No);
			  alert(ret.No); */
			$('.PopUpPage').css('display','none');
			$('.SearchNum').val('');
		});
		
	}
});
</script>
<style>
	.PopUpPage{
		display:none;
		position: absolute;
		top:100;
		left:0;
	}
</style>
</head>
<body>
<div id = 'header' class='clearfix col-md-12'>
	<div id = 'NavButton' class = 'col-md-12'>
		<input type = 'button' id = 'NavBtn' class = 'btn btn-default col-xs-12' value = '메뉴'/>
	</div>
	<div id = 'Nav' class= 'col-md-12 clearfix'>
		<a href= '../Member/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>적립하기</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>교환상품등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
	</div>
	<br/>
</div>
<div class='col-sm-12 col-xs-12 clearfix'>
	<div class='col-sm-push-9 pull-left col-sm-3 col-xs-12'>
		<input type='text' class='col-sm col-xs-12 text-right input-lg SearchNum'/>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>1</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>2</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>3</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>4</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>5</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>6</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>7</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>8</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>9</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtn'>0</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtnB'><-</button>
		<button class='btn btn-default col-sm-4 col-xs-4 text-center input-lg NumBtnC'>C</button>
		<button class='btn btn-default col-sm-12 col-xs-12 text-center input-lg NumBtnS'>검색</button>
	</div>
	<div id='MemberInfo' class='col-sm-pull-3 col-sm-9 col-xs-12 pull-right clearfix'>
		<div class='MemberInfo clearfix' style='border:1px solid #ccc'>
			<div class='col-sm-4 col-xs-12'>
				이름 :
				<span class='Name'>신세용</span>
			</div>
			 <div class='col-sm-8 col-xs-12'>
				생년월일 : 
				<span class='BirthYear'>1987</span> 년
				<span class='BirthMonth'>4</span> 월
				<span class='BirthDate'>5</span> 일
			</div>
			<div class='col-sm-4 col-xs-4'>
				성별 :
				<span class='Gender'>남자</span>
			</div>
			<div class='col-sm-8 col-xs-12'>
				휴대폰번호 :
				<span class='Phone'>010-5109-3286</span>
			</div>
			<div class='col-sm-8 col-xs-12'>
				전화번호 :
				<span class='Tel'>02-6453-3286</span>
			</div>
			
		</div>
	</div>
	<div id='PointInfo' class='col-sm-pull-3 col-sm-9 col-xs-12 pull-right'>
		<div id='PointArea'  style='border:1px solid #ccc'>
		
		</div>
	</div>
	<div class='col-sm-pull-3 col-sm-9 col-xs-12 pull-right'>
		3
	</div>
</div>
<div class='PopUpPage col-sm-push-2 col-sm-8 col-xs-12 clearfix'>
	<table id="MemberList"></table>
	<div id="MemberGridPager"></div>
	<button class='SelectMember btn btn-default col-sm-5 col-xs-5'>선택</button>
	<button class='cancelMember btn btn-default col-sm-push-2 col-xs-push-2 col-sm-5 col-xs-5'>취소</button>
</div>
</body>
</html>