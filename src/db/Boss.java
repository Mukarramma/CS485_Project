package db;

import java.util.ArrayList;

public class Boss {
	public int health = 0;
	public String name = "";
	public String raid = "";
	public String resistance = "";
	public ArrayList<Ability> abilities = null;
	public ArrayList<Parse> parse = null; 
	public Boss(int h, String n, String r, String rs, ArrayList<Ability> ab, ArrayList<Parse> p)
	{
		health=h;
		name=n;
		raid=r;
		resistance=rs;
		abilities=ab;
		parse=p;
	}
	public Boss()
	{
		
	}
}
