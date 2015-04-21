<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="ni.module.config.*" %>
<%@ page language="java" contentType="javascript/jsonp; charset=UTF-8" pageEncoding="UTF-8"%>

<%
//	{ 'Name': Name , 'PhoneNum': PhoneNum  , 'BirthDay' : BirthDay , 'TelNum' : TelNum}
	String sStoreOwnerName = request.getParameter("StoreOwnerName");
	String sStoreName = request.getParameter("StoreName");
	String sStoreAccount = request.getParameter("StoreAccount");
	String sStorePassword = request.getParameter("StorePassword");
	String sStoreTel = request.getParameter("StoreTel");
	String sStoreAddress = request.getParameter("StoreAddress");
	String sStorePhone = request.getParameter("StorePhone");
	String sStoreFax = request.getParameter("StoreFax");
    String sStoreCompanyNo =request.getParameter("StoreCompanyNo");
	String sStore_No = (String)session.getAttribute("Store_No");
	String sinsert = request.getParameter("insert");

	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = "jdbc:mariadb://27.102.197.30:3306/Stamp";
	String DB_id = "admin";
	String DB_password="admin!";
	try{
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url,DB_id,DB_password);
		Statement stat = con.createStatement();
		
		ResultSet rs = null;
		String query = "INSERT INTO Store (OwnerName, Name, Account, Password, Address, Tel, Phone, Fax, CompanyNo, CreateDate, CreateBy) ";
		query += "VALUES ('" + sStoreOwnerName +"','"+ sStoreName +"','"+ sStoreAccount +"','"+ sStorePassword +"','"+ sStoreAddress +"','"+ sStoreTel +"','"+ sStorePhone +"','"+ sStoreFax +"','"+ sStoreCompanyNo +"', CURRENT_TIMESTAMP, "+ Integer.parseInt(sStore_No) +")";
		
		rs = stat.executeQuery(query);
		con.close();
	}catch(Exception e){
		out.print("DB접속 실패");
		e.printStackTrace();
	}
	
	out.println(sinsert + "(");
	out.println("{\"data\":{\"StoreName\":\""+ sStoreName +"\",\"StoreAccount\":\""+ sStoreAccount +"\",\"StoreCompanyNo\":\""+ sStoreCompanyNo +"\"}}");
	out.println(")");
	
%>



	