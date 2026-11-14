#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
frame=0
aaa=0
bbb=0

image_speed = 0

c=1
target=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (powner) powner.items-=1
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
        global.coll=owner
        if (vspeed>0) {
            with (instance_place(x,y,enemy)) {
                instance_create(mean(other.x,x),mean(other.y,y),kickpart)
                enemydie(id,9)
            }
        }
    } else y-=vspeed
}

shot=max(0,shot-1)
if (shot) frame=4-ceil(shot/4)
else {
    frame=0

    bbb=max(0,bbb-0.021)
    aaa=max(0,aaa-0.021)

    if (!shot) with (player) if (!intangible()) if (place_meeting(x,y,other.id)) {
        spronge=other.id

        if spronge.velocity!=0 vsp=spronge.velocity
        if spronge.hvelocity!=0 { if(name="kid") {hyperspeed=spronge.hvelocity xsc=esign(spronge.hvelocity,1) if (spronge.dir!=6 && spronge.dir!=7) vsp=min(-3.5,vsp)} else {hsp=spronge.hvelocity hyperspeed=(spronge.hvelocity / 2)}}
        if (spronge.object_index=sprong && spronge.target &&!teleport) {
            piped=1
            hspeed=hsp
            vspeed=vsp
            sprung=1
            spriteswitch(1)
            sound("itemsprong")
            myheaven=spronge.target
            sprongin=1
        } else {
            if (jump) com_landing() //?????
            com_landing()
            sound("itemspring")
            jump=1
        }

        if !(abs(spronge.hvelocity)) {
            sprung=1
            fall=1
            insted=0
            fly=0
            slide=0
        }

        if (spronge.velocity < 0) {
            charm_run("sprung");
        }
        crouch=0
        rise=0
        upper=0
        spindash=0
        lookup=0
        spindash=0
        pound=0
        teleport=0

        other.shot=12
    }
    var springing;
    with (item) {mask_index=spr_goombamask if (place_meeting(x,y,other.id)) {get_sprongged_dummy(other.velocity) sound("itemspring") other.shot=12} mask_index=spr_mask12x12}
    if (object_index=sprong) with (stone) if (place_meeting(x,y,other.id)) {vsp=-7-3*(object_index==cork) sound("itemspring") other.shot=12}
    if (object_index=spring) with (cork) if (place_meeting(x,y,other.id)) {vsp=-7 sound("itemspring") other.shot=12}
    if (object_index=spring) with (objectdummy) if (place_meeting(x,y,other.id)) {vsp=-7 sound("itemspring") other.shot=12}
    with (itemdrop) {mask_index=spr_goombamask if (place_meeting(x,y,other.id)) {get_sprongged_dummy(other.velocity) sound("itemspring") other.shot=12} mask_index=spr_mask12x12}
    with (enemy) if (object_index!=bulletbill && object_index!=blooper && object_index!=cheepred && object_index!=cheepwhite && object_index!=cheepfly && object_index!=redhover && !carry) {springing=1 if (object_index=piranha) if(!loose) springing=0
        if (place_meeting(x,y,other.id) && springing) {get_sprongged_dummy(other.velocity) sound("itemspring") other.shot=12}}

    if (shot=12) springsmoke(x,y)
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dir=unreal(dir,0)
switch(dir)
{
case 0:
    velocity=-7
    hvelocity=0
    image_index=0
break;
case 1:
    velocity=7
    hvelocity=0
    image_index=1
break;
case 2:
    velocity=0
    hvelocity=-7
    image_index=2
break;
case 3:
    velocity=0
    hvelocity=7
    image_index=3
break;
case 4:
    velocity=-7
    hvelocity=-7
    image_index=4
break;
case 5:
    velocity=-7
    hvelocity=7
    image_index=5
break;
case 6:
    velocity=7
    hvelocity=-7
    image_index=6
break;
case 7:
    velocity=7
    hvelocity=7
    image_index=7
break;
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (global.debug) draw_self();
ssw_objects("terrainspring")
