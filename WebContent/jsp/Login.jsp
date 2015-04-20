<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="ni.module.config.*"%>
<%@page import="org.apache.log4j.Logger"%>

<%@ page language="java" contentType="javascript/json; charset=EUC-KR" pageEncoding="EUC-KR"%>

<% System.out.println("NIStamp Start!");	%>
<%! 
	
static Logger logger = Logger.getLogger("Login.jsp"); %>

<%
	// ù �ε�
	NiModuleConfig.setLogger();
	
	logger.info( "NIStamp Start!");
	
	String sId = request.getParameter("Id");
	String sPw = request.getParameter("Pw");
	String Store_No = null;
	String login = request.getParameter("login");
	
	String driverName = "org.mariadb.jdbc.Driver";
	// String DB_url = "jdbc:mariadb://27.102.197.30:3306/Stamp";
	// String DB_id = "admin";
	// String DB_password="admin!";
	
	// config���� ���� �����´�.
	// conf ������ ���� svn�� �ø��� �ʵ���!
	// �� ������ �츮 ���� ��� IP �������� ����Ǳ� ������.
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();
	
	System.out.println("DB_url : " + DB_url + ", DB_id = " + DB_id + ", DB_password : " + DB_password );
	logger.info( "DB_url : " + DB_url + ", DB_id = " + DB_id + ", DB_password : " + DB_password );
	try {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
		Statement stat = con.createStatement();
		
		ResultSet rs = stat.executeQuery("SELECT * FROM Store WHERE Account = '" + sId + "' AND Password = '" + sPw + "';");
		rs.last();
		int i_CountRow = rs.getRow();
		Store_No = String.valueOf(rs.getInt("No"));
		session.setAttribute("Store_No", Store_No);
		session.setAttribute("ID", sId);
		con.close();
	} catch(Exception e) {
		out.print("DB���� ����");
		e.printStackTrace();
	}
	out.println(login + "(");
	out.println("{\"data\":{\"Id\":\""+ sId +"\",\"Pw\":\""+ sPw +"\",\"No\":"+ Store_No +"}}");
	out.println(")");
%>