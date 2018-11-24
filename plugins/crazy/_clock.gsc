//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________
#include maps\mp\_utility;
#include plugins\_common;


init()
{
	level endon("disconnect");
	
	level.clock = true;
	level.clockTime = [];
	if( level.clock )
	{
		if(1)
		{
			level.clockTime[0] = newHudElem();
			level.clockTime[0].elemType = "font";
			level.clockTime[0].x = -20;
			level.clockTime[0].y = 5;
			level.clockTime[0].alignx = "right";
			level.clockTime[0].horzAlign = "right";
			level.clockTime[0].sort = 1002;
			level.clockTime[0].alpha = 1;
			level.clockTime[0].fontscale = 1.4;
			level.clockTime[0].foreground = false;
			level.clockTime[0].hidewheninmenu = false;
			
			level.clockTime[1] = newHudElem();
			level.clockTime[1].x = 0;
			level.clockTime[1].y = 3;
			level.clockTime[1].alignx = "right";
			level.clockTime[1].horzAlign = "right";
			level.clockTime[1].sort = 1001;
			level.clockTime[1] setShader("gradient", 100, 20);
			level.clockTime[1].alpha = 0.7;
			level.clockTime[1].color = (0.25,0.51,0.68);
			level.clockTime[1].glowAlpha = 0.3;
			level.clockTime[1].foreground = false;
			level.clockTime[1].hidewheninmenu = false;
			level.clockTime[1] ClearAllTextAfterHudelem();
			
			level thread ClockTimer();
		
			level waittill("strat_over");
			
			AmbientStop( 0 );
			for(i=0;i<level.clockTime.size;i++)
			{
				level.clockTime[i] moveOverTime(5);
				level.clockTime[i].x = 300;
			}
			level.clock = false;
			wait 6;
			for(i=0;i<level.clockTime.size;i++)
				level.clockTime[i] destroy();
		}
	}
}

ClockTimer()
{
	level endon("disconnect");
	level endon( "stop_clock" );
	
	while(level.clock)
	{
		time = getRealTime();
		timedisplay = TimeToString(time,0,"%H:%M:%S");
		level.clockTime[0] setText("^2"+timedisplay+"^1 IST");
		wait 1;			
	}
}