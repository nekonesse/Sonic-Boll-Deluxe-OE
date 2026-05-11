//-S- here, this is changed due to the optimization made since it's now called within drawregion's event_user(7)

//test=1
//with(lemongrab.semis[drawregion.region]) {

//}


//with (deity) {
    image_xscale=1
    image_yscale=1

    switch (obj) {

    case slopel1: case sloper1: case usloper2: case uslopel2:
    case slopel1s : case obj=sloper1s: case uslopel2s: case obj=usloper2s:
    case slopel1b : case obj=sloper1b: case uslopel2b: case obj=usloper1b:
    case bighardblock: case obj=bigbrick:
        image_xscale=2
        image_yscale=2
    break;

    case slopel2: case sloper2: case usloper1: case uslopel1:
    case slopel2s: case obj=sloper2s: case uslopel1s: case obj=usloper1s:
    case slopel2b: case obj=sloper2b: case uslopel1b: case obj=usloper1b:
        image_yscale=2
    break;

    case banzailauncher:
        image_xscale=4
        image_yscale=5
    break;

    case dashpanel:
        image_xscale=2
    break;

    case (mark): {
        frame=0
        if (data[0]="clark") frame=1
        if (data[0]="tran") frame=2
    } break
    case (x1F0): {
        frame=0
        if (data[0]="1") frame=1
    } break

    case (monitor): {
        if (data[1]= "10coin") frame=0
        if (data[1]="mush") frame=1
        if (data[1]="fire") frame=2
        if (data[1]="star") frame=3
        if (data[1]="1up") frame=4
        if (data[1]="3up") frame=12
        if (data[1]="poison") frame=5
        if (data[1]="feather") frame=6
        if (data[1]="shield") frame=7
        if (data[1]="superring") frame=8
        if (data[1]="mini") frame=9
        if (data[1]="time") frame=11
    } break

    case (noteblock):{
        frame=0
        if data[1]="vine" frame=4
        if funnytruefalse(data[3]) frame=2
        if funnytruefalse(data[2]) frame+=1
    } break
    case (tyler): {
        var str, p;
        str=data[1]

        p=string_pos(",",str) l=unreal(string_copy(str,1,p-1),0)*8+8 str=string_delete(str,1,p)
        p=string_pos(",",str) t=unreal(string_copy(str,1,p-1),0)*8+8 str=string_delete(str,1,p)

        p=string_pos(",",str)
        w=unreal(string_copy(str,1,p-1),1)*8
        h=unreal(string_delete(str,1,p),1)*8

        str=data[0] p=string_pos(",",str)
        u=x*16+unreal(string_copy(str,1,p-1),0)*8
        v=y*16+unreal(string_delete(str,1,p),0)*8

        str=data[4] p=string_pos("x",str)
        ur=unreal(string_copy(str,1,p-1),0)
        vr=unreal(string_delete(str,1,p),0)

        flip=unreal(data[5],0)
        col=unreal(data[6],$ffffff)
        sheet=global.master[getbiomeid(lemongrab.typeobj[drawregion.region])]
    } break
    case (terraintyler): {
        var str, p;
        str=data[1]

        p=string_pos(",",str) l=unreal(string_copy(str,1,p-1),0)*8+8 str=string_delete(str,1,p)
        p=string_pos(",",str) t=unreal(string_copy(str,1,p-1),0)*8+8 str=string_delete(str,1,p)

        p=string_pos(",",str)
        w=unreal(string_copy(str,1,p-1),1)*8
        h=unreal(string_delete(str,1,p),1)*8

        str=data[0] p=string_pos(",",str)
        u=x*16+unreal(string_copy(str,1,p-1),0)*8
        v=y*16+unreal(string_delete(str,1,p),0)*8

        str=data[4] p=string_pos("x",str)
        ur=unreal(string_copy(str,1,p-1),0)
        vr=unreal(string_delete(str,1,p),0)

        flip=unreal(data[5],0)
        col=unreal(data[6],$ffffff)
        sheet=global.masterterrain[getbiomeid(lemongrab.typeobj[drawregion.region])]
    } break

    case (objectstyler): {
        var str, p;
        str=data[1]

        p=string_pos(",",str) l=unreal(string_copy(str,1,p-1),0)*8+8 str=string_delete(str,1,p)
        p=string_pos(",",str) t=unreal(string_copy(str,1,p-1),0)*8+8 str=string_delete(str,1,p)

        p=string_pos(",",str)
        w=unreal(string_copy(str,1,p-1),1)*8
        h=unreal(string_delete(str,1,p),1)*8

        str=data[0] p=string_pos(",",str)
        u=x*16+unreal(string_copy(str,1,p-1),0)*8
        v=y*16+unreal(string_delete(str,1,p),0)*8

        str=data[4] p=string_pos("x",str)
        ur=unreal(string_copy(str,1,p-1),0)
        vr=unreal(string_delete(str,1,p),0)

        flip=unreal(data[5],0)
        col=unreal(data[6],$ffffff)
        sheet=global.masterobjects[getbiomeid(lemongrab.typeobj[drawregion.region])]
    } break
    case (decortyler): {
        var str, p;
        str=data[1]

        p=string_pos(",",str) l=unreal(string_copy(str,1,p-1),0)*8+8 str=string_delete(str,1,p)
        p=string_pos(",",str) t=unreal(string_copy(str,1,p-1),0)*8+8 str=string_delete(str,1,p)

        p=string_pos(",",str)
        w=unreal(string_copy(str,1,p-1),1)*8
        h=unreal(string_delete(str,1,p),1)*8

        str=data[0] p=string_pos(",",str)
        u=x*16+unreal(string_copy(str,1,p-1),0)*8
        v=y*16+unreal(string_delete(str,1,p),0)*8

        str=data[4] p=string_pos("x",str)
        ur=unreal(string_copy(str,1,p-1),0)
        vr=unreal(string_delete(str,1,p),0)

        flip=unreal(data[5],0)
        col=unreal(data[6],$ffffff)
        sheet=global.masterdecor[getbiomeid(lemongrab.typeobj[drawregion.region])]
    } break
    case (spawncancel): {
        var find;
        find=noone
        var maxx;
        maxx=0
        with (drawregion.deity) if (x>maxx && x<other.x && y=other.y) if (obj=cheepspawner || obj=bulletspawner || obj=bullseyespawner || obj=lakitu) {
            maxx=x
            find=id
        }
        point=find
    } break
    case (textblock): {
        align=unreal(data[1])
        col=unreal(data[2])
    } break
    case (pipeblock):
    case (sidepipe):
    case (downpipe):
    case pipeblock || obj=sidepipe || obj=downpipe || obj=theothersidepipe:
        if (obj=pipeblock) mask_index=spr_mask2x1
        if (obj=theothersidepipe) image_yscale=2
        if (obj=downpipe) mask_index=spr_mask2x1
        if (obj=sidepipe) image_yscale=2
        point=noone
        if (data[1]!="") with (drawregion.deity) if (obj=pipeblock || obj=sidepipe || obj=downpipe || obj=theothersidepipe || obj=droptarget) if (data[0]=other.data[1]) other.point=id
    break;
    case (door): {
        point=noone
        if (data[1]!="") with (drawregion.deity) if (obj=door) if (data[0]=other.data[1]) other.point=id
        if (data[4]!="0") {frame=2}
        else if (data[3]!="0") {keyed=1 frame=1}
        else {keyed=0 frame=0}
    } break
    case (warpbox): {
        point=noone
        if (data[1]!="") with (drawregion.deity) if (obj=warpbox) if (data[0]=other.data[1]) other.point=id
        if (data[4]="1") {
            frame=1
            keyed=1
        }
        else {
            frame=0
            keyed=0
        }
    } break
    case (waterblock): {
        w=unreal(data[0],1)
        h=unreal(data[1],1)
    } break
    case (axe): {
        var d, maxx;
        point=noone
        maxx=verybignumber
        with (drawregion.deity) if (obj=bridge) {d=point_distance(x,y,other.x,other.y) if (d<maxx) {maxx=d other.point=id}}
    } break
    case (axewall): {
        var d, maxx;
        point=noone
        maxx=verybignumber
        with (drawregion.deity) if (obj=axe) {d=point_distance(x,y,other.x,other.y) if (d<maxx) {maxx=d other.point=id}}
    } break
    case (fbarblock): {
        long=(data[1]="long")
        fire=(data[1]!="off")
        clock=(data[2]="1")
    } break

    /*if (anchor) { //hi -S- orange is bugging me to fix this Please Help
        tex=0
        for (i=1;i<=global.asset[0,0];i+=1) {
           if global.asset[i,8]=data[0]{if global.biome[max(0,global.asset[i,9])]=lemongrab.typeobj[drawregion.region] biomefound=1}
           if (global.asset[i,8]=data[0] && (global.biome[max(0,global.asset[i,9])]=lemongrab.typeobj[drawregion.region] ||  (!biomefound && global.asset[i,9]=69) || global.asset[i,9]=-1)) {

                tex=global.asset[i,0]
                w=sprite_get_width(tex)
                fh=round(sprite_get_height(tex)/global.asset[i,4])
                dx=global.asset[i,2]+x*16-floor(w/2)+8
                dy=global.asset[i,3]+y*16-fh+8
            }
        }
        if (data[1]!="") {
            p=string_pos(",",data[1])
            if (p!=0) {
                ofx=unreal(string_copy(data[1],1,p-1),0)
                ofy=unreal(string_delete(data[1],1,p),0)
            }
        }
    }*/
    case (spike): {
        frame=min(4,unreal(data[2],4))
    } break
    case (sonicspike): {
        frame=min(4,unreal(data[1],4))
    } break
    case (lavablock): {
        frame=0
        with (instance_position(x,y-1,object_index)) if (obj=lavablock) other.frame=1
    } break
    case (phaser): {
        frame=0
        if (data[0]="-1") frame=1
        if (data[0]="1") frame=2
        if (data[0]="2") frame=3
    } break

    case (bumper): {
        if (data[1]= "0") frame=0
        if (data[1]="1") frame=1
    } break

    case (itemlaunch): {
        if (data[1]="mushroom") frame=0
        if (data[1]="shard") frame=1
        if (data[1]="1up") frame=2
        if (data[1]="star") frame=3
        if (data[1]="flower") frame=4
        if (data[1]="poison") frame=5
        if (data[1]="coin") frame=6
        if (data[1]="mini") frame=7
        if (data[1]="shield") frame=8
        if (data[1]="token") frame=9
        if (data[1]="tokenblue") frame=10
    } break
    case (shell): {
        if (data[0]="0") frame=0
        if (data[0]="1") frame=1
        if (data[0]="2") frame=2
        if (data[0]="3") frame=3
    } break
    case (singlecheep): {
        if (data[0]="0") frame=0
        if (data[0]="1") frame=1
        if (data[0]="2") frame=2
    } break
    case (montymole): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
    } break
    case (platdonut): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
    } break
    case (itembox): {
        spr=spr_box frame=0
        if (data[3]="1") frame=1
        if (data[2]="1") frame+=2
        if (data[1]="none") frame=4
    } break
    case (platform): {
        spr=spr_platform frame=0
        if (data[2]="1") frame=2
        if (data[1]="plat3") spr=spr_plat3
        if (data[1]="cloudform") frame=1
        if (data[1]="donut") spr=spr_donut
        if (data[1]="pulley") {
            var maxx;
            sub=noone
            maxx=verybignumber
            with (drawregion.deity) if (obj=platform && x<maxx) if (data[1]="pulley_sub") {other.sub=id maxx=x}
            height=unreal(data[3],0)
        }
    } break
    case (turing): {
        var p;
        p=string_pos(",",data[0])
        srcx=unreal(string_copy(data[0],1,p-1),0)+x
        srcy=unreal(string_delete(data[0],1,p),0)+y

        p=string_pos(",",data[1])
        dstx=unreal(string_copy(data[1],1,p-1),0)+x
        dsty=unreal(string_delete(data[1],1,p),0)+y

        if (srcx==x && srcy==y) mode=1 else mode=2
        if (srcx==dstx && srcy==dsty) {
            mode=0
            if (srcx!=x || srcy!=y) mode=3
        }
        if (mode=2 && dstx==x && dsty==y) mode=4

        frame=mode
    }  break
    case (flagpole): {
        frame=(data[1]=="1")
    } break

    case (ballcannon): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
        if (data[1]="2") frame=2
        if (data[1]="3") frame=3
        if (data[1]="4") frame=4
        if (data[1]="5") frame=5
        if (data[1]="6") frame=6
        if (data[1]="7") frame=7
    } break

    case (redballcannon): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
        if (data[1]="2") frame=2
        if (data[1]="3") frame=3
        if (data[1]="4") frame=4
        if (data[1]="5") frame=5
        if (data[1]="6") frame=6
        if (data[1]="7") frame=7
    } break

    case (ballcannonquad): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
    } break

    case (redballcannonquad): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
    } break

    case (fakesemiplat): {
        if (data[3]="0") {frame=0  col=c_red}
        if (data[3]="1") {frame=1 col=c_yellow}
        if (data[3]="2") {frame=2 col=c_blue}
    } break

    case (bigitembox): {
        image_xscale=3
        spr=spr_bigbox frame=0
        if (data[1]="none") frame=2
    } break

    case (terrainspring): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
        if (data[1]="2") frame=2
        if (data[1]="3") frame=3
        if (data[1]="4") frame=4
        if (data[1]="5") frame=5
        if (data[1]="6") frame=6
        if (data[1]="7") frame=7
    } break

    case (terrainsprong): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
        if (data[1]="2") frame=2
        if (data[1]="3") frame=3
        if (data[1]="4") frame=4
        if (data[1]="5") frame=5
        if (data[1]="6") frame=6
        if (data[1]="7") frame=7
    } break

    case (signalcommunicator): {
        if (data[7]="0") frame=0
        if (data[7]="1") frame=1
        if (data[7]="2") frame=2
        if (data[7]="3") frame=3
        if (data[7]="4") frame=4
        if (data[7]="5") frame=5
    } break

    case (detector): {
        if (data[2]="0") {col=c_red}
        if (data[2]="1") {col=c_blue}
        if (data[2]="2") {col=c_orange}
        if (data[2]="3") {col=c_yellow}
        if (data[2]="4") {col=c_red}
    } break
    case (gate):
    case (sidegate): {
        col=$003872
    } break
    case (onoffscreen): {
        if (data[5]="0") frame=0
        if (data[5]="1") frame=1
        if (data[5]="2") frame=2
    } break

    case (variableblock): {
        if (data[6]!="2") frame=0 else frame=1
    } break

    case (ireader): {
        var p;
        p=string_pos(",",data[0])
        srcx=unreal(string_copy(data[0],1,p-1),0)+x
        srcy=unreal(string_delete(data[0],1,p),0)+y
    } break

    case (gobble): {
        var p;
        p=string_pos(",",data[0])
        srcx=unreal(string_copy(data[0],1,p-1),0)+x
        srcy=unreal(string_delete(data[0],1,p),0)+y
        p=string_pos(",",data[1])
        srcx2=unreal(string_copy(data[1],1,p-1),0)+x
        srcy2=unreal(string_delete(data[1],1,p),0)+y
        if (data[2]="0") frame=0
        if (data[2]="1") frame=1
        if (data[2]="2") frame=2
    } break

    case (bombenemy): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
        if (data[1]="2") frame=2
    } break

    case (signalblock): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
    } break

    case (swinginghammer): {
        if (data[1]="0") frame=0
        if (data[1]="90") frame=1
        if (data[1]="180") frame=2
        if (data[1]="270") frame=3
    } break

    case (lightbulb): {
        if (data[1]="ellipse") frame=0
        if (data[1]="square") frame=1
        if (data[1]="spotlight") frame=2
    } break

    case (fireballshooter): {
        if (data[1]="0") frame=0
        if (data[1]="1") frame=1
        if (data[1]="2") frame=2
        if (data[1]="3") frame=3
    } break

    case (token):
        frame = min(unreal(data[1],0),2) //all these other objects doing a whole lotta ifs for something that could be 1 line :p
    }
//}

if (new) {
    x-=verybignumber
    if (place_meeting(xstart,y,drawregion.deity)) instance_destroy()
    x+=verybignumber
    new=0
}

/*with (deity) if (new) {
    x-=verybignumber
    if (place_meeting(xstart,y,drawregion.deity)) instance_destroy()
    x+=verybignumber
    new=0
}

with (lemongrab.waters[drawregion.region]) test=0
with (lemongrab.semis[drawregion.region]) test=0
with (lemongrab.backs[drawregion.region]) test=0

with (regionbutton) if (n=drawregion.region) empty=test*/
