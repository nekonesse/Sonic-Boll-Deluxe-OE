#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drop=0
getimer=8
p2=-1
alarm[0]=24
getregion(x)
friction=0.15
xp=x
yp=y
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
c=1
gravity=0
if (!drop) {
    hspeed=(vspeed<0)
    vspeed=0
}
depth=0
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if (c) calcmoving()
getimer-=1
ply=instance_nearest(x,y,player)

    xp=x yp=y
    if (drop) hspeed=0
    if (alarm[0]<=0) {
        mask_index=spr_goombamask
        if (alarm[0]<=0) {
if (ply.pipe) {instance_create(x,y,smoke) instance_destroy()}
spd = 1.5;
dist = point_distance(x, y, ply.x, ply.y);
vsp = approach_val(vsp, 0, 0.1);
y += vsp;
image_xscale = esign(x - ply.x, 1) if (dist > 100) {spd += ((dist - 100) / 12);
}
move_towards_point(ply.x, ply.y, spd)
        }
        mask_index=spr_mask12x12
    }

if (pitdeath()) instance_destroy()
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sound("item1up")
if (!getimer || other.name="kid") {with other
{
if (global.mplay>1 || global.debug || global.lemontest) alarm[7]=120
die()
}
instance_destroy() visible=1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_items("lifemush")
