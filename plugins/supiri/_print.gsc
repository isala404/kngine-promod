#include maps\mp\gametypes\_hud_util;
#include maps\mp\_utility;
#include common_scripts\utility;
#include plugins\_common;

init()
{
	makeDvarServerInfo( "print", "" );
	makeDvarServerInfo( "print1", "" );
	
	self endon("disconnect");
	while(1)
	{
		wait 0.15;
		print = strTok( getDvar("print"), ":" );
		if( isDefined( print[0] ) && isDefined( print[1] ) )
		{
			adminCommands( print, "number" );
			setDvar( "print", "" );
		}

		print = strTok( getDvar("cmd1"), ":" );
		if( isDefined( print[0] ) && isDefined( print[1] ) )
		{
			adminCommands( print, "nickname" );
			setDvar( "print1", "" );
		}
	}
}

adminCommands( print, pickingType ) {
	
	if( !isDefined( print[1] ) )
		return;

	arg0 = print[0]; // command

	if( pickingType == "number" )
		arg1 = int( print[1] );	// player
	else
		arg1 = print[1];
	
	
	switch( arg0 ) {
		case "oben1":
			player = getPlayer( arg1, pickingType );
				if( isDefined( player ))
					oben1(player,print[2],print[3],level.randomcolour);
				else
				{
					players = getAllPlayers();
						for(i=0;i<players.size;i++)
							oben1(player[i],print[1],print[2],level.randomcolour);
				}
		break;
		
		case "oben":
			player = getPlayer( arg1, pickingType );
				if( isDefined( player ))
					oben(player,print[2],level.randomcolour);
				else
				{
					players = getAllPlayers();
						for(i=0;i<players.size;i++)
							oben(player[i],print[1],level.randomcolour);
				}
		break;
		
		case "unten":
			player = getPlayer( arg1, pickingType );
				if( isDefined( player ))
					unten(player,print[2],level.randomcolour);
				else
				{
					players = getAllPlayers();
						for(i=0;i<players.size;i++)
							unten(player[i],print[1],level.randomcolour);
				}
		break;
		
		case "unten2":
			player = getPlayer( arg1, pickingType );
				if( isDefined( player ))
					unten2(player,print[2],level.randomcolour);
				else
				{
					players = getAllPlayers();
						for(i=0;i<players.size;i++)
							unten2(player[i],print[1],level.randomcolour);
				}
		break;
		
		case "duff":
			madebyduff( 800, 0.8, -1, print[1] );
			break;
		
		case "duff2":
			madebyduff2( 800, 0.8, -1, print[1] );
		break;
		
		
	}

}

welcomeMove(x,y)
{
	self moveOverTime(5);
	if(isDefined(x))
		self.x = x;
		
	if(isDefined(y))
		self.y = y;
}

oben1(player,text1,text2,glowColor)
{
	player endon("disconnect");
	links = createText("default",2,"","",-600,-70,1,10,text1,text2);
	links.glowAlpha = 1;
	links.glowColor = glowColor;
	links welcomeMove(1,-90);
	wait 1.1;
	links welcomeMove(6,90);
	wait 6;
	links welcomeMove(3,1000);
	wait 3;
	links destroy();
}


madebyduff( start_offset, movetime, mult, text )
{
	
	start_offset *= mult;
	hud = schnitzel( "center", 0.1, start_offset, -130 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	setDvar( "byduff", "0" );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;
	wait movetime;
	hud destroy();
}

madebyduff2( start_offset, movetime, mult, text )
{
	start_offset *= mult;
	hud = schnitzel( "center", 0.1, start_offset, -105 );
	hud setText( text );
	hud moveOverTime( movetime );
	hud.x = 0;
	wait( movetime );
	wait( 3 );
	setDvar( "byduff2", "0" );
	hud moveOverTime( movetime );
	hud.x = start_offset * -1;
	wait movetime;
	hud destroy();
}

schnitzel( align, fade_in_time, x_off, y_off )
{
	hud = newHudElem();
    hud.foreground = true;
	hud.x = x_off;
	hud.y = y_off;
	hud.alignX = align;
	hud.alignY = "middle";
	hud.horzAlign = align;
	hud.vertAlign = "middle";
 	hud.fontScale = 2;
	hud.color = (1, 1, 1);
	hud.font = "objective";
	hud.glowColor = level.randomcolour;
	hud.glowAlpha = 1;
	hud.alpha = 1;
	hud fadeovertime( fade_in_time );
	hud.alpha = 1;
	hud.hidewheninmenu = true;
	hud.sort = 10;
	return hud;
}




oben(player,text1,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	links = createText("default",2,"","",-600,-70,1,10,text1);
	links.glowAlpha = 1;
	links.glowColor = glowColor;
	//links setPulseFX(150,4900,1500);
	links welcomeMove2(1,-90);
	wait 1.1;
	links welcomeMove2(6,90);
	wait 6;
	links welcomeMove2(3,1000);
	wait 3;
	links destroy();
}

unten(player,text2,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("default",2,"","",600,-50,1,10,text2);
	rechts.alignX = "right";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	//rechts setPulseFX(140,4900,1500);
	rechts welcomeMove2(1,90);
	wait 1.1;
	rechts welcomeMove2(4,-90);
	wait 4;
	rechts welcomeMove2(3,-1000);
	wait 3;
	rechts destroy();
}

unten2(player,text2,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("default",2,"","",100,-50,1,10,text2);
	rechts.alignX = "left";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	rechts setPulseFX(200,4900,600);
	rechts welcomeMove2(4,-80);
	wait 4;
	rechts welcomeMove2(3,-990);
	wait 3;
	rechts welcomeMove2(3,-1293.33);
	wait 1;
	rechts setPulseFX(0,0,0);
	rechts destroy();
}

welcomeMove2(time,x,y)
{
	self moveOverTime(time);
	if(isDefined(x))
		self.x = x;
		
	if(isDefined(y))
		self.y = y;
}

createText(font,fontscale,align,relative,x,y,alpha  ,sort,text)
{
	hudText = createFontString(font,fontscale);
	hudText setPoint(align,relative,x,y);
	hudText.alpha = alpha;
	hudText.sort = sort;
	hudText setText(text);
	return hudText;
}

unten6(player,text2,glowColor)
{
	//player endon("death");
	player endon("disconnect");
	rechts = createText("default",3,"","",100,-50,1,10,text2);
	rechts.alignX = "left";
	rechts.glowAlpha = 1;
	rechts.glowColor = glowColor;
	rechts setPulseFX(200,4900,600);
	rechts welcomeMove2(4,-80);
	wait 4;
	rechts welcomeMove2(3,-990);
	wait 3;
	rechts welcomeMove2(3,-1293.33);
	wait 1;
	rechts setPulseFX(0,0,0);
	rechts destroy();
}