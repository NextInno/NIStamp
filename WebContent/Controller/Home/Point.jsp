<%@ page language="java" contentType="javascript/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="net.sf.json.*" %>
<%@ page import="ni.module.config.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<%! static Logger logger = Logger.getLogger("Point.jsp"); %>

<%
NiModuleConfig.setLogger();

String sStore_No = (String)session.getAttribute("Store_No");
String driverName = "org.mariadb.jdbc.Driver";
String DB_url = NiModuleConfig.getInstance().getDB_SERVER_IP();
String DB_id = NiModuleConfig.getInstance().getDB_ID();
String DB_password= NiModuleConfig.getInstance().getDB_PASSWORD();

String sQuery = "";
String sNo = request.getParameter("No");
String sPoint =request.getParameter("Point");
String sType = (String)session.getAttribute("SaveType");
logger.info( "MemberPoint!");

JSONObject responcedata = new JSONObject();

try {			
    Class.forName(driverName);
	Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
	ResultSet rs= null;
	PreparedStatement stmt = null;
	if(sPoint != null){
			sQuery = "INSERT INTO Point (Type, Point, Member_No, ExpireDate, CreateDate, CreateBy, UpdateDate, UpdateBy) ";
			sQuery += "VALUE ("+ sType + ", "+ sPoint +"," + sNo + ", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, "+ sStore_No + ", CURRENT_TIMESTAMP, "+ sStore_No +");";
			stmt = con.prepareStatement(sQuery);
			rs = stmt.executeQuery();
			/* sQuery = "INSERT INTO Point (Type, Point, Member_No, ExpireDate, CreateDate, CreateBy, UpdateDate, UpdateBy) ";
			sQuery += "VALUE ("+ 0 + ", "+ sPoint +"," + sNo + ", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, "+ sStore_No + ", CURRENT_TIMESTAMP, "+ sStore_No +");";
			stmt = con.prepareStatement(sQuery);
			rs = stmt.executeQuery(); */
	}
	
	sQuery = "SELECT MAX(T1.Member_No) AS 'Member_No'";
	sQuery += ", MAX(T1.Store_No) AS 'Store_No'";
	sQuery += ", SUM(T1.Point) AS 'Point'";
	sQuery += "FROM (SELECT po.Member_No AS 'Member_No'";
	sQuery += " , mem.Store_No AS 'Store_No'";
	sQuery += ", CASE po.Type WHEN 0 THEN po.Point ELSE po.Point * -1 END AS 'Point'";
	sQuery += " FROM Point po";
	sQuery += " INNER JOIN Member mem ON po.Member_No = mem.No";
	sQuery +=  " WHERE po.Member_No = " + sNo;
	sQuery +=   " AND mem.Store_No = " + sStore_No;
	sQuery +=   ") AS T1";
	sQuery += " GROUP BY T1.Member_No;";
	
	stmt = con.prepareStatement(sQuery);
	rs = stmt.executeQuery();
    JSONArray cellarray = new JSONArray();

    rs.last();
    responcedata.put("total", rs.getRow());
    responcedata.put("page", 1);
    responcedata.put("records", rs.getRow());

    rs.beforeFirst();
    JSONObject cellobj = new JSONObject();
	if(rs.next()){
		rs.beforeFirst();
		 while(rs.next()) {
		        cellobj.put("Point", rs.getString("Point"));
		        cellarray.add(cellobj);
		    }
	}else{
		cellobj.put("Point","0");
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
