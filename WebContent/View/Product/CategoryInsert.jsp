<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>상품 등록</title>
<script src="../../js/datePicker/jquery-1.10.2.js"></script> 
<script src="../../js/datePicker/jquery-ui.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/jquery.jqGrid.src.js" type="text/javascript"></script>
<script src="../../js/jqGrid/js/i18n/grid.locale-kr.js" type="text/javascript"></script>
<link href="../../css/Bootstrap/css/bootstrap-theme.min.css" rel="stylesheet" />
<link href="../../css/Bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../css/MenuBtn.css" rel="stylesheet" type ="text/css"/>

<script>
$(document).ready(function(){
	var Session_No = '<%= (String)session.getAttribute("Store_No") %>';
	var no = '<%= request.getParameter("no")%>';
	alert(Session_No);

		//수정할 때 
		$.ajax({
			url: '../../Controller/Product/CategoryLoad.jsp',
	        type: 'POST',
	        dataType: 'JSON',
	        jsonp: 'insert',
	        data: { 
		   		'BigCategoryNo' : ''
	   		 },
	   		success:function(json) {
	   			var temp ='';
	   			var BigCategoryList = new Array();
	 	    	for(i = 0 ; i < json.rows.length; i++){
	 	    		var temp = "<option value='" + json.rows[i].No + "'>" + json.rows[i].CategoryName + "</option>";
	 	    		alert(temp);
	 	    		$('#BigCategory').append(temp);
	 	    		BigCategoryList.push(json.rows[i].CategoryName +',' + json.rows[i].No);
	 	    		 
	 	    	}
	 	    	alert(BigCategoryList);
	 	    	
	 	    },
	 	    error:function(json){
	 	    	alert('통신에러입니다..');
	     	
	     	}
	 	  });
		
	
});
</script>

</head>
<body>
<div id = 'header' class='clearfix'>
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
	<br/>
</div>
<div class='col-sm-pull-3 col-sm-9 col-xs-12 pull-right'>
		<select id='BigCategory' class='col-sm-4 col-xs-12'>
			<option value='0'>1차 카테고리</option>
		</select>
		<select id='MiddleCategory' class='col-sm-4 col-xs-12'>
			<option>2차 카테고리</option>
		</select>
		<select id='MenuList' class='col-sm-4 col-xs-12'>
			<option>메뉴</option>
		</select>
	</div>
</body>
</html>