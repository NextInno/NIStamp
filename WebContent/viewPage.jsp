<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<%
	request.setCharacterEncoding("EUC-KR");

	String saveFolder = "C:/Users/�ż���/workspace/AdminStamp/WebContent/storeage";
	String encType = "euc-kr";

	int maxSize = 5 * 1024 * 1024;

	try { 
		MultipartRequest multi = null;

		multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration params = multi.getParameterNames();

		while(params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = multi.getParameter(name);
			out.println(name+"="+value+"<br>");//while���� ���� �ݺ�����Ǹ鼭
            //name, value ������ ��� ���� �������� ������ش�.
		}

		Enumeration files = multi.getFileNames();

		while(files.hasMoreElements()) {
			String name = (String) files.nextElement();
			String filename = multi.getFilesystemName(name);
			String original = multi.getOriginalFileName(name);
			String type = multi.getContentType(name);

			File f = multi.getFile(name);

			out.println("�Ƕ���� �̸� : "+name+"<br>");
			out.println("���� ���� �̸� : "+original+"<br>");
			out.println("����� ���� �̸� : "+filename+"<br>");
			out.println("���� Ÿ�� : "+type+"<br>");

			if(f!=null) {
		    	out.println("ũ�� : "+f.length()+"����Ʈ");
     			out.println("<br>");
    		}
   		}
	} catch(IOException ioe) {
		System.out.println(ioe);
	} catch(Exception e) {
		System.out.println(e);
	}
%>
