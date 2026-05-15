#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.playback && global.length=1) {
    room_goto_safe(replays)
    exit
}

if (!readmetadata()) exit;

if (global.lemontest) {
    if (global.visualstagecount && !global.respawn) { //assume player finished level or something
        room_goto_safe(lemon)
    }
    FMODAllStop()
    global.music=""
    //alarm[0]=1
}

updatelevelpack()

// kelloggs was here

with (globalmanager)

if (!global.respawn) {
    FMODAllStop()
    global.music=""
    if (global.exception == "" && (!global.lemontest || global.lemonlskin == "None")) {
        updatemusic()     //dont run with exception or the base music will play in lemon !
    }
    updatelevelskin()

    i=0
    repeat (4) {global.startsize[i]=global.size[i] global.startshielded[i]=global.shielded[i] i+=1}
    mus_play("start",0)
} else if (!skindat("deathmusic")) {
    FMODAllStop()
    global.music=""
    mus_play("start",0)
}

desc=global.leveldesc

if (skindat("skipchange") || string_count("$nocard",desc)) {room_goto_safe(game) alarm[0]=1 exit}

time=0

if (!global.tasing) {
    alarm[0]=max(1,200-time)
    alarm[1]=max(1,60-time)
    ready=""
} else ready=lang("tasready")

if (global.playback) roomname=string(global.visualstagecount)+"/"+string(global.moviestagecount)+"##"+replacebuttonnames(global.levelname) //its honestly quite simple
else
if (global.gamemode="battle") roomname=string(global.visualstagecount+1)+"/"+string(settings("playstages"))+"##"+replacebuttonnames(global.levelname)
else roomname="##"+replacebuttonnames(global.levelname)

while (!ok) {
    var l, v;
    if !string_count("$",desc) && !string_count("¬", desc) {ok=1 break}
    l = string_pos("$",desc)
    desc = string_delete(desc,l,string_length(desc)-l+1)
    l = string_pos("¬",desc)
    desc = string_delete(desc,l,string_length(desc)-l+1)
}
global.leveldescnotags=desc


roomname+="##"+replacebuttonnames(desc)



view_yview[0]=0
view_yview[1]=0
view_yview[2]=0
view_yview[3]=0


frame=0
frame2=0
xsc=1
ysc=1
loose=0
hsp=1
go=0
alpha=1

if (global.lemontest) alarm[0]=1
room_goto_safe(game)
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
i=0
repeat (4) {if firstrun[i] with firstrun[i] instance_destroy() i+=1}
with gamemanager tokens=other.tokens
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_number(segafade) > instance_number(segafadein)) exit
if neveragain exit
if !global.respawn global.visualstagecount+=1 //prevent stage count increasing from dying
savemetadata()
if (!skindat("deathmusic")) mus_stop()

with (spawner) event_user(0)
neveragain=1
alarm[2]=2
#define Alarm_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.tasing) {
    input_get(global.input[0])
    if (skey) {go=1 timer=128 ready="Ready..."}
    if (go) {
        timer-=1
        if (timer<=0) alarm[0]=1
    }
} else {
    input_get(-1)
    if !(instance_exists(message) || instance_exists(console)) && (akey || skey) && frame2>1
        alarm[0]=1
}


if (!akey && !skey) frame2+=0.2

global.bgscroll+=1

if !firstrun.object_index
event_user(12)
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (room!=game) {visible=0 instance_destroy()}
#define Other_22
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//for whatever reason i can put this in the create code in 2.1.5.2 but not in plus? oh well.

for (i=0;i<global.mplay;i+=1) {
    str[i]=playerskinstr(i,"credits"+string(i))

    if !firstrun[i] firstrun[i]=instance_create(x,y,lemon_tile) // when im a convenient completely null object! this is copied from the battle results in case you couldnt tell lol
    with firstrun[i] {
        persistent=1
        p2 = other.i
        init_changechar()
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if room != game exit

d3d_set_projection_ortho(0,0,400,224,0)
p2=view_current

draw_clear_alpha(0,1)

draw_sprite_stretched(skindat("tex_change"),0,0,0,view_wview[p2],224)

if firstrun[p2] with firstrun[p2] {
    persistent = 1
    ssw_core(1)

    if (global.shielded[p2]) ssw_shield("shield_back")

    if usepalette scr_applyPaletteSegmented(global.shaderPaletteSwap,global.palettesprites[p2*100],global.pal_1[p2]+1,global.pal_2[p2]+1,global.pal_3[p2]+1,global.pal_4[p2]+1,size,totpal+1)
    ssw_core(0)
    shader_reset()
    if (global.shielded[p2]) ssw_shield("shield")

    if global.gamemode!="battle" && global.gamemode!="coop"
    execute_string(global.changecode[charm_get_id(name)])

}

col=$ffffff
if (global.mplay>1) col=playercol(global.input[view_current],view_current)

if (global.gamemode="battle") {
    draw_skintext(x,104,playerskinstr(view_current,"name"+string(view_current)),col)
} else draw_skintext(x-4,104,"x "+string_format(drawlivestring(),2,0),col)

global.halign=1

if (skindat("cardtext")) {
    if lemongrab.compat != "2.1.6s" && global.lskins[global.levelskin+1,0]!=global.lbase {
        draw_skintext(x,32,roomname+"#[Level version: v"+lemongrab.compat+"]")
    } else {
        draw_skintext(x,32,roomname)
    }
}
if (go) draw_healthbar(x-64,68,x+64,84,timer/1.28,0,$ff,$ff0000,1,0,0)
draw_skintext(x,72,ready)

if (!global.playback && !global.tasing && str[view_current]!="") draw_skintext(x,144,playerskinstr(view_current,"name"+string(view_current))+"##"+str[view_current])
if (global.playback) draw_sprite(spr_moviekeys,0,x,156)
if (global.tasing) draw_skintext(x,160,global.spd)

global.halign=0
