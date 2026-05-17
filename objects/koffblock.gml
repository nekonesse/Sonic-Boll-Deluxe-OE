#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
kaeru=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (instance_place(x,y,player)) hurtplayer("crush")

global.coll=owner
with (enemy) if (place_meeting(x,y,other.id)) enemydie(id,2)

instance_change(konblock,0)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_tile("koffblock")
