<!DOCTYPE html>
<%@ page import="db.*" %>
<html lang = 'en'>
	<head>
		<meta charset = "utf-8">
		<link href= "vanillalogs.css" type="text/css" rel="stylesheet">
		<title>Vanilla Logs</title>
	</head>

	<body>
		<div class="backdrop">
			<header>
				<h1 class="logo">Vanilla Logs</h1>
				<form action="results.jsp" id="searchbar" method="get">
					<input type="text" name="search" placeholder="Search for players">
					<input type="submit" style="position: absolute; left: -9999px; width: 1px; height: 1px;">
				</form>
			</header>
		</div>
		
		<ul class=navul>
			<li class="navli col-2 col-m-3"><a href = "index.jsp">Home</a></li>
			<li class="navli col-2 col-m-3"><a href = "bosses.jsp">Bosses</a></li>
			<li class="navli col-2 col-m-3"><a href = "upload.jsp">Upload Logs</a></li>
			<li class="navli col-2 col-m-3"><a href = "uploadplayer.jsp">Upload Player</a></li>
			<li class="navli col-2 col-m-3"><a href = "signin.jsp">Sign In</a></li>
		</ul>
		
		<div class="centerdiv">
			<form action="signin.jsp" id="centerform" class="backdrop" name="Login" method="post">
				<h2 id="loginheader">Login</h2>
				<input type="text" name="Username" placeholder="Username">
				<input type="password" name="Password" placeholder="Password" maxlength="32">
				<input type="submit" name="submit" value="Login">
				<p>Not registered?  Create an account <a href="create.jsp">here</a></p>
			
			<% 
				if(request.getParameter("submit")!=null){
					String user = request.getParameter("Username");
					String pw = request.getParameter("Password");
					if(DatabaseUtility.login(user,pw)){
						session.setAttribute("logged", request.getParameter("Username"));
					%>
					<script type="text/javascript">window.location.replace("index.jsp");</script>
					<%}else{%>
						<p>**Login Failed**</p>
					<%}} %>
			</form>
		</div>
		
	</body>
</html>