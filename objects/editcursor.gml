#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_xscale=2
image_yscale=2
tool=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x=mouse_x
y=mouse_y

left=mouse_check_button(mb_left)
leftp=mouse_check_button_pressed(mb_left)
right=mouse_check_button(mb_right)
rightp=mouse_check_button_pressed(mb_right)
middle=mouse_check_button(mb_middle) || keyboard_check(vk_space)
middlep=mouse_check_button_pressed(mb_middle) || keyboard_check_pressed(vk_space)
ctrl=keyboard_check_direct(vk_control)
shift=keyboard_check_direct(vk_shift)
alt=keyboard_check_direct(vk_alt)
scrw=mouse_wheel_down()-mouse_wheel_up()
escape=input_esc()

//Replaced with Toggle Lemon Music button

/*
//MUTE with -
if keyboard_check_direct(189) && !keyboard_check_direct(vk_shift) && global.focus mus_volume(0)

//MUTE with + ("do you mean unmute" -moster)
if keyboard_check_direct(187) && !keyboard_check_direct(vk_shift) && global.focus mus_volume(1)
*/

if (ctrl) {
    if (keyboard_check_pressed(ord("S"))) {editsave(global.lemonfilename) if !(settings("nolemonsound")) sound("lemonlevelsave")}
    if (keyboard_check_pressed(ord("Z"))) editundo()
    if (keyboard_check_pressed(ord("C"))) editcopy(0)
    if (keyboard_check_pressed(ord("X"))) editcopy(1)
    if (keyboard_check_pressed(ord("V"))) editpaste()
    if (keyboard_check_pressed(ord("A"))) editall()
    if (keyboard_check_pressed(ord("N"))) editnew(1)
    if (keyboard_check_pressed(ord("O"))) if shift editload(editmanager.autosave) else editload()
} else if (alt && scrw!=0) {
    editloadregion(wrap_val(drawregion.region+scrw,0,7))
    if !(settings("nolemonsound")) sound("lemonselectitem")
} else {
    if (keyboard_check_pressed(ord("S"))) {tool=1 if !(settings("nolemonsound")) sound("lemonselecttool")} //Select
    if (keyboard_check_pressed(ord("D"))) {tool=0 if !(settings("nolemonsound")) sound("lemonselecttool")} //Draw
    if (keyboard_check_pressed(ord("F"))) {tool=2 if !(settings("nolemonsound")) sound("lemonselecttool")} //Fill
    if (keyboard_check_pressed(ord("W"))) {tool=9 if !(settings("nolemonsound")) sound("lemonselecttool")} //Spawn Marker
    if (keyboard_check_pressed(ord("E"))) {tool=3 if !(settings("nolemonsound")) sound("lemonselecttool")} //Boundary Tool
    if (keyboard_check_pressed(ord("R"))) {tool=7 if !(settings("nolemonsound")) sound("lemonselecttool")} //Reference Tool
    if (keyboard_check_pressed(ord("G"))) {if !(settings("nolemonsound")) sound("lemonselecttool") with (gridtoggle) event_user(0)}
    if (keyboard_check_pressed(vk_delete)) {editdeleteselection()}
    if (keyboard_check_pressed(vk_f5)) {edittest(1)}
}

if (middle) {
    leftp=0
    left=0
}

if (left) {
    if (leftp) image_index=1
    image_index=min(2,image_index+0.2)
} else if (right) {
    if (rightp) image_index=3
    image_index=min(4,image_index+0.2)
} else image_index=0

if (drawregion.hidecur) image_xscale=1
else image_xscale=editzoom.level
image_yscale=image_xscale
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !settings("funmode") {
    mouse_hsp=x-xprevious;
    mouse_vsp=y-yprevious;

    image_angle = round(mouse_vsp)*2+round(mouse_hsp)*2 //funny dance
} else {
    mouse_hsp=0;
    mouse_vsp=0;
    image_angle=0;
}

draw_self();

//Selection Ruler
if (drawregion.selecting && !settings("lemon disableruler")) draw_systext(round(x+4),round(y-12),string(drawregion.selw)+"x"+string(drawregion.selh))

if (drawregion.flooding) draw_sprite(spr_editortools,6,x+18,y)
else if (drawregion.grab || (middle && !drawregion.drawing && !drawregion.grabf && !drawregion.grabs && !drawregion.grabj && !drawregion.resize && !drawregion.selecting)) draw_sprite(spr_editortools,8,x+18,y)
else if (!drawregion.hidecur) {
    if (tool=0 && ctrl) draw_sprite(spr_editortools,5,x+18,y)
    else if (tool=0) {
        if (shift) draw_sprite(spr_editortools,8,x+18,y)
        else if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=waterblock) draw_sprite(lemongrab.objlist[hotbar.obj[hotbar.cur],1],0,x+18,y)
        else draw_sprite(spr_editortools,0,x+18,y)
    }
    else draw_sprite(spr_editortools,tool,x+18,y)
}
