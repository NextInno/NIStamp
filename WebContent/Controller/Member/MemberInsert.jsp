<%@ page language="java" contentType="javascript/jsonp; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="ni.module.config.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%! static Logger logger = Logger.getLogger("MemberInsert.jsp"); %>
<%
	String sName = request.getParameter("Name");
	String sPhoneNum = request.getParameter("PhoneNum");
	String sBirthDay = request.getParameter("BirthDay");
	String sTelNum = request.getParameter("TelNum");
	Integer iGender = Integer.parseInt(request.getParameter("Gender"));
	String sStore_No = (String)session.getAttribute("Store_No");
	String sinsert = request.getParameter("insert");
	
	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();

	try {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
		Statement stat = con.createStatement();
		
		String smemNoQuery = "SELECT MAX(MemberNo) AS 'MemberNo' FROM Member WHERE Store_No = " + sStore_No + " GROUP BY Store_No";
		ResultSet rs = stat.executeQuery(smemNoQuery);
		rs.last();
		Integer iMember_No = rs.getInt("MemberNo") + 1;
		String query = "INSERT INTO Member (MemberNo, Store_No, Name, Birth, Phone, Tel, Gender, CreateDate, CreateBy) ";
		query += "VALUES (" + iMember_No + ", "+ Integer.parseInt(sStore_No) +", '"+ sName +"', '" + sBirthDay +"', '" + sPhoneNum +"', '" + sTelNum +"', " + iGender +", CURRENT_TIMESTAMP, "+ Integer.parseInt(sStore_No) +")";
		
		rs = stat.executeQuery(query);
		con.close();
	} catch(Exception e) {
		out.print("DB접속 실패");
		e.printStackTrace();
	}
	out.println(sinsert + "(");
	out.println("{\"data\":{\"Name\":\""+ sName +"\",\"PhoneNum\":\""+ sPhoneNum +"\",\"BirthDay\":"+ sBirthDay +"}}");
	out.println(")");
%>



	