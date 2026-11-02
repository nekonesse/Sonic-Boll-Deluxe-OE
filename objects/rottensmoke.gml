#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fr=0
getregion(x)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fr=fr+0.2
frame=floor(fr)

if (frame>=7) {instance_destroy() visible=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_weffects("rottensmoke")
