<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<%
	request.setCharacterEncoding("EUC-KR");

	String saveFolder = "C:/Users/신세용/workspace/AdminStamp/WebContent/storeage";
	String encType = "euc-kr";

	int maxSize = 5 * 1024 * 1024;

	try { 
		MultipartRequest multi = null;

		multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration params = multi.getParameterNames();

		while(params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = multi.getParameter(name);
			out.println(name+"="+value+"<br>");//while문에 의해 반복수행되면서
            //name, value 변수에 담긴 값을 브라우저에 출력해준다.
		}

		Enumeration files = multi.getFileNames();

		while(files.hasMoreElements()) {
			String name = (String) files.nextElement();
			String filename = multi.getFilesystemName(name);
			String original = multi.getOriginalFileName(name);
			String type = multi.getContentType(name);

			File f = multi.getFile(name);

			out.println("피라미터 이름 : "+name+"<br>");
			out.println("실제 파일 이름 : "+original+"<br>");
			out.println("저장된 파일 이름 : "+filename+"<br>");
			out.println("파일 타입 : "+type+"<br>");

			if(f!=null) {
		    	out.println("크기 : "+f.length()+"바이트");
     			out.println("<br>");
    		}
   		}
	} catch(IOException ioe) {
		System.out.println(ioe);
	} catch(Exception e) {
		System.out.println(e);
	}
%>
