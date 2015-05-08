<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>Insert title here</title>
<script src="../../js/jquery-1.11.2.min.js" type="text/javascript"></script>
<script>
$(document).ready(function() {
	$('#insert_member').click(function(){
		location.assign('MemberInsert.jsp');
	});
});
</script>
</head>
<body>
	<button id='insert_member' class='insert_member' >맴버등록</button>
</body>
</html>