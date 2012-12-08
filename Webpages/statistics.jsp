<%@page import ="java.io.*"%> 
<%@page import="org.w3c.dom.Node, org.w3c.dom.Element, org.w3c.dom.Document, 
org.w3c.dom.NodeList, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory" %>
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
			<li id="login"><a href="login.jsp">Login</a></li>
			<li ><a href="index.jsp">Homepage</a></li>
			<li><a href="location.jsp">Location</a></li>
			<li class="current_page_item"><a href="#">Statistics</a></li>
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post" id="one">
					<%
						String username=(String) session.getAttribute("username");
						if(username != null){
					%>
						<script>
							document.getElementById('login').innerHTML = "<a href='login.jsp'>Logout</a>";
						</script>
						<h2 class="title"><a>Number of attacks in Ireland</a></h2>
						<% 
							String password = request.getParameter("password");
							Connection conn = null;
							Statement stmt = null;
							int count[] = new int[26];
							try 
							{ 
								Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
								conn = DriverManager.getConnection("jdbc:odbc:AttackAppDB", "",""); 							
								Statement stm = conn.createStatement();
								ResultSet results = stm.executeQuery("SELECT CountyAttacked FROM video");							
								while(results.next()){
									String value = results.getString("CountyAttacked");
									if(value.equals("Galway"))
										count[0]++;
									if(value.equals("Leitrim"))
										count[1]++;
									if(value.equals("Mayo"))
										count[2]++;
									if(value.equals("Roscommon"))
										count[3]++;
									if(value.equals("Sligo"))
										count[4]++;
									if(value.equals("Carlow"))
										count[5]++;
									if(value.equals("Dublin"))
										count[6]++;
									if(value.equals("Clare"))
										count[7]++;
									if(value.equals("Kilkenny"))
										count[8]++;
									if(value.equals("Laois"))
										count[9]++;
									if(value.equals("Longford"))
										count[10]++;
									if(value.equals("Louth"))
										count[11]++;
									if(value.equals("Meath"))
										count[12]++;
									if(value.equals("Offaly"))
										count[13]++;
									if(value.equals("Westhmeath"))
										count[14]++;
									if(value.equals("Wexford"))
										count[15]++;
									if(value.equals("Clare"))
										count[16]++;
									if(value.equals("Cork"))
										count[17]++;
									if(value.equals("Kerry"))
										count[18]++;
									if(value.equals("Limerick"))
										count[19]++;
									if(value.equals("Tipperary"))
										count[20]++;
									if(value.equals("Waterford"))
										count[21]++;
									if(value.equals("Cavan"))
										count[22]++;
									if(value.equals("Donegal"))
										count[23]++;
									if(value.equals("Monaghan"))
										count[24]++;
								}
							}
							catch(Exception ex) 
							{ 
								ex.printStackTrace(); 
							}	
							String val = "Dublin";
							int num = 3;
						%>
						   <script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript'>
     google.load('visualization', '1', {'packages': ['geochart']});
     google.setOnLoadCallback(drawMarkersMap);

      function drawMarkersMap() {
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'County');
      data.addColumn('number', 'No. of attacks');
      data.addRows([
								["Galway", <%=count[0]%>],
								["Leitrim", <%=count[1]%>],
								["Mayo", <%=count[2]%>],
								["Roscommon", <%=count[3]%>],
								["Sligo", <%=count[4]%>],
								["Carlow", <%=count[5]%>],
								["Dublin", <%=count[6]%>],
								["Clare", <%=count[7]%>],
								["kilkenny", <%=count[8]%>],
								["Laois", <%=count[9]%>],
								["Longford", <%=count[10]%>],
								["Louth", <%=count[11]%>],
								["Meath", <%=count[12]%>],
								["Offaly", <%=count[13]%>],
								["Westmeath", <%=count[14]%>],
								["Wexford", <%=count[15]%>],
								["Clare", <%=count[16]%>],
								["Cork", <%=count[17]%>],
								["Kerry", <%=count[18]%>],
								["Limerick", <%=count[19]%>],
								["Tpperary", <%=count[20]%>],
								["Waterford", <%=count[21]%>],
								["Cavan", <%=count[22]%>],
								["Donegal", <%=count[23]%>],
								["Monaghan", <%=count[24]%>]
								
      ]);

      var options = {
        region: 'IE',
        displayMode: 'markers',
        colorAxis: {colors: ['green', 'blue']}
      };

      var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    };
    </script>
	<%}
	else{
		out.println("<h3 stlye='color:red'>You must <a href='login.jsp'>Login</a> to see the statistics</h3>");
	}
	%>
  </head>
  <body>
    <div id="chart_div" style="width: 900px; height: 500px;"></div>
  </body>
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

 