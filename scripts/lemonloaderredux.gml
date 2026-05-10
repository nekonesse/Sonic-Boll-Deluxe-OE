///lemonloaderredux()
//loads a redux 1.5 level because i already added redux 1.4 support and 1.5 uses the exact same internal version and im not about to magically predict whether the goomba you placed is a goombrat or a galoomba thatll get converted into a goomba anyway

global.levelname=lemongrab.levelname
global.leveldesc=lemongrab.leveldesc
global.time=lemongrab.time

l=lemongrab.length

//read regions
if (readstring()!="[reg]") {show_message("can't find region marker") exit}
r=0
repeat (8) {
    if (readstring()!="[rg"+string(r+1)+"]") {show_message("can't find region "+string(r+1)) exit}
    deity=lemongrab.gods[r]
    water=lemongrab.waters[r]
    biomemod = 0
    lemongrab.typeobj[r]=convert193biome(readstring(),0) //really hope i got this right loll
    lemongrab.typebg[r]=convert193biome(readstring(),1)
    lemongrab.typemus[r]=convert193biome(readstring(),2)
    lemongrab.typetime[r]="day"
    w=readshort()
    h=readshort()
    size=w*h
    lemongrab.w[r]=w
    lemongrab.h[r]=h
    i=0
    repeat (72) {
        lemongrab.cambitmap[r,i]=readbyte()
        lemongrab.cambitmap2[r,i]=readbyte()
        i+=1
    }

    lemongrab.horizon[r]=0
    lemongrab.water[r]=0
    if (biomemod == 2 || biomemod == 3) lemongrab.water[r]=lemongrab.h[r]-1
    else if (biomemod) lemongrab.horizon[r]=lemongrab.h[r]+1
    if (biomemod == 3) lemongrab.horizon[r]=lemongrab.h[r]+1

    //read entities
    test=1
    if (readstring()!="[nty]") {show_message("can't find entity marker") exit}
    repeat (readbyte()) {
        test=0
        str=readstring()
        obj=editname2obj(str,1)
        if (obj=-1) {
            //this object is unknown, so let's skip loading it
            ent=readbyte()
            repeat (readuint()) {
                readbyte()
                readushort()
                if (ent) repeat (8) readstring()
            }
            show_debug_message("lemon: can't find object called "+qt+str+qt)
        } else {
            i=1 repeat l {if (obj=lemongrab.objlist[i,0]) {spr=lemongrab.objlist[i,1] off=lemongrab.objlist[i,2] did=i break} i+=1}
            ent=readbyte()
            repeat (readuint()) {
                //read one entity
                b=readbyte()
                b=(b<<16)+readushort()
                i=instance_create(b>>12,b&$fff,deity)
                i.obj=obj
                i.spr=spr
                i.off=off  
                i.dataid=did
                if (ent) {
                    k=0 repeat (8) {i.data[k]=readstring() k+=1}
                    
                    if (obj==coral) {
                        if (i.data[0] == "4") instance_destroy_id(i) //Zero Coin
                        else {i.data[0]="0,0" i.obj=itemring}
                    }
                    
                    if (string(lemongrab.objlist[did,5]) = "align") {    
                        if obj=fbarblock||obj=itembox||obj=monitor||obj=itemlaunch||obj=crate||obj=phaser||obj=brick||obj=fakesemiplat||obj=warpbox||obj=door { //fix objects getting align much later
                            var al;
                            al=7 repeat (8) {i.data[al+1]=i.data[al] al-=1}
                            i.data[0]="0"
                        }
                        
                        if (i.data[0]="1") i.data[0]="-8,0"
                        else i.data[0]="0,0"
                        unpack_align(i)
                    }
                }
                
                //lemon data converter for forward porting 1.9 objects
                
                if (obj=fbarblock) {
                    i.data[4]="6"
                    if (i.data[1]=="long") {i.data[1]="normal" i.data[4]="12"}
                }
                if (obj==itembox || obj==bigitembox || obj=noteblock) {
                    if (i.data[1] == "moon") i.data[1]="moon"
                    if (i.data[1] == "bros" && obj!=itembox) i.data[1]=""
                    if (i.data[1] == "floorclock" || i.data[1] == "plusclock" || i.data[1] == "greenplusclock") {i.data[1]="time" i.obj=monitor}
                    if (i.data[1] == "rotten" || i.data[1] == "demon") i.data[1] = "poison"
                    if (i.data[1] == "dotter") i.data="mini"
                    if (i.data[1] == "undotter") i.data="item"
                    if (i.data[2] == "2" || i.data[2] == "3" && obj==itembox) i.data[2] = "1" //convert Flipblocked and Crated to Bricked
                    
                }
                
                if (obj==tyler) {
                    i.data[0]=i.data[0]+","+i.data[1]
                    i.data[1]=i.data[2]
                    i.data[2]=i.data[3]
                    i.data[3]=i.data[4]
                    i.data[4]=i.data[5]+"x"+i.data[6]
                    i.data[5]=i.data[7]
                    i.data[6]="#ffffff"
                    if (string_length(i.data[4])<3) i.data[4]="1x1"
                }                 
                if (obj==itemlaunch) {                
                    //convert old drop item spawners into loose items
                    if (i.data[2]="1") {
                        if (i.data[1]="mushroom" || i.data[1]="undotter") i.obj=mushroom
                        if (i.data[1]="flower") i.obj=flower
                        if (i.data[1]="1up" || i.data[1]="3up") i.obj=lifemush
                        if (i.data[1]="star") i.obj=starman
                        if (i.data[1]="poison" || i.data[1]=="rotten" || i.data[1]=="demon") i.obj=mushpoison
                        if (i.data[1]="shard") i.obj=starshard
                        if (i.data[1]="coin") i.obj=coin
                        if (i.data[1]="tap") i.obj=crystaltap
                        if (i.data[1]="key") i.obj=keyitem
                        if (i.data[1]="dotter") i.obj=mushmini
                        if (i.data[1]="shield") i.obj=shield
                    } else {
                        if (i.data[1]="3up") i.data[1]="1up"
                        if (i.data[1]="rotten" || i.data[1]="demon") i.data[1]="poison"
                        if (i.data[1]="tap") i.obj=crystaltap
                        if (i.data[1]="key") i.obj=keyitem
                        if (i.data[1]="undotter") i.data[1]="mushroom"
                        if (i.data[1]="dotter") i.data[1]="mini"
                    }
                    if (i.data[1]="floorclock" || i.data[1]="plusclock" || i.data[1]="greenplusclock") {i.obj=monitor i.data[1]="time"}
                }
                
                // Sonic Boll Redux I remember you're Turning All Of The Enemy And Object Types Into Data As Well As Adding Tabs To Lemon... no hate but this is gonna be a cruel list LOL
                // my favourite part of redux is the part where i keep adding support for 1.5 and then 1.5 still doesnt even use the functionality i just added support for so i look stupid now for porting unused functionality and then stupid again later because when 1.5 releases it won't work
                
                if (obj==monitor) {
                    if (i.data[1]=="coin") i.data[1]="10coin"
                    if (i.data[1]=="flour") i.data[1]="fire"
                    if (i.data[1]=="ring") i.data[1]="superring"
                    if (i.data[1]=="dotter") i.data[1]="mini"
                    if (i.data[1]=="undotter") i.data[1]="mush"
                    if (i.data[1]=="moon") i.data[1]="3up"
                    if (i.data[1]=="life") i.data[1]="1up"
                    if (i.data[1]=="shard") {i.data[1]="" i.obj=starshard}
                    if (i.data[1]=="banana") i.data[1]="thenewitems"
                    
                }
                if (obj==crate) {
                    if (i.data[1]=="item") i.data[1]="flower"
                    if (i.data[1]=="coins") i.data[1]="coin"
                    if (i.data[1]=="moon") i.data[1]="3up"
                    if (i.data[1]=="life") i.data[1]="1up"
                    if (i.data[1]=="rotten" || i.data[1]=="demon") i.data[1]="poison"
                    if (i.data[1]=="vine") i.data[1]="spring"
                    if (i.data[1]=="dotter") i.data[1]="mini"
                    if (i.data[1]=="undotter") i.data[1]="mush"
                }
                if (obj==goomba) { //All of your galoombas are gone goodbye.
                    if i.data[1]="1" i.obj=paragoomba
                    if i.data[1]="2" || i.data[1]="7" i.obj=rexbig
                    if i.data[1]="4" || i.data[1]="6" i.obj=goombrat
                    if i.data[1]="5" i.obj=paragoombrat

                }
                if (obj==koopa) {
                    if i.data[1]="1" i.obj=redkoopa //jolly video game nerd This game is redkoopamazing!
                    if i.data[1]="2" i.obj=yelkoopa
                    if i.data[1]="3" i.obj=blukoopa
                    if i.data[1]="4" i.obj=drybones
                    if i.data[1]="5" i.obj=bombshellkoopa
                }
                if (obj==hopkoopa) {
                    if i.data[1]="1" i.obj=redhover
                    if i.data[1]="2" i.obj=yelhover
                    if i.data[1]="3" i.obj=bluhover
                }
                if (obj==orbinautgreen) {
                    if i.data[1]="1" i.obj=orbinautred
                    if i.data[1]="2" i.obj=orbinautblue
                    if i.data[1]="3" i.obj=orbinautbumper
                }
                if (obj==checkpoint) {
                    if i.data[1]=="" {
                        i.data[0]="-8,16"
                        i.data[1]="0"
                        i.data[2]="0"
                        unpack_align(i)
                    }
                }
                if (obj==coin) { //techically speaking i don't even need to do this here because redux 1.5 itself doesn't convert 1.4.2 levels anyway and coins with data don't work in 1.5 but idc
                    if i.data[1]="1" i.obj=redcoin
                    if i.data[1]="2" { //is it technically cheating to convert something to a modded item?     absolutely yes it is but i dont care Create Your Own P-switch blue coin
                        i.obj=coin
                        if (global.bluecoin_p && object_exists(global.bluecoin_p))
                            i.obj=global.bluecoin_p
                    }
                    if i.data[1]="3" i.obj=itemring
                    if i.data[1]="4" i.obj=keyitem //uhnuhnuh nono the thing in my script is definitely Not unused types
                }
                if (obj==shell) {
                    if (unreal(i.data[0]) > 1) { //convert yellow and blue shell to green and red because apparently boll deluxe just does not have placeable yellow and blue shells.
                        i.data[0]=string(unreal(i.data[0])-2)
                    }
                }
                if (obj==platform) {
                    if (i.data[1] == "donut") {i.data[1]="0" i.obj=platdonut}
                    if (i.data[1] == "cloud") {i.data[1]="0" i.obj=cloudtile}
                }
                if (obj==hammerbro) {
                    if (i.data[1] == "1") {i.obj=firebro i.data[1]="1"}
                    if (i.data[1] == "2") {i.obj=boomerangbro i.data[1]="1"}
                    if (i.data[1] == "3") i.data[1]="2" //just to screw people over "banana bros" convert to enraged hammer bros LOLL
                    if (i.data[1] == "0") i.data[1]="1"
                }
                
                if (obj==groundsemi) {
                    o=instance_create(i.x,i.y,lemongrab.semis[r])
                    o.obj=obj
                    with (i) instance_destroy()
                }  
                if (obj==groundback) {
                    w=unreal(i.data[0],1)
                    h=unreal(i.data[1],1)
                    var u,v;
                    repeat (w) {
                        repeat(h) {
                            if (i.x+u<lemongrab.w[r] && i.y+v<lemongrab.h[r]) {
                                o=instance_create(i.x+u,i.y+v,lemongrab.backs[r])
                                o.obj=obj
                            }
                            v+=1
                        } v=0 u+=1
                    }
                    with (i) instance_destroy()
                }  
                
                if (obj == token) {
                    i.data[0]="0,0"
                    i.data[1]="1"
                }
                if (obj==door) {
                    i.data[6]="tokenblue"
                }
                if (obj==warpbox) {
                    i.data[4]="0"
                    i.data[5]="0"
                    i.data[6]="tokenblue"
                }
                if (obj==cardreader) {
                    i.data[1]="card"
                }
                
                if (obj==mark) {
                    //Items
                    if (i.data[0]="undotter" || i.data[0]="mushroom") {i.obj=mushroom i.data[0]="0,0"}
                    if (i.data[0]="dotter")   {i.obj=mushmini i.data[0]="0,0" }
                    if (i.data[0]="flower")   {i.obj = flower i.data[0]="0,0" }
                    if (i.data[0]="star")     {i.obj =starman i.data[0]="0,0" }
                    if (i.data[0]="1up")      {i.obj=lifemush i.data[0]="0,0" }
                    //Misc
                    if (i.data[0]="delfruit") i.obj=delfruit
                    if (i.data[0]="pswitch") { i.obj=pswitch i.data[0]="0,0" }
                }
                
                if (obj==waterblock) {
                    w=unreal(i.data[0],1)
                    h=unreal(i.data[1],1)
                    var u,v;
                    repeat (w) {
                        repeat(h) {
                            o=instance_create(i.x+u,i.y+v,water)
                            o.region=r
                            v+=1
                        } v=0 u+=1
                    }
                    with (i) instance_destroy()
                }  
                if (obj==skullblock) {
                    if (i.data[0]=="1") {
                        i.obj=skullbloff
                    }
                }
                if (obj==anchor) { 
                    i.data[1]="0,0"
                    i.data[2]="0"
                    
                    switch i.data[0] { //convert castles because theres no snowcastle asset in 2.1.5 because there is a biome even though theres also no snowcastle asset in redux because there is a biome
                        case "snowcastle": i.data[0]="castle" break;
                        case "snowbigcastle": i.data[0]="bigcastle" break;
                        default: break;
                    }
                }
                if i.obj != i.dataid {
                    var z;
                    z=1 repeat l {if (i.obj=lemongrab.objlist[z,0]) {i.spr=lemongrab.objlist[z,1] i.off=lemongrab.objlist[z,2] i.dataid=z break} z+=1}
                }
            }
        }
    }  
    with (regionbutton) if (n=r) empty=test  
    r+=1
}
with(drawregion) UPDATE_THE_DEITIES=1

if room == lemon ping(lang("error lemon converted"))
