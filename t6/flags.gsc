#include maps\mp\_utility;
#include common_scripts\utility;

//simple gsc script for teleport flags for teleporting the player out of map
//flags will not show unless player is on last, bots can not see/go through the flags, and the flag system is "one-way"

init()
{
    precachemodel("mp_flag_neutral");
    level thread setupFlags();
}

setupFlags()
{
    mapname = getDvar("mapname");
    switch(mapname)
    {
        //dlc maps
        case "mp_nuketown_2020":
            level thread nuketown();
            break;

        default:
            break;
    }
}

nuketown()
{
    CreateFlag((28.678, -564.446, -66.9508), (-1511.33, -1254.81, 66.425));
    createFlag((-1844.93, 401.3, -61.875), (7163.95, -4944.31, 2520.87));

    //crates
    level addCrateLocation("mp_studio", (7163.95, -4944.31, 2520.87));
}


createFlag(enter, exit)
{
    entryFlag = spawnEntity("script_model", "mp_flag_neutral", enter, (0, 0, 0));
    exitFlag = spawnEntity("script_model", undefined, exit, (0, 0, 0));
    level thread flagThink(entryFlag, exitFlag);
}

flagThink(entryFlag, exitFlag)
{
    level endon("game_ended");
    while(true)
    {
        flagVisible = false;
        foreach(player in level.players)
        {
            if(isonlast(player))
            {
                flagVisible = true;
                if(distance(player.origin, entryFlag.origin) < 25)
                {
                    player setOrigin(exitFlag.origin + vectorScale(anglesToForward((0, player.angles[1], 0)), 30));
                }
            }
        }

        if(flagVisible)
        {
            entryFlag setVisibleToAll(); 
            exitFlag setVisibleToAll();  
        }
        else
        {
            entryFlag setInvisibleToAll();
            exitFlag setInvisibleToAll();   
        }

        foreach(player in level.players)
        {
            if(isonlast(player) && !flagVisible)
            {
                entryFlag setVisibleToAll();
                exitFlag setVisibleToAll();
            }
        }
        wait 0.15;
    }
}

spawnentity(entityClass, model, origin, angle, solid)
{
    entity = spawn(entityClass, origin );
    entity.angles = angle;
    entity setmodel(model);
    level.entities[level.amountofentities] = entity;
    level.amountofentities++;
    if(isDefined(solid))
    {
        entity notsolid();
    }
    return entity;
}

isonlast(player)
{
    return player.pers["pointstowin"] == (level.scorelimit - 1);
}

//crates
addPlatformLocation(map, origin, width, length)
{
    if(level.script != map) 
        return;
    platform = [];    
    for(e=0;e<width;e++) for(a=0;a<length;a++)
    {
        platform[platform.size] = spawn("script_model", origin + (a*64,e*64,0)); 
        platform[platform.size-1] setModel("collision_clip_64x64x10"); //invisible
    }
    return platform; 
}

addcrateLocation(map, origin)
{
    if(level.script != map) 
        return;
    platform = spawn("script_model", origin); 
    platform setModel("collision_clip_64x64x10");
    return platform;
}