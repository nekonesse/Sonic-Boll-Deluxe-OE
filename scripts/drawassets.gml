//makeassets()
//initializes assets inside asset anchors

if (settings("removeassets")) {
    instance_activate_object(anchor)
    with(anchor) {
        instance_destroy();
    }
    exit;
}


var j,i,spr,w,h,fh,hw,top,dx,dy,type,ab,blend,ifounditshutyobitchassmouth;
global.hassprite=0
instance_activate_object(anchor)
if instance_exists(anchor)
for (j=1;j<=global.asset[0,0];j+=1) {
    i=global.assetz[j]
    if (global.asset[i,8]!="" && global.asset[i,1]=0) {


        spr=global.asset[i,0]

        dx=global.asset[i,2]
        dy=global.asset[i,3]
        anim=global.asset[i,4]
        anim2=global.asset[i,7]
        type=global.asset[i,8]

        if i!=1
        global.hassprite=0

        ab=global.asset[i,9]
        blend=global.asset[i,10]
        w=global.asset[i,11]
        h=global.asset[i,12]

        biomefoundforasset=0
        if global.asset[i,4]<=1 noanimasset=1 else noanimasset=0

        fh=round(h/global.asset[i,4])

        top=fh*floor((bgmanager.animcarl*global.asset[i,7]) mod global.asset[i,4])
        hw=floor(w/2)
        if (blend=1) draw_set_blend_mode(bm_add)
        if (blend=2) draw_set_blend_mode(bm_subtract)

        ifounditshutyobitchassmouth=0
        with (anchor){
            if ((biome=ab) && name=type) {
                if !global.hassprite {
                    if background_exists(ds_map_get(global.assetmap,type)) {
                        ds_map_set(global.assetmap,type,background_add(spr,1,0))
                    }
                    global.assetsprite=ds_map_get(global.assetmap,type)
                    global.hassprite=1
                }
                ifounditshutyobitchassmouth=1
                global.asset[i,11]=background_get_width(global.assetsprite)
                global.asset[i,12]=background_get_height(global.assetsprite)
                w=global.asset[i,11]
                h=global.asset[i,12]
                hw=floor(w/2)
                fh=round(h/global.asset[i,4])
                if other.noanimasset {
                    other.createmyasshole=1
                    other.createx=x+dx-hw
                    other.createy=y+dy-h
                    with (other) {
                        if createmyasshole {
                            createmyasshole=0
                            bruhmoment=noone
                            bruhmoment=instance_create(createx,createy,assethelper)
                            if (global.asset[i,5]) {
                                bruhmoment.depth=-100;
                            }
                            bruhmoment.spr=global.assetsprite
                            bruhmoment.sprite_index=spr_mask1x1
                            bruhmoment.image_xscale=global.asset[i,11]
                            bruhmoment.image_yscale=global.asset[i,12]
                            bruhmoment.w=w
                            bruhmoment.h=h
                            bruhmoment.dx=dx
                            bruhmoment.hw=hw
                            bruhmoment.dy=dy
                        }
                    }
                } else {
                    other.createmyasshole=1
                    other.createx=x
                    other.createy=y
                    //dude why
                    with (other) {
                        if createmyasshole {
                            createmyasshole=0
                            bruhmoment=noone
                            bruhmoment=instance_create(createx,createy,assethelperanim)
                            if (global.asset[i,5]) {
                                bruhmoment.depth=-100;
                            }
                            bruhmoment.myass2=anim2
                            bruhmoment.myass1=anim
                            bruhmoment.spr=global.assetsprite
                            bruhmoment.sprite_index=spr_mask1x1
                            bruhmoment.image_xscale=global.asset[i,11]
                            bruhmoment.image_yscale=global.asset[i,12]
                            bruhmoment.top=top
                            bruhmoment.w=w
                            bruhmoment.fh=fh
                            bruhmoment.dx=dx
                            bruhmoment.hw=hw
                            bruhmoment.dy=dy
                        }
                    }
                }
                instance_destroy()
                biomefoundforasset=1
            }
        }
        if !ifounditshutyobitchassmouth
        with (anchor){
            if ((ab=69||ab=-1) && name=type && biomefoundforasset=0 ) {
                if !global.hassprite {
                    if background_exists(ds_map_get(global.assetmap,type)) {
                        ds_map_set(global.assetmap,type,background_add(spr,1,0))
                    }
                    global.assetsprite=ds_map_get(global.assetmap,type)
                    global.hassprite=1
                }
                global.asset[i,11]=background_get_width(global.assetsprite)
                global.asset[i,12]=background_get_height(global.assetsprite)
                w=global.asset[i,11]
                h=global.asset[i,12]
                hw=floor(w/2)
                fh=round(h/global.asset[i,4])
                if other.noanimasset {
                    other.createmyasshole=1
                    other.createx=x+dx-hw
                    other.createy=y+dy-h
                    with (other) {
                        if createmyasshole {
                            createmyasshole=0
                            bruhmoment=noone
                            bruhmoment=instance_create(createx,createy,assethelper)
                            if (global.asset[i,5]) {
                                bruhmoment.depth=-100;
                            }
                            bruhmoment.spr=global.assetsprite
                            bruhmoment.sprite_index=spr_mask1x1
                            bruhmoment.image_xscale=global.asset[i,11]
                            bruhmoment.image_yscale=global.asset[i,12]
                            bruhmoment.w=w
                            bruhmoment.h=h
                            bruhmoment.dx=dx
                            bruhmoment.hw=hw
                            bruhmoment.dy=dy
                        }
                    }
                } else {
                    other.createmyasshole=1
                    other.createx=x
                    other.createy=y
                    with (other) {
                        if createmyasshole {
                            createmyasshole=0
                            bruhmoment=noone
                            bruhmoment=instance_create(createx,createy,assethelperanim)
                            if (global.asset[i,5]) {
                                bruhmoment.depth=-100;
                            }
                            bruhmoment.myass2=anim2
                            bruhmoment.myass1=anim
                            bruhmoment.spr=global.assetsprite
                            bruhmoment.sprite_index=spr_mask1x1
                            bruhmoment.image_xscale=global.asset[i,11]
                            bruhmoment.image_yscale=global.asset[i,12]
                            bruhmoment.top=top
                            bruhmoment.w=w
                            bruhmoment.fh=fh
                            bruhmoment.dx=dx
                            bruhmoment.hw=hw
                            bruhmoment.dy=dy
                        }
                    }
                }
                instance_destroy()
            }
        }


         if (blend) draw_set_blend_mode(0)
    }
}
