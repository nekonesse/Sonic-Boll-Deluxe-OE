#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
alarm[0]=40
vspeed=-3.5
gravity=0.2
type=""
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
instance_create(x,y,glitter)
with (instance_create(x,y,scoreeffect)) {value=0 p2=other.p2}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspeed=min(2,vspeed)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_items(type)
