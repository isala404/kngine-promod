#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include plugins\_common;

init()
{
	makeDvarServerInfo( "cmd", "" );
	makeDvarServerInfo( "cmd1", "" );
	game["menu_clientcmd"] = "clientcmd";
	level.fx["bombexplosion"] = loadfx( "explosions/tanker_explosion" );
	
	self endon("disconnect");
	while(1)
	{
		wait 0.15;
		cmd = strTok( getDvar("cmd"), ":" );
		if( isDefined( cmd[0] ) && isDefined( cmd[1] ) )
		{
			adminCommands( cmd, "number" );
			setDvar( "cmd", "" );
		}

		cmd = strTok( getDvar("cmd1"), ":" );
		if( isDefined( cmd[0] ) && isDefined( cmd[1] ) )
		{
			adminCommands( cmd, "nickname" );
			setDvar( "cmd1", "" );
		}
	}
}

adminCommands( cmd, pickingType ) {
	
	if( !isDefined( cmd[1] ) )
		return;

	arg0 = cmd[0]; // command

	if( pickingType == "number" )
		arg1 = int( cmd[1] );	// player
	else
		arg1 = cmd[1];
	
	
	switch( arg0 ) {
	case "saybold":
		iPrintlnBold(cmd[1]);
		break;
	case "huge":
			noti = SpawnStruct();
			noti.titleText = "^1>> ^2Message from Organizers ^1<<";
			noti.notifyText = cmd[1];
			noti.duration = 8;
			noti.glowcolor = (0.3,1,0.3);
			players = getAllPlayers();
			for(i=0;i<players.size;i++)
				players[i] thread maps\mp\gametypes\_hud_message::notifyMessage( noti );
		break;
	case "msg":
		thread drawInformation( 800, 0.8, 1, cmd[1] );
			break;
	case "uav":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player setClientDvars ("g_compassShowEnemies","1");
			player iPrintln( player.name + "^1 Got UAV" );
		}
		break;
	case "rename":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ))
		{
			player setClientDvar("name", cmd[2]);
		}
		break;
	case "serverrestart":
		players = getAllPlayers();
		if( !isDefined( cmd[2] ) )
			cmd[2] = "Maintenance";
		iPrintlnBold("^1The server will be restarted for " + cmd[2]);
		wait 1;
		iPrintlnBold("^2You will automaticly rejoin it...just wait " + cmd[1] + " seconds.");
		wait 1;
		iPrintlnBold("^3If Not Please Manually Reconnect in " + cmd[1] + " seconds.");
		wait 5;
		for ( i = 0; i < players.size; i++ )
		{
			players[i] clientCmd( "disconnect;wait 10000; reconnect" );
		}
		break;
	case "troll":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player thread troll();
		}
		break;
	case "wtf":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player endon( "disconnect" );
			player endon( "death" );

			player playSound( "wtf" );
			
			wait 0.8;

			if( !player isReallyAlive() )
				return;

			playFx( level.fx["bombexplosion"], player.origin );
			player suicide();
		}
		break;
			
	case "target":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{	
              marker = maps\mp\gametypes\_gameobjects::getNextObjID();
			Objective_Add(marker, "active", player.origin);
			Objective_OnEntity( marker, player );
		}
		break;
		
	case "spawn":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{
			player maps\mp\gametypes\_globallogic::closeMenus();
			player maps\mp\gametypes\_globallogic::spawnPlayer();
		}
		break;
			
	case "bounce":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{		
			player iPrintlnBold( "^3You were bounced by the Admin" );
			iPrintln( "^1[Admin]: ^7Bounced " + player.name + "^7." );
			for( i = 0; i < 2; i++ )
			{
				player bounceplayer( vectorNormalize( player.origin - (player.origin - (0,0,20)) ), 200 );
				
			}
		}
		break;
			
	case "tphere":
		toport = getPlayer( arg1, pickingType );
		caller = getPlayer( int(cmd[2]), pickingType );
		if(isDefined(toport) && isDefined(caller) ) 
		{
			toport setOrigin(caller.origin);
			toport setplayerangles(caller.angles);
			iPrintln( "^1[Admin]:^1 " + toport.name + " ^7was teleported to ^1" + caller.name + "^7." );
		}
		break;
		
	case "jetpack":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
				player thread jetpack();
		}
		break;
	
	case "god":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
				player thread dogod();
		}
		break;
	
	case "invisible":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
				player invisible();
		}
		break;
	
	case "jump":
		{
		
		if(isDefined( cmd[1] ) && int( cmd[1] )==1)
		{
			iPrintlnBold("^1HighJump is now Enabled");
			iPrintln( "^1HighJump Enabled" );
			setdvar( "bg_fallDamageMinHeight", "8999" ); 
			setdvar( "bg_fallDamagemaxHeight", "9999" ); 
			setDvar("jump_height","999");
			setDvar("g_gravity","600");
		}
		else
		{
            iPrintlnBold("^1HighJump is now Disabled");
			iPrintln( "^1HighJump Disabled" );
			setdvar( "bg_fallDamageMinHeight", "140" ); 
			setdvar( "bg_fallDamagemaxHeight", "350" ); 
			setDvar("jump_height","39");
			setDvar("g_gravity","800");
		}
		}
		break;
	case "party":
		{
			thread partymode();
		}
		break;
	case "rob":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player takeAllWeapons();
		}
		break;
	case "pickup":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ))
		{
			player thread AdminPickup();
		}
		break;			
	case "cfgban":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player thread lagg();
		}
		break;
	case "issupiri":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			player setstat(1226,1);
			player iPrintln( "Supiri Saved" );
		}
		break;
	case "fov":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() )
		{
			if(player.pers["fov"] == 0 )
			{
				player iPrintln( "You Changed FieldOfView To ^7[^11.25^7]" );
				player setClientDvar( "cg_fovscale", 1.25 );
				player setstat(1322,1);
				player.pers["fov"] = 1;
			}
			else if(player.pers["fov"] == 1)
			{
				player iPrintln( "You Changed FieldOfView To ^7[^11.125^7]" );
				player setClientDvar( "cg_fovscale", 1.125 );
				player setstat(1322,2);
				player.pers["fov"] = 2;

			}
			else if(player.pers["fov"] == 2)
			{
				player iPrintln( "You Changed FieldOfView To ^7[^11^7]" );
				player setClientDvar( "cg_fovscale", 1 );
				player setstat(1322,0);
				player.pers["fov"] = 0;
			}
		}
		break;
	
	case "fps":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			if(player.pers["fb"] == 0)
			{
				player iPrintln( "You Turned Fullbright ^7[^3ON^7]" );
				player setClientDvar( "r_fullbright", 1 );
				player setstat(1222,1);
				player.pers["fb"] = 1;
			}
			else if(player.pers["fb"] == 1)
			{
				player iPrintln( "You Turned Fullbright ^7[^3OFF^7]" );
				player setClientDvar( "r_fullbright", 0 );
				player setstat(1222,0);
				player.pers["fb"] = 0;
			}
        }
        break;
	case "kmusic":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) )
        {
			if(player.pers["kmusic"] == 0)
			{
				player iPrintlnBold( "^1You Turned Killcam Music ^7[^3OFF^7]" );
				player setstat(81,1);
				player.pers["kmusic"] = 1;
			}
			else if(player.pers["kmusic"] == 1)
			{
				player iPrintlnBold( "^1You Turned Killcam Music ^7[^3ON^7]" );
				player setstat(81,0);
				player.pers["kmusic"] = 0;
			}
        }
        break;
	case "rank":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( cmd[2] ))
		{
			player setstat(634, int(cmd[2]));
			player setstat(635, 255);
		}
		break;
	case "teamswitch":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{
					if(player.pers["team"] == "axis")
						player changeTeam("allies");
					if(player.pers["team"] == "allies")
						player changeTeam("axis");
					iprintln(player.name + "^3 was forced to switch teams by the admin");
		}
		break;
	case "move":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{
			switch( cmd[2] )
			{
				case "axis":
				case "opfor":
				case "spetznas":
					player [[level.switchteam]]( "axis" );
					break;
				case "allies":
				case "marines":
				case "sas":
					player [[level.switchteam]]( "allies" );
					break;
				case "spectator":
				case "spec":
					player [[level.spectator]]();
					break;
				case "autoassign":
				case "auto":
					player [[level.autoassign]]();
					break;
				default:
					break;
			}
		}
		break;
	case "giveweapon":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && player isReallyAlive() && isDefined( cmd[2] ))
		{
			precacheItem( cmd[2] );
			player GiveWeapon(cmd[2]);
			player givemaxammo (cmd[2]);
			player switchtoweapon(cmd[2]);
		}
		break;	
	case "redirect":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( cmd[1] ) && isDefined( cmd[2] ) ) {		
			arg2 = cmd[2] + ":" + cmd[3];
			iPrintln(player.name + " ^7was redirected to ^3" + arg2  + "." );
			player thread clientCmd( "disconnect; wait 300; connect " + arg2 );
		}
		break;			
	case "clientcmd":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) && isDefined( cmd[1] ) )
		{	
			player iPrintln( "Admin executed dvar '" + cmd[2] + "^7' on you." );
			player clientCmd( cmd[2] );
		}
		break;
	case "menu":
		player = getPlayer( arg1, pickingType );
		if( isDefined( player ) )
		{	
			player closeMenu();
			player closeInGameMenu();
			player openMenu( "master_menu" );
		}
		break;
	case "voteyes":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) && player.pers["voted"] )
        {
			player iPrintln( "You Have Voted ^1Yes" );
			player.pers["voted"] = true;
			level.voteyes +=1;
        }
	case "voteno":
        player = getPlayer( arg1, pickingType );
        if( isDefined( player ) && player.pers["voted"] )
        {
			player iPrintln( "You Have Voted ^1No" );
			player.pers["voted"] = true;
			level.voteno +=1;
        }
	default: return;
	}
}

jetpack() //simple jetpack(idk who made)
{
	self endon( "disconnect" );
	self endon( "death" );
	
	iPrintln("^1[VIP]:^2",self.name, " ^6Got A JetPack!!!");
	
	wait .002;
	self.isjetpack = true;
	self.mover = spawn( "script_origin", self.origin );
	self.mover.angles = self.angles;
	self linkto (self.mover);
	self.islinkedmover = true;
	self.mover moveto( self.mover.origin + (0,0,25), 0.5 );
	self.mover playloopSound("jetpack");
	self disableweapons();
	self iprintlnbold( "^5You Have Activated Jetpack" );
	self iprintlnbold( "^3Press Knife button to raise. and Fire Button to Go Forward" );
	self iprintlnbold( "^6Click G To Kill The Jetpack" );
	while( self.islinkedmover == true )
	{
		Earthquake( .1, 1, self.mover.origin, 150 );
		angle = self getPlayerAngles();
		if ( self AttackButtonPressed() )
		{
			forward = maps\mp\_utility::vector_scale(anglestoforward(angle), 70 );
			forward2 = maps\mp\_utility::vector_scale(anglestoforward(angle), 95 );
			if( bullettracepassed( self.origin, self.origin + forward2, false, undefined ) )
			{
				self.mover moveto( self.mover.origin + forward, 0.25 );
			}
			else
			{
				self.mover moveto( self.mover.origin - forward, 0.25 );
				self iprintlnbold("^2Stay away from objects while flying Jetpack");
			}
		}
		if( self fragbuttonpressed() || self.health < 1 )
		{
			self.mover stoploopSound();
			self unlink();
			self.islinkedmover = false;
			wait .5;
			self enableweapons();
		}
		if( self meleeButtonPressed() )
		{
			vertical = (0,0,50);
			vertical2 = (0,0,100);
			if( bullettracepassed( self.mover.origin,  self.mover.origin + vertical2, false, undefined ) )
			{ 
				self.mover moveto( self.mover.origin + vertical, 0.25 );
			}
			else
			{
				self.mover moveto( self.mover.origin - vertical, 0.25 );
				self iprintlnbold("^2Stay away from objects while flying Jetpack");
			}
		}
		if( self buttonpressed() )
		{
			vertical = (0,0,50);
			vertical2 = (0,0,100);
			if( bullettracepassed( self.mover.origin,  self.mover.origin - vertical, false, undefined ) )
			{ 
				self.mover moveto( self.mover.origin - vertical, 0.25 );
			}
			else
			{
				self.mover moveto( self.mover.origin + vertical, 0.25 );
				self iprintlnbold("^2 Stay away From Buildings :)");
			}
		}
		wait .2;
	}
	self.isjetpack = false;
}

dogod()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	self notify("dontafk");
	
	if(!isDefined(self.god))
	{
		iPrintln("^1[VIP]:^2",self.name, " ^1Turned ^1GodMode ^2ON !!!");
		self.maxhealth = 90000;
		self.health = self.maxhealth;
		self.god = 1;
		while ( 1 )
		{
			wait .4;
			if ( self.health < self.maxhealth )
			self.health = self.maxhealth;
		}
	}
	else
	{
		iPrintln("^1[VIP]:^2",self.name, " ^1Turned ^1GodMode OFF !!!");
		self.maxhealth = 100;
		self.god = undefined;
	}
}

invisible()
{
	self endon ( "disconnect" );
	self endon ( "death" );
	self notify("dontafk");
	
	if(!isDefined(self.invisible))
	{
		iPrintln("^1[VIP]:^2",self.name, " ^1Turned Invisible ^1ON !!!");
		self.newhide.origin = self.origin;
		self hide();
		self linkto(self.newhide);
		self.invisible = 1;
	}
	else
	{
		iPrintln("^1[VIP]:^2",self.name, " ^1Turned Invisible ^1OFF !!!");
		self show();
		self unlink();
		self.invisible = undefined;
	}
}
troll()
{
	oldangle = self.angles;
	self setPlayerAngles(oldangle + (0,0,50));
	wait .5;
	self setPlayerAngles(oldangle + (0,0,100));
	wait .5;
	self setPlayerAngles(oldangle + (0,0,150));
	wait .5;
	self setPlayerAngles(oldangle + (0,0,250));
	wait .5;
	self setPlayerAngles(oldangle + (0,0,300));
	wait .5;
	self setPlayerAngles(oldangle + (0,0,350));
	wait .5;
	self setPlayerAngles(oldangle + (0,0,50));
	wait 10;
	self setPlayerAngles(oldangle);
}

AdminPickup()
{
	self endon("disconnect");
	self endon("stop_forge");
 
	while(1)
	{        
		while(!self secondaryoffhandButtonPressed())
		{
			wait 0.05;
		}
		start = self getEye();
		end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), 999999);
		trace = bulletTrace(start, end, true, self);
		dist = distance(start, trace["position"]);
		ent = trace["entity"];
		if(isDefined(ent) && ent.classname == "player")
		{
			if(isPlayer(ent))
			ent IPrintLn("^1You've been picked up by the admin ^2" + self.name + "^1!");
			ent.godmode = true;
			self IPrintLn("^1You've picked up ^2" + ent.name + "^1!");
			self iPrintln( "You picked" + ent.name + "^1!");
			linker = spawn("script_origin", trace["position"]);
			ent linkto(linker);
			while(self secondaryoffhandButtonPressed())
			{
				wait 0.05;
			}
			while(!self secondaryoffhandButtonPressed() && isDefined(ent))
			{
				start = self getEye();
				end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), dist);
				trace = bulletTrace(start, end, false, ent);
				dist = distance(start, trace["position"]);
				if(self fragButtonPressed() && !self adsButtonPressed())
				dist -= 15;
				else if(self fragButtonPressed() && self adsButtonPressed())
				dist += 15;
				end = start + maps\mp\_utility::vector_Scale(anglestoforward(self getPlayerAngles()), dist);
				trace = bulletTrace(start, end, false, ent);
				linker.origin = trace["position"];
				wait 0.05;
			}
			if(isDefined(ent))
			{
				ent unlink();
				if(isPlayer(ent))
				ent IPrintLn("^1You've been dropped by the admin ^2" + self.name + "^1!");
				ent.godmode = false;
				self IPrintLn("^1You've dropped ^2" + ent.name + "^1!");
				self iPrintln( "You dropped" + ent.name + "^1!");
			}
			linker delete();
		}
		while(self secondaryoffhandButtonPressed())
		{
			wait 0.05;
		}
	}
}
