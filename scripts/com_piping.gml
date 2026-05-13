if (piped || hurt || teleport) exit

pipeid=noone
pipeid2=noone
if ((!jump||canpipejump)&&!spindash) {
    if (down || diggity=1) {
        pipeid=instance_place(x,y+4,pipeblock)
        if (pipeid) if ((pipeid.t || pipeid.warp) && y<pipeid.y && (diggity=1 || abs(x-pipeid.x)<8)) pipe=2
    }
    if (!pipe && !diggity) {
        pipeid=instance_place(x+4,y,sidepipe)
        if (pipeid && right) {if ((pipeid.t || pipeid.warp) && x<pipeid.x && abs(y-(pipeid.y+12))<16) {pipe=1 xsc=1}}
        else {
            pipeid=instance_place(x-4,y,theothersidepipe)
            if (pipeid && left) if ((pipeid.t || pipeid.warp) && x>pipeid.x+16 && abs(y-(pipeid.y+12))<16) {pipe=1 xsc=-1}
        }
    }
}

if (up && !pipe) {
    if (jump) {
        pipeid=instance_place(x,y-4,downpipe)
        if (pipeid) if ((pipeid.t || pipeid.warp) && y>pipeid.y && (abs(x-pipeid.x)<8)) pipe=3
    } else if position_meeting(x,y+8,door) {
        pipeid=instance_position(x,y+8,door)
        if (pipeid) if ((pipeid.t || pipeid.warp) && abs(x-(pipeid.x+8))<4 && !pipeid.oneway) {
            if (!pipeid.key && (!funnytruefalse(pipeid.is_pdoor) || pipeid.switched) ||
               (pipeid.locktype=="key" && count_owned(keyfollow)>=pipeid.key) && (!funnytruefalse(pipeid.is_pdoor) || pipeid.switched) ||
               (pipeid.locktype=="token" && gamemanager.tokens>=pipeid.key) && (!funnytruefalse(pipeid.is_pdoor) || pipeid.switched) ||
               (pipeid.locktype=="tokenblue" && global.tokens>=pipeid.key) && (!funnytruefalse(pipeid.is_pdoor) || pipeid.switched) ||
               (pipeid.locktype=="tokengreen" && pipeid.greentoken==1) && (!funnytruefalse(pipeid.is_pdoor) || pipeid.switched)
            ) {
                pipe=4
                with (pipeid) if (key) {
                    if (locktype == "key") {
                        repeat (key) {
                            o=other.follower
                            while (o.follower) o=o.follower
                            if (o) with (o) {follow.follower=noone instance_destroy() instance_create(x,y,smoke)}
                        }
                    }
                    else if (locktype == "token") gamemanager.tokens-=key
                    else if (locktype == "tokenblue") {global.tokens-=key repeat(key) spendtoken()}
                    else if (locktype == "tokengreen") settings("token " + name + " " + chr(187) + pack,2)

                    key=0
                    with (instance_create(x,y-8,smoke)) {direction=135 speed=2 friction=0.1}
                    with (instance_create(x+16,y-8,smoke)) {direction=45 speed=2 friction=0.1}
                    with (instance_create(x,y+8,smoke)) {direction=225 speed=2 friction=0.1}
                    with (instance_create(x+16,y+8,smoke)) {direction=315 speed=2 friction=0.1}
                    instance_create(x+8,y,kickpart)
                }
            } else if (!oup) sound("itemblockbump")
        }
    } else if position_meeting(x,y+8,chardoor) {
        pipeid=instance_position(x,y+8,chardoor)
        if (pipeid) if ((pipeid.t || pipeid.warp) && abs(x-(pipeid.x+8))<4) {
            pipe=5
            pipeid.pid=id
        }
    }
}

if (pipe) {
    if (pipe=1) type="side"
    if (pipe=2) type="down"
    if (pipe=3) type="up"
    if (pipe=4) type="door"
    if (pipe=5) type="chardoor"

    piped=1
    flash=0
    frspd=1
    frame=0
    dy=0
    hyperspeed=0
    gm8exspd=0
    canstopjump=0
    sprung=0
    fastpipe=0
    if (pipeid.warp) warppipe=1

    if (type="door" || type="chardoor") {
        pipeid.open=1
        hsp=0 vsp=0
        sound("itemdoor")
        pipeid.alarm[0]=40
        set_sprite("doorenter")
    }
    if (type="down") {
        fall=5
        who_put_SHIT_in_my_PIP=1
        vspeed=(bbox_bottom-bbox_top)/30
        if !fastpipe set_sprite("piping")
        //frame=skindat("vicfr")-1
    }
    if (type="up") {
        fall=5
        who_put_SHIT_in_my_PIP=1
        vspeed=-(bbox_bottom-bbox_top)/30
        if !fastpipe set_sprite("pipingup")
        //frame=skindat("vicfr")-1
    } else if (type!="side" || jump=0) {
        pollenated=0
    }
    if (type="side") {
        hspeed=max((bbox_right-bbox_left)/30,hsp*xsc)*xsc
        y=pipeid.y+15
        alarm[6]=ceil(24/abs(hspeed))
        if !fastpipe set_sprite("sidepiping")
        frspd=0.5
    }
    charm_run("enterpipe")

    if type!="door" && type!="chardoor" {
    depth=1000001
    sound("itempipe",0,1+0.26*fastpipe)
    }
}
