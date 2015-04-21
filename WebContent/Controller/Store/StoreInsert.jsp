<%@ page language="java" contentType="javascript/jsonp; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="ni.module.config.*" %>
<%@ page import="org.apache.log4j.Logger"%>

<%! static Logger logger = Logger.getLogger("StoreInsert.jsp"); %>
<%
	String sStore_No = (String)session.getAttribute("Store_No");
	String sStoreOwnerName = request.getParameter("StoreOwnerName");
	String sStoreName = request.getParameter("StoreName");
	String sStoreAccount = request.getParameter("StoreAccount");
	String sStorePassword = request.getParameter("StorePassword");
	String sStoreTel = request.getParameter("StoreTel");
	String sStoreAddress = request.getParameter("StoreAddress");
	String sStorePhone = request.getParameter("StorePhone");
	String sStoreFax = request.getParameter("StoreFax");
    String sStoreCompanyNo =request.getParameter("StoreCompanyNo");
	String sinsert = request.getParameter("insert");

	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();
	try {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url,DB_id,DB_password);
		Statement stat = con.createStatement();
		
		ResultSet rs = null;
		String query = "INSERT INTO Store (OwnerName, Name, Account, Password, Address, Tel, Phone, Fax, CompanyNo, CreateDate, CreateBy) ";
		query += "VALUES ('" + sStoreOwnerName +"','"+ sStoreName +"','"+ sStoreAccount +"','"+ sStorePassword +"','"+ sStoreAddress +"','"+ sStoreTel +"','"+ sStorePhone +"','"+ sStoreFax +"','"+ sStoreCompanyNo +"', CURRENT_TIMESTAMP, "+ Integer.parseInt(sStore_No) +")";
		
		rs = stat.executeQuery(query);
		con.close();
	} catch(Exception e) {
		out.print("DB접속 실패");
		e.printStackTrace();
	}
	out.println(sinsert + "(");
	out.println("{\"data\":{\"StoreName\":\""+ sStoreName +"\",\"StoreAccount\":\""+ sStoreAccount +"\",\"StoreCompanyNo\":\""+ sStoreCompanyNo +"\"}}");
	out.println(")");
%>



	