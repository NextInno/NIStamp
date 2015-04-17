package MyStamp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import net.sf.json.util.JSONStringer;

public class jqgrid {
	private static String driverName = "org.mariadb.jdbc.Driver";
	private static String DB_url = "jdbc:mariadb://27.102.197.30:3306/Stamp";
	private static String DB_id = "admin";
	private static String DB_password = "admin!";
	
	String No = "";
	String Name = "";
	String Birth = "";
	String Gender = "";
	String Phone = "";
	String Tel = "";
	
	//String Store_No = (String)session.getAttribute("Store_No");
	
	public JSONStringer getDate()
	{
		JSONStringer js = new JSONStringer();
		
		try {			
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(DB_url, DB_id, DB_password);
			PreparedStatement stmt = con.prepareStatement("SELECT No, Name, Birth, Gender, Phone, Tel FROM Member WHERE IsDelete = 0 AND Store_No = 1"); // + Store_No + ";");
			ResultSet rs = stmt.executeQuery();

			js.array();
			while(rs.next()){
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
			stmt.close();
			con.close();
		} catch (Exception ex) {
			System.out.println("Error - " + ex.getMessage());
		}
		return js;
	}
}
