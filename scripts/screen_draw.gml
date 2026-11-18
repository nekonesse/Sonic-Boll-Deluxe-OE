if !global.frameskipreal {
    global.frameskip-=1
    if global.frameskip=0 {global.frameskip=global.frameskipreal  exit}
}
//wrap up rendering once the last view is done
for (i=0;i<4;i+=1) {
    if (view_current==i) {
        //slam alpha
        draw_set_blend_mode(bm_add)
        rect(0,0,global.w,global.h,0,1)
        draw_set_blend_mode(0)
    }

    if (view_visible[i]) {
        view_last=i
    }
}

if (view_current=view_last) {
    /*skipframe=!skipframe
    if skipframe exit*/
    if instance_exists(editmanager) exit
    if instance_exists(specialectrl) exit
    //reset screenshake
    with (gamemanager) for (i=0;i<global.mplay;i+=1) view_yview[i]=memy[i]
    d3d_set_projection_ortho(0,0,global.w,global.h,0)
    draw_set_blend_mode(0)
    surface_reset_target()

    //process pending screenshot operation
    if (screenshot) {
        screenshot=0
        system_screenshot(0)
    }
    //apply fullscreen filtering
    filter=(global.vapor || settings("dequanto")==3)
    dq=settings("dequanto")


    if (room=title) if (introctrl.classicm) {
        dequanto=sureface("dequanto",global.w*3,global.h*3)
        if (!sureface_set_target("dequanto")) exit
        draw_surface_ext(appsurf,0,0,1,1,0,$040404,1)
        surface_reset_target()
        if (!sureface_set_target("appsurf")) exit
        draw_clear_alpha(0,1)
        draw_set_blend_mode(bm_add)
        repeat (64) draw_surface(dequanto,0,0)
        draw_set_blend_mode(0)
        surface_reset_target()
    }

    draw=appsurf
    full=settings("fullscreen")
    if (full) {
        if (dq==1) {
            dequanto=sureface("dequanto",global.w*3,global.h*3)
            if (!sureface_set_target("dequanto")) exit
            d3d_set_projection_ortho(0,0,global.w*3,global.h*3,0)
            draw_surface_stretched(appsurf,0,0,global.w*3,global.h*3)
            surface_reset_target()
            draw=dequanto
        }
    }

    lw=global.w*global.s
    lh=global.h*global.s
    if !global.set_projectionshitttie
    d3d_set_projection_ortho(0,0,lw,lh,0)

    if (filter || global.fuzzy) {
        rect(0,0,lw,lh,0,0.4)
        draw_set_blend_mode(bm_add)
    } else draw_clear_alpha(0,1)

    if (dq>1 || ( dq==1 && frac(global.s)!=0)) texture_set_interpolation(1)

    //process screen flip if enabled
    mirror=0
    if (room=game) if (skindat("left")) mirror=1
    if (mirror) {
        //fix for pixel wonkiness
        u=1/lw
        v=1/lh
        if (filter) {
            c=color_mult($ff99c1,$80ff)
            draw_primitive_begin_texture(pr_trianglestrip,surface_get_texture(draw))
            draw_vertex_texture_color(0,0,1,0,c,0.5)
            draw_vertex_texture_color(lw,0,0-u,0,c,0.5)
            draw_vertex_texture_color(0,lh,1,1+v,c,0.5)
            draw_vertex_texture_color(lw,lh,0-u,1+v,c,0.5)
            draw_primitive_end()
            c=color_mult($ff99c1,$ff8000)
            draw_primitive_begin_texture(pr_trianglestrip,surface_get_texture(draw))
            draw_vertex_texture_color(global.s,0,1,0,c,0.5)
            draw_vertex_texture_color(lw+global.s,0,0-u,0,c,0.5)
            draw_vertex_texture_color(global.s,lh,1,1+v,c,0.5)
            draw_vertex_texture_color(lw+global.s,lh,0-u,1+v,c,0.5)
            draw_primitive_end()
        } else {
            draw_primitive_begin_texture(pr_trianglestrip,surface_get_texture(draw))
            draw_vertex_texture(0,0,1,0)
            draw_vertex_texture(lw,0,0-u,0)
            draw_vertex_texture(0,lh,1,1+v)
            draw_vertex_texture(lw,lh,0-u,1+v)
            draw_primitive_end()
        }
    } else if (global.fuzzy || filter) {
        if (filter) {
            draw_surface_stretched_ext(draw,global.vaporkek*global.s*0.5,0,lw,lh,color_mult($ff99c1,$80ff),0.8)
            draw_surface_stretched_ext(draw,global.vaporkek*global.s*0.5+global.s,0,lw,lh,color_mult($ff99c1,$ff8000),0.8)
        }
        if (global.fuzzy) {
            draw_surface_stretched_ext(draw,0,0,lw,lh,make_color_hsv(30+32*sin(global.bgscroll/100),100,255),0.15)
            draw_surface_stretched_ext(draw,-2+2*sin(global.bgscroll/91)*sin(global.bgscroll/24),-2+2*sin(global.bgscroll/72)*sin(global.bgscroll/28),lw+8+2*sin(global.bgscroll/85)*sin(global.bgscroll/35),lh+8+2*sin(global.bgscroll/64)*sin(global.bgscroll/31),merge_color(0,$ffffff,room_speed/60),0.2)
            draw_surface_stretched_ext(draw,-100,-100,lw+200,lh+200,$ff0000,0.04)
        }
    } else {
        draw_surface_stretched(draw,0,0,lw,lh)
    }

    draw_set_blend_mode(0)

    if (filter) {
        global.vaporkek=!global.vaporkek
        draw_sprite_stretched(spr_scanline,0,0,-global.vaporkek*(lh/224),lw,lh)
        draw_sprite_stretched(spr_introborder,0,0,0,lw,lh)
        draw_set_blend_mode(bm_subtract)
        draw_circle_color(lw/2,lh/2,lw*0.75,0,$606060,0)
        draw_set_blend_mode(bm_add)
        rect(0,0,lw,lh,0,1)
        draw_set_blend_mode(0)
    }

    texture_set_interpolation(0)

    //the minecraft title screen text renders in native resolution
    with (text1080) event_user(0)
    if global.playerbecomesmall with player {
    savex=x
    savey=y
    x=(x-view_xview[view_current])*global.s y=(y-view_yview[view_current])*global.s

    spriteswitch(0) if (star) ssw_shield("star") else if (shielded) ssw_shield("shield")
    y=savey
    x=savex

    shader_reset()
    }
}
