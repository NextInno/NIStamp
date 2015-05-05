<%@ page language="java" contentType="javascript/jsonp; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="net.sf.json.*" %>
<%@ page import="ni.module.config.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
//  {ResultSet : 쿼리문 날린거 결과값 받는거}
//  {Statement : 디비 쿼리 날릴수 있게끔 만들어주는거}
// 	{DriverManager : 마리아 디비 연결 되도록 해주는거}
//	{Connection : 드라이버매니저 가지고 디비에 연결해주는거}
%>
<%! static Logger logger = Logger.getLogger("CategoryInsert.jsp"); %>
<%
// { 'Name' : 상품이름, 'CategoryBig' : 1차카테고리, 'CategoryMiddle' : 2차카테고리, 'Price' : 상품가격, 'Contents' : 상품설명 } 

	String pNo = request.getParameter("no");
	if(pNo == ""){
		pNo = null;
	}
	String sCategoryName = request.getParameter("CategoryName");
	String sParentNo = request.getParameter("ParentNo");
	String sName = request.getParameter("Name");
	String sIsUse = request.getParameter("IsUse");
	String sStore_No = (String)session.getAttribute("Store_No");
	String sinsert = request.getParameter("insert");
	
	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();
	
	try {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
		Statement stat = con.createStatement();
		ResultSet rs = null;
		String pQuery = "";
		
		if( sCategoryName != null && sParentNo != null && sName != null && sIsUse !=null) {
			Integer sCategoryNo = 0;
			
			if(pNo == null) {
				
				pQuery = "INSERT INTO Category (CategoryName, Store_No, ParentNo, Name, IsUse, CreateDate, CreateBy) ";
				pQuery += "VALUE ("+ sCategoryName + ", "+ sStore_No +", "+ sParentNo + ", "+ sName + ", '"+ sIsUse+ "', CURRENT_TIMESTAMP, "+ sStore_No +");";
			} else {
				sCategoryNo = Integer.parseInt(pNo);
				pQuery = "UPDATE Product SET CategoryName = '" + sCategoryName + "',  ParentNo = '" + sParentNo + "', Name = '" + sName + "', IsUse = '" + sIsUse + "' WHERE No = " + pNo +";";		
			}			
		} else {
			pQuery = "SELECT CategoryName, Name, ParentNo, IsUse FROM Product WHERE ProductNo = " + pNo;
		}
		rs = stat.executeQuery(pQuery);
		
		
		while(rs.next()) {
			sCategoryName = rs.getString("CategoryName");
			sName = rs.getString("Name");
			sParentNo = rs.getString("ParentNo");
			sIsUse = rs.getString("IsUse");
			
			
		}
		con.close();
	} catch(Exception e) {
		out.print("DB 접속 실패");
		e.printStackTrace();
	}
	out.println(sinsert + "(");
	out.println("{\"data\":{\"sCategoryName\":\""+ sCategoryName +"\",\"sName\":\""+ sName +"\",\"sParentNo\":\""+ sParentNo +"\",\"sIsUse\":\""+ sIsUse +"\"}}");
	out.println(")");
%>

