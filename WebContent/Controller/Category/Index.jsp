<%@ page language="java" contentType="javascript/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="net.sf.json.*" %>
<%@ page import="ni.module.config.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%! static Logger logger = Logger.getLogger("Category.jsp"); %>

<%
NiModuleConfig.setLogger();

String sStore_No = (String)session.getAttribute("Store_No");
String driverName = "org.mariadb.jdbc.Driver";
String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
String DB_id = NiModuleConfig.getInstance().getDB_ID();
String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();

String sQuery = "";

logger.info( "Category Load!");

JSONArray cellarray = new JSONArray();

try {			
    Class.forName(driverName);
	Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
	
	sQuery = "SELECT No, Name, ParentNo FROM Category WHERE IsDelete = 0 AND Store_No = " + sStore_No + ";";
	PreparedStatement stmt = con.prepareStatement(sQuery);
	ResultSet rs = stmt.executeQuery();
    
    JSONObject cellobj = new JSONObject();

    while(rs.next()) {
        cellobj.put("id", rs.getString("No"));
               
        if(rs.getInt("ParentNo") == 0) {
        	cellobj.put("parent", "#");
        } else {
        	cellobj.put("parent", rs.getString("ParentNo"));
        }
		cellobj.put("text", rs.getString("Name"));
		cellarray.add(cellobj);
    }
	stmt.close();
	con.close();
} catch (Exception ex) {
	out.println("Error - " + ex.getMessage());
}
out.print(cellarray.toString());
%>
