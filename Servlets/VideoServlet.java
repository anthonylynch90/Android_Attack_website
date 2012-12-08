package SampleService;

import java.io.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.*;
 
import java.util.*;
 
import javax.servlet.*;
 
import javax.servlet.http.*;

public class VideoServlet extends HttpServlet {
	 
		public void init(ServletConfig config) throws ServletException {
			super.init(config);
		}
	 
		public void destroy() {
	 
		}
	 
		public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
			PrintWriter out = response.getWriter();
			Connection conn = null;
			Statement stmt = null;
			String value = request.getParameter("value");
			String county = request.getParameter("county");
			try 
				{ 
					Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
					conn = DriverManager.getConnection("jdbc:odbc:AttackAppDB", "","");								 
					boolean found = false;
						
					while(found == false){
						Statement smt = conn.createStatement();
						ResultSet sets = smt.executeQuery("SELECT * FROM video WHERE ID > "+value+" AND CountyAttacked ='"+county+"'");
						if(sets.next()){
							found = true;
						}
						smt.close();
					}	
					out.println("New Video is found. Do you want to reload the page to see it");
						
				} 
				catch(Exception ex) 
				{ 
					ex.printStackTrace(); 
				} 
		}
	 
		public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
			doPost(request,response);
		}
	}
