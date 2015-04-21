<%@ page language="java" contentType="javascript/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="net.sf.json.*" %>
<%@ page import="ni.module.config.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%! static Logger logger = Logger.getLogger("MemberList.jsp"); %>

<%
NiModuleConfig.setLogger();

String sStore_No = (String)session.getAttribute("Store_No");
String driverName = "org.mariadb.jdbc.Driver";
String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
String DB_id = NiModuleConfig.getInstance().getDB_ID();
String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();

String sQuery = "";
String sFromDate = request.getParameter("fromdate");
String sToDate = request.getParameter("todate");

logger.info( "MemberList!");

JSONObject responcedata = new JSONObject();

try {			
    Class.forName(driverName);
	Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
	
	sQuery = "SELECT No, Name, Birth, CASE Gender WHEN 0 THEN '남자' ELSE '여자' END AS 'Gender', Phone, Tel FROM Member WHERE IsDelete = 0 AND Store_No = " + sStore_No;
	
	if(sFromDate != null) {
		sQuery += " AND CreateDate >= '" + sFromDate.substring(0, 4) + "-" + sFromDate.substring(4, 2) + "-" + sFromDate.substring(6, 2) + " 00:00:00";
	}
	if(sToDate != null) {
		sQuery += " AND CreateDate <= '" + sFromDate.substring(0, 4) + "-" + sFromDate.substring(4, 2) + "-" + sFromDate.substring(6, 2) + " 23:59:59";
	}
	sQuery += ";";
	PreparedStatement stmt = con.prepareStatement(sQuery);
	ResultSet rs = stmt.executeQuery();
    JSONArray cellarray = new JSONArray();

    rs.last();
    responcedata.put("total", rs.getRow());
    responcedata.put("page", 1);
    responcedata.put("records", rs.getRow());

    rs.beforeFirst();
    JSONObject cellobj = new JSONObject();

    while(rs.next()) {
        cellobj.put("No", rs.getString("No"));
        cellobj.put("Name", rs.getString("Name"));
		cellobj.put("Birth", rs.getString("Birth"));
		cellobj.put("Gender", rs.getString("Gender"));
		cellobj.put("Phone", rs.getString("Phone"));
		cellobj.put("Tel", rs.getString("Tel"));
        cellarray.add(cellobj);
    }
    responcedata.put("rows", cellarray);
	stmt.close();
	con.close();
} catch (Exception ex) {
	System.out.println("Error - " + ex.getMessage());
}
out.print(responcedata.toString());
%>
