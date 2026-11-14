#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
frame=0
aaa=0
bbb=0

c=1
target=0

velocity=-7
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
        yground=easyground()
        if (y>=yground-16-4*(vspeed=0)) {
        vspeed=0
        y=yground-16
        belt=collision(0,1)
        if belt.object_index=conveyorbelt && !collision(belt.beltspd,0) && !collision(-belt.beltspd,0)
        x=x+belt.beltspd;
        }
        else vspeed=min(3,vspeed+0.25)

        global.coll=owner
        if (vspeed>0) {
            with (instance_place(x,y+vspeed,enemy)) {
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

    if (!shot) with (player) if (!intangible()) if (place_meeting(x,y+4,other.id)) {
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
            sound("itemspring")
            jump=1
        }


        charm_run("sprung")
        sprung=1
        crouch=0
        rise=0
        fall=1
        upper=0
        spindash=0
        lookup=0
        slide=0
        spindash=0
        pound=0
        insted=0
        fly=0
        teleport=0

        other.shot=12
    }
    var springing;
    with (item) {mask_index=spr_goombamask if (place_meeting(x,y+4,other.id)) {get_sprongged_dummy(other.velocity) sound("itemspring") other.shot=12} mask_index=spr_mask12x12}
    if (object_index=sprong) with (stone) if (place_meeting(x,y+4,other.id)) {vsp=-7-3*(object_index==cork) sound("itemspring") other.shot=12}
    if (object_index=spring) with (cork) if (place_meeting(x,y+4,other.id)) {vsp=-7 sound("itemspring") other.shot=12}
    if (object_index=spring) with (objectdummy) if (place_meeting(x,y+4,other.id)) {vsp=-7 sound("itemspring") other.shot=12}
    with (itemdrop) {mask_index=spr_goombamask if (place_meeting(x,y+4,other.id)) {get_sprongged_dummy(other.velocity) sound("itemspring") other.shot=12} mask_index=spr_mask12x12}
    with (enemy) if (object_index!=bulletbill && object_index!=bullseyebill && object_index!=banzaibill && object_index!=lakitu && object_index!=blooper && object_index!=cheepred && object_index!=cheepwhite && object_index!=cheepfly && object_index!=redhover && object_index!=orbinautgreen && object_index!=orbinautblue && object_index!=orbinautred && object_index!=orbinautbumper && !carry) {springing=1 if (object_index=piranha) if(!loose) springing=0
        if (place_meeting(x,y+4,other.id) && springing) {get_sprongged_dummy(other.velocity) sound("itemspring") other.shot=12}}

    if (shot=12) springsmoke(x+8,y)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_objects("spring")
