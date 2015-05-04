<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
</head>
<body>
<div id='header'>
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
</div>
<div id='container'>
	<div id='TitleArea' class = 'col-sm-push-2 col-sm-8 col-xs-12 clearfix' style='border: 1px solid #ccc'>
		<label for='TitleInput' class='text-left pull-left' style='padding-right:10px;'>제목  :  </label>
		<input type='text' id='TitleInput' name='TitleInput' class='col-sm-8 col-xs-10 ' placeholder='제목을 입력해주세요'>
	</div>
	<div id='TextContentArea' class='col-sm-push-2 col-sm-8 col-xs-12 clearfix' style='border: 1px solid #ccc'>
		<label for='Content' class='hidden'>Content</label>
		<textarea id = 'Content' name='Content' class='col-sm-12 col-xs-12' rows='20' resize='inherit' style='resize:inherit'></textarea>
	</div>
	<div id='ButtonArea' class='col-sm-push-2 col-sm-8 col-xs-12 clearfix' style='border:1px solid #ccc'>
		<input type='button' id='InsertNotice' class='btn btn-default col-sm-push-2 col-sm-2 col-xs-push-1 col-xs-3' role='button' value='저장'>
		<input type='button' id='InsertCancel' class='btn btn-default col-sm-push-6 col-sm-2 col-xs-push-4 col-xs-3' role='button' value='취소'>
	</div>
</div>
</body>
</html>