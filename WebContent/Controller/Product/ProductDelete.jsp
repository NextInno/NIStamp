<%@ page language="java" contentType="javascript/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="ni.module.config.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%! static Logger logger = Logger.getLogger("ProductDelete.jsp"); %>
<%
	String sStore_No = (String)session.getAttribute("Store_No");
	String sinsert = request.getParameter("delete");
	String sNo = request.getParameter("No");
	
	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();

	try {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
		Statement stat = con.createStatement();
		ResultSet rs = null;
		String sQuery = "";
		
		String[] No = sNo.split(",");
		
		for(int i = 0; i < No.length; i++) {
			sQuery = "UPDATE Product SET IsDelete = 1 WHERE No = " + No[i] + ";";
			rs = stat.executeQuery(sQuery);
		}
		con.close();
	} catch(Exception e) {
		out.print("DB접속 실패");
		e.printStackTrace();
	}
	out.println(sinsert + "(");
	out.println("{\"data\":{\"result\":\"success\"}}");
	out.println(")");
%>