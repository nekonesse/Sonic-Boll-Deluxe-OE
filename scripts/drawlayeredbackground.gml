var vx,bw,p,t,name,water,horizon,dy,curr,i,repeats,yv;

curr=argument[1]

with (bgmanager) {

    d3d_set_projection_perspective(view_xview[curr],view_yview[curr]+224,400,-224,0)
    d3d_set_depth(0)

    horizon=gamemanager.horizon[curr]
    water=gamemanager.water[curr]+4
    dy=view_yview[curr]
    yv=view_yview[curr] //view_yview apparently messes up special stage rendering. Lol
                        //SIDENOTE: would like a Chat with whoever used view_yview instead of view_yview[curr] like 8 times in this script??
    if (instance_exists(moranboll)) {horizon=0 water=0 bgname="specialsky" dy=0 yv=0}
    else bgname=gamemanager.players[curr].region.typebg + gamemanager.players[curr].region.typetime + "sky"

    if !skindat("bg_"+bgname) bgname=gamemanager.players[curr].region.typebg + "sky"

    maxslot=skindat("ms_"+bgname)
    if settings("removeassets") maxslot=0
    //if (horizon+316<view_yview[curr]) maxslot=-1 //Commented this out 'cause it keeps making the below bg disappear lol -moster
    
    for (i=0;i<=maxslot;i+=1) {
        name=bgname+string(i)     
        spr=skindat("tex_"+name)
        if (spr) if (skindat("fg_"+name)=argument[0]) {
            bw=skindat("texw_"+name)
            bh=skindat("texh_"+name)        
            ani=skindat("af_"+name)
            a3d=skindat("3d_"+name)
            of=skindat("of_"+name)
            px=skindat("px_"+name)
            sc=skindat("sc_"+name)
            py=skindat("py_"+name)
            vsc=skindat("vsc_"+name)
            vloop=skindat("vloop_"+name)
            attach=skindat("attach_"+name)
            
            fh=bh/ani
            hpan=skindat("minshpan_"+name)
            xvm=max(gamemanager.origin[curr],view_xview[curr])
            if hpan==0
            vx=floor(
                xvm-max(0,((xvm-offmoran-gamemanager.origin[curr])*((global.fuzzy * sign(px)) + px)+global.bgscroll*sc) mod bw )
            ) else{           
                kx=abs((gamemanager.origin[curr])-(gamemanager.righthand[curr]))
                diff_kx=max(hpan*400-(kx),0)
                vx=1-( (xvm+diff_kx)/max(0.01, max(kx,hpan*400)-400) )*max(0,bw-400) 
                vx+=floor(view_xview[curr])
                vx-=1
            }
            p=0
            
            if (instance_exists(moranboll)) {
                ky=256
            } else {
                ky=gamemanager.ky[curr]               
            }
            min_scroll_screen=skindat("minsvpan_"+name)
            force_min_scroll=skindat("forceminvscreen_"+name)
            anim_frame=((animbob mod max(1,ani)+1)*fh)
            
            yvm=min(horizon-224,view_yview[curr] )            
            if force_min_scroll {yvm=max(yvm,min_scroll_screen*224) ky=min_scroll_screen*224 } //YAHOO

            diff_ky=max(min_scroll_screen*224-horizon,0)
            
            
            
            vertf=224
            if vloop!=0
                vertf-=(yvm-max(0, (yvm*py+global.bgscroll*vsc) mod fh)) mod fh           
            else{
                if horizon<=240 {} //Single screen is an edgecase the formula can't handle.
                else vertf+=( 1- (yvm+diff_ky)/max(0.01, max(horizon,min_scroll_screen*224)-224) )*max(0,fh-224)
            }
            vertf=floor(vertf)
            bm=skindat("bm_"+name)
            if (bm==1) draw_set_blend_mode(bm_add)
            else if (bm==2) draw_set_blend_mode(bm_subtract)

            if attach==2 && abs(yv-horizon)<224 {of+=(224-abs(yv-horizon))}
            else if attach==1 && abs(yv-horizon)<224{
                of+=(224-abs(yv-horizon))*0.75+((224-abs(yv-horizon))/224)*0.25/(max(0.01,fh-224)*2)
            }


            if !(lowdetail && bm){

                vrepeats=max((ceil(224/fh)+!(py==0 && vsc==0))*(vloop!=0),1) //it has to be at least 1 or else nothing is drawn!

                repeats= max((ceil(400/bw)+!(px==0 && sc==0)+!!a3d*2) *(hpan=0),1) //did this because I could swear the repeat function probably does this calculation per repeat. (i'm probably wrong)
                repeat (vrepeats){ 
                    repeat (repeats) {
                        if (a3d!=0) {                      
                            d3d_transform_add_rotation_x(a3d)
                            d3d_transform_add_translation(-a3d,view_yview[curr]+224-of,0) //The -a3d is purely there because 3d sucks ass :thumbsup:
                            texture_set_interpolation(1)
                            draw_sprite(spr,0,vx+p,-((animbob mod max(1,ani)+1)*fh))
                            texture_set_interpolation(0)
                            d3d_transform_set_identity() 
                        } else {
                        if !instance_exists(moranboll){
                        
                            //If you're a not a fg piece draw normally.
                            if !argument[0] {

                                draw_sprite(spr,0,vx+p,view_yview[curr]+vertf-of-anim_frame)
                            }else { //HOWEVER. if you are one, dont draw below the trans line you mf.
                                t=max(0,horizon-(dy+vertf-of-fh))
                                if t>=0 draw_sprite_part(spr,0,0,(anim_frame-fh),bw,min(t,bh),vx+p,view_yview[curr]+vertf-of-fh)
                            }
                        }else
                        draw_sprite(spr,0,vx+p,view_yview[curr]+(224-((animbob mod max(1,ani)+1)*fh)+(1-(dy+(224+6))/(ky))*max(0,fh-224)))
                        }
                        p+=bw
                    }
                    p=0
                    of-=fh
                }
            }
            if (bm) draw_set_blend_mode(0)
        }
    }
    if !(horizon>=ky)
    draw_below(argument[0],argument[1])
    if (water<yv+224) {
    if (instance_exists(moranboll)) {bgname="specialsky" dy=0}
    else bgname=gamemanager.players[curr].region.typebg+"water"

        maxslot=skindat("ms_"+bgname)
        for (i=0;i<=maxslot;i+=1) {
            name=bgname+string(i)
            spr=skindat("tex_"+name)
            if (spr) if (skindat("fg_"+name)=argument[0]) {
                bw=skindat("texw_"+name)
                bh=skindat("texh_"+name)
                ani=skindat("af_"+name)
                of=skindat("of_"+name)
                px=skindat("px_"+name)
                sc=skindat("sc_"+name)
                py=skindat("py_"+name)
                vsc=skindat("vsc_"+name)
                vloop=skindat("vloop_"+name)
                attach=skindat("attach_"+name)



                if settings("removeassets") && i>2 i=maxslot
                fh=bh/ani
                hpan=skindat("minshpan_"+name)
                xvm=max(gamemanager.origin[curr],view_xview[curr])
                if hpan==0
                vx=floor(
                    xvm-max(0,((xvm-offmoran-gamemanager.origin[curr])*((global.fuzzy * sign(px)) + px)+global.bgscroll*sc) mod bw )
                ) else{
                    kx=abs((gamemanager.origin[curr])-(gamemanager.righthand[curr]))
                    diff_kx=max(hpan*400-(kx),0)
                    vx=1-( (xvm+diff_kx)/max(0.01, max(kx,hpan*400)-400) )*max(0,bw-400)
                    vx+=floor(view_xview[curr])
                    vx-=1
                }
                p=0

                if (instance_exists(moranboll)) {
                    ky=512
                } else {
                    ky=gamemanager.ky[curr]
                }

                //We want the below bg's vertical parallax point to be water-224, so all variables relative to 0 have to change to represent this.
                min_scroll_screen=skindat("minsvpan_"+name)
                force_min_scroll=skindat("forceminvscreen_"+name)
                anim_frame=((animbob mod max(1,ani)+1)*fh)
                            
                yvm=max(water,view_yview[curr] )-water
                if force_min_scroll {yvm=min(yvm,min_scroll_screen*224-water) ky=min_scroll_screen*224+water } //YAHOO
            
                
                
                vertf=224
                if vloop!=0
                vertf+=(yvm-max(0, (yvm*py+global.bgscroll*vsc) mod fh)) mod fh
                else{
                    if ky<=240 vertf+=max(0,fh-224) //Single screen is an edgecase the formula can't handle.
                    else vertf+=(1-(yvm)/max(0.01, (max(ky-water,min_scroll_screen*224)-224)))*max(0,fh-224)
                }
                vertf=floor(vertf)

                bm=skindat("bm_"+name)
                if (bm=1) draw_set_blend_mode(bm_add)
                else if (bm==2) draw_set_blend_mode(bm_subtract)

                if attach==2 && abs(yv-water)<224 && yv<=water {of+=(abs(yv-water))}
                else if attach && abs(yv-water)<224 && yv<=water
                of+=(abs(yv-water))*0.75+((abs(yv-water))/224)*0.25/(max(0.01,fh-224)*2)

                if !(lowdetail && bm){
                    if vloop
                        vrepeats=(ceil(224/fh)+1) //it has to be at least 1 or else nothing is drawn!
                    else vrepeats=1
                    repeats= max((ceil(400/bw)+!(px==0 && sc==0)) *(hpan=0),1) //did this because I could swear the repeat function probably does this calculation per repeat. (i'm probably wrong)
                    repeat (vrepeats){ 
                        repeat (repeats*vrepeats) {
                            t=max(0,water-(yv+vertf+of-fh))
                            if (t<fh) draw_sprite_part(spr,0,0,t+(anim_frame-fh),bw,fh-t,vx+p,yv+vertf+t+of-fh)                
                            p+=bw
                        }
                        p=0
                        of+=fh
                    }
                }
                if (bm) draw_set_blend_mode(0)
            }
        }
    }
    d3d_set_projection_ortho(view_xview[curr],view_yview[curr],400,224,0) 
}
