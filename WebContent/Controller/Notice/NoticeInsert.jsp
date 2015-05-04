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
	
	if(sno == ""){
		sno = null;
	}
	
	if( sContent != null){
		sContent = sContent.replaceAll("\n","<br/>");
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
			if(sno ==null){

				sQuery = "INSERT INTO Notice ( Store_No, Title, Content , CreateDate, CreateBy) ";
				sQuery += "VALUES ( "+ Integer.parseInt(sStore_No) +", '"+ sTitle+"', '"+ sContent +"', CURRENT_TIMESTAMP, "+ Integer.parseInt(sStore_No) +")";
			}else{
	
				sQuery = "UPDATE Notice SET  Title = '"+ sTitle +"' , Content = '" + sContent + "' , UpdateDate = CURRENT_TIMESTAMP , UpdateBy = " + sStore_No + "   WHERE No = " + sno + ";";
			}
			
			
			
		}else{
			sQuery = "SELECT Title, Content FROM Notice WHERE No = " + sno;
			
		}
		rs = stat.executeQuery(sQuery);
		if( sTitle == null && sContent == null ){
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
		out.println("{\"data\":{\"Title\":\""+ sTitle +"\",\"Content\":\""+ sContent  +"\"}}");
		out.println(")");
	
%>



	