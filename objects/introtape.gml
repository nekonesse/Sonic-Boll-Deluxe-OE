#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
y=ystart+200
alarm[0]=170
image_xscale=1000
f20=0
fr20=0
frg20=0
flare=0
lock=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible=1
instance_create(x,y,introcircle)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (visible) {
    image_xscale=max(1,image_xscale*0.777)
    if (!lock) {
        vspeed-=1
        if (y+vspeed<=ystart) {vspeed=0 y=ystart lock=1}
    }
}

if (lock && !introctrl.craft) {
    f20=min(1,f20+0.02)
    if (f20=1) {
        if (!flare) {flare=1 instance_create(x-10,y+78,cool_lens_flare)}
        fg20=min(1,fg20+0.05)
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(spr_deluxe,0,x,y+cosine(200,76,f20))
draw_sprite_ext(spr_deluxe,1,x,y+cosine(200,76,f20),1,1,0,$ffffff,fg20)
draw_self()
with (introslide1) if (visible) event_user(0)
with (introslide2) if (visible) event_user(0)
