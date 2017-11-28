<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="db.*" %>
<%@ page import="java.util.*" %>
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
		
		<div class="backdrop">
		<% 
			if(session.getAttribute("logged")!=null){//Pull news from DB
				
				ArrayList<Parse> parse = DatabaseUtility.news((String)session.getAttribute("logged"));%>
					<% if(!parse.isEmpty()){%>
							<table>
							<tr> <th>Player</th><th>Boss</th><th>DPS</th> <th>HPS</th><th>Date</th></tr>
							<%while(!parse.isEmpty()){%>
							<tr> 
							<td><%=parse.get(0).name%></td>
							<td><%=parse.get(0).boss%></td>
							<td><%=parse.get(0).dps%></td>
							<td><%=parse.get(0).hps%></td>
							<td><%=parse.get(0).date%></td>
							</tr>
				<%parse.remove(0);
				}
			%> 
			</table>
			<%}
					else{%>
						<h3>Search for players and follow them to display recent logs!</h3>
					<%}
			}
			
			else{%>
			<p>
				Sign up / Log in to see recent activity of players that you are following!
			</p>
			<%} %>
		</div>
		
	</body>
</html>