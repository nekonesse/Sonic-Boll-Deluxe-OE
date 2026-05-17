#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
frame=0
open=0
fc=0
flash=0
is_frogdoor=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
open=0 sound("itemdoorclose")
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
over=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (string(is_pdoor) == "2") {
   is_pdoor = 0
   is_frogdoor=1
}

if (open) frame=min(2,frame+0.125)
else frame=max(0,frame-0.125)

if (frame=0.125 && key) event_user(1)

fc+=1 if (fc=8) {fc=0 flash=!flash}
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (key>1 || (locktype=="tokengreen" && greentoken < 2)) {
    over=1
    alarm[1]=2
    haskeys=0

    switch (locktype) {
        case "key": with (other) other.haskeys=max(other.haskeys,count_owned(keyfollow)) break;
        case "token": haskeys=max(haskeys,gamemanager.tokens) break;
        case "tokenblue": haskeys=max(haskeys,global.tokens) break;
        case "tokengreen": if greentoken!=2 greentoken = settings("token " + name + " " + chr(187) + pack)
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
key=unreal(key,0)
oneway=unreal(oneway,0)

if (locktype == "tokengreen") {
    pack = global.lskins[global.levelskin+1,0]
    if (pack == global.lbase) pack = ""

    greentoken = settings("token " + name + " " + chr(187) + pack)
    if (greentoken == 2) {
        key=0
    } else {
        key=1
    }
}
if (locktype == "tokenblue") {
    key-=spenttoken()
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (instance_create(x+4,y-4,smoke)) {direction=135 speed=2 friction=0.1}
with (instance_create(x+12,y-4,smoke)) {direction=45 speed=2 friction=0.1}
with (instance_create(x+4,y+4,smoke)) {direction=225 speed=2 friction=0.1}
with (instance_create(x+12,y+4,smoke)) {direction=315 speed=2 friction=0.1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_tile("door")
if (over) {
    x+=8
    y-=32
    switch locktype {
        case "key": ssw_items("key") break;
        case "token": type=0 ssw_items("token") break;
        case "tokenblue": type=1 ssw_items("token") break;
        case "tokengreen": type=2 ssw_items("token") break;
    }
    col=$ff
    if locktype != "tokengreen" {
        if (haskeys>=key || flash) col=$ffffff
        global.halign=1
        draw_skintext(x,y+8,string(haskeys)+"/"+string(key),col,1)
        global.halign=0
    } else {
        if (greentoken) col=$ffffff else col=$808080
        global.halign=1
        draw_skintext(x,y+8,string(name),col,1)
        global.halign=0
    }
    x-=8
    y+=32
}
