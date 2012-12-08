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
 <%
	String val = request.getParameter("login");
	if(val != null){%>
		<script>
			alert("Username or password was wrong");
		</script><%
	}
%>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title></title>
<link href='http://fonts.googleapis.com/css?family=Arvo' rel='stylesheet' type='text/css'>
<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="Javascript/jquery.js"></script>

</head>
<%
	session.setAttribute("username", null);
	session.setAttribute("county", null);
%>

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
			<li class="current_page_item"><a href="#">Login</a></li>
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post" id="one">
					
						<form name="form" method="post" action="checkLogin.jsp">
							<table>
								<tr>
									<td> Username  : </td><td> <input name="username" size=15 type="text" /> </td> 
								</tr>
								<tr>
									<td> Password  : </td><td> <input name="password" size=15 type="Password" /> </td> 
								</tr>
							</table>
							<input type="submit"/>
							<a href="register.jsp">Register</a>
						</form>
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
<script>
$(document).ready(function(){
	var value ='<%= session.getAttribute("login")%>'
	if(value == "false"){
		alert("Username or password is incorrect");
		<%
			session.setAttribute("login", "true");
		%>
	}
});
</script>
</body>
</html>

 