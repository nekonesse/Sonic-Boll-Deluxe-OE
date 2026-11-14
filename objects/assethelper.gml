#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (blend=1) draw_set_blend_mode(bm_add)
else if (blend=2) draw_set_blend_mode(bm_subtract)

draw_background(spr,x,y)

if (blend) draw_set_blend_mode(0);
