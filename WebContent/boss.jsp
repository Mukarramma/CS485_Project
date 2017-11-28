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
		
		<div class="backdrop">
			
			<%Boss boss = DatabaseUtility.bossInfo(Integer.parseInt(request.getParameter("id")));%>
			<p>Name: <%=boss.name%></p>
			<p>Raid: <%=boss.raid%></p>
			<p>Health: <%=boss.health%></p>
			<p>Resistance: <%=boss.resistance%></p>
			
			<table>
			<tr> <th>Ability Name</th> <th>Phase</th> <th>Description</th></tr>
				<%while(!boss.abilities.isEmpty()){%>
					
						<tr> <td><%=boss.abilities.get(0).name%></td>
							<td><%=boss.abilities.get(0).phase%></td>
							<td><%=boss.abilities.get(0).description%></td>
						</tr>
				<%boss.abilities.remove(0);
				}
			%> 
			</table>
			
			<table>
					<tr> <th>Player</th> <th>DPS</th> <th>HPS</th></tr>
				<%while(!boss.parse.isEmpty()){%>
						<tr> <td><%=boss.parse.get(0).name%></td>
							<td><%=boss.parse.get(0).dps%></td>
							<td><%=boss.parse.get(0).hps%></td>
						</tr>
				<%boss.parse.remove(0);
				}
			%> 
			</table>
		</div>
	</body>
</html>