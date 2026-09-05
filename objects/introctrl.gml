#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//emptyreplaycache()
crashhandler()

if (global.discordoverride<2) { discord_update_presence("","On the Title Screen","boll-icon","")}

alarm[1]=1
alarm[3]=8
alarm[2]=20

fade=0
vs=0
f=0
a=0
vol=1
cango=0
clicc=0
boll=-1
boll2=-1
suns=0
yeans=0
ye=0
craft=0
time=0
bt=-1
bs=0
lok=1
cango=0
year=calcyear()
classic=!!year
classicm=0
cantriangel=0
pb_length=0

df=degtorad(135)

x=round(200+(20+80*cos(df)))
y=round(140-80*sin(df))
instance_create(x,y,introblink)
ystart=96

instance_create(0,0,intromode7)
instance_create(0,0,introborder)
instance_create(0,0,introfade)
instance_create(200,y+16,introtape)
instance_create(0,y+16,introslide1)
instance_create(0,y+16,introslide2)

repeat (32) instance_create(0,0,introslide)
repeat (32) instance_create(0,0,introbackgroundhill)

event_user(0)

if (!classicm && !yeans && !global.quietyou && !instance_exists(blastprocessor)) {
    mus_play("_intro",0)
    global.quietyou=1
}

blc=0
blt=current_time

bl[0]=1194      bl[1]=1289      bl[2]=1391      bl[3]=1495
bl[4]=1997      bl[5]=2772      bl[6]=3588      bl[7]=4376
bl[8]=4684      bl[9]=5137      bl[10]=5973     bl[11]=6767
bl[12]=7562     bl[13]=7657     bl[14]=7760     bl[15]=7857
bl[16]=8352     bl[17]=9151     bl[18]=9950     bl[19]=10747
bl[20]=11040    bl[21]=11537    bl[22]=12335
bl[23]=12736    bl[24]=12826    bl[25]=12926    bl[26]=13126
bl[27]=13325    bl[28]=13428    bl[29]=13622    bl[30]=13724
bl[31]=13923    bl[32]=14021    bl[33]=14123    bl[34]=14244
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[1]=60

joy_detect()
#define Alarm_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lok=0
#define Alarm_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
cantriangel=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!ye) {
    f=min(1,f+0.01)
    df=degtorad(135-sqr(f)*360)

    x=200+(20+80*cos(df))*sqrt(1-f)
    y=128-80*sin(df)

    if (f=1 && !ye) {
        ye=1
        bt=0
        vspeed=-8
        bs=1
    }
} else x=200

a=min(2,a+0.02)
image_blend=merge_color(0,$ffffff,max(0,a-1))

if introtape.visible=1 && !instance_exists(BETA){instance_create(144,144,BETA)}

if (blc<35 && !instance_exists(segafade)) if (current_time-blt>bl[blc]) {blc+=1 repeat (2) instance_create(irandom_range(x-64*bs,x+64*bs),irandom_range(y-64*bs,y+64*bs),introblink)}
//if !instance_exists(segafade) && introtape.visible=0 instance_create(0,0,intro_fallingobject)

if time=350 screenshake(0,10)

if (!lok) {
    if (advance() || anykey()) {
        if (!clicc) {
            clicc=1
            if (cango) {
                lok=1
                alarm[0]=-1
                segafadeto(mainmenu,"systemgo")
            }
            if (!cango) {
                cango=1
                ye=1
                x=xstart y=ystart
                vspeed=0
                bt=2 bs=1 vs=1
                with (introfade) alarm[0]=1
                with (introslide1) alarm[0]=1*!!alarm[0]
                with (introslide2) alarm[0]=1*!!alarm[0]
                with (introtape) alarm[0]=1*!!alarm[0]
                with (text1080) alarm[0]=1*!!alarm[0]
                with (intromode7) alarm[0]=1*!!alarm[0]
            }
        }
    } else clicc=0
}

time+=1
if (bt=-1) {bs=sqr(f) time+=3}
if (bt=0) {vspeed+=0.3 if (y>ystart-20 && vspeed>0) {bs=(y-(ystart-90))/70 if (y>ystart+20) {bt=1 vspeed=-4}}}
if (bt=1) {bs=(0.9+bs*5)/6 vspeed+=0.2 if (y>ystart+6 && vspeed>0) {y=ystart+6 vspeed=0 bt=2}}
if (bt=2) {bs=(1+bs*3)/4}

if (bt=-1) is=bs else is=1/bs

vs=mean(bs,vs)

boll=sureface("boll",360,360)
boll2=sureface("boll2",180 + (sqaur || triangel)*40,180 + (sqaur || triangel)*40)

if (!sureface_set_target("boll2")) exit
draw_clear_alpha(0,1)
draw_set_blend_mode(bm_subtract)
if sqaur draw_rectangle(0,0,220,220,0)
else draw_circle(90+(triangel*20),90+(triangel*20),70.5+(triangel*15.5),0)
draw_set_blend_mode(0)

if (!sureface_set_target("boll")) exit
d3d_set_projection_ortho(0,0,180,180,0)
draw_clear_alpha(0,0)
if (craft) {
    d3d_set_lighting(1)
    d3d_light_define_ambient($808080)
    d3d_light_define_direction(0,0,-1,0,$dddddd)
    d3d_light_enable(0,1)
    d3d_transform_add_rotation_y(time)
    d3d_transform_add_rotation_x(time*1.3)
    d3d_transform_add_rotation_z(time*0.7)
    d3d_transform_add_translation(90,90,0)
    d3d_set_culling(0)
    d3d_draw_floor(-45,-45,-45,45,45,-45,graas,1,1)
    d3d_set_culling(1)
    d3d_draw_wall(-45,-45,-45,-45,45,45,side,1,1)
    d3d_draw_wall(-45,45,-45,45,45,45,side,1,1)
    d3d_draw_wall(45,45,-45,45,-45,45,side,1,1)
    d3d_draw_wall(45,-45,-45,-45,-45,45,side,1,1)
    d3d_draw_floor(45,45,45,-45,-45,45,dirb,1,1)
    d3d_transform_set_identity()
    d3d_set_lighting(0)
    d3d_set_culling(0)
} else {
    d3d_set_lighting(1)
    if (debug_mode) d3d_light_define_ambient($aa)
    if (sqaur) d3d_light_define_ambient($aa0055)
    if (triangel) d3d_light_define_ambient($00aaaa)
    else d3d_light_define_ambient($aa0000)
        if (triangel) {
        d3d_light_define_direction(0,-1,1,-1,$bbbb)
        d3d_light_define_direction(2,1,-1,1,$ff)
        d3d_light_define_point(1,80+72,80-72,72,100,$dddddd)
    } else {
    d3d_light_define_direction(0,-1,1,-1,$bbdd)
    d3d_light_define_direction(2,1,-1,1,$ff)
    d3d_light_define_point(1,90+72,90-72,72,100,$dddddd)
    }
    d3d_light_enable(0,1)
    d3d_light_enable(1,1)
    d3d_light_enable(2,1)
    d3d_set_culling(1)
    d3d_transform_add_rotation_y(time)
    d3d_transform_add_rotation_x(time*1.3)
    d3d_transform_add_rotation_z(time*0.7)
    d3d_transform_add_translation(90,90,0)
    if (triangel) {d3d_set_shading(0) d3d_draw_ellipsoid(-72,-72,-72,72,72,72,-1,0,0,5) d3d_set_shading(1)}
    else if (sqaur) {d3d_set_shading(0) d3d_draw_block(-45,-45,-45,45,45,45,-1,0,0) d3d_set_shading(1)}
    else d3d_model_draw(global.boll,0,0,0,-1)
    d3d_transform_set_identity()
    d3d_set_lighting(0)
    d3d_set_culling(0)
    d3d_set_projection_ortho(0,0,360,360,0)
    draw_set_blend_mode(bm_subtract)
    draw_surface_stretched(boll2,0,0,360,360)
    draw_set_blend_mode(0)
}


surface_reset_target()

//listen i'm lazy ,ok? -scarf
if cantriangel=0  && !onechance{
    onechance=1
    if ((!global.easter && egg()) || keyboard_check(vk_numpad3) || keyboard_check(ord("3"))) {
        instance_create(0,0,blastprocessor)
        cantriangel=1
        mus_stop("_intro",0)
    }
    if (!instance_exists(blastprocessor)) {
        if (egg() || keyboard_check(ord("T"))) {
            introslide1.sprite_index=spr_luigi
            introslide2.sprite_index=spr_tails
            introtape.image_index=1
            cantriangel=1
            triangel=1
            sqaur=0
        }
    
        if (egg() || keyboard_check(ord("G"))) {
            introslide1.sprite_index=spr_garf
            introslide2.sprite_index=spr_introsonic
            introtape.image_index=2
            cantriangel=1
            triangel=0
            sqaur=0
        }
        if (egg() || keyboard_check(ord("Q"))) {
            introslide1.sprite_index=spr_intromario
            with (introslide2) instance_change(introslide2sqaur,true)
            introtape.image_index=3
            cantriangel=1
            triangel=0
            sqaur=1
        }
    }
}
#define Keyboard_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (keyboard_check_direct(vk_space)&&keyboard_check_pressed(ord('B'))) {surface_save(boll,"Boll.png")}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sureface_free("boll")
sureface_free("boll2")

if (classicm) {
    FMODAllStop()
    FMODSoundFree(classicm)
}
if (yeans) {
    FMODAllStop()
    FMODSoundFree(yeans)
}
#define Other_8
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bt=0
vspeed=-8
bs=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sureface_exists("boll")) {
    draw_surface_stretched_ext(boll,x-90*vs-1,floor(y-98*is),180*vs,180*is,0,1)
    draw_surface_stretched_ext(boll,x-90*vs+1,floor(y-98*is),180*vs,180*is,0,1)
    draw_surface_stretched_ext(boll,x-90*vs,floor(y-98*is)-1,180*vs,180*is,0,1)
    draw_surface_stretched_ext(boll,x-90*vs,floor(y-98*is)+1,180*vs,180*is,0,1)

    texture_set_interpolation(1)
    draw_surface_stretched(boll,x-90*vs,floor(y-98*is),180*vs,180*is)
    texture_set_interpolation(0)
}


if (year && introtape.f20=1) {
    global.halign=1
    if (classic && year) draw_systext(x,208,"Sonic Boll is "+string(year)+" years old today!")
    global.halign=0
}

if (global.frame88<4 && introtape.f20=1 && !year) {
    //pb stands for pressbutton here dw :p
    pb_counter=(pb_counter+1) mod 64
    if !(pb_counter mod 4) pb_length=min(pb_length+1,16)

    pb=0
    repeat (pb_length) {
        draw_sprite(spr_pressbutton,pb,136+8*pb,208-((pb_counter div 4) == pb))
        pb+=1
    }
}
#define KeyPress_32
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//generate discord server icons from the boll model

//surface_save(boll,"boll.png")
