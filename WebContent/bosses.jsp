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
		
		<div class="backdrop">
			<ul id="raids">
				<li><strong>Molten Core: Tier 1, Blackrock Mountain</strong>
					<ul>
						<li><p id ="16" onClick="f(this.id)">Lucifron</p></li>
						<li><p id ="17" onClick="f(this.id)">Magmadar</p></li>
						<li><p id ="18" onClick="f(this.id)">Gehennas</p></li>
						<li><p id ="19" onClick="f(this.id)">Garr</p></li>
						<li><p id ="20" onClick="f(this.id)">Baron Geddon</p></li>
						<li><p id ="21" onClick="f(this.id)">Shazzrah</p></li>
						<li><p id ="22" onClick="f(this.id)">Sulfuron Harbinger</p></li>
						<li><p id ="23" onClick="f(this.id)">Golemagg the Incinerator</p></li>
						<li><p id ="24" onClick="f(this.id)">Majordomo Exectus</p></li>
						<li><p id ="25" onClick="f(this.id)">Ragnaros</p></li>
					</ul>
				</li>
				
				<li><strong>Blackwing Lair, Tier 2, Blackrock Mountain</strong>
					<ul>
						<li><p id ="26" onClick="f(this.id)">Razorgore the Untamed</p></li>
						<li><p id ="27" onClick="f(this.id)">Vaelastrasz the Corrupt</p></li>
						<li><p id ="28" onClick="f(this.id)">Broodlord Lashlayer</p></li>
						<li><p id ="29" onClick="f(this.id)">Firemaw</p></li>
						<li><p id ="30" onClick="f(this.id)">Ebonroc</p></li>
						<li><p id ="31" onClick="f(this.id)">Flamegor</p></li>
						<li><p id ="32" onClick="f(this.id)">Chromaggus</p></li>
						<li><p id ="33" onClick="f(this.id)">Nefarian</p></li>
					</ul>
				</li>
				
				<li><strong>Naxxramas, Tier 3, Eastern Plaguelands</strong>
					<ul>
						<li><em>The Arachnid Quarter</em>
							<ul>
								<li><p id ="1" onClick="f(this.id)">Anub'Rekhan</p></li>
								<li><p id ="2" onClick="f(this.id)">Grand Widow Faerlina</p></li>
								<li><p id ="3" onClick="f(this.id)">Maexxna</p></li>
							</ul>
						</li>
						<li><em>The Plague Quarter</em>
							<ul>
								<li><p id ="8" onClick="f(this.id)">Noth the Plaguebringer</p></li>
								<li><p id ="9" onClick="f(this.id)">Heigan the Unclean</p></li>
								<li><p id ="10" onClick="f(this.id)">Loatheb</p></li>
							</ul>
						</li>
						<li><em>The Military Quarter</em>
							<ul>
								<li><p id ="11" onClick="f(this.id)">Instructor Razuvious</p></li>
								<li><p id ="12" onClick="f(this.id)">Gothik the Harvester</p></li>
								<li><p id ="13" onClick="f(this.id)">The Four Horsemen</p></li>
							</ul>
						</li>
						<li><em>The Construct Quarter</em>
							<ul>
								<li><p id ="4" onClick="f(this.id)">Patchwerk</p></li>
								<li><p id ="5" onClick="f(this.id)">Grobbulus</p></li>
								<li><p id ="6" onClick="f(this.id)">Gluth</p></li>
								<li><p id ="7" onClick="f(this.id)">Thaddius</p></li>
							</ul>
						</li>
						<li><em>Frostwyrm Lair</em>
							<ul>
								<li><p id ="14" onClick="f(this.id)">Sapphiron</p></li>
								<li><p id ="15" onClick="f(this.id)">Kel'Thuzad</p></li>
							</ul>
						</li>
					</ul>
				</li>
			</ul>
		</div>
		<form name="input" id="hi" action="" method="post">
		<input type="hidden" value="2" name="bossID" placeholder="bossID" /> </form>
		<script type="text/javascript">
		function f(id){
			window.location.replace("boss.jsp?id="+id);
		}
		</script>
	</body>
</html>