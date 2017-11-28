<%
	session.removeAttribute("logged");
	session.invalidate();     
%>
<script type="text/javascript">window.location.replace("index.jsp");</script>