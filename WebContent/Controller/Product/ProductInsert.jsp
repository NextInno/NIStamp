<%@ page language="java" contentType="javascript/jsonp; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="net.sf.json.*" %>
<%@page import="ni.module.config.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
//  {ResultSet : 쿼리문 날린거 결과값 받는거}
//  {Statement : 디비 쿼리 날릴수 있게끔 만들어주는거}
// 	{DriverManager : 마리아 디비 연결 되도록 해주는거}
//	{Connection : 드라이버매니저 가지고 디비에 연결해주는거}

%>

<%! static Logger logger = Logger.getLogger("ProductInsert.jsp"); %>

<%
// { 'PName' : 상품이름, 'PCategory1' : 1차카테고리, 'PCategory2' : 2차카테고리, 'PPrice' : 상품가격, 'pContents' : 상품설명 } 


	String pNo = request.getParameter("no");
	String pCategory1 = request.getParameter("pCategory1");
	String pCategory2 = request.getParameter("pCategory2");
	String pName = request.getParameter("pName");
	String pPrice = request.getParameter("pPrice");
	String pContents = request.getParameter("pContents");
	String pStore_No = (String)session.getAttribute("Store_No");
	String pinsert = request.getParameter("insert");
	
	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();
	
	try{
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
		Statement stat = con.createStatement();
		ResultSet rs = null;
		String pQuery = null;
		if(pCategory1 != null && pCategory2 != null && pName != null && pPrice != null ){
			Integer iProduct_No=null;
			if(pNo == null){
				String productNoQuery = "SELECT MAX(ProductNo) AS 'ProductNo' FROM Product WHERE Store_No = " + pStore_No + " GROUP BY Store_No"; 
				rs = stat.executeQuery(productNoQuery);
				rs.last();
				iProduct_No =  rs.getInt("ProductNo") + 1;
				pQuery = "INSERT INTO Product (ProductNo, Store_No, pCategory1, pCategory2, pName, pPrice, pContents, CreateDate, CreateBy) ";
				pQuery += "VALUE ('"+ iProduct_No + "', '"+ Integer.parseInt(pStore_No) +"', '"+ pCategory1 + "', '"+ pCategory2 + "', '"+ pName + "', '"+ pPrice + "', '"+ pContents + "', CURRENT_TIMESTAMP, "+ Integer.parseInt(pStore_No) +")";
			}else{
				iProduct_No = Integer.parseInt(pNo);
				pQuery = "UPDATE Product SET pCategory1 = '" + pCategory1 + "',  pCategory2 = '" + pCategory2 + "', pName = '" + pName + "', pPrice = '" + pPrice + "' , pContents = '" + pContents + "WHERE ProductNo = " + pNo +";";		
			}
						
		}else{
			pQuery = "SELECT pCategory1, pCategory2, pName, pPrice, pContents FROM Product WHERE ProductNo = " + pNo;
		}
		rs = stat.executeQuery(pQuery);
		if(pCategory1 == null && pCategory2 == null && pName == null && pPrice == null ){
			while(rs.next()){
				pCategory1 = rs.getString("pCategory1");
				pCategory2 = rs.getString("pCategory2");
				pName = rs.getString("pName");
				pPrice = rs.getString("pPrice");
				pContents = rs.getString("pContents");
			}
		}
		con.close();
		
	}catch(Exception e){
		out.print("DB 접속 실패");
		e.printStackTrace();
	}
	
	out.println(pinsert + "(");
	out.println("{\"data\":{\"pCategory1\":\""+ pCategory1 +"\",\"pCategory2\":\""+ pCategory2 +"\",\"pName\":\""+ pName +"\",\"pPrice\":\""+ pPrice +"\",\"pContents\":"+ pContents +"}}");
	out.println(")");
%>

