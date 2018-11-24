init() {

	while( 1 )
	{
		level waittill( "connected", player );	
		player thread onconnect();	
	}

}
onconnect(){
	self endon("disconnect");
	self thread plugins\crazy\_togglebinds::ToggleBinds();
	self thread plugins\supiri\_stats::initStats();
}