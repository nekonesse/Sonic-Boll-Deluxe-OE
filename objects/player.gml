#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xsc=1
ysc=1
hsp=0
vsp=0

grav = 0

name=""

time=-1
mem=0
carryid=noone
jump=0
super=0
dy=0
dix=0
jumpspd=0.5
ready=-1
weight=1
timeend=0
follow=id
last=id

reset_invincible()
is_intangible=1
is_coinexplosive=0
power_lv=0
global.finishmusic=0
hurt=0
dead=0
fall=0
flash=0
piped=0
move_lock=0
hurttype=0
prevent_spr_reset=0
iframeslength=90;

water=0
frame=0
frspd=0
super=0

ending=""

expulsionbias=0
respawncamslide=0
magnetignore=noone;

safex=x
safey=y

camx=0
camy=0
ycam=0
camspd=4
looky=0
lookgy=0

mask_w=12
mask_h=12

size=0
energy=0
memsize=-1
sprite=""
oldspr=""
fallspr=""
shadow=0
alpha=1
sprite_angle=0
bumperpower=3
bumpercollision=1
nocratebounce=0

input_clear()
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
piped=0
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///end instashield
insta=0
#define Alarm_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///star ending
if (intangible() && flag.count=global.mplay) {star=0 exit}

if (!gamemanager.drowning) {
    var yes; yes=1
    with (player) if (id!=other.id && star && !alarm[3]) yes=0
    if (yes) {
        global.music=""
        stagemusic(id,p2,false)
    }
}

alarm[3]=80
#define Alarm_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///star ended
star=0
seqcount=1
#define Alarm_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///get out of frag hitstun
if (!dead) {
    piped=0
    flash=(flash || hurt)
}
#define Alarm_6
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///disappear
speed=0 visible=0
#define Alarm_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///respawn
if (gamemanager.deathtimer >= 10) exit
player_respawn()
#define Alarm_8
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///begin respawn
if (gamemanager.deathtimer >= 10) exit
respawncamslide=1

slidefromx=view_xview[p2]
slidefromy=view_yview[p2]

x=safex
y=safey
player_camera(1)
safevx=view_xview[p2]
safevy=view_yview[p2]

view_xview[p2]=slidefromx
view_yview[p2]=slidefromy
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (id<other.id) player_collision()
#define Collision_enemy
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//manage most enemy collisions
//some enemies are hardcoded, such as podoboos and firebars due to being very specific
var extracheck,calcfall,inst,type;
if (hurt || piped) exit

coll=noone extracheck=id inst=0





if (other.phase!=id && !other.lock){
    coll=other.id
    charm_run("enemycoll")
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.debug) rect(bbox_left,bbox_top,bbox_right-bbox_left+1,bbox_bottom-bbox_top+1,$ffffff,1)

if ((room==ta_results || room==scoring || room==results || room==finalscore) && !global.debug && p2!=view_current) exit

if (star) ssw_shield("star_back")
else if (shielded) ssw_shield("shield_back")

if latchedtoflagpole x-=(poleoffx*xsc)


if !global.playerbecomesmall
if !(flash && global.bgscroll mod 5<3) || (dontflash)
    if !(diggity=32 && digvisible){
        mem=size
        if (((hurt || fall=6) && hk<4) || ((grow && gk mod 6<3) && showgrow) || (showoldsize)) size=oldsize
        sheet=sheets[size]
        ssw_core(0)
        if (!super) if (((hurt || fall=6) && hk<4) || ((grow && gk mod 6<3) && showgrow) || (showoldsize)) size=mem
    }


if latchedtoflagpole x+=(poleoffx*xsc)

if !global.playerbecomesmall
if (star) ssw_shield("star")
else if (shielded) ssw_shield("shield")

if (global.debug) rect(bbox_left,bbox_top,bbox_right-bbox_left+1,bbox_bottom-bbox_top+1,$ffffff,0.5)
