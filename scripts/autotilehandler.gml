//global.tiles=ds_priority_create()
with (regionmarker) event_user(0)

with (enemy) getregion(x)
with (hittable) getregion(x)
with (flag) getregion(x)
with (item) getregion(x)
with (crystaltap) getregion(x)
with (checkpoint) getregion(x)
with (spawner) getregion(x)
with (axe) getregion(x)
with (heaven) getregion(x)
with (cheepspawner) getregion(x)
with (bulletspawner) getregion(x)
with (bullseyespawner) getregion(x)
with (spring) getregion(x)
with (door) getregion(x)
with (warpbox) getregion(x)
with (axewall) getregion(x)
with (platdonut) getregion(x)
with (swinginghammer) getregion(x)

global.always_codeblock_count=0
with (code) event_user(0)
with (scriptblock) event_user(0)
with (customobject) event_user(0);
with (customobjectenemy) event_user(5);
with (customobjectcollider) event_user(0);
with (customobjectphaser) event_user(0);
with (customobjectbarrier) event_user(0);
with (customobjecthittable) event_user(5);
with (customobjectmoving) event_user(0);
with (customobjectmovingphaser) event_user(0);
with (activate_region) event_user(0)


with (mark) event_user(0)

with (itembox) event_user(7)
with (noteblock) event_user(7)
with (powblock) event_user(7)
with (platform) event_user(0)
with (cloudform) getregion(x)
with (pulley) event_user(0)
with (token) event_user(0)

with (player) player_camera(1)
with (enemy) event_user(10)
with (hittable) event_user(3)
with (lakitu) event_user(0)
with (podoboo) event_user(0)
with (chopper) event_user(4)
with (bowserboss) event_user(0)
with (finalwall) if (object_index=finalwall) event_user(0)
with (droptarget) event_user(0)
with (checkpoint) event_user(0)
with (jetstream) event_user(0)
with (enemydummy) event_user(0)
with (thwimp) event_user(0)
with (pokey) event_user(3)
with (spikenemy) event_user(0)

with (camsecret) y=-verybignumber
with (camblock) event_user(0)
with (camsecret) y=ystart

//Terrain Slopes
with (slopebox) event_user(0)

with (nslopl) event_user(0)
with (nslopr) event_user(0)
with (nslopl2) event_user(0)
with (nslopr2) event_user(0)
with (nsloplu) event_user(0)
with (nslopru) event_user(0)
with (nslopl2u) event_user(0)
with (nslopr2u) event_user(0)

//Semisolid Slopes
with (nslopls) event_user(0)
with (nsloprs) event_user(0)
with (nslopl2s) event_user(0)
with (nslopr2s) event_user(0)
with (nsloplus) event_user(0)
with (nsloprus) event_user(0)
with (nslopl2us) event_user(0)
with (nslopr2us) event_user(0)

//Background Slopes
with (nsloplb) event_user(0)
with (nsloprb) event_user(0)
with (nslopl2b) event_user(0)
with (nslopr2b) event_user(0)
with (nsloplub) event_user(0)
with (nsloprub) event_user(0)
with (nslopl2ub) event_user(0)
with (nslopr2ub) event_user(0)

with (bridgetile)    event_user(0)
with (cloudtile)    event_user(0)
with (phaser)        event_user(0) //these two were moved up to prevent phasers being in the same position
with (x1F0)          event_user(0)
with (slopy)         {event_user(0)}
with (fbarblock)     event_user(0)
with (groundback)    event_user(0)
with (vine)         event_user(0)
with (groundsemi)    event_user(0)
with (groundblock)   event_user(0)
with (crackedblock)   event_user(0)
with (fbarblock)     event_user(1)
with (vine)         event_user(1)
with (groundblock)   event_user(1)
with (crackedblock)   event_user(1)
with (grateblock)   event_user(1)
with (groundsemi)    event_user(1)
with (groundback)    event_user(1)

//new semisolid platform depth priority
var list,i;
list = ds_priority_create();
with(fakesemiplat) {
    ds_priority_add(list,id,y)
}

while(ds_priority_size(list)) {
    with(fakesemiplat) {
        if id==ds_priority_find_min(list) {
            event_user(1);
            ds_priority_delete_min(list);
        }
    }
}

ds_priority_destroy(list);

with (hardblock)     event_user(0)
with (bighardblock)     event_user(0)
with (bigbrick)     event_user(0)
with (coral)         event_user(0)
with (castleceiling) event_user(0)
global.levelendcount=0
with (flagpole)      event_user(0)
with (bridge)        event_user(0)
with (axe)           event_user(0)
with (axewall)       event_user(0)
with (treeblock)     event_user(0)
with (treeblock)     event_user(1)
with (treewall)      event_user(0)
with (mushblock)     event_user(0)
with (mushblock2)     event_user(0)
with (mushblock3)     event_user(0)
with (spike)         event_user(0)
with (sonicspike)       event_user(0)
with (sonicspike)       event_user(1)
with (fence)         event_user(0)
with (fence)         event_user(1)
with (textblock)     event_user(0)
with (tyler)         event_user(0)
with (terraintyler)  event_user(0)
with (objectstyler)  event_user(0)
with (decortyler)  event_user(0)
with (hillzone)     event_user(0)
with (fencezone)     event_user(0)
with (anchor)        event_user(0)
with (retainer)      event_user(0)
with (door)          event_user(0)
with (chardoor) event_user(0)
with (warpbox)       event_user(0)
with (cardreader)    event_user(0)
with (skullblock)    event_user(0)
with (skullbloff)    event_user(0)
with (beepblockon)    event_user(0)
with (beepblockoff)    event_user(0)

with (cannon)        event_user(0)
with (cannon)        event_user(1)
with (redcannon)        event_user(0)
with (redcannon)        event_user(1)


with (pipeblock) event_user(0)
with (sidepipe) event_user(0)
with (theothersidepipe) event_user(0)
with (pipetiler) event_user(0)

with (piranha) event_user(3)
with (shell) event_user(3)
with (bulletbill) event_user(0)
with (bullseyebill) event_user(0)
with (banzaibill) event_user(0)
with (cheepspawner) event_user(0)
with (bulletspawner) event_user(0)
with (bullseyespawner) event_user(0)

with (barrier) if (object_index=barrier) event_user(0)
with (axewall) event_user(0)

with (waterblock) event_user(0)

with (autotiler) instance_destroy()
with (spawncancel) instance_destroy()

with (button) getregion(x)
with (detector) getregion(x)
with (ireader) getregion(x)
with (spawnerblock) getregion(x)
with (gate) getregion(x)
with (sidegate) getregion(x)
with (signalblock) getregion(x)
with (terrainspring) getregion(x)
with (fireballshooter) getregion(x)
with (spikecrusher) getregion(x)
with (displayscreen) getregion(x)
with (gobble) getregion(x)

with (signalcommunicator) event_user(5);
with (button) event_user(2);
with (detector) event_user(2);
with (onoffscreen) event_user(5);
with (displayscreen) event_user(0);
with (variableblock) event_user(7);
with (channelmaster) event_user(4);
with (bopblock) event_user(5);
with (timerblock) event_user(6);
with (ireader) event_user(2);
with (gobble) event_user(2);
with (spawnerblock) event_user(5);
with (gate) event_user(0);
with (sidegate) event_user(0);
with (signalblock) event_user(0);
with (lightbulb) event_user(0);

with (terrainspring) event_user(0);
with (fireballshooter) event_user(0);
with (spikecrusher) event_user(0);
with (bubble) event_user(0);

with(logic_parent) event_user(0);

var l,t,uu,vv,u,v,w,h,b,batmap,bat,i;

/*grabtilesizes()

batmap=ds_map_create()
with (batchan) {
    d3d_model_primitive_begin(m,pr_trianglelist)
    tex=background_get_texture(sheet)
    vert=0
    ds_map_add(batmap,string(depth)+"|"+string(sheet),id)
}
i=0
repeat (ds_priority_size(global.tiles)) {

    b=ds_priority_delete_max(global.tiles)
    bat=ds_map_find_value(batmap,string(tile_get_depth(b))+"|"+string(tile_get_background(b)))

    u=tile_get_x(b)
    v=tile_get_y(b)
    l=tile_get_left(b)
    t=tile_get_top(b)
    w=tile_get_width(b)
    h=tile_get_height(b)
    biomebefore=biome

    found=0
    getregion(u)
    if biomebefore!=biome grabtilesizes()
    for (i=0;i<=global.biomes;i+=1){
        if bat.sheet=global.masterobjects[i] && !found {uu=ouu vv=ovv found=1}
        else if bat.sheet=global.master[i] && !found { uu=luu vv=lvv  found=1}
        else if bat.sheet=global.masterdecor[i] && !found {uu=tuu vv=tvv found=1} else if !found {uu=suu vv=svv}
    }


    d3d_model_vertex_texture_color(bat.m,u,v,0,l*uu,t*vv,$ffffff,1)
    d3d_model_vertex_texture_color(bat.m,u+w,v,0,(l+w)*uu,t*vv,$ffffff,1)
    d3d_model_vertex_texture_color(bat.m,u,v+h,0,l*uu,(t+h)*vv,$ffffff,1)
    d3d_model_vertex_texture_color(bat.m,u,v+h,0,l*uu,(t+h)*vv,$ffffff,1)
    d3d_model_vertex_texture_color(bat.m,u+w,v,0,(l+w)*uu,t*vv,$ffffff,1)
    d3d_model_vertex_texture_color(bat.m,u+w,v+h,0,(l+w)*uu,(t+h)*vv,$ffffff,1)
    bat.vert+=6 if (bat.vert>9000) {bat.vert=0 d3d_model_primitive_end(bat.m) d3d_model_primitive_begin(bat.m,pr_trianglelist)}
    if (current_time>global.loadtime+64) loadtext()
    tile_delete(b)
    i+=1
}

with (batchan) d3d_model_primitive_end(m)


ds_map_destroy(batmap)
ds_priority_destroy(global.tiles)
