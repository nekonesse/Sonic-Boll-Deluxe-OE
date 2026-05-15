///lemonrunner()

/*

             LEMON
       File loader module
   initial v. renex nov/2018

*/
var offx,o,i,j,count,lg;

lg=lemongrab.id

with (spawner) {
    if (global.lemontest) {
        x=lg.tspawnx*16
        y=lg.tspawny*16+16
    } else {
        x=lg.spawnx*16
        y=lg.spawny*16+16
    }
}

offx=0
i=0
repeat (8) {
    with (instance_create(offx+lg.w[i]*16,0,regionmarker)) {
        type=lg.typeobj[i]
        typebg=lg.typebg[i]
        typemus=lg.typemus[i]
        typetime=lg.typetime[i]

        //Custom Music
        with (globalmanager) {
            if !ds_map_exists(mushandles, other.typemus) {
                musc+=1 mload[musc]=global.biome[i]
                musc+=1 mload[musc]=global.biome[i]+"fast"
                ds_map_add(mushandles, other.typemus, 0)
                ds_map_add(mushandles, other.typemus+"_filename", 0)
            }
            if (string(global.lemonlskin) != "" && string(global.lemonlskin) != "None") {
                if (!replacemusic(other.typemus, global.lemonlskin+"\music\"))
                    if (!replacemusic(other.typemus))
                        replacemusic(other.typemus, global.wbase+"\music\")
            } else if (string(global.exception) != "" && string(global.exception) != "0") {
                if (!replacemusic(other.typemus, global.exceptdir+"\music\"))
                    if (!replacemusic(other.typemus))
                        replacemusic(other.typemus, global.wbase+"\music\")
            } else if (!replacemusic(other.typemus))
                replacemusic(other.typemus, global.wbase+"\music\")
        }

        lefthand=offx
        ky=lg.h[i]*16+16
        water=(lg.h[i]-lg.water[i])*16+16
        horizon=(lg.h[i]-lg.horizon[i])*16
        bpm=lg.bpm[i]
        bpb=lg.bpb[i]
        lightlevel=lg.lightlevel[i]
        if horizon<=0 horizon=-verybignumber
        else horizon+=16
        if (water==16) {water=-16 with (instance_create(offx,0,barrier)) {image_xscale=(other.x-x)/16}}
    }

    var m, n;

    with (lg.gods[i]) {
        if obj {
            updatedeities(1)

            m = 0; n = 0;
            scalex = max(1, scalex); scaley = max(1, scaley)
            var _obj; _obj = obj;

            switch (obj) {
                case groundblock: _obj = ground;
                case ground:
                case phaser:
                case barrier:
                    o=instance_create(offx+x*16+off+off2x,y*16+off+off2y+16,_obj)
                    o.image_xscale = scalex;
                    o.image_yscale = scaley;
                break;

                case groundblock:
                default:
                    repeat (scalex) {
                        repeat (scaley) {
                            o=instance_create(offx+x*16+off+off2x+(m*16*_xsc),y*16+off+off2y+(n*16*_ysc)+16,obj)
                            if (obj == groundblock) o.scaled = 1;
                            count=lg.objlist[dataid,3]
                            if (count) {j=0 repeat (count) {variable_instance_set(o,lg.objlist[dataid,5+j],data[j]) j+=1}}
                            n += 1;
                        }
                        n = 0;
                        m += 1;
                    }
                break;
            }



            if (current_time>global.loadtime+64) loadtext()
        }
    }
    with (lg.waters[i]) {
        updatedeities(1)

        m = 0; n = 0;
        scalex = max(1, scalex); scaley = max(1, scaley)
        repeat (scalex) {
            repeat (scaley) {
                instance_create(offx+x*16+(m*16*_xsc),y*16+(n*16*_ysc)+16,waterblock)
                n += 1;
            }
            n = 0;
            m += 1;
        }

        if (current_time>global.loadtime+64) loadtext()
    }
    with (lg.semis[i]) {
        if obj {
            updatedeities(1)

            m = 0; n = 0;
            scalex = max(1, scalex); scaley = max(1, scaley)
            repeat (scalex) {
                repeat (scaley) {
                    instance_create(offx+x*16+(m*16*_xsc),y*16+(n*16*_ysc)+16,obj)
                    n += 1;
                }
                n = 0;
                m += 1;
            }

            if (current_time>global.loadtime+64) loadtext()
        }
    }
    with (lg.backs[i]) {
        if obj {
            updatedeities(1)

            m = 0; n = 0;
            scalex = max(1, scalex); scaley = max(1, scaley)

            if (obj == groundsemi) {
                o=instance_create(offx+x*16,y*16+16,obj)
                o.image_xscale = scalex;
                o.image_yscale = scaley;
            }

            repeat (scalex) {
                repeat (scaley) {
                    o=instance_create(offx+x*16+(m*16*_xsc),y*16+(n*16*_ysc)+16,obj)
                    if (obj == groundsemi) o.scaled = 1;
                    n += 1;
                }
                n = 0;
                m += 1;
            }

            if (current_time>global.loadtime+64) loadtext()
        }
    }

    j=0
    k=0
    repeat(72) {
        v=lg.cambitmap[i,k]
        v2=lg.cambitmap2[i,k]
        v3=lg.cambitmap3[i,k]
        b=128
        repeat (8) {
            if (j mod 24<lg.w[i]/25 && j div 24<lg.h[i]/14) {
                if (v & b) instance_create(offx+(j mod 24)*400,(j div 24)*224+16,camblock)
                if (v2 & b) instance_create(offx+(j mod 24)*400,(j div 24)*224+16,camsecret)
                if (v3 & b) instance_create(offx+(j mod 24)*400,(j div 24)*224+16,camsecret)
                b=b>>1
            }
            j+=1
        } k+=1
    }
    offx+=lg.w[i]*16+400
    i+=1
}

with (objcontainer) instance_destroy()
with (watercontainer) instance_destroy()
with (semicontainer) instance_destroy()
with (backcontainer) instance_destroy()
