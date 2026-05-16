#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.ptime=0
alarm[8]=-1

alarm[0]=2
alarm[1]=40
alarm[7]=1

ky[0]=240
ky[1]=240
ky[2]=240
ky[3]=240

water[0]=verybignumber
water[1]=verybignumber
water[2]=verybignumber
water[3]=verybignumber

shake[3]=0
shakek=0

crash_detect=0
crash_count=0

muspeedavg=1
skipresult=0
stop=0
fasting=0
debugcamlock=0
fgfxdisable=0
framestep=0
specialreset=0
onblockstate=1
switched=0
sekiro=0 //players die twice
global.on=1

ratchet=settings("ratchet")

borda=1
if (skindat("nofade")) borda=0

hoffx=skindat("hudoffx")
hoffy=skindat("hudoffy")

pl=0
if (settings("musbalance")=0) pl=-1

instance_create(0,0,hudlayer)
instance_create(0,0,walter)

hudspr=skindat("tex_hud-"+global.gamemode)
hudw=round(sprite_get_width(hudspr)/2)

plrsort=0

if (global.gamemode="tutorial") instance_create(0,0,runes)
else {instance_create(0,0,bgmanager) if instance_exists(runes) with(runes) instance_destroy()}
roomname=global.levelname

//if (global.playback) stageleft=string_format(global.stagecount+1,2,0)+"/"+string(global.mov iestagecount) else
stageleft=string_format(global.visualstagecount,2,0)+"/"+string(settings("playstages"))

playmusic=1

getregion(x)

instance_create(0,0,darkareamanager)

var i;
for (i=0;i<global.mplay;i+=1) {
    view_yview[i]=8+skindat("voffset")
    hud_alpha[i]=1
    with (instance_create(spawner.x-(16*i)+8,spawner.y+2,player)) {
        p2=i
        player_start()
        other.players[i]=id
        if (global.gamemode="battle") flash=1
    }
    with (instance_create(0,0,beatmanager)) {p2=i}
}

if (!global.discordoverride) {
    if global.lemontest {discord_update_presence("Playing as "+playerskinstr(top,"name"+string((top))),"Testing Level ("+string(global.levelname)+")","boll-icon","lemon-icon")}
    else if global.movie=1 {discord_update_presence("Player is "+playerskinstr(top,"name"+string((top))),"Watching replay on ("+string(global.levelname)+")","boll-icon","movie-icon")}
    else if global.gamemode="timeattack" {discord_update_presence("Playing as "+playerskinstr(top,"name"+string((top))),"Playing Time Attack on ("+string(global.levelname)+")","boll-icon","timeattack-icon")}
    else {discord_update_presence("Playing as "+playerskinstr(top,"name"+string((top))),"In Game ("+string(global.levelname)+")","boll-icon","")}
}

if (lemongrab.spawnx>mean(region.x,region.lefthand)) with (player) xsc=-1 //only check spawnx so player still faces right direction while testing

if (global.mplay=1 && global.check!="") {
    var ck; ck=noone with (checkpoint) if (cid=global.check) ck=id
    if (ck!=noone) {
        with (enemy) if (x==clamp(x,ck.x-128,ck.x+128) && y==clamp(y,ck.y-64,ck.y+64) && region=ck.region && object_index!=lakitu) instance_destroy()
        with (checkpoint) if (x<ck.x-8) {passed=1}
        with (ck) {passed=1 player.x=x player.y=y+2 im_a_spawnster=1}
    }
}

if (global.wanna) {time=0 tick=0}
else {time=global.time tick=time*60+60}
if (time >= 12001) {
    global.inf_time = 1
} else {
    global.inf_time = 0
}
timeleft=-1
with (player) {time=other.time tick=other.tick player_camera(1)}

//Hud inits
ringxoffset=-44
tokenxoffset=64
blokenxoffset=64

for (i=1;i<6;i+=1) {
    ringexists[i]=0
}
//get current level pack directory for red rings lmao
pack = global.lskins[global.levelskin+1,0]
if (pack == global.lbase) pack = ""

//this is a variable now to prevent a Freaky resetting bug
global.reset_on_state_load=1

gamemanager.frog_escape=0
gamemanager.frog_escape_timer = 0
gamemanager.frog_escape_timer_effect = 0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.wanna || (global.tasing || (global.lemontest && settings("lemontasing"))) || global.debug || global.gamemode="timeattack" || global.lemontest) savetas()
global.createcode = ""
instance_activate_object(redring)
with (redring) {
    other.ringexists[real(redringid)] = 1
}
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
theyremakingamovie=1
#define Alarm_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///deactivation
if (!pause) activation_update()
alarm[7]=5
#define Alarm_8
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switched=0
instance_activate_object(brick)
instance_activate_object(coin)
instance_activate_object(pblockoff)
instance_activate_object(pblock)
instance_activate_object(bluecoin)
if instance_exists(moranboll) instance_activate_object(regionmarker)
with (brick) if !biggie && switched {
    instance_create(x+8,y+8,coin)
    instance_destroy()
}
with (coin) {
    if (!dropped && switched && object_index!=redcoin && object_index!=bluecoin) {
        with instance_create(x-8,y-8,brick) {stoned=other.stoned event_user(3)}
        instance_destroy()
    }
}
with (pblock) if switched {
    instance_create(x,y,pblockoff)
    instance_destroy()
}
with (pblockoff) if switched {
    with instance_create(x,y,pblock) {event_user(3)}
    instance_destroy()
}
with (bluecoin) {
    instance_create(x,y,smoke)
    y=-verybignumber
    active=0
}
with (door) if (funnytruefalse(is_pdoor)) {switched=0}
global.ptime=0
if !global.finishmusic && !instance_exists(moranboll) stagemusic(players[0])
if instance_exists(moranboll) instance_deactivate_object(regionmarker)
#define Alarm_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if flag.yup exit
segafadeto(replays)
with segafade {slow=1 forcefade=1}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (pause) exit
if (instance_exists(moranboll)) exit

if (global.debug) crash_count=0
if (crash_detect) crash_count+=1 else crash_count=0
if (crash_count>10) system_crash()
crash_detect=1
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
pause_update()

if (pause) exit

if global.ptime {
    global.ptime-=1
    if global.ptime==128 {
        instance_activate_object(bluecoin)
        with (bluecoin) flash=1
    } else if global.ptime==0 {
        alarm[8]=1
    }
}

animation_update()

if (instance_exists(moranboll)) exit

player_update()
if (global.epic_speed_mode) player_update()

crash_detect=0

for (i=0;i<global.mplay;i+=1) {
    getregion(view_xview[i]+view_wview[0]/2)
    bpm[i]=region.bpm
    bpb[i]=region.bpb
    water[i]=region.water
    horizon[i]=region.horizon
    ky[i]=region.ky
    typebg[i]=region.typebg
    typetime[i]=region.typetime
    biome[i]=region.biome
}


plrsort=(plrsort+1) mod 4
act=(act+1) mod 128
borda=max(0,borda-0.05)

if (meta && !flag.yup && global.pos<global.length) {
    //somehow the movie ended earlier than the stage
    meta=0
    discord_update_presence("","Loading a level ("+global.nextlevel+")","boll-icon","dice-icon")
    segafadeto(change)
}

game_update()
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
FMODGroupSetPitch(1,1)
FMODGroupSetPitch(2,1)
if (!skindat("deathmusic")) FMODAllStop()
else FMODInstanceSetPitch(globalmanager.handle,1)

global.lemontestviewhack=0

with(darkareamanager){}

if (pausequit) {
    instance_activate_all()
    if (pausequit=1) {
        if (global.gamemode="classic") inputclassic() else inputresults()
        inputstats()
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///draw hud
var i;

if (instance_exists(moranboll)) exit

x=view_xview[view_current]
y=view_yview[view_current]
vww=view_wview[view_current]

if theyremakingamovie exit

if (skindat("left")) {
    d3d_transform_add_scaling(-1,1,1)
    d3d_transform_add_translation(x+400,y,0)
} else d3d_transform_add_translation(x,y,0)

//Charm plugin

if !players[view_current].dontdrawdefaulthud && hud_alpha[view_current] > 0.0 {
    drawskinnablehud()
}

//moved red rings to drawskinnablehud because they're a part of the hud :) -moster

with (players[view_current]) charm_run("customhud") 
       
d3d_transform_set_identity()

if ((global.mplay>1 || global.playback) && !global.hidereplayui) {
    //draw player proximity indicators
    global.halign=1
    for (i=0;i<global.mplay;i+=1) {
        with (players[i]) if (!piped && diggity!=32) {
            yes=0
            if (global.playback && global.mplay>1) yes=1
            else with (player) if (id!=other.id && abs(x-other.x)<200) other.yes=1
            if (yes) {
                col=playercol(global.input[p2])
                draw_skintext(round(x),round(y-(playerskindat(p2,"moth"+string(p2))+8)+dy),"P"+string(p2+1),col)
                draw_sprite_ext(spr_pointer,0,round(x),round(y-playerskindat(p2,"moth"+string(p2))+dy),1,1,0,col,1)
            }
        }
        if (timeleft>0 && !flag.passed[view_current]) {
            col=$ffffff
            if (timeleft<12 && global.frame8) col=$ff
            draw_skintext(round(players[view_current].x),round(players[view_current].bbox_top-16),format(timeleft,2),col)
        }
    }
    global.halign=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(moranboll)) exit

x=view_xview[view_current]
y=view_yview[view_current]
vww=view_wview[view_current]

if (settings("frameskip") && global.debug) draw_systext(x,y,string(global.frameskipshow))

global.reset_on_state_load=0

//time attack / lemon resetting
if ((global.gamemode="timeattack" || global.lemontest) && !global.tasing) {
    input_get(0)
    input_keystates()

    if (rkey) {
    ta_flash+=(100/30)
    } else {ta_flash=min(100,ta_flash) ta_flash=max(0,ta_flash-2)}

    if ta_flash {
    draw_set_alpha(ta_flash/100)
    draw_rectangle(view_xview,view_yview,view_xview+global.w+16,view_yview+global.h+16,0)
    draw_set_alpha(1)
    }

    if ta_flash>=100 { /*global.reset_on_state_load=1*/ loadtas()} //actually lets just set this on level start and let code blocks turn it off lmao

}

if (borda>0) {
    if (borda>0.9) rect(x,y,401,225,0,1)
    draw_sprite_ext(skindat("tex_change"),0,x,y,1,1,0,$ffffff,borda)
}

drawmoviehud()
drawpausehud()
