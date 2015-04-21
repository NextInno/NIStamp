<%@ page language="java" contentType="javascript/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="ni.module.config.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<% System.out.println("NIStamp Start!"); %>
<%! static Logger logger = Logger.getLogger("Login.jsp"); %>
<%  // 첫 로딩
	NiModuleConfig.setLogger();
	
	logger.info("NIStamp Start!");
	
	String sId = request.getParameter("Id");
	String sPw = request.getParameter("Pw");
	String Store_No = null;
	String login = request.getParameter("login");
	
	String driverName = "org.mariadb.jdbc.Driver";
	// config에서 값을 가져온다.
	// conf 파일은 절대 svn에 올리지 않도록!
	// 그 이유는 우리 서버 장비 IP 정보들이 노출되기 때문에.
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
		out.print("DB연결 에러");
		e.printStackTrace();
	}
	out.println(login + "(");
	out.println("{\"data\":{\"Id\":\""+ sId +"\",\"Pw\":\""+ sPw +"\",\"No\":"+ Store_No +"}}");
	out.println(")");
%>