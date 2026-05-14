var ref; ref=id

if (go=1) yoff=16
else yoff=-8

if (go=-1) {
    bumpspringstack()
    coll=instance_place(x,y-16,coin)
    if (coll) {
        fresh=1
        if (owner.name="kid" && coll.object_index!=redcoin) with (coll) {with (instance_create(x,y,itemdrop)) {hspeed=myrand(2)-1 vspeed=(2+myrand(2))*ref.go drop=0 type="coinup"} instance_destroy()}
        else with (coll) {joe=other.owner with (instance_create(x,y,coinup)) {other.red=(other.object_index=redcoin) red=other.red active=other.active p2=other.joe.p2 fresh=other.fresh vspeed=-1.5+2*ref.go if (!red) give_item(other.joe,"coin") else gibcoinred(other.joe)} instance_destroy()}
    }
    if (object_index=brick) {
        coll=instance_place(x,y-16,monitor)
        if (coll) with (coll) {fall=1 vspeed=-2}
    }
}
if (go=1) {
    coll=instance_place(x,y+16,coin)
    if (coll) {
        fresh=1
        if (owner.name="kid" && coll.object_index!=redcoin) with (coll) {with (instance_create(x,y,itemdrop)) {hspeed=myrand(2)-1 vspeed=(2+myrand(2))*ref.go drop=0 type="coinup"} instance_destroy()}
        else with (coll) {joe=other.owner with (instance_create(x,y,coinup)) {other.red=(other.object_index=redcoin) red=other.red active=other.active p2=other.joe.p2 fresh=other.fresh vspeed=-1.5+2*ref.go if (!red) give_item(other.joe,"coin") else gibcoinred(other.joe)} instance_destroy()}
    }
}

image_yscale=0.5
coll=instance_place(x,y+yoff,player)
if (coll && coll!=owner && coll.pvp_avoid=0) with (coll) {if (!hurt && !flash && !piped && power_lv<2) fragplayer(other.owner)}

coll=instance_place(x,y+yoff,item)
if (coll) if (coll.c && (coll.object_index=mushroom || coll.object_index=lifemush || coll.object_index=mushpoison || coll.object_index=starman)) if (!coll.getimer) {coll.vspeed=2.5*go coll.c=1 coll.drop=0 coll.hspeed=esign(coll.x-(x+8),1)}

coll=instance_place(x,y+yoff,litbobomb)
if (coll) {with (coll) {sound("enemykick") vspeed=-2.5 hspeed=esign(x-(other.x+8),1)}}

coll=instance_place(x,y+yoff,enemy)
image_yscale=1

if (coll) {
    if (coll.object_index=goomba || coll.object_index=paragoomba) with (coll) {doscore_e(800,id) sound("enemykick") if brat {with (instance_create(x,y,goombratdead)) {hspeed*=esign(x-ref.x,1) biome=other.biome}} else {with (instance_create(x,y,goombadead)) {hspeed*=esign(x-ref.x,1) biome=other.biome}} instance_destroy() with (other.owner) enemyc+=1}
    if (coll.object_index=koopa || coll.object_index=redkoopa || coll.object_index=yelkoopa || coll.object_index=blukoopa || coll.object_index=hopkoopa || coll.object_index=beetle || coll.object_index=spiny) with (coll) {
        sound("enemykick")
        doscore_e(800,id)
        hspeed=esign(x-(other.x+8),1)
        if (hspeed=0) hspeed=1
        heorng=instance_create(x,y,shell)
        owner=other.owner
        if (other.go=-1) with (heorng) {hspeed=other.hspeed owner=other.owner vspeed=-2.5 stop=1 flip=1}
        else with (heorng) {owner=other.owner spd=3 hspeed=spd*esign(other.hspeed,x-owner.x) kicked=1 stop=0 phase=owner}
        if (object_index=redkoopa) heorng.type="red"
        if (object_index=blukoopa) {heorng.type="blu" heorng.enemy2=1}
        if (object_index=yelkoopa) {heorng.type="yel" heorng.enemy2=1}
        if (object_index=beetle) heorng.type="beetle"
        if (object_index=spiny) heorng.type="spiny"
        heorng.ysc=-1
        instance_destroy()
    }
    if (coll.object_index=hammerbro || coll.object_index=firebro || coll.object_index=boomerangbro) with (coll) {
        sound("enemykick")
        doscore_e(1000,id)
        with (instance_create(x,y,genericdead)) {
            hspeed=1
            vspeed=-2
            switch (other.object_index) {
                case firebro: {
                    type="firebrodead"
                break}
                case boomerangbro: {
                    type="boomerangbrodead"
                break}
                default: {
                    type="hammerbrodead"
                }
            }
            if type!="hammerbrodead" enemy2=1
            biome=other.biome
        }
        instance_destroy()
    }
    if (coll.object_index=piranha || coll.object_index=firepiranha) if (coll.active) {
        doscore_e(800,id) with (coll) {sound("enemykick") instance_create(x,y-8,smoke) instance_destroy()}
    }
    if (coll.object_index=shell) {
        if (!coll.kicked && !coll.stop) {
            doscore_e(800,coll)
            coll.owner=owner
            if (go=-1) {
                coll.vspeed=-2.5
                coll.hspeed=esign(coll.x-(x+8),1)
                coll.stop=1
            } else {
                coll.spd=3
                coll.hspeed=coll.spd*esign(coll.x-(x+8),1)
                coll.kicked=1
                coll.stop=0
                coll.phase=owner
            }
        }
    }
    if (coll.object_index=drybones) {
        if !coll.unfresh doscore_e(800,id)
        with coll {
            sound("enemykick")
            with instance_create(x,y,drydead) {
                xsc=other.xsc
                if other.vspeed!=0 {
                    drop=1
                    vspeed=other.vspeed
                }
                powner=other.powner
            }
            instance_destroy()
        }
    }
    if (coll.object_index=bombshellkoopa) {
        doscore_e(800,id)
        with coll {
            sound("enemykick")
            bmb=instance_create(x,y,bombshell)
            if other.go=-1 {
                bmb.vspeed=-2.5
            }
            instance_destroy()
        }
    }
    if (coll.object_index=montymole) {
        doscore_e(800,id)
        with coll {
            sound("enemykick")
            hspeed=esign(x-(other.x+8),1)
            with instance_create(x,y,genericdead) {
                vspeed=-2.5
                hspeed=other.hspeed
                type="montydead"
                enemy2=1
                biome=other.biome
            }
            instance_destroy()
        }
    }
    if (coll.object_index=rexbig || coll.object_index=rexsmall) {
        doscore_e(800+200*(coll.object_index=rexbig),id)
        with coll {
            hspeed=esign(x-(other.x+8),1)
            sound("enemykick")
            with instance_create(x,y,genericdead) {
                vspeed=-2.5
                hspeed=other.hspeed
                type="rexdead"
                if other.object_index=rexsmall type="rexsmalldead"
                enemy2=1
                biome=other.biome
            }
            instance_destroy()
        }
    }
    if (coll.object_index=bobomb) {
        doscore_e(800,id)
        with coll {
            sound("enemykick")
            hspeed=esign(x-(other.x+8),1)
            with instance_create(x,y,litbobomb) {
                xsc=other.xsc
                vspeed=-2.5
                hspeed=other.hspeed
            }
            instance_destroy()
        }
    }
    if (coll.object_index=spikenemy) {
        doscore_e(800,id)
        with coll {
            sound("enemykick")
            hspeed=esign(x-(other.x+8),1)
            with instance_create(x,y,genericdead) {
                hspeed=other.hspeed
                vspeed=-2.5
                type="spikedead"
                enemy2=1
                biome=other.biome
            }
            instance_destroy()
        }
    }
    if (coll.object_index=pokey || coll.object_index=pokeybody) {
        with coll { //in case you're wondering why pokeys don't die from bumping, they're weirdly OP in Boll and the head doesn't work properly anyway
            sound("enemykick")
            hspeed=abs(hspeed)*esign(x-(other.x+8),1)
            vspeed=-2.5
        }
    }
    if (coll.object_index=crabmeat || coll.object_index=bombenemy) {
        doscore_e(800,id)
        with coll {
            sound("enemykick")
            instance_create(x,y,badniksmoke)
            instance_destroy()
        }
    }
}
