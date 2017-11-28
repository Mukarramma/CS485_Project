package db;

import java.util.ArrayList;

public class Player {
	public String name="";
	public String pClass="";
	public String faction="";
	public String guild="None";
	public ArrayList<Parse> parse = null;
	public Player(String n, String c, String f, ArrayList<Parse> p, String g)
	{
		name=n;
		pClass=c;
		faction=f;
		parse=p;
		guild=g;
	}
	public Player()
	{
		
	}
}
