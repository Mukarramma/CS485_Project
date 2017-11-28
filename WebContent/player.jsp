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
			<!-- Put Logs Here -->
			<%Player player = DatabaseUtility.playerParses((Integer)session.getAttribute("id"));%>
			<p>Name: <%=player.name%></p>
			<p>Class: <%=player.pClass%></p>
			<p>Guild: <%=player.guild%></p>
			<p>Faction: <%=player.faction%></p>
			
			<table>
					<tr> <th>DPS</th> <th>HPS</th> <th>Boss</th><th>Date</th></tr>
				<%while(!player.parse.isEmpty()){%>
						<tr> <td><%=player.parse.get(0).dps%></td>
							<td><%=player.parse.get(0).hps%></td>
							<td><%=player.parse.get(0).name%></td>
							<td><%=player.parse.get(0).date%></td>
						</tr>
				<%player.parse.remove(0);
				}
			%> 
			</table>
			<%if(session.getAttribute("logged")!=null){%>
				<button onClick="click()">Follow</button>
				<script type="text/javascript">
				function click(){
					<%DatabaseUtility.follow((String)session.getAttribute("logged"), (int)session.getAttribute("id"));%>
				}
			</script>
			<%}%>
			
		</div>
	</body>
</html>