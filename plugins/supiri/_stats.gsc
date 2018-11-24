/*===================================================================||
||/|¯¯¯¯¯¯¯\///|¯¯|/////|¯¯|//|¯¯¯¯¯¯¯¯¯|//|¯¯¯¯¯¯¯¯¯|//\¯¯\/////¯¯//||
||/|  |//\  \//|  |/////|  |//|  |/////////|  |//////////\  \///  ///||
||/|  |///\  \/|  |/////|  |//|  |/////////|  |///////////\  \/  ////||
||/|  |///|  |/|  |/////|  |//|   _____|///|   _____|//////\    /////||
||/|  |////  //|  \/////|  |//|  |/////////|  |/////////////|  |/////||
||/|  |///  ////\  \////  ////|  |/////////|  |/////////////|  |/////||
||/|______ //////\_______/////|__|/////////|__|/////////////|__|/////||
||===================================================================||

||===================================================================*/

#include plugins\_common;


init() {

	while( 1 )
	{
		level waittill( "connected", player );	
		player thread playerconnect();
		player thread initStats();
	}

}
playerconnect(){

	while( 1 )
		{
			self waittill( "spawned_player" );
			self setStats();
		}

}

initStats() {

	if(!isDefined(self.pers["fb"]))
		self.pers["fb"] = self getstat(1222);
	if(!isDefined(self.pers["fov"]))
		self.pers["fov"] = self getstat(1322);
	if(!isDefined(self.pers["power"]))
		self.pers["power"] = self getstat(1523);
	if(!isDefined(self.pers["laser"]))
		self.pers["laser"] = self getstat(1521);
	if(!isDefined(self.pers["adminicon"]))
		self.pers["adminicon"] = self getstat(90);	
	if(!isDefined(self.pers["kmusic"]))
		self.pers["kmusic"] = self getstat(81);
	if(!isDefined(self.pers["stockteammenu"]))
		self.pers["stockteammenu"] = self getstat(2213);
	if(!isDefined(self.pers["hidevote"]))
		self.pers["hidevote"] = self getstat(2214);
	if(!isDefined(self.pers["hidekillcard"]))
		self.pers["hidekillcard"] = self getstat(2215);
	if(!isDefined(self.pers["hidestatshud"]))
		self.pers["hidestatshud"] = self getstat(2216);
	if(!isDefined(self.pers["stopknife"]))
		self.pers["stopknife"] = self getstat(2217);
	if(!isDefined(self.pers["hidelevelup"]))
		self.pers["hidelevelup"] = self getstat(2218);	
	if(!isDefined(self.pers["disablespree"]))
		self.pers["disablespree"] = self getstat(2219);
		
	

	if(!isDefined(self.pers["vip"]))
		self.pers["vip"] = 0;
	if(!isDefined(self.pers["admin"]))
		self.pers["admin"] = 0;
	if(!isDefined(self.pers["bestdeathsstreak"]))
		self.pers["bestdeathsstreak"] = 0;
	if(!isDefined(self.pers["bestkillsstreak"]))
		self.pers["bestkillsstreak"] = 0;
	if(!isDefined(self.pers["playedtime"]))
		self.pers["playedtime"] = int(self getplayerStat("TIME_PLAYED_TOTAL"));
		
		
	/*if(self.pers["fov"] == 1)
		self iPrintln( "^3You Still Have ^1Fov Enabled At 1.125" );
	if(self.pers["fov"] == 2)
		self iPrintln( "^3You Still Have ^1Fov Enabled At 1.25" );
	if(self.pers["fb"] == 1)
		self iPrintln( "^3You Still Have ^1Fullbright Enabled" );
	if(self.pers["power"] == 6)
		self iPrintln( "^3You Still Have ^1logged in as ^3Master" );
	if(self.pers["power"] == 5)
		self iPrintln( "^3You Still Have ^1logged in as ^3Leader" );
	if(self.pers["power"] == 4)
		self iPrintln( "^3You Still Have ^1logged in as ^3HeadAdmin" );
	if(self.pers["power"] == 3)
		self iPrintln( "^3You Still Have ^1logged in as ^3FullAdmin" );
	if(self.pers["power"] == 2)
		self iPrintln( "^3You Still Have ^1logged in as ^3Moderator" );
	if(self.pers["power"] == 1)
		self iPrintln( "^3You Still Have ^1logged in as ^3" );
	if(self.pers["laser"] == 1)
		self iPrintln( "^3You Still Have ^1Laser Enabled" );
	if(self.pers["adminicon"] == 1)
		self iPrintln( "^3You Still Have ^1Admin Icon Enabled" );
	if(self.pers["kmusic"] == 1)
		self iPrintln( "^3You Still Have ^1Killcam Music Disabled" );
	if(self.pers["vip"] == 1)
		self iPrintln( "^3You Still Have ^1logged in as ^3VIP" );*/
		
	if(self.pers["stockteammenu"])
		self setClientDvar( "supiri_stockmenu", 1 );
	else
		self setClientDvar( "supiri_stockmenu", 0 );
		
	if(self.pers["hidevote"])
		self setClientDvar( "supiri_hidevote", 1 );
	else
		self setClientDvar( "supiri_hidevote", 0 );
		
	if(self.pers["hidekillcard"])
		self setClientDvar( "supiri_hidekillcard", 1 );
	else
		self setClientDvar( "supiri_hidekillcard", 0 );
		
	if(self.pers["stopknife"])
		self setClientDvar( "supiri_stopknife", 1 );
	else
		self setClientDvar( "supiri_stopknife", 0 );
		
	if(self.pers["kmusic"])
		self setClientDvar( "supiri_kmusic", 1 );
	else
		self setClientDvar( "supiri_kmusic", 0 );
		
	if(self.pers["hidelevelup"])
		self setClientDvar( "supiri_hidelevelup", 1 );
	else
		self setClientDvar( "supiri_hidelevelup", 0 );
		
	if(self.pers["disablespree"])
		self setClientDvar( "supiri_disablespree", 1 );
	else
		self setClientDvar( "supiri_disablespree", 0 );
	
	if(self.pers["fb"])
		self setClientDvar( "r_fullbright", 1 );
	else
		self setClientDvar( "r_fullbright", 0 );


		
}

setStats(){
	self.voted = false;
	self.novoting = false;
	self.recentKillCount = 0;
	self.lastKillTime = 0;
	self.lastKilledBy = undefined;
	self.deathTime=0;
	
}
