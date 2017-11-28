package db;
import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;

public class DatabaseUtility {
	private static Connection dbconn;
	private static Connection newConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
					
			dbconn = DriverManager.getConnection("jdbc:mysql://localhost:3306?useSSL=false","root","");
			return dbconn;
			
		}
		catch (Exception err){
			err.printStackTrace();
		}
		return null;
	}
	public static void addPlayer(String n, String c, String f, String g)
	{
		String pid="";
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select count(*), playerID from cs485_project.players where name=?;";
		try {
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, n);
			r = pQuery.executeQuery();
			r.next();
			if(!r.getString("count(*)").equals("1"))
			{
				query = "INSERT INTO cs485_project.players(`name`, `class`, `faction`) VALUES(?, ?, ?)";
				pQuery = dbconn.prepareStatement(query);
				pQuery.setString(1, n);
				pQuery.setString(2, c);
				pQuery.setString(3, f);
				pQuery.executeUpdate();
				query = "select count(*), playerID from cs485_project.players where name=?;";
				dbconn = newConnection();
				pQuery = dbconn.prepareStatement(query);
				pQuery.setString(1, n);
				r = pQuery.executeQuery();
				r.next();
				pid=r.getString("playerID");
				if(g!="")
				{
					query = "select count(*) from cs485_project.guilds where name=?;";
					dbconn = newConnection();
					pQuery = dbconn.prepareStatement(query);
					pQuery.setString(1, g);
					r = pQuery.executeQuery();
					r.next();
					if(!r.getString("count(*)").equals("1"))
					{
						query = "INSERT INTO cs485_project.guilds(`name`) VALUES(?)";
						pQuery = dbconn.prepareStatement(query);
						pQuery.setString(1, g);
						pQuery.executeUpdate();
					}
					query = "select guildID from cs485_project.guilds where name=?;";
					dbconn = newConnection();
					pQuery = dbconn.prepareStatement(query);
					pQuery.setString(1, g);
					r = pQuery.executeQuery();
					r.next();
					String gid=r.getString("guildID");
					query = "UPDATE cs485_project.players SET guildID=? where playerID=?";
					pQuery = dbconn.prepareStatement(query);
					pQuery.setString(1, gid);
					pQuery.setString(2, pid);
					pQuery.executeUpdate();
				}
			}
			dbconn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void addLog(String p, String b, int dps, int hps, int progress)
	{
		String player="";
		String boss="";
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select playerID from cs485_project.players where name=?;";
		try {
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, p);
			r = pQuery.executeQuery();
			r.next();
			if(!r.first()) return;
			player=r.getString("playerID");
			dbconn = newConnection();
			query = "select bossID from cs485_project.bosses where name=?;";
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, b);
			r = pQuery.executeQuery();
			r.next();
			if(!r.first()) return;
			boss=r.getString("bossID");
			dbconn = newConnection();
			query = "INSERT INTO cs485_project.logs(`dps`, `hps`, `playerID`, `progress`, `date`, `bossID`) VALUES(?, ?, ?, ?, NOW(), ?)";
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, Integer.toString(dps));
			pQuery.setString(2, Integer.toString(hps));
			pQuery.setString(3, player);
			pQuery.setString(4, Integer.toString(progress));
			pQuery.setString(5, boss);
			pQuery.executeUpdate();
			dbconn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static ArrayList<Parse> news(String user)
	{
		ArrayList<Parse> data = new ArrayList<Parse>();
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select dps, hps, date, cs485_project.players.name as pname, cs485_project.bosses.name from cs485_project.logs join cs485_project.bosses join cs485_project.following join cs485_project.users join cs485_project.players where cs485_project.users.username=? and cs485_project.users.userID=cs485_project.following.userID and cs485_project.following.playerID=cs485_project.logs.playerID and cs485_project.logs.playerID=cs485_project.players.playerID and cs485_project.bosses.bossID=cs485_project.logs.bossID ORDER BY YEAR(Date) DESC, MONTH(Date) DESC, DAY(DATE) DESC;";
		try {
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, user);
			r = pQuery.executeQuery();
			r.next();
			if(r.first())
			{
				do{
					data.add(new Parse(r.getInt("dps"), r.getInt("hps"), r.getString("pname"), r.getString("date"), r.getString("name")));
					r.next();
				}while(!r.isAfterLast());
			}
			dbconn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return data;
	}
	public static void follow(String user, int playerID)
	{
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select userID from cs485_project.users where username=?;";
		try {
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, user);
			r = pQuery.executeQuery();
			r.next();
			String userID=r.getString("userID");
			query = "select count(*) from cs485_project.following where userID=? and playerID=?";
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, userID);
			pQuery.setString(2, Integer.toString(playerID));
			r = pQuery.executeQuery();
			r.next();
			if(r.getString("count(*)").equals("0"))
			{
				query = "INSERT INTO cs485_project.following(`userID`, `playerID`) VALUES(?, ?)";
				pQuery = dbconn.prepareStatement(query);
				pQuery.setString(1, userID);
				pQuery.setString(2, Integer.toString(playerID));
				pQuery.executeUpdate();
			}else
			{
				query = "DELETE FROM cs485_project.following where userID=? and playerID=?";
				pQuery = dbconn.prepareStatement(query);
				pQuery.setString(1, userID);
				pQuery.setString(2, Integer.toString(playerID));
				pQuery.executeUpdate();
			}
			dbconn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static int search(String search)
	{
		int data=0;
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select playerID from cs485_project.players where name LIKE ?";
		try {
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, "%"+search+"%");
			r = pQuery.executeQuery();
			r.next();
			if(r.first())
			{
				data=r.getInt("playerID");
			}
			dbconn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return data;
	}
	public static Boss bossInfo(int id)
	{
		Boss data = new Boss();
		ArrayList<Ability> dataA = new ArrayList<Ability>();
		ArrayList<Parse> dataB = new ArrayList<Parse>();
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select phase_number, ability_name, description from cs485_project.bosses join cs485_project.abilities join cs485_project.phases where cs485_project.bosses.bossID=? and cs485_project.phases.bossID=cs485_project.bosses.bossID and cs485_project.phases.abilityID=cs485_project.abilities.abilityID;";
		try {
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, Integer.toString(id));
			r = pQuery.executeQuery();
			r.next();
			if(r.first())
			{
				do{
					dataA.add(new Ability(r.getInt("phase_number"), r.getString("ability_name"), r.getString("description")));
					r.next();
				}while(!r.isAfterLast());
			}
			query = "select dps, hps, date, cs485_project.players.name from cs485_project.logs join cs485_project.bosses join cs485_project.players where cs485_project.logs.bossID=? and cs485_project.bosses.bossID=cs485_project.logs.bossID and cs485_project.players.playerID=cs485_project.logs.playerID ORDER BY dps+hps DESC;";
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, Integer.toString(id));
			r = pQuery.executeQuery();
			r.next();
			if(r.first())
			{
				do{
					dataB.add(new Parse(r.getInt("dps"), r.getInt("hps"), r.getString("name"), r.getString("date")));
					r.next();
				}while(!r.isAfterLast());
			}
			query = "select health, cs485_project.bosses.name, resistance, rName from cs485_project.bosses join cs485_project.raids where bossID=? and cs485_project.bosses.raidID=cs485_project.raids.raidID;";
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, Integer.toString(id));
			r = pQuery.executeQuery();
			r.next();
			data= new Boss(r.getInt("health"), r.getString("name"), r.getString("rName"), r.getString("resistance"), dataA, dataB);
			dbconn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return data;
	}
	public static Player playerParses(int id)
	{
		Player player = new Player();
		ArrayList<Parse> data = new ArrayList<Parse>();
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select dps, hps, date, name from cs485_project.logs join cs485_project.bosses where playerID=? and cs485_project.bosses.bossID=cs485_project.logs.bossID ORDER BY dps+hps DESC;";
		try {
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, Integer.toString(id));
			r = pQuery.executeQuery();
			r.next();
			if(r.first())
			{
				do{
					data.add(new Parse(r.getInt("dps"), r.getInt("hps"), r.getString("name"), r.getString("date")));
					r.next();
				}while(!r.isAfterLast());
			}
			player.parse=data;
			query = "select cs485_project.players.name as name, class, faction from cs485_project.players where playerID=?";
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, Integer.toString(id));
			r = pQuery.executeQuery();
			r.next();
			player.name=r.getString("name");
			player.pClass=r.getString("class");
			player.faction=r.getString("faction");
			query = "select cs485_project.guilds.name as guild from cs485_project.guilds join cs485_project.players where cs485_project.guilds.guildID=cs485_project.players.guildID and playerID=?";
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, Integer.toString(id));
			r = pQuery.executeQuery();
			r.next();
			if(r.first())
				player.guild=r.getString("guild");
			dbconn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return player;
	}
	public static void signup(String user, String pass)
	{
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select count(*) from cs485_project.users where username=?;";
		try {
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, user);
			r = pQuery.executeQuery();
			r.next();
			if(!r.getString("count(*)").equals("1"))
			{
				query = "INSERT INTO cs485_project.users(`username`, `password`) VALUES(?, ?)";
				pQuery = dbconn.prepareStatement(query);
				pQuery.setString(1, user);
				pQuery.setString(2, pass);
				pQuery.executeUpdate();
			}
			dbconn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static boolean login(String user, String pass)
	{
		ResultSet r;
		PreparedStatement pQuery;
		String query = "select count(*) from cs485_project.users where username=? and password=?;";
		try {
			boolean result = false;
			dbconn = newConnection();
			pQuery = dbconn.prepareStatement(query);
			pQuery.setString(1, user);
			pQuery.setString(2, pass);
			r = pQuery.executeQuery();
			r.next();
			result = (r.getString("count(*)").equals("1"));
			dbconn.close();
			return result;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	public static void main(String[] args) {
		DatabaseUtility db = new DatabaseUtility();
		System.out.println(db.bossInfo(4).abilities.get(1).description);
		Scanner in = new Scanner(System.in);
		System.out.print("Username: ");
		String user=in.nextLine();
		System.out.print("\nPassword: ");
		String pass=in.nextLine();
		if(db.login(user, pass))
			System.out.println("Login Successful");
		else
			System.out.println("Login Failed");
	}
}