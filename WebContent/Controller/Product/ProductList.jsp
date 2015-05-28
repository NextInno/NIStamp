<%@ page language="java" contentType="javascript/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %> 
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="net.sf.json.*" %>
<%@ page import="ni.module.config.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%
//  {ResultSet : 쿼리문 날린거 결과값 받는거}
//  {Statement : 디비 쿼리 날릴수 있게끔 만들어주는거}
// 	{DriverManager : 마리아 디비 연결 되도록 해주는거}
//	{Connection : 드라이버매니저 가지고 디비에 연결해주는거}
%>
<%! static Logger logger = Logger.getLogger("ProductList.jsp"); %>
<%
	NiModuleConfig.setLogger();

	String pStore_No = (String)session.getAttribute("Store_No");
	String sLocation = (String)request.getParameter("Location");
	String sBigCategory = request.getParameter("BigCategory");
	String sNo = request.getParameter("no");
	if(sNo == ""){
		sNo = "0";
	}
	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();
	
	String pQuery = "";

	logger.info("ProductList!");
	
	JSONObject responcedata = new JSONObject();
	
	try {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
		
		if(sLocation == "Reserve") {
			pQuery = "SELECT No, Name, Price FROM Product WHERE IsDelete = 0 AND Store_No = " + pStore_No + " AND CategoryMiddle = " + sNo + "AND CategoryBig = " + sBigCategory;
				
		} else {
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
			pQuery += " AND pro.Store_No = " + pStore_No;
		}
		pQuery += ";";
		
		logger.debug(pQuery);
		
		PreparedStatement stmt = con.prepareStatement(pQuery);
		ResultSet rs = stmt.executeQuery();
	    JSONArray cellarray = new JSONArray();

	    rs.last();
	    responcedata.put("total", rs.getRow());
	    responcedata.put("page", 1);
	    responcedata.put("records", rs.getRow());
	    
	    rs.beforeFirst();
	    JSONObject cellobj = new JSONObject();
	    if(sLocation != "Reserve") {
	    	 while(rs.next()) {
	 	    	cellobj.put("No", rs.getString("No"));
	  	        cellobj.put("CategoryBig", rs.getString("CategoryBig"));
	 			cellobj.put("CategoryMiddle", rs.getString("CategoryMiddle"));
	 			cellobj.put("Name", rs.getString("Name"));
	 			cellobj.put("Price", rs.getString("Price"));
	 			cellobj.put("Contents", rs.getString("Contents"));
	 			cellobj.put("Saving", rs.getString("Saving"));
	 			cellobj.put("Exchange", rs.getString("Exchange"));
	 	    	cellarray.add(cellobj);
	 	    }
	    } else {
	    	while(rs.next()) {
	 	    	cellobj.put("No", rs.getString("No"));
	 			cellobj.put("Name", rs.getString("Name"));
	 			cellobj.put("Price", rs.getString("Price"));
	 	    	cellarray.add(cellobj);
	 	    }
	    }
	    responcedata.put("rows", cellarray);
		stmt.close();
		con.close();
	} catch (Exception ex) {
		System.out.println("Error - " + ex.getMessage());
	}
	out.print(responcedata.toString());
%>