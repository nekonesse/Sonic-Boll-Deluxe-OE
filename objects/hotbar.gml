#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
cur=1
obj=0
obj[1]=editobjfind(groundblock)
obj[2]=editobjfind(hardblock)
obj[3]=editobjfind(brick)
obj[4]=editobjfind(coin)
obj[5]=editobjfind(goomba)
obj[6]=editobjfind(koopa)
obj[7]=editobjfind(spring)
obj[8]=editobjfind(pipeblock)
obj[9]=editobjfind(treeblock)
obj[10]=editobjfind(spikenemy)
pickeddata=0

alpha=1
alpha2=0
alpha3=0
str=""
str2=""

//fun mode waving stuff
amp=4
freq=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x=view_wview[0]/2-16
y=view_hview[0]-200
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!drawregion.flooding) {
    curp=cur
    if (!editcursor.ctrl && !editcursor.alt) {savecur=cur cur=modulo(cur+editcursor.scrw,1,10+pickeddata)  if savecur!=cur {if !(settings("nolemonsound")) sound("systemselect") /*while lemonobjname(lemongrab.objlist[obj[cur],0])="0" {cur=modulo(cur+editcursor.scrw,1,10)}*/}}
    for (i=0;i<10;i+=1) {
        if (keyboard_check_pressed(ord("0")+i)) {
            if (pickeddata || i) {
                cur=i+(!i*10)
            }
            if !(settings("nolemonsound")) sound("systemselect")
        }
    }
    if (cur!=curp) {
        str=lemonobjname(lemongrab.objlist[obj[cur],0])
        alpha2=3

        str2=wordwrap(lemonobjdesc(lemongrab.objlist[obj[cur],0]),32)
        alpha3=10
    }
}
//while lemonobjname(lemongrab.objlist[obj[cur],0])="0" cur=modulo(cur+editcursor.scrw,1,10) //do NOT go into an infinite loop and crash the game if selecting 0

if (within(mouse_x,mouse_y,x-180,y-20,360,60)) alpha=max(0.25,alpha-0.05)
else alpha=min(1,alpha+0.05)

alpha2=max(0,alpha2-0.05)
alpha3=max(0,alpha3-0.05)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
t+=1
for (i=0;i<9+pickeddata;i+=1) {
    xx=x-159+40*i+(i=9)*20
    so = t + (i*6)+(i=9)*3

    if (cur == i+1) {
        yraise[i]=approach_val(yraise[i],-8,1)
        why = 0;
    } else {
        yraise[i]=approach_val(yraise[i],0,1)
        why = sin(so*pi*freq/room_speed)*amp;
    }

    if !settings("funmode")
    yy=(y+why)+yraise[i]
    else
    yy=y+yraise[i]

    draw_sprite_ext(spr_editorbuttonshadow,0,xx,yy,1,1,0,c_black,0.5)
    if (editcursor.tool=2 && cur=i+1) draw_sprite_ext(spr_editorbutton,2+!editcanflood(lemongrab.objlist[obj[cur],0]),xx,yy,1,1,0,$ffffff,alpha)
    else if i=9 draw_sprite_ext(spr_editorbutton,(4-(cur=i+1)*3),xx,yy,1,1,0,$ffffff,alpha)
    else draw_sprite_ext(spr_editorbutton,(cur=i+1),xx,yy,1,1,0,$ffffff,alpha)

    if (cur=i+1) draw_sprite_ext(spr_editsel,0,xx,yy,1,1,0,$ffffff,alpha)

    if (obj[i+1]) draw_sprite_ext(spr_editpal,lemongrab.objlist[obj[i+1],25],xx,yy,1,1,0,c_black,0.5) draw_sprite_ext(spr_editpal,lemongrab.objlist[obj[i+1],25],xx-1,yy-1,1,1,0,$ffffff,alpha)
    if (picked[i+1]) draw_sprite_ext(spr_editsel,1,xx,yy,1,1,0,$ffffff,alpha)
}

global.tscale=2
global.halign=1
global.valign=2
draw_systext(x+16,y-18,wordwrap(str,45),$ffffff,alpha2)
global.valign=0
draw_systext(x+16,97,wordwrap(str2,45),$ffffff,alpha3)
global.tscale=1
global.halign=0
