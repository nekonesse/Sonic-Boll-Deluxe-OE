var noped;

if (respawncamslide) {
    view_xview[p2]=round(cosine(slidefromx,safevx,camslidec/50))
    view_yview[p2]=round(cosine(slidefromy,safevy,camslidec/50))
    viewx=view_xview[p2]
    viewy=view_yview[p2]
    ygoto=viewy+128
    camslidec+=1
    if (camslidec=50) {respawncamslide=0 camslidec=0}
}

lookgy=inch(lookgy,(crouch-lookup)*(80+120)*(!spindash && !left && !right),2)
if (abs(lookgy)<120 && sign(lookgy)!=(down-up)) lookgy=0
looky=inch(lookgy,0,120)

if (transform) {
    transform+=1
    if (transform=4) /*if oldtrans*/ frame=1
    if (transform=8) {
        playsfx(name+"super")
        if playsupermusic{
        mus_stop()
        global.music="super"
        mus_play(global.music,1,other.p2)}
        throwsparks(x,y)
        /*if oldtrans*/ frame=2
    }
    if (transform=12) {/*if oldtrans*/ frame=3 screenshake(x,8)}
    if (transform=16) /*if oldtrans*/ frame=2
    if (transform=20) /*if oldtrans*/ frame=3
    if (transform=28) /*if oldtrans*/ frame=4
    if (transform=36) /*if oldtrans*/ frame=5
    if (transform=48) {transform=0 piped=0 spriteswitch(1)}
}

if (grow) {gk+=1 if (gk>48) {grow=0 gk=0}}
if (flash) {fk+=1 if (fk>iframeslength) {flash=0 fk=0}}

fired=max(0,fired-1)
bonk=max(0,bonk-1) if (!bonk) bonkbrick = 0;
hitlok=max(0,hitlok-1)
hk=(hk+1) mod 8

hyperspeed=inch(hyperspeed,0,0.1)
gm8exspd=inch(gm8exspd,0,0.005)
if (vsp<7 || water) downpiped=0
if (!jump) canstopjump=1
else if (vsp>0) {canstopjump=0 if (sprung) {sprung=0 fall=1}}

heavened=checkforheaven()

//death by holes
if (pitdeath()) {
    if (skidding) {soundstop(name+"skid") skidding=0}
    if (ending!="") noped=1
    if (noped) {
        //"die"
        piped=1
        flash=0
        visible=0
        dead=1
        kek=instance_create(x,y,charmdeath)

        with (kek) {
            owner=other.id
            p2=owner.p2
            size=owner.size
            orig=owner
            xsc=esign(owner.hspeed,owner.xsc)
            sheets[size]=owner.sheets[owner.size]
            event="create"
            event_user(p2)
            charm_init()
            spriteswitch(1)
            if (playerskindat(slot,"3ddeath"+string(p2))) rotate=1
            shortsmallform=owner.shortsmallform
        }

        playsfx(name+"die")
        if (super) stopsuper(1,1)

        y=-verybignumber
    } else {
        //die
        piped=1
        flash=0
        visible=0
        if (heavened) {
            //exit coin heaven
            sprongin=120
            piped=1
            visible=0
        } else if (global.gamemode="battle" || global.gamemode="coop" || global.debug || global.lemontest) {
            //respawn
            if global.gamemode=="coop" dead=1
            hurt=1
            deaths+=1
            alarm[7]=120
            alarm[8]=60
            if (name="kid") reset=1
            kek=instance_create(x,y,charmdeath)

            with (kek) {
                owner=other.id
                p2=owner.p2
                size=owner.size
                orig=owner
                xsc=esign(owner.hspeed,owner.xsc)
                sheets[size]=owner.sheets[owner.size]
                event="create"
                event_user(p2)
                charm_init()
                spriteswitch(1)
                if (playerskindat(slot,"3ddeath"+string(p2))) rotate=1
                shortsmallform=owner.shortsmallform
            }

            playsfx(name+"die")
            dropcoins(1)
            if (super) stopsuper(1,1)
            else if (star  ) {with (instance_create(x,y,itemdrop)) {p2=other.p2 vspeed=min(-5,-other.vsp) hspeed=-esign(other.hsp,other.xsc) type="star" fuel=max(60,other.alarm[2])} star=0 alarm[2]=2}
            else if (size=7) {with (instance_create(x,y,itemdrop)) {p2=other.p2 vspeed=min(-5,-other.vsp) hspeed=-esign(other.hsp,other.xsc) type="glui"}}
            else if (size=6) {with (instance_create(x,y,itemdrop)) {p2=other.p2 vspeed=min(-5,-other.vsp) hspeed=-esign(other.hsp,other.xsc) type="btroot"}}
            else if (size=3) {with (instance_create(x,y,itemdrop)) {p2=other.p2 vspeed=min(-5,-other.vsp) hspeed=-esign(other.hsp,other.xsc) type="bfeather"}}
            else if (size=2) {with (instance_create(x,y,itemdrop)) {p2=other.p2 vspeed=min(-5,-other.vsp) hspeed=-esign(other.hsp,other.xsc) type="fflower"}}
            else if (size=1) {with (instance_create(x,y,itemdrop)) {p2=other.p2 vspeed=min(-5,-other.vsp) hspeed=-esign(other.hsp,other.xsc) type="mushroom"}}
            size=0
        } else {
            die()
            gamemanager.stop=1
        }
        y=-verybignumber
    }
}


//starman
mcs+=1
if (star || (super && abs(hsp)>2)) {
    mcs+=1
    sh+=1 if (sh=10) {
        if (star) {
            i=instance_create(x,y+((jump && !fall) || spin)*4+32-abs(32-diggity),stareffect)
            i.sheetshields=sheetshields
        }
        if (super && (abs(hsp)+abs(vsp))>2) with (instance_create(x,y+((jump && !fall) || spin)*4+32-abs(32-diggity),supereffect)) owner=other.id
        sh=0
    }
}

//air bubbles
if (water) {
    wbc+=1-hsp/10
    if (wbc>50) {
        wbc=0
        if !(size) && (unreal(skindat(name+" bubble offset x small"),0) || unreal(skindat(name+" bubble offset y small"),0))
        with(instance_create(x+(unreal(skindat(name+" bubble offset x small"),0)*xsc),y+unreal(skindat(name+" bubble offset y small"),0),airbubble)) {
            hspeed=-(other.hsp)+0.5*other.xsc
        }
        else
        with(instance_create(x+(unreal(skindat(name+" bubble offset x"),0)*xsc),y+unreal(skindat(name+" bubble offset y"),0),airbubble)) {
            hspeed=-(other.hsp)+0.5*other.xsc
        }
    }
}

if (!is_invincible("fire")) if (place_meeting(x,y,lavablock)) hurtplayer("lava")

//die to standing on damage sources
if (!jump) {

    coll=instance_place(x,y+1,sonicspike)
    if (coll && (coll.dir == 1 || coll.dir == 4)) && !is_intangible && !is_invincible("spike") {
        hurtplayer("spike")
    }

    if (place_meeting(x,y+1,muncher) &&!is_intangible&&!is_invincible("muncher")) {
        hurtplayer("muncher")
    }

    if (place_meeting(x,y+1,bigmuncher) &&!is_intangible&&!is_invincible("muncher")) {
        hurtplayer("muncher")
    }
}
if (place_meeting(x,y,spike)&&!is_intangible&&!is_invincible("spike")) hurtplayer("spike")

if (place_meeting(x,y,spikeball)&&!is_intangible&&!is_invincible("spike")) hurtplayer("spike")

o=instance_place(x,y,orbispikyball)
if (o.visible)&&(place_meeting(x,y,orbispikyball)&&!is_intangible&&!is_invincible("spike")) hurtplayer("spike")
