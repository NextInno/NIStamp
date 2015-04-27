<%@ page language="java" contentType="javascript/jsonp; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="net.sf.json.*" %>
<%@ page import="ni.module.config.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%! static Logger logger = Logger.getLogger("MemberInsert.jsp"); %>
<%
	String sno = request.getParameter("no");
	String sName = request.getParameter("Name");
	String sPhoneNum = request.getParameter("PhoneNum");
	String sBirthDay = request.getParameter("BirthDay");
	String sTelNum = request.getParameter("TelNum");
	String sGender = request.getParameter("Gender");
	Integer iGender = null;
	String sStore_No = (String)session.getAttribute("Store_No");
	String sinsert = request.getParameter("insert");

	if( sName != null && sPhoneNum != null && sBirthDay != null && sTelNum != null && sGender != null){
		iGender = Integer.parseInt(sGender);
		
	}
	
	
	String driverName = "org.mariadb.jdbc.Driver";
	String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
	String DB_id = NiModuleConfig.getInstance().getDB_ID();
	String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();

	try {
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
		Statement stat = con.createStatement();
		ResultSet rs = null;
		String sQuery = null;
		if(sName != null && sPhoneNum != null && sBirthDay != null && sTelNum != null && sGender != null){
			Integer iMember_No=null;
			if(sno ==null){
				String smemNoQuery = "SELECT MAX(MemberNo) AS 'MemberNo' FROM Member WHERE Store_No = " + sStore_No + " GROUP BY Store_No";
				rs = stat.executeQuery(smemNoQuery);
				rs.last();
				iMember_No = rs.getInt("MemberNo") + 1;
				sQuery = "INSERT INTO Member (MemberNo, Store_No, Name, Birth, Phone, Tel, Gender, CreateDate, CreateBy) ";
				sQuery += "VALUES (" + iMember_No + ", "+ Integer.parseInt(sStore_No) +", '"+ sName +"', '" + sBirthDay +"', '" + sPhoneNum +"', '" + sTelNum +"', " + iGender +", CURRENT_TIMESTAMP, "+ Integer.parseInt(sStore_No) +")";
			}else{
	
				sQuery = "UPDATE Member SET Name = '"+sName+"' , Birth = '"+ sBirthDay +"' , Phone = '" + sPhoneNum +"' , Tel = '"+ sTelNum +"', Gender = " + iGender + " , UpdateDate = CURRENT_TIMESTAMP , UpdateBy = " + sStore_No + "   WHERE MemberNo = " + sno + ";";
			}
			
			
			
		}else{
			sQuery = "SELECT Name, Birth, Phone, Tel, Gender FROM Member WHERE MemberNo = " + sno;
			
		}
		rs = stat.executeQuery(sQuery);
		if(sName == null && sPhoneNum == null && sBirthDay == null && sTelNum == null && sGender == null){
			while(rs.next()){
				sName = rs.getString("Name");
				sPhoneNum = rs.getString("Phone");
				sBirthDay = rs.getString("Birth");
				sTelNum = rs.getString("Tel");
				iGender = rs.getInt("Gender");
			}
		}
		con.close();
	} catch(Exception e) {
		out.print("DB접속 실패");
		e.printStackTrace();
	}
	
		out.println(sinsert + "(");
		out.println("{\"data\":{\"Name\":\""+ sName +"\",\"PhoneNum\":\""+ sPhoneNum +"\",\"BirthDay\":\""+ sBirthDay +"\",\"TelNum\":\""+ sTelNum +"\",\"Gender\":"+ iGender +"}}");
		out.println(")");
	
%>



	