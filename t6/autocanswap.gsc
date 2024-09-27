#include maps\mp\_utility;
#include common_scripts\utility;

//simple function for autocanswap
//super useful for creating out of maps

autocanswap()
{
	if(!self.autocanswap)
	{
		self.autocanswap = true;
		self iprintln("Auto Canswap: ^2On");
		self thread doAutoCanswap();
	}
	else
	{
		self.autocanswap = false;
		self iprintln("Auto Canswap: ^1Off");
		self notify("stop_ac");
	}
}

doAutoCanswap()
{
    self endon("disconnect");
	self endon("stop_ac");
	for(;;)
	{
		self waittill("weapon_change", weapon);
		self seteverhadweaponall(0);
	}
	wait 0.1;
}