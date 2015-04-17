<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<%
	request.setCharacterEncoding("UTF-8");
%>
<body>
	<form action="viewPage.jsp" name = "frmName" method="POST" enctype="multipart/form-data">
	user<br/>
	<input type="text" name="user"><br/>
	title<br/>
	<input type="text" name="title"><br/>
	file<br/>
	<input type="file" name = " uploadFile">
	<input type="submit" value="UPLOAD">
	</form>
</body>
	
	


	