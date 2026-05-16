#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
contents=""
fall=0
x-=9
y-=12
getregion(x)
shouldfall=1
hitbehaviour=1
landable=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//block bumping animation
dy=max(0,abs(dy)-2)*sign(dy)
var kek,yes; kek=999 yes=0
with (hittable) if (place_meeting(x,y-4,other.id)) {kek=min(kek,dy) yes=1}
if (yes) dy=kek

if (fall) {
    mask_index=spr_fallingmonitormask
    vspeed+=0.15
    coll=collision(0,vspeed+2)
    if (coll) {y=coll.y-8-12 vspeed=0 fall=0}
    else {
        coll=instance_place(x,y+vspeed+2,player)
        with (coll) if (!jump) hurtplayer(1)
    }
} else {
    mask_index=spr_monitormask
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
owner=global.coll
sound('itemmonitor')
instance_create(x+8,y+4,smoke)
instance_create(x,y,monitordead)
c=instance_create(x,y+2,monamie)
c.contents=contents
c.owner=owner
instance_destroy()
#define Other_16
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
owner=global.coll
sound('itemmonitor')
instance_create(x+8,y+4,smoke)
instance_create(x,y,monitordead)
c=instance_create(x,y+2,monamie)
c.contents=contents
c.owner=owner
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_monitor(contents)

if (global.debug) rect(bbox_left,bbox_top,bbox_right-bbox_left+1,bbox_bottom-bbox_top+1,$ffffff,0.5)
