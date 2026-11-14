#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dir = "up"
frame=0
aaa=0
bbb=0

image_speed = 0

c=1
target=0

velocity=-7
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

        vsp=spronge.velocity
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
            if (jump) com_landing()
            com_landing()
            sound("itemspring")
            jump=1
        }

        sprung=0
        charm_run("sprung");
        pollenated=1
        crouch=0
        rise=0
        fall=0
        upper=0
        spindash=0
        lookup=0
        slide=0
        spindash=0
        spin=0
        bellyslide=0
        slidekick=0
        pound=0
        insted=0
        fly=0
        teleport=0
        canstopjump=0
        spin=0

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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_objects("pollflower")
