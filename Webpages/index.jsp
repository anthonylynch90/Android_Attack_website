<%@page import ="java.io.*"%> 
<%@page import ="java.util.*, java.net.*"%> 
 <%@page import ="javax.servlet.*"%> 
 <%@page import ="javax.servlet.http.*"%> 
 <%@page import ="java.sql.*"%> 
 <!DOCTYPE html>
 <%
	String val = request.getParameter("time");
	if(val != null){
		session.setAttribute("lenght", val);
	}
	String vid = request.getParameter("videos");
	if(vid != null){
		session.setAttribute("videos", vid);
	}
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title></title>
<link href='http://fonts.googleapis.com/css?family=Arvo' rel='stylesheet' type='text/css'>
<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<script type="text/javascript" src="Javascript/display.js"></script>
<script type="text/javascript" src="Javascript/jquery.js">

</script>

</head>

<body id="body">
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
			<li id="login"><a href="login.jsp">Login</a></li>
			<li class="current_page_item"><a href="#">Homepage</a></li>
			<li><a href="location.jsp">Location</a></li>
			<li><a href="statistics.jsp">Statistics</a></li>
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
	
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					
					<div class="post" id="one">
					<%
					//response.setHeader("Refresh", "9");
						String username=(String) session.getAttribute("username");
						if(username != null){
					%>
						<script>
							document.getElementById('login').innerHTML = "<a href='login.jsp'>Logout</a>";
						</script>
						<div><h2 class="title"><a>Welcome to Attack App</a></h2></div>
						<% 
						String newVal1 = (String) session.getAttribute("videos");
						if(newVal1.equals("set county")){%>
							<div style="float:right;"><button id="showAll2" >Show all videos</button>
						<%}else{%>
							<div style="float:right;"><button id="showAll" >Show region videos</button>
						<%}%>
						<select onchange="videoPeriod(value)" selected="Last month">
							<option><%=session.getAttribute("lenght").toString()%></option>
							<option>All videos</option>
							<option>Last 7 days</option>
							<option>Last month</option>
							<option>Last 6 months</option>
						</select>
						</div>
						<% 
								Connection conn = null;
								Statement stmt = null;
								ResultSet rs = null; 
								String videoName = null;
								int i = 0;
								try 
									{ 
										Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
										conn = DriverManager.getConnection("jdbc:odbc:AttackAppDB", "",""); 
										stmt = conn.createStatement();
										String county =(String) session.getAttribute("county");
										String video =(String) session.getAttribute("videos");
										String time =(String) session.getAttribute("lenght");
										
										if(video.equals("set county")){
											if(time !=null){
									
												if(time.equals("All videos")){
													rs = stmt.executeQuery("SELECT * FROM video WHERE CountyAttacked = '"+county+"' ORDER BY  ID DESC");
												}
												if(time.equals("Last 7 days")){
													rs = stmt.executeQuery("SELECT * FROM video WHERE CountyAttacked = '"+county+"' AND datePosted >= (Date() - 7)  ORDER BY  ID DESC");												}
												
												if(time.equals("Last month")){
													rs = stmt.executeQuery("SELECT * FROM video WHERE CountyAttacked = '"+county+"' AND datePosted >= (Date() - 30)  ORDER BY  ID DESC");
												}
												if(time.equals("Last 6 months")){
													rs = stmt.executeQuery("SELECT * FROM video WHERE CountyAttacked = '"+county+"' AND datePosted >= (Date() - 180)  ORDER BY  ID DESC");
												}
												}
											else{
											System.out.println("2" +county);
												rs = stmt.executeQuery("SELECT * FROM video WHERE CountyAttacked = '"+county+"' ORDER BY  ID DESC");
											}
										}
										else{
											
												if(time.equals("All videos")){
													rs = stmt.executeQuery("SELECT * FROM video ORDER BY ID DESC");
												}
												if(time.equals("Last 7 days")){
													rs = stmt.executeQuery("SELECT * FROM video WHERE datePosted >= (Date() - 7) ORDER BY ID DESC");
												}
												if(time.equals("Last month")){
													rs = stmt.executeQuery("SELECT * FROM video WHERE datePosted >= (Date() - 30) ORDER BY ID DESC");
												}
												if(time.equals("Last 6 months")){
													rs = stmt.executeQuery("SELECT * FROM video WHERE datePosted >= (Date() - 180) ORDER BY ID DESC");
												}
										}
										String value = " ";
										String sessionVal = (String) session.getAttribute("value");
										while (rs.next()) {
													if(value.equals(" ") && sessionVal == null){
														value = rs.getString("ID");
														System.out.println(value);
													}
													
													videoName = rs.getString("videoPath");
													System.out.println(videoName);
													int id = rs.getInt("PersonAttackedId");
													Statement smt = conn.createStatement();
													ResultSet name = smt.executeQuery("SELECT * FROM PersonAttacked WHERE ID = "+id+"");
													name.next();
													String first = name.getString("Firstname");
													String second = name.getString("Secondname");
													String address = name.getString("Address");
													address = address.replaceAll("\n", ", ");
													String fullname = first+" "+second;
													String loc = rs.getString("location");
													String date = rs.getString("datePosted");
													%><script>
													$(document).ready(function(){
														myMethod("<%=address%>", "one", "<%=fullname%>", "<%=date%>", "<%=videoName%>", "<%=loc%>");
													});
													
												</script><%
											}
											if(value != " "){
												session.setAttribute("value", value);
											}
									} 
									catch(Exception ex) 
									{ 
										ex.printStackTrace(); 
									} 
							}
							else{
								out.println("<h3 stlye='color:red'>You must <a href='login.jsp'>Login</a> to see these videos</h3>");
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
<script>
function getLocation(id){
	var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "location.jsp");
	var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "location");
    hiddenField.setAttribute("value", id);
	form.appendChild(hiddenField);
    $('#footer').append(form);
    form.submit();
}
</script>
</html>
<script type="text/javascript">

$("#showAll").click(function(){
		
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", "index.jsp");
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "videos");
		hiddenField.setAttribute("value", "set county");
		form.appendChild(hiddenField);
		$('#footer').append(form);
		form.submit();
});
$("#showAll2").click(function(){
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", "index.jsp");
		var hiddenField = document.createElement("input");
		hiddenField.setAttribute("type", "hidden");
		hiddenField.setAttribute("name", "videos");
		hiddenField.setAttribute("value", "all");
		form.appendChild(hiddenField);
		$('#footer').append(form);
		form.submit();
});
function videoPeriod(time){
	var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "index.jsp");
	var hiddenField = document.createElement("input");
    hiddenField.setAttribute("type", "hidden");
    hiddenField.setAttribute("name", "time");
    hiddenField.setAttribute("value", time);
	form.appendChild(hiddenField);
    $('#footer').append(form);
	form.submit();
}

function getXMLObject()
{
   var xmlHttp = false;
   try {
     xmlHttp = new ActiveXObject("Msxml2.XMLHTTP")  
   }
   catch (e) {
     try {
       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP")
     }
     catch (e2) {
       xmlHttp = false 
     }
   }
   if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
     xmlHttp = new XMLHttpRequest();       
   }
   return xmlHttp; 
} 
var xmlhttp = new getXMLObject();

$(document).ready(function(){
	var value ='<%= session.getAttribute("login")%>'
	if(value == "false"){
		alert("Username or password is incorrect");
		<%
			session.setAttribute("login", "true");
		%>
	}
  if(xmlhttp) {
	var county ='<%= session.getAttribute("county")%>'
	var value ='<%= session.getAttribute("value")%>'
	
	console.log(value+county);
    xmlhttp.open("GET","VideoServlet?value="+value+"&county="+county,true);
    xmlhttp.onreadystatechange  = handleServerResponse;
    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlhttp.send(null);
	<% session.setAttribute("value", null);%>
  }
});
 
function handleServerResponse() {
   if (xmlhttp.readyState == 4) {
     if(xmlhttp.status == 200) {
       var value =xmlhttp.responseText;
	   var answer = confirm (value);
		if (answer){
			var form = document.createElement("form");
			form.setAttribute("method", "post");
			form.setAttribute("action", "index.jsp");
			var hiddenField1 = document.createElement("input");
			var hiddenField2 = document.createElement("input");
			
			hiddenField1.setAttribute("type", "hidden");
			hiddenField1.setAttribute("name", "lenght");
			hiddenField1.setAttribute("value", "All videos");
			
			hiddenField2.setAttribute("type", "hidden");
			hiddenField2.setAttribute("name", "videos");
			hiddenField2.setAttribute("value", "set county");
			
			form.appendChild(hiddenField1);
			form.appendChild(hiddenField2);
			$('#footer').append(form);
			form.submit();	
		}
     }
   }
}
</script>