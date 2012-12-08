<%@page import="java.sql.*"%>
<% 
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null; 
			boolean isUser = false;
			
			try 
			{ 
				Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
				conn = DriverManager.getConnection("jdbc:odbc:AttackAppDB", "",""); 
				stmt = conn.createStatement();
				rs = stmt.executeQuery("SELECT * FROM admin");
										
				while (rs.next()) {
					String userN = rs.getString("Username");
					String pass = rs.getString("Password");
					String isTrue = (String) rs.getString("isAdmin");
					if(userN.equals(username) && pass.equals(password) && isTrue.equals("1")){
						String county = rs.getString("county");
						session.setAttribute("username", username);
						session.setAttribute("county", county);
						session.setAttribute("lenght", "All videos");
						session.setAttribute("videos", "set county");
						session.setAttribute("login", null);
						response.sendRedirect("index.jsp");	
						isUser = true;
						break;						
					}
					else{
						session.setAttribute("login", "false");
						}
				}
			}					
			catch(Exception ex) 
			{ 
				ex.printStackTrace(); 
			} 
			
			if(isUser == false){
				response.sendRedirect("login.jsp");	
			}
		%>