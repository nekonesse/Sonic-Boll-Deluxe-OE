#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
top=fh*floor((bgmanager.animcarl*myass2) mod myass1)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (blend=1) draw_set_blend_mode(bm_add)
else if (blend=2) draw_set_blend_mode(bm_subtract)

draw_background_part(spr,0,top,w,fh,x,y)

if (blend) draw_set_blend_mode(0);
