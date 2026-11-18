#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//dark area
var i;
i=0;
repeat(global.mplay) {
    global.overridelightlevel[i]=-1
    i+=1;
}
global.overridelight=0
glowoff=0
lalpha=1
getregion(x)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Light Manager
global.glowoff = wave_val(-5,5,2,0)

instance_activate_object(flag)

with flag with player if (other.passed[p2] || finish) && (bigger_light<15) {
    bigger_light+=0.015+(bigger_light/5)
    lalpha-=0.025
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///The Dark

var i,ii;
i=0
repeat(global.mplay) {
    ii=string(i)
    //clear the surface at the beginning of each frame
    if !sureface_exists("lightsurface_"+ii) {
        sureface("lightsurface_"+ii,view_wview[i],view_hview[i])
    }

    sureface_set_target("lightsurface_"+ii);
    draw_clear_alpha(c_black,0);

    var lightlevel,surfalpha;
    lightlevel=0;

    //the lighter the color, the darker the shade and vice-versa
    //a 100% white pixel will draw 100% black for example since the blend mode is set to subtract
    if (global.overridelightlevel == -1) { //why are there two variables for overriding the light level i dont get it
        if !(gamemanager.players[i].star) {
            global.overridelight[i] = -1;
            lightlevel=(gamemanager.players[i]).region.lightlevel
        } else {
            global.overridelight[i] = min(lightlevel,1)
        }
    } else lightlevel=global.overridelightlevel

    surfalpha = min(0.17*lightlevel,1);

    if (lightlevel) {
        if !(global.overridelight)
        draw_sprite_ext(tex_1x1,0,0,0,view_wview[i],view_hview[i],0,c_white,lalpha*surfalpha);
        else
        draw_sprite_ext(tex_1x1,0,0,0,view_wview[i],view_hview[i],0,c_white,lalpha*surfalpha);
    }


    surface_reset_target();

    i+=1
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Draw spotlights for objects.

//set blend mode

var j,ii;
j=0
repeat(global.mplay) {
ii = string(j)
sureface_set_target("lightsurface_"+ii);

draw_set_blend_mode(bm_subtract);

//player glow
var i;
i=0;
repeat(global.mplay) {
    camx = view_xview[j]
    camy = view_yview[j]
    if (bigger_light) radius=50*bigger_light
    else radius = 50
    xx=gamemanager.players[i].x
    yy=gamemanager.players[i].y
    draw_circle_color(xx-camx,yy-camy-8,radius+20+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(xx-camx,yy-camy-8,radius+10+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(xx-camx,yy-camy-8,radius+global.glowoff,c_white,c_white,false);
    i+=1;
}

with(charmdeath){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=50
    radius2=10
    draw_circle_color(x-camx,y-camy-8,radius+(radius2*2)+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+radius2+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(lightbulb){ //real shit
    if (channelid && global.channel[channelid]) || (!channelid) {

    camx = view_xview[j]
    camy = view_yview[j]
    xx=8*image_xscale+x+8-camx
    yy=8*image_yscale+y-camy
    w=width*16
    h=height*16
    if (shape) == "ellipse" {
        draw_ellipse_color(xx-(w/2)-(10+global.glowoff),yy-(h/2)-(10+global.glowoff),xx+(w/2)+(10+global.glowoff),yy+(h/2)+(10+global.glowoff),make_color_rgb(245,245,245),c_dkgray,false)
        draw_ellipse_color(xx-(w/2)-(5+global.glowoff),yy-(h/2)-(5+global.glowoff),xx+(w/2)+(5+global.glowoff),yy+(h/2)+(5+global.glowoff),make_color_rgb(175,175,175),c_gray,false)
        draw_ellipse_color(xx-(w/2)-global.glowoff,yy-(h/2)-global.glowoff,xx+(w/2)+global.glowoff,yy+(h/2)+global.glowoff,c_white,c_white,false)
    } else if (shape) == "square" {
        draw_rectangle_color(xx-(w/2)-(10+global.glowoff),yy-(h/2)-(10+global.glowoff),xx+(w/2)+(10+global.glowoff),yy+(h/2)+(10+global.glowoff),c_dkgray,c_dkgray,c_dkgray,c_dkgray,false)
        draw_rectangle_color(xx-(w/2)-(5+global.glowoff),yy-(h/2)-(5+global.glowoff),xx+(w/2)+(5+global.glowoff),yy+(h/2)+(5+global.glowoff),c_gray,c_gray,c_gray,c_gray,false)
        draw_rectangle_color(xx-(w/2)-global.glowoff,yy-(h/2)-global.glowoff,xx+(w/2)+global.glowoff,yy+(h/2)+global.glowoff,c_white,c_white,c_white,c_white,false)
    } else if (shape) == "spotlight" {
        var _steps, _xx, _yy, _radius, j;
        _steps = 12;
        _xx = xx;
        _yy = yy-(h/2);
        _radius = 18+global.glowoff;
        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color(_xx, _yy, c_dkgray, 1);
        j=0
        repeat (_steps+1)
        {
            draw_vertex_color(_xx + lengthdir_x(_radius, 180 * j / _steps), _yy + lengthdir_y(_radius, 180 * j / _steps), c_dkgray, 1);
            j+=1;
        }
        draw_primitive_end();

        _radius = 13+global.glowoff;
        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color(_xx, _yy, c_gray, 1);
        j=0
        repeat (_steps+1)
        {
            draw_vertex_color(_xx + lengthdir_x(_radius, 180 * j / _steps), _yy + lengthdir_y(_radius, 180 * j / _steps), c_gray, 1);
            j+=1;
        }
        draw_primitive_end();

        _radius = 8+global.glowoff;
        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color(_xx, _yy, c_white, 1);
        j=0
        repeat (_steps+1)
        {
            draw_vertex_color(_xx + lengthdir_x(_radius, 180 * j / _steps), _yy + lengthdir_y(_radius, 180 * j / _steps), c_white, 1);
            j+=1;
        }
        draw_primitive_end();

        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color(xx-8-(10+global.glowoff), yy-(h/2),c_dkgray,1); //top left
        draw_vertex_color(xx-(w/2)-(10+global.glowoff),yy+(h/2),c_dkgray,1); //bottom left
        draw_vertex_color(xx+(w/2)+(10+global.glowoff),yy+(h/2),c_dkgray,1); //bottom right
        draw_vertex_color(xx+8+(10+global.glowoff), yy-(h/2),c_dkgray,1); //top right
        draw_primitive_end();

        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color(xx-8-(5+global.glowoff), yy-(h/2),c_gray,1); //top left
        draw_vertex_color(xx-(w/2)-(5+global.glowoff),yy+(h/2),c_gray,1); //bottom left
        draw_vertex_color(xx+(w/2)+(5+global.glowoff),yy+(h/2),c_gray,1); //bottom right
        draw_vertex_color(xx+8+(5+global.glowoff), yy-(h/2),c_gray,1); //top right
        draw_primitive_end();

        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color(xx-8-(global.glowoff), yy-(h/2),c_white,1); //top left
        draw_vertex_color(xx-(w/2)-(global.glowoff),yy+(h/2),c_white,1); //bottom left
        draw_vertex_color(xx+(w/2)+(global.glowoff),yy+(h/2),c_white,1); //bottom right
        draw_vertex_color(xx+8+(global.glowoff), yy-(h/2),c_white,1); //top right
        draw_primitive_end();

    }

    }
}

with(projectile){
    camx = view_xview[j]
    camy = view_yview[j]
    draw_circle_color(x-camx,y-camy-8,radius+(radius2*2)+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+radius2+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(podoboo){
    if visible {
    camx = view_xview[j]
    camy = view_yview[j]
    radius=30
    draw_circle_color(x-camx-8,y-camy-16,radius+10+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx-8,y-camy-16,radius+5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx-8,y-camy-16,radius+global.glowoff,c_white,c_white,false);
    }
}

with(lavablock){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=40
    draw_roundrect_color(x-(radius/3)-15-global.glowoff-camx,y-radius-15-global.glowoff-camy,x+(16*image_xscale)+(radius/3)+15+global.glowoff-camx,y+radius+15+global.glowoff-camy,make_color_rgb(245,245,245),c_dkgray,false);
    draw_roundrect_color(x-(radius/3)-10-global.glowoff-camx,y-radius-10-global.glowoff-camy,x+(16*image_xscale)+(radius/3)+10+global.glowoff-camx,y+radius+10+global.glowoff-camy,make_color_rgb(175,175,175),c_gray,false);
    draw_roundrect_color(x-(radius/3)-global.glowoff-camx,y-radius-global.glowoff-camy,x+(16*image_xscale)+(radius/3)+global.glowoff-camx,y+radius+global.glowoff-camy,c_white,c_white,false);
}

with(firebar){

    xx=x-4 yy=y-8
    repeat (length) {
        xx+=lengthdir_x(8,angle) yy+=lengthdir_y(8,angle)
        camx = view_xview[j]
        camy = view_yview[j]
        radius=15
        draw_circle_color(round(xx)-camx,round(yy)-camy,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
        draw_circle_color(round(xx)-camx,round(yy)-camy,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
        draw_circle_color(round(xx)-camx,round(yy)-camy,radius+global.glowoff,c_white,c_white,false);
    }
}

with(checkpoint){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=50
    draw_circle_color(x-camx+8,y-camy,radius+20+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx+8,y-camy,radius+10+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx+8,y-camy,radius+global.glowoff,c_white,c_white,false);
}

/*with(item){
    camx = real(view_xview[j])
    camy = real(view_yview[j])
    radius=10
    draw_circle_color(x-camx,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}*/

with(starman){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=10
    draw_circle_color(x-camx,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(fireball){
    camx = real(view_xview[j])
    camy = real(view_yview[j])
    radius=10
    draw_circle_color(x-camx,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(orbifireball){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=10
    draw_circle_color(x-camx,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(firemissile){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=20
    draw_circle_color(x-camx-4*xsc,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx-4*xsc,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx-4*xsc,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(firemissilesmall){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=10
    draw_circle_color(x-camx+8,y-camy-4,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx+8,y-camy-4,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx+8,y-camy-4,radius+global.glowoff,c_white,c_white,false);
}

with(crabfireball){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=10
    draw_circle_color(x-camx,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(newtronfireball){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=10
    draw_circle_color(x-camx,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(bombfireball){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=10
    draw_circle_color(x-camx,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}


with(fireballplant){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=10
    draw_circle_color(x-camx,y-camy-8,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx,y-camy-8,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx,y-camy-8,radius+global.glowoff,c_white,c_white,false);
}

with(monitor){
    camx = view_xview[j]
    camy = view_yview[j]
    radius=15
    draw_circle_color(x-camx+8,y-camy,radius+5+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
    draw_circle_color(x-camx+8,y-camy,radius+2.5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
    draw_circle_color(x-camx+8,y-camy,radius+global.glowoff,c_white,c_white,false);
}

with(onoffscreen){
    if ((active) && real(type)==2) || real(type)!=2 {
        camx = view_xview[j]
        camy = view_yview[j]
        radius=40
        draw_circle_color(x-camx+8,y-camy,radius+10+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
        draw_circle_color(x-camx+8,y-camy,radius+5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
        draw_circle_color(x-camx+8,y-camy,radius+global.glowoff,c_white,c_white,false);
    }
}

with(timerblock){
    if (frm) {
        camx = view_xview[j]
        camy = view_yview[j]
        radius=20
        draw_circle_color(x-camx+8,y-camy,radius+10+global.glowoff,make_color_rgb(245,245,245),c_dkgray,false);
        draw_circle_color(x-camx+8,y-camy,radius+5+global.glowoff,make_color_rgb(175,175,175),c_gray,false);
        draw_circle_color(x-camx+8,y-camy,radius+global.glowoff,c_white,c_white,false);
    }
}

surface_reset_target();

draw_set_blend_mode(bm_normal);
j+=1;
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i,ii;
i=0;
repeat(global.mplay) {
    ii=string(i)
    sureface_free("lightsurface_"+ii);
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///Draw Dark Surface

with (gamemanager) { //Generate replay thumbnail here because dark area manager keeps covering the world in darkness
    if theyremakingamovie {
        makemoviethumb() //secret hud on movies fix simply dont draw the hud yet its easy
        theyremakingamovie=0
        with hudlayer event_user(0)
    }
}

ii=string(view_current);
//draw the surface to the position of the camera
draw_set_alpha(1)
draw_set_blend_mode(bm_subtract);

if sureface_exists("lightsurface_"+ii) {
    draw_surface_ext(sureface_get("lightsurface_"+ii),view_xview[view_current],view_yview[view_current],1,1,0,c_white,1)
}

draw_set_blend_mode(bm_normal);
