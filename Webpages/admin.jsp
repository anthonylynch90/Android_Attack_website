<%@page import ="java.io.*"%> 
<%@page import ="java.util.*, java.net.*"%> 
 <%@page import ="javax.servlet.*"%> 
 <%@page import ="javax.servlet.http.*"%> 
 <%@page import ="java.sql.*"%> 
 <!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title></title>
<link href='http://fonts.googleapis.com/css?family=Arvo' rel='stylesheet' type='text/css'>
<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="Javascript/jquery.js"></script>

</head>

<body>
<div id="wrapper">
	<div id="header-wrapper">
		<div id="header">
			<div id="logo">
				<h1>Attack Application</h1>
			</div>
		</div>
	</div>
	<div id="menu">
		<ul>
			<li id ="login"><a href="login.jsp">Login</a></li>
			<li><a href="index.jsp">Homepage</a></li>
			<li class="current_page_item"><a href="#">Location</a></li>
			<li><a href="statistics.jsp">Statistics</a></li>
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
								<% 
								Connection conn = null;
								Statement stmt = null;
								ResultSet rs = null; 
																		
									try 
									{ 
										Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
										conn = DriverManager.getConnection("jdbc:odbc:AttackAppDB", "",""); 
										stmt = conn.createStatement();
										rs = stmt.executeQuery("SELECT * FROM admin");
										%>
											<table>
										<%
										while (rs.next()) {
											%>
												<tr>
												
												<td>
													<%=rs.getString("Username")%>
												</td>
												<td>
													<%=rs.getString("policeNumber")%>
												</td>	
												<td>
													<div>
														<input type="checkbox" name="<%=rs.getString("Username")%>" value = "g">
													</div>
												</td>												
												</tr>
											<%
										}	
										%>
											</table>
										<%										
										
									}					
									catch(Exception ex) 
									{ 
										ex.printStackTrace(); 
									} 
								%>
					
					</div>
					
				</div>
				<!-- end #content -->
				<div style="clear: both;">&nbsp;</div>
			</div>
		</div>
	</div>
	<!-- end #page -->
</div>

<div id="footer">
	<p>Copyright (c) 2012 AttackApplication.com. All rights reserved. Design by AntApp</p>
</div>


</body>
</html>