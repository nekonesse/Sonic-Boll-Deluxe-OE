#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0;

scriptname = "";
stepevent = -1;
createevent = -1;
drawevent = -1;
triggeredevent = -1;
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (stepevent != 0) {
    code_execute(stepevent)
}

if (triggerevent != 0) && (global.channel[channelid]) {
    code_execute(triggerevent)
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
stepevent=ds_map_find_value(global.levelscripts,"step_"+scriptname)
createevent=ds_map_find_value(global.levelscripts,"create_"+scriptname)
drawevent=ds_map_find_value(global.levelscripts,"draw_"+scriptname)
triggerevent=ds_map_find_value(global.levelscripts,"trigger_"+scriptname)

if (createevent != 0) {
    code_execute(createevent)
}

channelid=unreal(channelid,0)
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
levelinitevent=ds_map_find_value(global.levelscripts,"level_init_"+scriptname)

if (levelinitevent != 0) {
    code_execute(levelinitevent)
}
#define Other_12
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
levelendevent=ds_map_find_value(global.levelscripts,"level_end_"+scriptname)

if (levelendevent != 0) {
    code_execute(levelendevent)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (drawevent != 0) {
    code_execute(drawevent)
}
