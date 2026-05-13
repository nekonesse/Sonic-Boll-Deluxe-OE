#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
x-=8
y-=8
c = 1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x,y,hitswitch)
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
c=1
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (c) {
    if (inview()) {
        player_nslopforce()
        if (coll) {vspeed=0}
        else vspeed=min(3,vspeed+0.25)

        global.coll=owner
        if (vspeed>0) {
            with (instance_place(x,y+vspeed,enemy)) {
                instance_create(mean(other.x,x),mean(other.y,y),kickpart)
                enemydie(id,9)
            }
        }
    } else y-=vspeed
}
#define Other_16
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.ptime=600
sound("itempswitch")
stagemusic(id,1)
with instance_create(x,y,pSolid) {alarm[0]=2}

instance_activate_object(bluecoin)
with (bluecoin) {
    if (y!=ystart) instance_create(x,ystart,smoke)
    y=ystart active=1 flash=0 visible=1
}

if gamemanager.switched=1 {instance_destroy() exit}
instance_activate_object(brick)
instance_activate_object(coin)
instance_activate_object(pblockoff)
instance_activate_object(pblock)

with (brick)  if !biggie && !switched {
    if content="" with instance_create(x+8,y+8,coin) {switched=1 stoned=other.stoned}
    instance_destroy()
}
with (coin) {
    if (!dropped && !switched && object_index!=redcoin && object_index!=bluecoin) {
        with instance_create(x-8,y-8,brick) {stoned="0" switched=1 event_user(3)}
        instance_destroy()
    }
}
with (pblock) if !switched {
    with instance_create(x,y,pblockoff) switched=1
    instance_destroy()
}

with (pblockoff) if !switched{
    with instance_create(x,y,pblock) switched=1
    instance_destroy()
}
with (door) if (funnytruefalse(is_pdoor) && !switched) {switched=1}
gamemanager.switched=1
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_objects("pswitch")
