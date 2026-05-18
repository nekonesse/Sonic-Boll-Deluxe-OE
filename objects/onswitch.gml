#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite="onswitch"
content=""
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
owner=global.coll
if (!insted) {
    if (owner.fly) owner.vsp=0
    else owner.vsp=1.5
}
if(!wait) {
    sound("itemonoffswitch")
    instance_activate_object(onblock) instance_activate_object(offblock) instance_activate_object(onspike) instance_activate_object(offspike)
    with (onblock) alarm[0]=1
    with (offblock) {alarm[0]=1 owner=global.coll}
    with (offspike) alarm[0]=1
    with (onspike) {alarm[0]=1 owner=global.coll}
    with (itembox) {
        if (on_block || off_block)/* && !hit*/ {instance_change(offblock,0)}
        //if off_block && !hit {instance_change(offblock,0)}
    }
    gamemanager.onblockstate=!gamemanager.onblockstate
    wait=13
    tpos=1
}
