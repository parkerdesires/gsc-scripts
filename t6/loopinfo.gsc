#include maps\mp\_utility;
#include common_scripts\utility;

//gsc script to show the players coordinates and what map they are on every second
//super useful for creating out of maps

toggleloopinfo()
{
    if(!self.infoloop)
    {
        self.infoloop = true;
        self iprintln("Loop Info: ^2On");
        self thread doLoopInfo();
    }
    else
    {
        self.loopinfo = false;
        self iprintln("Loop Info: ^1Off");
        self notify("stop_loop");
    }
}

doLoopInfo()
{
    self endon("stop_loop");
    self endon("disconnect");
    for(;;)
    {
        self iprintlnbold("Coordinates: X: " + self.origin[0] + " Y: " + self.origin[1] + " Z: " + self.origin[2]);
        map = getDvar("mapname");
        self iprintln("Map: "+map);
        wait 1;
    }
}