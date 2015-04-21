<%@ page language="java" contentType="javascript/json; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="net.sf.json.util.JSONStringer" %>
<%@ page import="net.sf.json.*" %>

<%
String driverName = "org.mariadb.jdbc.Driver";
String DB_url = "jdbc:mariadb://27.102.197.30:3306/Stamp";
String DB_id = "admin";
String DB_password="admin!";
String sStore_No = (String)session.getAttribute("Store_No");

JSONObject responcedata = new JSONObject();
try {			
    Class.forName(driverName);
	Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
	PreparedStatement stmt = con.prepareStatement("SELECT No, Name, Birth, Gender, Phone, Tel FROM Member WHERE IsDelete = 0 AND Store_No = " + sStore_No + ";");
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
