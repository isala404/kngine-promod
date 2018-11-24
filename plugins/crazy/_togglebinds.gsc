//  ________/\\\\\\\\\__________________________________________________________        
//   _____/\\\////////___________________________________________________________       
//    ___/\\\/_________________________________________________________/\\\__/\\\_      
//     __/\\\______________/\\/\\\\\\\___/\\\\\\\\\_____/\\\\\\\\\\\___\//\\\/\\\__     
//      _\/\\\_____________\/\\\/////\\\_\////////\\\___\///////\\\/_____\//\\\\\___    
//       _\//\\\____________\/\\\___\///____/\\\\\\\\\\_______/\\\/________\//\\\____   
//        __\///\\\__________\/\\\__________/\\\/////\\\_____/\\\/_______/\\_/\\\_____  
//         ____\////\\\\\\\\\_\/\\\_________\//\\\\\\\\/\\__/\\\\\\\\\\\_\//\\\\/______ 
//          _______\/////////__\///___________\////////\//__\///////////___\////________

#include plugins\_common;
init( modVersion )
{
	while( 1 )
	{
		level waittill( "connected", player );	
		player thread ToggleBinds();
	}
}
 

ToggleBinds()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(response == "fps")
		{
			if(self.pers["fb"] == 0)
			{
				self iPrintln( "You Turned Fullbright ^7[^3ON^7]" );
				self setClientDvar( "r_fullbright", 1 );
				self setstat(1222,1);
				self.pers["fb"] = 1;
			}
			else if(self.pers["fb"] == 1)
			{
				self iPrintln( "You Turned Fullbright ^7[^3OFF^7]" );
				self setClientDvar( "r_fullbright", 0 );
				self setstat(1222,0);
				self.pers["fb"] = 0;
			}
		}
		if(response == "knginefov")
		{
			if(self.pers["fov"] == 0 )
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11.25^7]" );
				self setClientDvar( "cg_fovscale", 1.25 );
				self setstat(1322,1);
				self.pers["fov"] = 1;
			}
			else if(self.pers["fov"] == 1)
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11.125^7]" );
				self setClientDvar( "cg_fovscale", 1.125 );
				self setstat(1322,2);
				self.pers["fov"] = 2;

			}
			else if(self.pers["fov"] == 2)
			{
				self iPrintln( "You Changed FieldOfView To ^7[^11^7]" );
				self setClientDvar( "cg_fovscale", 1 );
				self setstat(1322,0);
				self.pers["fov"] = 0;
			}
		}
	}
}
