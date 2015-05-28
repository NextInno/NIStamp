<%@ page language="java" contentType="javascript/jsonp; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="net.sf.json.*" %>
<%@ page import="ni.module.config.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<%
//  {ResultSet : 쿼리문 날린거 결과값 받는거}
//  {Statement : 디비 쿼리 날릴수 있게끔 만들어주는거}
// 	{DriverManager : 마리아 디비 연결 되도록 해주는거}
//	{Connection : 드라이버매니저 가지고 디비에 연결해주는거}
%>
<%! static Logger logger = Logger.getLogger("ProductRead.jsp"); %>
<%
// { 'Name' : 상품이름, 'CategoryBig' : 1차카테고리, 'CategoryMiddle' : 2차카테고리, 'Price' : 상품가격, 'Contents' : 상품설명 , 'Saving' : 적립여부, 'Exchange' : 교환여부, 'Image' : 상품이미지} 

	String pNo = request.getParameter("no");
	
	if(pNo == "") {
		pNo = null;
	}
	String pCategoryBig = request.getParameter("CategoryBig");
	String pCategoryMiddle = request.getParameter("CategoryMiddle");
	String pName = request.getParameter("Name");
	String pPrice = request.getParameter("Price");
	String pContents = request.getParameter("Contents");
	String pStore_No = (String)session.getAttribute("Store_No");
	String pSaving = request.getParameter("Saving");
	String pSavingInput = request.getParameter("SavingInput");
	String pExchange = request.getParameter("Exchange");
	String pExchangeInput = request.getParameter("ExchangeInput");
	String pImageURL = "";
	String pImageName = ""; //request.getParameter("ImageName");
	String pinsert = request.getParameter("insert");
    String pTest = null;
	
	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();
	String Result = "";

	request.setCharacterEncoding("EUC-KR");

	String saveFolder = "http://27.102.197.30:8080/NIStamp/storeage";
	String encType = "euc-kr";

	int maxSize = 5 * 1024 * 1024;

	try { 
		MultipartRequest multi = null;

		multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
		Enumeration params = multi.getParameterNames();

		while(params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = multi.getParameter(name);
			//out.println(name+"="+value+"<br>");//while문에 의해 반복수행되면서
            //name, value 변수에 담긴 값을 브라우저에 출력해준다.
		}

		Enumeration files = multi.getFileNames();

		
		while(files.hasMoreElements()) {
			String name = (String) files.nextElement();
			String filename = multi.getFilesystemName(name);
			String original = multi.getOriginalFileName(name);
			String type = multi.getContentType(name);

			File f = multi.getFile(name);
			
			pImageURL = saveFolder + original;
			
			if(f!=null) {
				//int pImageByte = f.length();
			}
	//		out.println("피라미터 이름 : "+name+"<br>");
	//		out.println("실제 파일 이름 : "+original+"<br>");
	//		out.println("저장된 파일 이름 : "+filename+"<br>");
	//		out.println("파일 타입 : "+type+"<br>");

	
	//	if(f!=null) {
	//	    	out.println("크기 : "+f.length()+"바이트");
    // 			out.println("<br>");
    //		}
   		}
		
	} catch(IOException ioe) {
		System.out.println(ioe);
	} catch(Exception e) {
		System.out.println(e);
	}
%>
<%
	
	try {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
		Statement stat = con.createStatement();
		ResultSet rs = null;
		String pQuery = "";
		
		Integer iProduct_No = 0;
		
		if(pNo == null) {
			pQuery="";
		}else {
			//pQuery = "SELECT CategoryBig, CategoryMiddle, Name, Price, Contents, Saving, SavingInput, Exchange, ExchangeInput FROM Product WHERE ProductNo = " + pNo;
			pQuery = "SELECT pro.No AS 'No'";
			pQuery += ", pro.ProductNo AS 'ProductNo'";
			pQuery += ", cate1.Name AS 'CategoryBig'";
			pQuery += ", cate2.Name AS 'CategoryMiddle'";
			pQuery += ", pro.Name AS 'Name'";
			pQuery += ", pro.Price AS 'Price'";
			pQuery += ", pro.Contents AS 'Contents'";
			pQuery += ", CASE pro.Saving WHEN 0 THEN '사용' ELSE '미사용' END AS 'Saving'";
			pQuery += ", CASE pro.Exchange WHEN 0 THEN '사용' ELSE '미사용' END AS 'Exchange' ";
			pQuery += " FROM Product pro";
			pQuery += " INNER JOIN Category cate1 ON pro.CategoryBig = cate1.No";
			pQuery += " INNER JOIN Category cate2 ON pro.CategoryMiddle = cate2.No";
			pQuery += " WHERE pro.IsDelete = 0 ";
			pQuery += " AND pro.ProductNo = " + pNo;
		}
		rs = stat.executeQuery(pQuery);
		
		if(pCategoryBig == null && pCategoryMiddle == null && pName == null && pPrice == null ) {
			while(rs.next()) {
				pCategoryBig = rs.getString("CategoryBig");
				pCategoryMiddle = rs.getString("CategoryMiddle");
				pName = rs.getString("Name");
				pPrice = rs.getString("Price");
				pContents = rs.getString("Contents");
				pSaving = rs.getString("Saving");
				pSavingInput = rs.getString("SavingInput");
				pExchange = rs.getString("Exchange");
				pExchangeInput = rs.getString("ExchangeInput");
			}
		}
		con.close();
		Result = "Success";
	} catch(Exception e) {
		Result = e.getMessage();
		e.printStackTrace();
	}
	out.println(pinsert + "(");
	out.println("{\"data\":{\"CategoryBig\":\""+ pCategoryBig +"\",\"CategoryMiddle\":\""+ pCategoryMiddle +"\",\"Name\":\""+ pName +"\",\"Price\":\""+ pPrice +"\",\"Contents\":\""+ pContents +"\",\"Saving\":\""+ pSaving +"\",\"SavingInput\":\""+ pSavingInput +"\",\"Exchange\":\""+ pExchange +"\",\"ExchangeInput\":\"" + pExchangeInput + "\",\"Result\":\"" + Result + "\"}}");
	out.println(")");
%>

