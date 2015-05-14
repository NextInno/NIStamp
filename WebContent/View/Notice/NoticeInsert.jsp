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
	var no = '<%= request.getParameter("no")%>';
	if(no != '' && no != 'null'){
		$.ajax({
            type: 'POST',
            dataType: 'jsonp',
            jsonp: 'insert',
            data: { 
        	    'no': no
		    },
		    url: '../../Controller/Notice/NoticeInsert.jsp',
            // jsonp ���� ������ �� ���Ǵ� �Ķ���� ������
            // �� �Ӽ��� �����ϸ� callback �Ķ���� ���������� ���޵ȴ�.
            success:function(json) {
            	var StringTemp =json.data.Content.replace(/<br\/>/g, '\n');
        	    $('#TitleInput').val(json.data.Title);
        	    $('#ContentInput').val(StringTemp);
        	    $('#InsertNotice').val('����');
        	    
            },
            error:function(){
        	    alert('�Է°��� �߸��Ǿ����ϴ�.');
            }
        });
		$('#InsertNotice').click(function(){
			var Title = $('#TitleInput').val();
			var Content = $('#ContentInput').val();
			alert(Content);
			$.ajax({
	            type: 'POST',
	            dataType: 'jsonp',
	            jsonp: 'insert',
			    url: '../../Controller/Notice/NoticeInsert.jsp',
	            data: { 
	        	      'Title': Title
	        	    , 'Content': Content
					, 'no' : no
			    },
	            // jsonp ���� ������ �� ���Ǵ� �Ķ���� ������
	            // �� �Ӽ��� �����ϸ� callback �Ķ���� ���������� ���޵ȴ�.
	            success:function(json) {		        	 
	        	    var message = confirm("����ȭ������ ���ư��ðڽ��ϱ�?");
	        	    if(message == true){
	        	    	window.location.href ="Notice.jsp";
	        	    }else{
	        	    	window.location.reload(true);
	        	    }
	            },
	            error:function(){
	        	    alert('�Է°��� �߸��Ǿ����ϴ�.1');
	            }
	        });
		});
		$('#cancel').click(function(){
			window.location.assign('Notice.jsp');
		});
		
		$('#LogOut').on('click',function(){
			var LogOutMessage = confirm("���� �α׾ƿ��Ͻðڽ��ϱ�?");
			if(LogOutMessage){
				location.href= '../../Controller/Home/LogOut.jsp'
			}
		})
	}else{
		no = '';
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
	<div id='TitleArea' class = 'col-sm-push-2 col-sm-8 col-xs-12 clearfix' style='border: 1px solid #ccc'>
		<label for='TitleInput' class='text-left pull-left' style='padding-right:10px;'>����  :  </label>
		<input type='text' id='TitleInput' name='TitleInput' class='col-sm-8 col-xs-10 ' placeholder='������ �Է����ּ���'>
	</div>
	<div id='TextContentArea' class='col-sm-push-2 col-sm-8 col-xs-12 clearfix' style='border: 1px solid #ccc'>
		<label for='ContentIput' class='hidden'>Content</label>
		<textarea id = 'ContentInput' name='ContentInput' class='col-sm-12 col-xs-12' rows='20' resize='inherit' style='resize:inherit'></textarea>
	</div>
	<div id='ButtonArea' class='col-sm-push-2 col-sm-8 col-xs-12 clearfix' style='border:1px solid #ccc'>
		<input type='button' id='InsertNotice' class='btn btn-default col-sm-push-2 col-sm-2 col-xs-push-1 col-xs-3' role='button' value='����'>
		<input type='button' id='InsertCancel' class='btn btn-default col-sm-push-6 col-sm-2 col-xs-push-4 col-xs-3' role='button' value='���'>
	</div>
</div>
</body>
</html>