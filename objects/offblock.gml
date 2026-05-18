#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
blue=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (instance_place(x,y,player)) hurtplayer("crush")

global.coll=owner
with (enemy) if (place_meeting(x,y,other.id)) enemydie(id,2)

if string(content)="" || string(content)="0" instance_change(onblock,0) else {instance_change(itembox,0)}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_tile("offblock")
