#include maps\mp\_utility;
#include common_scripts\utility;

//gsc script for save and load
//onplayerspawned checks if the location is saved, so if you die you will respawn where you saved
//error message will show if you try to load your location without first saving it

init()
{
	level thread onplayerconnect();
}

onplayerconnect()
{
	while(true)
	{
		level waittill("spawned_player");
		player thread onplayerspawned();
	}
}

onplayerspawned()
{
	while(true)
	{
		self waittill("spawned_player");
		if(self.first)
		{
			self thread saveandload();
			self.first = false;
		}
		if(isDefined(self.a) && isDefined(self.o))
		{
			self setplayerangles(self.a);
			self setorigin(self.o);
		}
	}
}

//saveandload
saveandload()
{
	level endon("game_ended");
	while(true)
	{
		if(self ActionSlotTwoButtonPressed() && self getStance() == "crouch")
		{
			self.o = self.origin;
			self.a = self.angles;
			self iprintln("Position: ^2Saved");
		}
		if(self ActionSlotOneButtonPressed() && self getStance() == "crouch")
		{
            if(!isdefined(self.a) && !isdefined(self.o))
            {
                self iprintln("^1Error:^7 You must set your position before you can load it.");
            }
            else
            {
                self setorigin(self.o);
                self setplayerangles(self.a);
                self iprintln("Position: ^2Loaded");
            }
		}
		wait 0.15;
	}
}