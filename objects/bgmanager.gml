#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
offsets[3]=0
animbob=0
animcarl=0
animkevin=0
global.removebackgrounddrawing=0
oxc=0
offmoran=0

lowdetail=(settings("detail"))

sb[0]=-1 sb[1]=-1 sb[2]=-1 sb[3]=-1
sf[0]=-1 sf[1]=-1 sf[2]=-1 sf[3]=-1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animcarl+=1/max(1,skindat("bgspd"))
animbob=floor(animcarl)
animkevin=!animkevin
global.bgscroll+=!gamemanager.pause
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/

if global.removebackgrounddrawing=1 exit
if (lowdetail && !animkevin) {
    for (i=0;i<global.mplay;i+=1) {
        sb[i]=sureface("background"+string(i),400,224)
        if (sureface_set_target("background"+string(i))) {
            //RENDERMARKER
            //draw_clear_alpha(0,0)
            drawlayeredbackground(0,i)
            surface_reset_target()
        }
        sf[i]=sureface("foreground"+string(i),400,224)
        if (sureface_set_target("foreground"+string(i))) {
            draw_clear_alpha(0,0)
            drawlayeredbackground(1,i)
            surface_reset_target()
        }
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///foreground layers
if (instance_exists(moranboll)) exit

if global.removebackgrounddrawing  exit

if (lowdetail) {
    if (sureface_exists("foreground"+string(view_current))) if surface_exists(sf[view_current]) draw_surface(sf[view_current],view_xview[view_current],view_yview[view_current])
} else {
    drawlayeredbackground(1,view_current)
}

waterbiome[view_current]=getbiomeid(gamemanager.typebg[view_current])

//water surface
if (gamemanager.water[view_current]<gamemanager.ky[view_current]) for (p=(view_xview[view_current] div 32)*32;p<view_xview[view_current]+400;p+=32)
    draw_background_part(global.master[waterbiome[view_current]],424+32*(global.frame88 mod 4),120+8*(global.frame88 div 4),32,8,p,gamemanager.water[view_current])
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///background layers

if (gamemanager.pause || instance_exists(moranboll)) exit

if global.removebackgrounddrawing exit

if (lowdetail) {
    if (sureface_exists("background"+string(view_current))) if surface_exists(sb[view_current]) draw_surface(sb[view_current],view_xview[view_current],view_yview[view_current])
} else if !(settings("removeassets")) {
    drawlayeredbackground(0,view_current)
}
