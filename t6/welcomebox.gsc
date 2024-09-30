#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

//simple red welcome box for players once they spawn in for the first time.

init()
{
    level thread onplayerconnect();
}

onplayerconnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
        if(self.first)
        {
            self thread welcomemessage();
            self freezecontrols(false);
            self.first = false;
        }
    }
}

//welcome
welcomeMessage()
{
    self.hud = [];
    
    //main hud elements
    self.hud["title"] = self createText("default", 1.3, "CENTER", "CENTER", 0, -210, 0, 1, "You're Playing: Mod Name", (255, 255, 255));
    self.hud["background"] = self createRectangle("CENTER", "CENTER", 0, -145, 271, 150, (0, 0, 0), "white", 1, 0.5);
    self.hud["topline"] = self createRectangle("CENTER", "CENTER", 0, -220, 274, 2, (1, 0, 0), "white", 0.5, 1);
    self.hud["topline"].foreground = true;
    self.hud["bottomline"] = self createRectangle("CENTER", "CENTER", 0, -70, 274, 2, (1, 0, 0), "white", 0.5, 1);
    self.hud["bottomline"].foreground = true;
    self.hud["leftline"] = self createRectangle("CENTER", "CENTER", -136, -145, 2, 150, (1, 0, 0), "white", 0.5, 1);
    self.hud["leftline"].foreground = true;
    self.hud["rightline"] = self createRectangle("CENTER", "CENTER", 136, -145, 2, 150, (1, 0, 0), "white", 0.5, 1);
    self.hud["rightline"].foreground = true;
    self.hud["topmidline"] = self createRectangle("CENTER", "CENTER", 0, -200, 274, 1, (1, 0, 0), "white", 0.5, 1);
    self.hud["topmidline"].foreground = true;

    //misc hud elements
    self.hud["description"] = self createText("default", 1, "LEFT", "CENTER", -133, -190, 0, 1, "This is the description text. \nThis is the other description text. \nThis is the other other description text.", (255, 255, 255));
}

destroyWelcomeMessage()
{
    //main hud elements
    self.hud["title"] destroy();
    self.hud["background"] destroy();
    self.hud["topline"] destroy();
    self.hud["bottomline"] destroy();
    self.hud["leftline"] destroy();
    self.hud["rightline"] destroy();
    self.hud["topmidline"] destroy();

    //misc hud elements
}

createText(font, fontscale, align, relative, x, y, sort, alpha, text, color, watchtext, islevel)
{
    textelem = self createFontString(font, fontscale);
    textelem setPoint(align, relative, x, y);
    textelem.hidewheninmenu = true;
    textelem.archived = false;
    textelem.sort = sort;
    textelem.alpha = alpha;
    textelem.color = color;
    textelem setText(text);
    textelem.foreground = true;
    return textelem;
}

hudFade(alpha,time)
{
    self fadeOverTime(time);
    self.alpha = alpha;
    wait time;
}

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha, server)
{
    boxelem = newClientHudElem( self );
    boxelem.elemtype = "icon";
    boxelem.color = color;
    boxelem.hidewheninmenu = true;
    boxelem.archived = false;
    boxelem.width = width;
    boxelem.height = height;
    boxelem.align = align;
    boxelem.relative = relative;
    boxelem.xoffset = 0;
    boxelem.yoffset = 0;
    boxelem.children = [];
    boxelem.sort = sort;
    boxelem.alpha = alpha;
    boxelem.shader = shader;
    boxelem setParent(level.uiparent);
    boxelem setShader(shader, width, height);
    boxelem setPoint(align, relative, x, y);
    return boxelem;
}
