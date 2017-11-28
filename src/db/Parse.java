package db;

public class Parse {
	public int dps=0;
	public int hps=0;
	public String name="";
	public String date="";
	public String boss="";
	Parse(int d, int h, String n, String dt)
	{
		dps=d;
		hps=h;
		name=n;
		date=dt;
	}
	Parse(int d, int h, String n, String dt, String b)
	{
		dps=d;
		hps=h;
		name=n;
		date=dt;
		boss=b;
	}
}