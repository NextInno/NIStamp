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
<%! static Logger logger = Logger.getLogger("ProductInsert.jsp"); %>
<%
// { 'Name' : 상품이름, 'CategoryBig' : 1차카테고리, 'CategoryMiddle' : 2차카테고리, 'Price' : 상품가격, 'Contents' : 상품설명 } 

	String pNo = request.getParameter("no");
	if(pNo == ""){
		pNo = null;
	}
	String pCategoryBig = request.getParameter("CategoryBig");
	String pCategoryMiddle = request.getParameter("CategoryMiddle");
	String pName = request.getParameter("Name");
	String pPrice = request.getParameter("Price");
	String pContents = request.getParameter("Contents");
	String pStore_No = (String)session.getAttribute("Store_No");
	String pinsert = request.getParameter("insert");
	
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
		
		if(pCategoryBig != null && pCategoryMiddle != null && pName != null && pPrice != null ) {
			Integer iProduct_No = 0;
			
			if(pNo == null) {
				String productNoQuery = "SELECT MAX(ProductNo) AS 'ProductNo' FROM Product WHERE Store_No = " + pStore_No + " GROUP BY Store_No"; 
				rs = stat.executeQuery(productNoQuery);
				rs.last();
				
				if(rs.getRow() == 0) {
					iProduct_No = 1;
				} else {
					iProduct_No = rs.getInt("ProductNo") + 1;
				}
				pQuery = "INSERT INTO Product (ProductNo, Store_No, CategoryBig, CategoryMiddle, Name, Price, Contents, CreateDate, CreateBy) ";
				pQuery += "VALUE ("+ iProduct_No + ", "+ pStore_No +", "+ pCategoryBig + ", "+ pCategoryMiddle + ", '"+ pName + "', "+ pPrice + ", '"+ pContents + "', CURRENT_TIMESTAMP, "+ pStore_No +");";
			} else {
				iProduct_No = Integer.parseInt(pNo);
				pQuery = "UPDATE Product SET CategoryBig = '" + pCategoryBig + "',  CategoryMiddle = '" + pCategoryMiddle + "', Name = '" + pName + "', Price = '" + pPrice + "' , Contents = '" + pContents + "WHERE ProductNo = " + pNo +";";		
			}			
		} else {
			pQuery = "SELECT CategoryBig, CategoryMiddle, Name, Price, Contents FROM Product WHERE ProductNo = " + pNo;
		}
		rs = stat.executeQuery(pQuery);
		
		if(pCategoryBig == null && pCategoryMiddle == null && pName == null && pPrice == null ) {
			while(rs.next()) {
				pCategoryBig = rs.getString("CategoryBig");
				pCategoryMiddle = rs.getString("CategoryMiddle");
				pName = rs.getString("Name");
				pPrice = rs.getString("Price");
				pContents = rs.getString("Contents");
			}
		}
		con.close();
	} catch(Exception e) {
		out.print("DB 접속 실패");
		e.printStackTrace();
	}
	out.println(pinsert + "(");
	out.println("{\"data\":{\"CategoryBig\":\""+ pCategoryBig +"\",\"CategoryMiddle\":\""+ pCategoryMiddle +"\",\"Name\":\""+ pName +"\",\"Price\":\""+ pPrice +"\",\"Contents\":\""+ pContents +"\"}}");
	out.println(")");
%>

