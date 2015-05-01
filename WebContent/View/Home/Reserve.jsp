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
	var SelectMemberNo = null;
	if(Session_No == 'null') {
		document.location.href = "Login.jsp";
	}
	else{
		$('#NavBtn').click(function() {
			$('#Nav').slideToggle();
		});
		$('.NumBtn').click(function() {
			var SearchNum =  $(this).siblings('input[type=text]').val();
			SearchNum += $(this).text();
			$(this).siblings('input[type=text]').val(SearchNum);
		});
		$('.NumBtnC').click(function(){
			$(this).siblings('input[type=text]').val('');
			var SearchNum =  $(this).siblings('input[type=text]').val();
			$(this).siblings('input[type=text]').val(SearchNum);
		});
		$('.NumBtnB').click(function(){
			var SearchNum =  $(this).siblings('input[type=text]').val();
			SearchNum = SearchNum.substring(0, SearchNum.length - 1);	
			$(this).siblings('input[type=text]').val(SearchNum);
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
			,ondblClickRow: function(rowid, rowIndex, cellIndex, event){
				var Data = $("#MemberList").getRowData(rowid);
				SelectMemberNo = Data.No;
				var BirthDate = Data.Birth.split('-');
				ShowMemberInfo(SelectMemberNo, Data.Name,BirthDate[0],parseInt(BirthDate[1]), parseInt(BirthDate[2]), Data.Gender, Data.Phone, Data.Tel);
				$('.PopUpPage').css('display','none');
				$('.SearchNum').val('');
				MemberPointSearch(SelectMemberNo);
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
		$('#NumBtnS').click(function() {
			var Phone = $('#SearchNum').val();
			$('#MemberList').setGridParam({
	            url: '../../Controller/Member/MemberList.jsp'
	            , datatype: 'JSON'
	            , mtype: 'POST'
	            , page: 1
	            , postData: {
	                FromDate: null,
	                ToDate: null,
	                Name: null,
	                Phone: $('#SearchNum').val(),
	                Birth: null
	            }
	        }).trigger('reloadGrid');
			$('.PopUpPage').css('display','block');
		});
		
		$('#SelectMember').on('click',function(){
			var SelectData = new Array();
			$('#MemberList tr').each(function(index){
				if($(this).attr('aria-selected') == 'true'){
					for( var i  = 1 ; i < 7 ; i++){
						SelectData[i-1] = $(this).children().eq(i).text();
					}
				}
			});
			var BirthDate = SelectData[2].split('-');
			SelectMemberNo = SelectData[0];
			ShowMemberInfo(SelectMemberNo, SelectData[1], BirthDate[0], parseInt(BirthDate[1]), parseInt(BirthDate[2]), SelectData[3], SelectData[4], SelectData[5]);
			$('.PopUpPage').css('display','none');
			$('.SearchNum').val('');
			MemberPointSearch(SelectMemberNo);
			
		});
		$('.PointInsertBtn').on('click',function(){
			var SavePointAmount = $('#SavePointAmount').val();
			var InsertMode = $(this).attr('id');
			var No = $('.No').text();
			if(SavePointAmount == ''){
				alert('입력값이 비어있습니다.');
			}else{
				InsertPoint(No, InsertMode,SavePointAmount);
			}
		});			
		$('#CancelSave').on('click',function(){
			document.location.reload();
		});
		
		$('.CancelMember').click(function(){
			$('.PopUpPage').css('display','none');
			$('.SearchNum').val('');
		})
		
	}
});
function MemberPointSearch(No){
	$.ajax({
        url: '../../Controller/Home/Point.jsp',
        type: 'POST',
        dataType: 'JSON',
        jsonp: 'insert',
        data: { 
	   		'No':No
    },
    success:function(json) {
    	$('#SearchNum').val('');
    	$('#SearchNum').removeAttr('id').attr('id','SavePointAmount');
    	$('#NumBtnS').addClass('hidden');
    	$('#SavPointAmount').val('');
    	$('#SavePoint').removeClass('hidden');
    	$('#UsePoint').removeClass('hidden');
    	$('#CancelSave').removeClass('hidden');
    	ShowPointInfo(10,json.rows[0].Point);
    },
    error:function(json){
    	alert('입력값이 잘못되었습니다.');
    	
    }}); 
}
function InsertPoint(No, Mode, Amount){
	var PointAmount;
	if(Mode == 'SavePoint'){
		PointAmount = Amount;
	}else{
		PointAmount = -Amount;
	}
	$.ajax({
        url: '../../Controller/Home/Point.jsp',
        type: 'POST',
        dataType: 'JSON',
        jsonp: 'insert',
        data: { 
	   		'No':No
	   		,'Point' : PointAmount
	    },
	    success:function(json) {
	    	var message = confirm("현재 "+$('.Name').text() +" 고객님의 총적립량은" +json.rows[0].Point + "입니다\n적립을 끝내시겠습니까?" );
	    	if(message){
	    		document.location.reload();
	    	}else{
	    		ShowPointInfo(10,json.rows[0].Point);
	    	}
	    	
	    },
	    error:function(json){
	    	alert('입력값이 잘못되었습니다.');
    }});
}
function ShowMemberInfo(No, Name, BirthYear, BirthMonth, BirthDate, Gender, Phone, Tel ){
	var MemberInfo = '';
		MemberInfo += "<div class='MemberInfo clearfix' style='border:1px solid #ccc'>\n";
		MemberInfo += "<div class='col-sm-4 col-xs-12 hidden'>번호 :\n";
		MemberInfo += "<span class='No'>"+ No +"</span>\n";
		MemberInfo += "</div>\n";
		MemberInfo += "<div class='col-sm-4 col-xs-12'>이름 :\n";
		MemberInfo += "<span class='Name'>"+ Name +"</span>\n";
		MemberInfo += "</div>\n";
		MemberInfo += "<div class='col-sm-8 col-xs-12'>생년월일 : \n";
		MemberInfo += "<span class='BirthYear'>"+ BirthYear +"</span> 년\n";
		MemberInfo += "<span class='BirthMonth'>"+ BirthMonth +"</span> 월\n";
		MemberInfo += "<span class='BirthDate'>"+ BirthDate +"</span> 일\n";
		MemberInfo += "</div>\n";
		MemberInfo += "<div class='col-sm-4 col-xs-4'>성별 :\n";
		MemberInfo += "<span class='Gender'>"+ Gender +"</span>\n";
		MemberInfo += "</div>\n";
		MemberInfo += "<div class='col-sm-8 col-xs-12'>휴대폰번호 :\n";
		MemberInfo += "<span class='Phone'>"+ Phone +"</span>\n";
		MemberInfo += "</div>\n";
		MemberInfo += "<div class='col-sm-8 col-xs-12'>전화번호 :\n";
		MemberInfo += "<span class='Tel'>"+ Tel +"</span>\n";
		MemberInfo += "</div>\n";
		MemberInfo += "</div>\n";
		$('#MemberInfo').html(MemberInfo);
}
function ShowPointInfo(totalStamp, Amount){
	var StampInfo = '';
		StampInfo += "<div class='clearfix'>\n<div class='col-sm-1 col-xs-1'></div>\n";
	for( var i = 0 ; i < totalStamp ; i ++){
		if(i < parseInt(Amount)){
			StampInfo += "<img src='../../images/StampImg/FullStamp.png' class='col-sm-2 col-xs-2 img-responsive'>\n";
			if(i == parseInt(totalStamp)/2){
				StampInfo += "</div>\n<br/>\n<div class='clearfix'>\n<div class='col-sm-1 col-xs-1'></div>\n";
			}
		}else{
			StampInfo += "<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2 img-responsive'>\n";
			if(i == parseInt(totalStamp)/2 -1){
				StampInfo += "</div>\n<br/>\n<div class='clearfix'>\n<div class='col-sm-1 col-xs-1'></div>\n";
			}
		}

	}
		StampInfo+="</div>\n</div>\n";
		$('.PointInfo').html(StampInfo);
	
}
</script>
<style>
	.PopUpPage{
		display:none;
		position: absolute;
		top:100;
		left:0;
	}
	.nullMember{
		border:1px solid #ccc; 
		padding : 90px 0;
		
	}
	.PointInfo{
		padding : 10px 0;
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
		<a href= '../Product/ProductList.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>상품목록</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Member/MemberInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
	</div>
	<br/>
</div>
<div class='col-sm-12 col-xs-12 clearfix'>
	<div class='col-sm-push-9 pull-left col-sm-3 col-xs-12'>
		<input id ='SearchNum' type='text' class='col-sm col-xs-12 text-right input-lg'/>
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
		<button id='NumBtnS' class='btn btn-default col-sm-12 col-xs-12 text-center input-lg'>고객 검색</button>
		<button id='SavePoint' class='btn btn-default col-sm-6 col-xs-6 text-center input-lg hidden PointInsertBtn'>적립</button>
		<button id='UsePoint' class='btn btn-default col-sm-6 col-xs-6 text-center input-lg hidden PointInsertBtn'>사용</button>
		<button id='CancelSave' class='btn btn-default col-sm-12 col-xs-12 text-center input-lg hidden'>취소</button>
	</div>
	<div id='MemberInfo' class='col-sm-pull-3 col-sm-9 col-xs-12 pull-right clearfix'>
		<div class='MemberInfo clearfix text-center nullMember'>
			고객을 선택해주세요			
		</div>
	</div>
	<div id='PointInfo' class='col-sm-pull-3 col-sm-9 col-xs-12 pull-right' >
		<div class='PointInfo clearfix'  style = 'border:1px solid #ccc'>
			<div class='clearfix'>
				<div class='col-sm-1 col-xs-1'></div>		
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2 img-responsive'>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
			</div>
			<br/>
			<div class='clearfix'>
				<div class='col-sm-1 col-xs-1'></div>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
				<img src='../../images/StampImg/NullStamp.png' class='col-sm-2 col-xs-2'>
			</div>
		</div>
	</div>		
	<div class='col-sm-pull-3 col-sm-9 col-xs-12 pull-right'>
		3
	</div>
</div>
<div class='PopUpPage col-sm-push-2 col-sm-8 col-xs-12 clearfix'>
	<table id="MemberList"></table>
	<div id="MemberGridPager"></div>
	<button id = 'SelectMember' class='SelectMember btn btn-default col-sm-5 col-xs-5'>선택</button>
	<button class='CancelMember btn btn-default col-sm-push-2 col-xs-push-2 col-sm-5 col-xs-5'>취소</button>
</div>
</body>
</html>