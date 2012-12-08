package SampleService;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;

public class DataPingServlet extends HttpServlet {

	private String location;
	private String firstName;
	private String secondName;
	private String address;
	private String str;
	private int personAttackedId = 0;
	private String[] names;
	private int[] numbers;
	@Override 
	protected void doPost(HttpServletRequest request, HttpServletResponse res)
			throws ServletException, IOException{
		 
		 System.out.println("SERVLET DOPOST");
		 
		         String fileValue =request.getParameter("Videofile");
		         location = request.getParameter("location");
		         firstName = request.getParameter("firstName");
		         secondName = request.getParameter("secondName");
		         address = request.getParameter("address");
		         
		         byte[] value = null;
				try {
					value = Base64.decode(fileValue);
				} catch (Base64DecodingException e) { 
					System.out.println(e);
				}
				
		        Connection con = null;
		        try {
		        	Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		        	con = DriverManager.getConnection("jdbc:odbc:AttackAppDB", "",""); 
		        	Statement sql_stmt = con.createStatement();

		        	sql_stmt.execute("SELECT * FROM video");
		        	ResultSet rs = sql_stmt.getResultSet();
		        	
		        	if (rs!=null){
		        		while (rs.next()){
		        			str = String.valueOf(rs.getString("ID"));
		        		}
		        	}
		        	rs.close();
		        	sql_stmt.close();
		        	}catch (Exception ex) {
		        	}
		        
		        File someFile = new File("C:\\Users\\Public\\Documents\\apache-tomcat-6.0.32\\webapps\\ROOT\\AttackAppVideos\\download"+str+".mp4");
		        FileOutputStream fos = new FileOutputStream(someFile);
		        fos.write(value);
		        fos.flush();
		        fos.close();  
		        
		        Runtime rt = Runtime.getRuntime();
				rt.exec("C:\\Users\\Public\\Documents\\apache-tomcat-6.0.32\\webapps\\ROOT\\AttackAppVideos\\ffmpeg.exe -i " +
						"C:\\Users\\Public\\Documents\\apache-tomcat-6.0.32\\webapps\\ROOT\\AttackAppVideos\\download"+str+".mp4 " +
						"C:\\Users\\Public\\Documents\\apache-tomcat-6.0.32\\webapps\\ROOT\\AttackAppVideos\\AttackVideo"+str+".mp4");
				
				
				try {
		        	Statement stm = con.createStatement();

		        	stm.execute("SELECT * FROM PersonAttacked");
		        	ResultSet personId = stm.getResultSet();
		        	System.out.println("heelo");
		        	if (personId!=null){
		        		while(personId.next()){
		        			if(personId.getString("Firstname").equals(firstName) && personId.getString("Secondname").equals(secondName) &&
		        				personId.getString("Address").equals(address)){
		        				personAttackedId = personId.getInt("ID");
		        				
		        				break;
		        			}
		        		}
		        	}
		        	personId.close();
		        	stm.close();
		        	}catch (Exception ex) {
		        	}
				
		       
		        PreparedStatement s;
				try {  
					
					if(personAttackedId == 0){
						PreparedStatement state = con.prepareStatement("INSERT Into PersonAttacked(Firstname, Secondname, Address) VALUES(?, ?, ?)");
						state.setString(1, firstName); 
						state.setString(2, secondName); 
						state.setString(3, address);
					    state.executeUpdate();
					    Statement stm = con.createStatement();
			        	stm.execute("SELECT * FROM PersonAttacked WHERE Firstname ='"+firstName+"' AND Secondname = '"+secondName+"' AND Address ='"+address+"'");
			        	ResultSet personId = stm.getResultSet();
			        	personId.next();
			        	personAttackedId = personId.getInt("ID");
			        	personId.close();
			        	stm.close();
					}
					if(!location.equals("") && !location.equals("No Value")){
						DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
						DocumentBuilder builder = factory.newDocumentBuilder();
						Document doc = builder.parse("http://maps.google.com/maps/geo?q="+location+"&output=xml&sensor=false");
						doc.getDocumentElement().normalize();
						NodeList nl = doc.getElementsByTagName("AdministrativeAreaName");
						Element n = (Element)nl.item(0);
						address = n.getFirstChild().getNodeValue();
						address = address.replace("County ", "");
					}
					else{
						address = "No value";
					}
					s = con.prepareStatement("INSERT Into video(videoPath, Location, CountyAttacked, PersonAttackedId) VALUES(?, ?, ?, ?)");
				    s.setString(1, "AttackVideo"+str+".mp4"); 
				    s.setString(2, location);  
				    s.setString(3, address); 
				    s.setInt(4, personAttackedId);
				    s.executeUpdate();
				    personAttackedId = 0;
				    con.close();
				    someFile.deleteOnExit();
				    OutputStream stream = res.getOutputStream();
				    stream.write("got it".getBytes());
				    this.destroy();
				} catch (Exception err) {
		        	System.out.println( "Error: " + err.getMessage() );
		        	err.printStackTrace();
		         }
		     	}

}
