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
						String username=(String) session.getAttribute("username");
						if(username != null){
							String location = (String) request.getParameter("location");
					%>
						<script>
							document.getElementById('login').innerHTML = "<a href='login.jsp'>Logout</a>";
						</script>
						<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false&region=GB" ></script>
									<script type="text/javascript">
										window.onload = function initialize() {
											var latlng = new google.maps.LatLng(<%=location%>);
											var myOptions = {
											zoom: 15,
											center: latlng,
											mapTypeId: google.maps.MapTypeId.ROADMAP 
										};
										var map = new google.maps.Map(document.getElementById("mapLocation"), myOptions);
										var myLatLng = new google.maps.LatLng(<%=location%>);  
										var iconMarker = new google.maps.Marker({
											position: myLatLng,
											map: map
										});

										}

									</script>
									<div id="mapLocation" style="width:800px; height:600px"></div>
					<%
							}
							else{
								out.println("<h3 stlye='color:red'>You must <a href='login.jsp'>Login</a> to see the locations</h3>");
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