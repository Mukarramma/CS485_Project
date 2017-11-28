<%@ page import="db.*" %>
<%if(session.getAttribute("logged")==null){%>
	<script>
		alert("Please login before accessing this page");
		window.location.replace("signin.jsp");			
	</script>
<%} %>
<!DOCTYPE html>
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
                <%if(session.getAttribute("logged")!=null){%>
            <li class="navli col-2 col-m-3"><a href = "signout.jsp">Log Out</a></li>
                <%}else{ %>
            <li class="navli col-2 col-m-3"><a href = "signin.jsp">Sign In</a></li>
                <%} %>
        </ul>
		
		<div class="centerdiv">
			<form action="upload.jsp" id="centerform" class="backdrop" name="Login" method="post">
				<h2 id="formheader">Upload Logs</h2>
				Enter DPS:<input type="text" name="dps" placeholder="Enter DPS..."><br>
				Enter HPS:<input type="text" name="hps" placeholder="Enter HPS..."><br>
				Enter Player Name:<input type="text" name="playername" placeholder="Enter Player Name..."><br>
				Enter Progress:<input type="text" name="progress" placeholder="Enter Progress..."><br>
				Enter Boss Name:<input type="text" name="boss" placeholder="Enter Boss Name..."><br>
				<input type="submit" name="submit" value="Upload">
				
				<%
				if(request.getParameter("submit")!=null)
					DatabaseUtility.addLog(request.getParameter("playername"), request.getParameter("boss"), Integer.parseInt(request.getParameter("dps")), Integer.parseInt(request.getParameter("hps")), Integer.parseInt(request.getParameter("progress")));
					%>
			</form>
		</div>
		
	</body>
</html>