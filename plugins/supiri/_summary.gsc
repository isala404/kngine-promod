/*==============================================================================
		████████████████████████████████████████████████████████████████
		█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█
		█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█
		█░░░█████████░█████░░████░██████████░█████░██████████░░█████░░░█
		█░░███░░░░░░░░░███░░░░██░░░███░░░░███░███░░░███░░░░███░░███░░░░█
		█░░░█████████░░███░░░░██░░░█████████░░███░░░█████████░░░███░░░░█
		█░░░░░░░░░░███░███░░░░██░░░███░░░░░░░░███░░░███░░███░░░░███░░░░█
		█░░██████████░░░███████░░░█████░░░░░░█████░█████░░████░█████░░░█
		█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█
		█░░░DO NOT USE, SHARE OR MODIFY THIS FILE WITHOUT PERMISSION░░░█
		█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█
		████████████████████████████████████████████████████████████████
==============================================================================*/
#include plugins\_common;

playersummary() {
		self endon("disconnect");
		
		stats = [];
		value = [];
		
		self.pers["playedtime"] = int(self getplayerStat("TIME_PLAYED_TOTAL")) - self.pers["playedtime"];

		stats[0] = addTextHud( self, -170, -150, 1, "left", "middle", "center", "middle", 1.8, 9999);		
		stats[0] setText("^3Rank XP Gain\nKill Strike\nDeath Strike\nHeadShots\nK/D/A Ratio\nAccuracy\nMelee Kills\nGrenade Kills\nSniper Kills\nSMG Kills\nAK Kills\nMap Time");

		stats[1] = addTextHud( self, -10, -150, 1, "left", "middle", "center", "middle", 1.8, 9999);		
		stats[1] setText("^3XP 2 Next Rank\nBest Kill Strike\nBest Death Strike\nTotal HeadShots\nOverrall KDA Ratio\nOverrall Accuracy\nOverrall Melee Kills\nOverrall Grenade Kills\nOverrall Sniper Kills\nOverrall SMG Kills\nOverrall AK Kills\nTotal Time Played");
		
		text = "^7: ^1" + self.pers["thisrankxp"] + "\n^7: ^1" + self.pers["killsstreak"] + "\n^7: ^1" + self.pers["deathsstreak"] + "\n^7: ^1" + self.pers["headshots"] + "\n^7: ^1" + self.pers["kda"] + "\n^7: ^1" + self.pers["accuracy"] + "\n^7: ^1" + self.pers["knifes"] + "\n^7: ^1" + self.pers["nades"] + "\n^7: ^1" + self.pers["scope"] + "\n^7: ^1" + self.pers["smg"] + "\n^7: ^1" + self.pers["ak47"] + "\n^7: ^1" + RoundDown(self.pers["playedtime"]/60) + " mins";
		
		stats[2] = addTextHud( self, -75, -150, 1, "left", "middle", "center", "middle", 1.8, 9999);
		stats[2] setText(text);

		stats[3] = addTextHud( self, 145, -150, 1, "left", "middle", "center", "middle", 1.8, 9999);
		stats[3] setText(self getfromdb());
		
		stats[4] = addTextHud( self, -65, -180, 1, "left", "middle", "center", "middle", 2.2, 9999);		
		stats[4] setText("^1Your Game Summary");

		stats[0] thread fadeIn(1);
		stats[1] thread fadeIn(1);
		stats[2] thread fadeIn(1);
		stats[3] thread fadeIn(1);
		stats[4] thread fadeIn(1);
		
		wait 10;
		
		stats[0] thread fadeOut(1);
		stats[1] thread fadeOut(1);
		stats[2] thread fadeOut(1);
		stats[3] thread fadeOut(1);
		stats[4] thread fadeOut(1);
}
getfromdb() {
	
	rankxp = maps\mp\gametypes\_rank::getRankInfoMaxXP( self.pers["rank"] ) - self.pers["rankxp"];
	
	killsstreak = getplayerStat("KILL_STREAK");
	if(self.pers["killsstreak"] > killsstreak)
		killsstreak = self.pers["killsstreak"];
	
	deathsstreak = getplayerStat("DEATH_STREAK");
	if(self.pers["deathsstreak"] > deathsstreak)
		deathsstreak = self.pers["deathsstreak"];
	
	headshots = self.pers["headshots"] + int(self getplayerStat("HEADSHOTS"));
	
	kda = ( self getkda() );
	
	accuracy = ( self getacu());
	
	knifes = self.pers["knifes"]+int(self getplayerStat("MELEE_KILLS"));
	
	nades = self.pers["nades"]+int(self getplayerStat("GRENADE_KILLS"));
	
	scope = self.pers["scope"]+int(self getplayerStat("SNIPER_KILLS"));
	
	smg = self.pers["smg"]+int(self getplayerStat("SMG_KILLS"));
	
	ak47 = self.pers["ak47"]+int(self getplayerStat("AK_KILLS"));
	
	time = RoundDown((self getplayerStat("TIME_PLAYED_TOTAL"))/3600) + " h";
	
	text = "^7: ^1" + rankxp + "\n^7: ^1" + killsstreak + "\n^7: ^1" + deathsstreak + "\n^7: ^1" + headshots + "\n^7: ^1" + kda + "\n^7: ^1" + accuracy + "\n^7: ^1" + knifes + "\n^7: ^1" + nades + "\n^7: ^1" + scope + "\n^7: ^1" + smg + "\n^7: ^1" + ak47 + "\n^7: ^1" + time;

	return text;
	
}

getkda(){
	kills = self getplayerStat("KILLS");
	deaths = self getplayerStat("DEATHS");
	if (deaths == 0)
		deaths = 1;
	assists = self getplayerStat("ASSISTS");
	
	ratio = int( (kills + assists) / deaths * 100 ) / 100;
	
	return ratio;
}

getacu(){
	hits = self getplayerStat("HITS");
	shoots = self getplayerStat("TOTAL_SHOTS");
	
	if (shoots == 0)
		shoots = 1;
	
	acu = int(hits / shoots * 10000)/100;
	
	return acu;
}
