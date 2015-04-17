<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="net.sf.json.util.JSONStringer" %>

<%
String driverName = "org.mariadb.jdbc.Driver";
String DB_url = "jdbc:mariadb://27.102.197.30:3306/Stamp";
String DB_id = "admin";
String DB_password="admin!";

JSONStringer js = new JSONStringer();

try {
	Class.forName(driverName);
	Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
	Statement stat = con.createStatement();
	
	ResultSet rs = stat.executeQuery("SELECT No, Name, Birth, Gender, Phone, Tel FROM Member WHERE Store_No = 1");// + Store_No + ";");
	
	js.array();
	while(rs.next()) {
		js.object()
		.key("No").value(rs.getString("No"))
		.key("Name").value(rs.getString("Name"))
		.key("Birth").value(rs.getString("Birth"))
		.key("Gender").value(rs.getInt("Gender"))
		.key("Phone").value(rs.getString("Phone"))
		.key("Tel").value(rs.getString("Tel"))
		.endObject();
	}
	js.endArray();	
	stat.close();
	con.close();
} catch(Exception e){
	out.print("DB접속 실패");
	e.printStackTrace();
}
out.print(js);

%>
