<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
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
			, colNames: [ 'No', '1차 카테고리', '2차 카테고리', '상품명', '상품가격', '상품설명', '적립가능여부', '교환가능여부' ]
	        , colModel: [
					{ name: 'No', index: 'No', width: 60, hidden: true , align: 'center'},
					{ name: 'CategoryBig', index: 'CategoryBig', width: 120 , align: 'center'},
					{ name: 'CategoryMiddle', index: 'CategoryMiddle', width: 120 , align: 'center'},
					{ name: 'Name', index: 'Name', width: 160 , align: 'center'},
					{ name: 'Price', index: 'Price', width: 100, formatter: 'integer', align: 'center' },
					{ name: 'Contents', index: 'Contents', width: 200 , align: 'center'},
					{ name: 'Saving', index: 'Saving', width: 100 , align: 'center'},
					{ name: 'Exchange', index: 'Exchange', width: 100 , align: 'center'} 
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
		$(window).resize(function () {
	        $('#ProductGrid').setGridWidth($(this).width() * .85);
	    });
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
	
	$('#searchStart').click(function(){
		$('#searchArea').slideToggle();
		$(this).css('visibility','hidden');
	})
	$('#searchCancel').click(function(){
		$('#searchArea').slideToggle();
		$('#searchStart').css('visibility','visible');
	});
	$('#LogOut').on('click',function(){
			var LogOutMessage = confirm("정말 로그아웃하시겠습니까?");
			if(LogOutMessage){
				location.href= '../../Controller/Home/LogOut.jsp'
			}
		})
});
</script>
</head>
<body>
<div id = 'header' class='clearfix'>
	<div id='IdArea' class='col-sm-12 col-xs-12 text-right clearfix'>
		<strong><%=session.getAttribute("ID")%></strong>님이 <strong>로그인</strong>하셨습니다.&nbsp;&nbsp;&nbsp;
		<button id = 'LogOut' class='btn btn-default'>로그아웃</button>
	</div>
	<div id = 'NavButton' class = 'col-sm-12 col-xs-12'>
		<input type = 'button' id = 'NavBtn' class = 'btn btn-default col-xs-12' value = '메뉴'/>
	</div>
	<div id = 'Nav' class= 'col-sm-12 col-xs-12 clearfix'>
		<a href= '../Home/Index.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>홈</a>
		<a href= '../Home/Reserve.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>적립하기</a>
		<a href= '../Member/MemberInsert.jsp' class='btn btn-default col-xs-12 col-sm-2' role = 'button'>회원등록</a>
		<a href= '../Product/ProductInsert.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>교환상품등록</a>
		<a href= '../Product/ProductList.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>상품목록</a>
		<a href= '../Store/StoreCondiction.jsp' class=' btn btn-default col-xs-12 col-sm-2' role = 'button'>매장현황</a>
	</div>
	<br/>
</div>
<br>
	<div class='col-sm-12 col-xs-12'>
		<button type="button" id = 'searchStart' class="btn btn-default col-md-1">검색하기</button>
	</div>
<br>
	<div id = 'searchArea' class='clearfix'>
		<form class="form-horizontal col-md-12">
			<div class= 'clearfix col-xs-12 col-sm-12'></div>
		    <div class="form-group col-xs-12 col-sm-4 clearfixs" >
		        <label for="Category">카테고리</label>
		      	<select id="CategoryBig" class="CategoryBig">
		      		<option value="0">---1차카테고리---</option>
		      	</select>
		      	<select id="CategoryMiddle" class="CategoryMiddle">
		      		<option value="0">---2차카테고리---</option>
		      	</select>
		    </div>
		    <div class= 'clearfix col-xs-12 col-sm-12'></div>
		    <div class="form-group col-xs-12 col-sm-4 clearfixs" >
		        <label for="name">상품이름</label>
		        <input type="text" class="form-control" id="name" placeholder="이름을 입력해주세요.">
		    </div>
		    <div class= 'clearfix col-xs-12 col-sm-12'></div>
		    <div class="form-group col-xs-12 col-sm-4 clearfixs" >
		        <label for="Price">상품가격</label>
		        <input type="text" class="form-control" id="Price" placeholder="가격을 입력해주세요.">
		    </div>
		    <div class= 'clearfix col-xs-12 col-sm-12'></div>
		    <div class="form-group col-xs-12 col-sm-4 clearfixs" >
		        <label for="saving">적립가능여부</label>
		      	<select id="saving" class="saving">
		      		<option value="0">사용</option>
		      		<option value="1">미사용</option>
		      	</select>
		   	</div>
		    <div class= 'clearfix col-xs-12 col-sm-12'></div>
		    <div class="form-group col-xs-12 col-sm-4 clearfixs" >
		        <label for="exchange">교환가능여부</label>
		      	<select id="exchange" class="exchange">
		      		<option value="0">사용</option>
		      		<option value="1">미사용</option>
		      	</select>
		    </div>
		</form>
		<div class= 'clearfix col-xs-12 col-sm-12'>
			<div class = ''>
				<button type="button" id = 'searchbtn' class="btn btn-default ">검색</button>
				<button type="button" id = 'searchCancel' class="btn btn-default ">취소</button>
				<button type="button" id = 'searchReset' class="btn btn-default ">초기화</button>
			</div>
		</div>
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