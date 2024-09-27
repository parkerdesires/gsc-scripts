#include maps\mp\_utility;
#include common_scripts\utility;

//simple gsc script for "afterhits", which is a function that gives the player a weapon immediately after they hit a trickshot

//example usage:
//self add_option("afterhits", "DSR-50", ::afterhit, "dsr50_mp");

afterhit(weapon)
{
    if(!self.afterhit)
    {
        self.afterhit = true;
        self iprintln("Afterhit: "+weapon);
        self thread doafterhit(weapon);
    }
    else
    {
        self.afterhit = false;
        self iprintln("Afterhit: ^1Off");
        self notify("stop_afterhit");
    }
}

doafterhit(weapon)
{
    self endon("stop_afterhit");
    level waittill("game_ended");
    weap = self getcurrentweapon();
    self giveweapon(weapon);
    self takeweapon(weap);
    self switchtoweapon(weapon);
}