<%@ page language="java" contentType="javascript/jsonp; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="net.sf.json.*" %>
<%@ page import="ni.module.config.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%! static Logger logger = Logger.getLogger("NoticeInsert.jsp"); %>
<%
	String sno = request.getParameter("no");
	String sTitle = request.getParameter("Title");
	String sContent = request.getParameter("Content");
	String sStore_No = (String)session.getAttribute("Store_No");
	String sinsert = request.getParameter("insert");

	if( sTitle != null && sContent != null){
		
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
		if(sTitle != null && sContent != null){
			Integer iNotice_No=null;
			if(sno ==null){
				String smemNoQuery = "SELECT MAX(NotieNo) AS 'NotieNo' FROM Notice WHERE Store_No = " + sStore_No + " GROUP BY Store_No";
				rs = stat.executeQuery(smemNoQuery);
				rs.last();
				iNotice_No = rs.getInt("MemberNo") + 1;
				sQuery = "INSERT INTO Notice (NoticeNo, Store_No, Title, Content , CreateDate, CreateBy) ";
				sQuery += "VALUES (" + iNotice_No + ", "+ Integer.parseInt(sStore_No) +", '"+ sTitle+", '"+ sContent +", CURRENT_TIMESTAMP, "+ Integer.parseInt(sStore_No) +")";
			}else{
	
				sQuery = "UPDATE Member SET NoticeNo = '"+iNotice_No +"' , Title = '"+ sTitle +"' , Content = '" + sContent + " , UpdateDate = CURRENT_TIMESTAMP , UpdateBy = " + sStore_No + "   WHERE NoticeNo = " + sno + ";";
			}
			
			
			
		}else{
			sQuery = "SELECT Title, Content FROM Member WHERE NoticeNo = " + sno;
			
		}
		rs = stat.executeQuery(sQuery);
		if( sTitle != null && sContent != null ){
			while(rs.next()){
				sTitle = rs.getString("Title");
				sContent = rs.getString("Content");
			}
		}
		con.close();
	} catch(Exception e) {
		out.print("DB접속 실패");
		e.printStackTrace();
	}
	
		out.println(sinsert + "(");
		out.println("{\"data\":{\"Title\":\""+ sTitle +"\",\"Content\":\""+ sContent  +"}}");
		out.println(")");
	
%>



	