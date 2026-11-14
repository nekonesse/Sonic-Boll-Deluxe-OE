#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tex1=sprite_get_texture(tex_clouds,0)
tex2=sprite_get_texture(tex_introground,0)

alarm[0]=180

xx=random(32)
yy=random(32)
x2=random(32768)
x3=random(32768)

s=1
surf=-1

starfield=d3d_model_create()
d3d_model_primitive_begin(starfield,pr_trianglelist)
repeat (300) {
    col=make_color_rgb(255,255,irandom_range(128,255))
    sx=random_range(-300,300)
    sy=random_range(-300,300)
    d3d_model_vertex_color(starfield,sx,sy,0,col,0.4)
    d3d_model_vertex_color(starfield,sx+2,sy,0,col,0.4)
    d3d_model_vertex_color(starfield,sx,sy+2,0,col,0.4)
    d3d_model_vertex_color(starfield,sx,sy+2,0,col,0.4)
    d3d_model_vertex_color(starfield,sx+2,sy,0,col,0.4)
    d3d_model_vertex_color(starfield,sx+2,sy+2,0,col,0.4)
}
d3d_model_primitive_end(starfield)
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
surf=sureface("mode7",800,448)

if (sureface_set_target("mode7")) {
    xx-=0.002
    yy-=0.004
    zz-=0.1

    if (xx<0) xx+=1/s
    if (yy<0) yy+=1/s

    x2=(x2+0.016) mod 1
    x3=(x3+1) mod 256

    //if (introctrl.classic) {col1=$bbbbbb col2=$bbbbbb}
    /*else*/ {col1=$404000 col2=$aaaa00}

    //DRAW SKY
    texture_set_interpolation(!introctrl.craft)
    d3d_set_projection_ortho(0,0,400,224,0)
    draw_sprite_stretched(tex_sky,3-introctrl.classic,0,0,401,112)
    //

    //DRAW STARS
    d3d_transform_add_rotation_z(zz)
    d3d_transform_add_translation(200,96,0)
    d3d_model_draw(starfield,0,0,0,-1)
    d3d_transform_set_identity()
    //

    //DRAW CLOUDS
    texture_set_repeat(1)
    d3d_set_projection_ext(0,0,0,0,-10,3,0,0,-1,105,400/224,1,1000)
    draw_set_blend_mode(bm_add)
    d3d_primitive_begin_texture(pr_trianglestrip,tex1)
        d3d_vertex_texture_color(-70,-40,-5,xx*s,-yy*s,$d1b09b,0)
        d3d_vertex_texture_color(70,-40,-5,(xx+lengthdir_x(2.5,30))*s,-(yy+lengthdir_y(2.5,30))*s,$d1b09b,0)
        d3d_vertex_texture_color(-70,-5,-5,(xx+lengthdir_x(2.5,300))*s,-(yy+lengthdir_y(2.5,300))*s,$d1b09b,1)
        d3d_vertex_texture_color(70,-5,-5,(xx+lengthdir_x(2.5,30)+lengthdir_x(2.5,300))*s,-(yy+lengthdir_y(2.5,30)+lengthdir_y(2.5,300))*s,$d1b09b,1)
    d3d_primitive_end()
    draw_set_blend_mode(0)
    //



    //DRAW BACKGROUND HILLS
    texture_set_repeat(0)
    d3d_set_projection_ortho(0,0,400,224,0)
    d3d_transform_set_identity()
    with(introbackgroundhill2) event_perform(ev_draw,0);
    with(introbackgroundhill) event_perform(ev_draw,0);
    d3d_set_projection_ext(0,0,0,0,-10,3,0,0,-1,105,400/224,1,1000)
    texture_set_repeat(1)
    //

    //DRAW 3D GROUND
    d3d_primitive_begin_texture(pr_trianglestrip,tex2)
        d3d_vertex_texture_color(-70,-30,5,x2,0,col1,1)
        d3d_vertex_texture_color(-70,0,5,x2,8,col2,1)
        d3d_vertex_texture_color(70,-30,5,x2-16,0,col1,1)
        d3d_vertex_texture_color(70,0,5,x2-16,8,col2,1)
    d3d_primitive_end()
    texture_set_interpolation(0)
    //

    d3d_set_projection_ortho(0,0,400,224,0)
    draw_set_blend_mode(bm_subtract)
    with (introslide) draw_ellipse_color(x-20+hspeed,y,x+20+hspeed,y+(16*((y-100)/112)),$2b2b2b,0,0)
    draw_set_blend_mode(bm_add)
    rect(0,0,400,224,0,1)
    draw_set_blend_mode(0)

    surface_reset_target()
}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sureface_free("mode7")

d3d_model_destroy(starfield)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sureface_exists("mode7")) draw_surface_stretched(surf,0,0,400,224)
