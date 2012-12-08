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
			<li class="current_page_item"><a href="login.jsp">Login</a></li>
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div class="post">
					<p style="color:red">Newly register's must wait up to three days before they can log in for background security check</p>
						<form name="form" action="" method="">
							<table>
								<tr>
									<td> Username  : </td><td> <input id ="user" name="username" size=15 type="text" /> </td> 
								</tr>
								<tr>
									<td> Password  : </td><td> <input id="pass" name="password" size=15 type="Password" /> </td> 
								</tr>
								<tr>
									<td> Re-Type Password  : </td><td> <input id="pass1" name="password1" size=15 type="Password" /> </td> 
								</tr>
								<tr>
									<td> Police number  : </td><td> <input id="police" name="number" size=15  onkeyup="if (this.value.length > 9) { alert('Too many digits. Must be Maximum 9 charachters only');this.value = this.value.substr(0,9);}" type="Password" /> </td> 
								</tr>
								<tr>
									<td> county  : </td>
									<td>
									<select id="county" name="county">
									<option selected="selected">Select County</option> 
									<option value="Galway">Galway</option> 
									<option value="Leitrim">Leitrim</option> 
									<option value="Mayo">Mayo</option> 
									<option value="Roscommon">Roscommon</option> 
									<option value="Sligo">Sligo</option> 
									<option value="Carlow">Carlow</option> 
									<option value="Dublin">Dublin</option> 
									<option value="Clare">Clare</option> 
									<option value="Kilkenny">kilkenny</option> 
									<option value="Laois">Laois</option> 
									<option value="Longford">Longford</option> 
									<option value="Louth">Louth</option> 
									<option value="Meath">Meath</option> 
									<option value="Offaly">Offaly</option> 
									<option value="Westhmeath">Westmeath</option> 
									<option value="Wexford">Wexford</option> 
									<option value="Clare">Clare</option> 
									<option value="Cork">Cork</option> 
									<option value="Kerry">Kerry</option> 
									<option value="Limerick">Limerick</option> 
									<option value="Tpperary">Tpperary</option> 
									<option value="Waterford">Waterford</option> 
									<option value="Cavan">Cavan</option> 
									<option value="Donegal">Donegal</option> 
									<option value="Monaghan">Monaghan</option> 
									<option value="Armagh">Armagh</option> 
									<option value="Down">Down</option> 
									<option value="Fermanagh">Fermanagh</option> 
									<option value="Derry">Derry</option> 
									<option value="Tyrone">Tyrone</option> 
									</select></td>
								</tr>
							</table>
							<input type="button" onClick="button(this);" value="Register" />
						</form>
						<div id="one"></div>
					</div>
				</div>
				<!-- end #content -->
				<div style="clear: both;">&nbsp;</div>
			</div>
		</div>
	</div>
	<!-- end #page -->
</div>
<script>
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

		function button(form){
			var username = document.form.username.value;
			var password = document.form.password.value;
			var password2 = document.form.password1.value;
			var number = document.form.number.value;
			var county = document.form.county.value;
			
			if(password != null && password != "" && password2 != null && password2 != "" && username != null && username != ""
				&& number != null && number != "" && county != "Select County"){
				if(password == password2){
					if(xmlhttp) {
						xmlhttp.open("GET","register?username="+username+"&password="+password+"&number="+number+"&county="+county,true);
						xmlhttp.onreadystatechange  = handleServerResponse;
						xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
						xmlhttp.send(null);
						
					  }
				}
				else{
					alert("Passwords dont match");
				}
			}
			else{
				alert("All forms werent filled in");
			}
			function handleServerResponse() {
			   if (xmlhttp.readyState == 4) {
				 if(xmlhttp.status == 200) {
				   var value = new String(xmlhttp.responseText);
				   console.log(value);
					if (value.trim() == "true"){
						alert("it may take up to 3 working days until you can log in");
						location.href = 'login.jsp';	
					}
					else{
						alert("Password and username already used. Please change one of them");
					}
				 }
			   }
			
	}
	}
</script>
<div id="footer">
	<p>Copyright (c) 2012 AttackApplication.com. All rights reserved. Design by AntApp</p>
</div>


</body>
</html>

 