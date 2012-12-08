package SampleService;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
	 
		public void init(ServletConfig config) throws ServletException {
			super.init(config);
		}
	 
		public void destroy() {
	 
		}
	 
		public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
			PrintWriter out = response.getWriter();
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String number = request.getParameter("number");
			String county = request.getParameter("county");
			System.out.println(username + password + county);
			Connection conn = null;
			try 
			{ 
				Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
				conn = DriverManager.getConnection("jdbc:odbc:AttackAppDB", "",""); 
		        Statement sql_stmt = conn.createStatement();

		        sql_stmt.executeQuery("SELECT * FROM admin WHERE Username ='"+username+"' AND Password ='"+password+"'");
		        ResultSet rs = sql_stmt.getResultSet();
		        
		       	if (rs.next()){
		       		String val12 = rs.getString("Username");
		       		System.out.println(val12);
		       		out.println("false");
		       	}
		       	else{				
					PreparedStatement state = conn.prepareStatement("INSERT INTO admin(Username, Password, policeNumber, county) VALUES (?, ?, ?, ?);");
					state.setString(1, username); 
					state.setString(2, password); 
					state.setString(3, number);
					state.setString(4, county);
				    state.executeUpdate();
					out.println("true");
		       	}
			}					
			catch(ClassNotFoundException e) 
			{ 
				System.out.println(e);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
	 
		public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException {
			doPost(request,response);
		}
}
