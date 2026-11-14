#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
x=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (x < -(sprite_width)) event_user(0)

image_xscale=1
image_yscale=1
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_index=0
image_speed=0
x=0
y=96

if (!introctrl.classic) image_blend=merge_color($ffff80,$808040,1-(y-104)/110)

hspeed=-0.1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,floor(x),y,abs(image_xscale),abs(image_yscale),0,c_white,1)

draw_sprite_ext(sprite_index,image_index,floor(x+sprite_width),y,abs(image_xscale),abs(image_yscale),0,c_white,1)
