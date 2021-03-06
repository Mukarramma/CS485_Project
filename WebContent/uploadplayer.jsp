<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="db.*" %>
<%if(session.getAttribute("logged")==null){%>
	<script>
		alert("Please login before accessing this page");
		window.location.replace("signin.jsp");			
	</script>
<%} %>
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
				<form action=results.jsp id="searchbar" method="get">
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
                <%if(session.getAttribute("logged")!=null){%>
            <li class="navli col-2 col-m-3"><a href = "signout.jsp">Log Out</a></li>
                <%}else{ %>
            <li class="navli col-2 col-m-3"><a href = "signin.jsp">Sign In</a></li>
                <%} %>
        </ul>
		
		<div class="centerdiv">
			<form action = "uploadplayer.jsp" id="centerform" class="backdrop" name="Login" method="post">
				<h2 id="formheader">Upload Player</h2>
				Enter Player Name:<input type="text" name="name" placeholder="Enter Name..."><br>
				Enter Class:<input type="text" name="class" placeholder="Enter Class..."><br>
				Enter Faction:<input type="text" name="faction" placeholder="Enter Faction..."><br>
				Enter Guild:<input type="text" name="guild" placeholder="Enter Guild..."><br>
				<input type="submit" name="submit" value="Upload">
			</form>
			<%
				if(request.getParameter("submit") != null){
					String name=request.getParameter("name");
					String clss=request.getParameter("class");
					String faction=request.getParameter("faction");
					String guild=request.getParameter("guild");
					DatabaseUtility.addPlayer(name, clss, faction, guild);%>
						<script type="text/javascript">
							window.location.replace("index.jsp");
						</script>
					<%}%>
		</div>
	</body>
</html>