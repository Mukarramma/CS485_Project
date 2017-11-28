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
                <%if(session.getAttribute("logged")!=null){%>
            <li class="navli col-2 col-m-3"><a href = "signout.jsp">Log Out</a></li>
                <%}else{ %>
            <li class="navli col-2 col-m-3"><a href = "signin.jsp">Sign In</a></li>
                <%} %>
        </ul>
		
		
		<div class="backdrop">
			<form action="create.jsp" id="centerform" class="backdrop" name="Login" method="post">
				<h2 id="loginheader">Create Account</h2>
				<input type="text" name="Username" placeholder="Username"><br>
				<input type="password" name="Password" placeholder="Password" maxlength="32"><br>
				<input type="password" name="confirmPassword" placeholder="Confirm Password" maxlength="32"><br>
				<input type="submit" name="submit" value="Create Account">
			</form>
			
				<%
				if(request.getParameter("submit") != null){
					String username=request.getParameter("Username");
					String password=request.getParameter("Password");
					String confirmPassword=request.getParameter("confirmPassword");
					if(password.equals(confirmPassword)){
						DatabaseUtility.signup(username, password);%>
						<script type="text/javascript">
							alert("Account Successfully Created!");
							window.location.replace("signin.jsp");
						</script>
					<%
					}
					else{%><p>**Password Mismatch**</p><%}
				}%>
		</div>
	</body>
</html>