///lemonloader(filename)
//loads the actual level data into lemongrab and objcontainers
var fn,fnf,l,t,f,fs,i,o,b,c,lv,size,map,r,deity,water,w,h,obj,realobj,ent,did,k,converted,str,test,moe;

fn=argument[0]


drawregion.unchanged=1
editnew(0)
clearbuffer()
l=lemongrab.length
converted=0

if (global.lemon_compat && fn!="test") {
    fnf=filename_fixname(fn)
    global.levelfname=string_copy(fnf,1,string_pos(".lemon",string_lower(fnf))-1)

    //read footer anchor and find lemon header
    t=createbuffer()
    f=fileopen(fn,0)
    fs=filesize(f)
    fileread(f,fs,t)
    fileclose(f)
    setpos(fs-4,t)
    i=readuint(t)

    if (i>fs) {error(lang("error lemon corrupt")+fn) return -1}

    size=(fs-i-4)
    setpos(i,t)
} else if (fn!="test") {
    fnf=filename_fixname(fn)
    global.levelfname=string_copy(fnf,1,string_pos(".lemon",string_lower(fnf))-1)

    t=createbuffer()
    f=fileopen(fn,0)
    fs=filesize(f)
    fileread(f,fs,t)
    fileclose(f)
    size=fs
    setpos(0,t) //we dont need to do the weird thumbnail stuff here as .lemon files are purely the level as opposed to .lemon.png's png with a level tacked on at the end
} else {
    //load from test buffer
    t=global.lemonbuffer
    size=global.lemonsize
    setpos(0,t)
}
//custom run-length compression v3
i=0
do {
    b=external_call(global._BufG,t)
    if (b=255) {
        c=external_call(global._BufG,t)
        b=external_call(global._BufG,t)
        repeat (c+1) external_call(global._BufA,b,0)
        i+=2
    } else external_call(global._BufA,b,0)
    i+=1
} until (i=size)   
if (fn!="test") freebuffer(t)
setpos(0)
         
if (readstring()!="[lemon]") {
    ping(lang("error lemon version"))
    exit
}
//read and extract header
map=ds_map_create()
if (!ds_map_read_safe(map,readstring())) {show_message("can't find lemon header???") ds_map_destroy(map) exit}
lv=ds_map_find_value(map,"v")

lemongrab.compat = string(lv)
if (string_starts_with(lv,"1.")) { //Lol
    lemonloader193(map) 
    exit
}

lemongrab.spawnx=ds_map_find_value(map,"spawnx")
lemongrab.spawny=ds_map_find_value(map,"spawny")
if (lv="2.1.5" || lv="2.1.6" || lv="2.1.6s") {
    lemongrab.tspawnx=ds_map_find_value(map,"tspawnx")
    lemongrab.tspawny=ds_map_find_value(map,"tspawny")
    lemongrab.tspawnr=ds_map_find_value(map,"tspawnr")
    lemongrab.spawnr=ds_map_find_value(map,"spawnr")
} else {
    lemongrab.tspawnx=ds_map_find_value(map,"spawnx")
    lemongrab.tspawny=ds_map_find_value(map,"spawny")
    lemongrab.tspawnr=0
    lemongrab.spawnr=0
}
lemongrab.levelname=string(ds_map_find_value(map,"name"))
lemongrab.leveldesc=string(ds_map_find_value(map,"desc"))  
lemongrab.time=max(30,ds_map_find_value(map,"time"))

if (ds_map_exists(map,"modded")) {
    moe = ds_list_create();
    ds_list_read(moe,string(ds_map_find_value(map,"modded")));
    
    var missingstr,showmissing;
    showmissing = false;
    missingstr = "WARNING:#This level contains Modded Objects that are not installed!##Please install: "
    
    r=0
    repeat(ds_list_size(moe)) {
        if !ds_map_exists(global.objectlemonlist,ds_list_find_value(moe, r)) {
            showmissing = true;
            if (r < (ds_list_size(moe)-1)) {
                missingstr+=ds_list_find_value(moe, r)+", "
            } else if (ds_list_size(moe) > 1) {
                missingstr+="and "+ds_list_find_value(moe, r)+"!"
            } else {
                missingstr+=ds_list_find_value(moe, r)+"!"
            }
        }
        
        r+=1;
    }
    
    if (showmissing) {
        show_message(missingstr);
    }
    
    ds_list_destroy(moe);
}

if (lv!="2.1.5" && lv!="2.1.6" && lv!="2.1.6s" && lemongrab.time==600) lemongrab.time=12001

ds_map_destroy(map)

global.levelname=lemongrab.levelname
global.leveldesc=lemongrab.leveldesc          
global.time=lemongrab.time

with (regionbutton) empty=1

//read regions
if (readstring()!="[reg]") {show_message("can't find region marker") exit}
r=0
repeat (8) {
    if (readstring()!="[rg"+string(r+1)+"]") {show_message("can't find region "+string(r+1)) exit}
    deity=lemongrab.gods[r]
    water=lemongrab.waters[r]
    semi=lemongrab.semis[r]
    back=lemongrab.backs[r]
    lemongrab.typeobj[r]=convert193biome(readstring())
    lemongrab.typebg[r]=convert193biome(readstring())
    lemongrab.typemus[r]=convert193biome(readstring())
    if (lv="2.1.6" || lv="2.1.6s") lemongrab.typetime[r]=readstring()
    
    else {lemongrab.typetime[r]="day"} //todo: fancy converter script to get the time of day of every biome in the game The Spirits: Release Us
    
    if (getbiomeid(lemongrab.typeobj[r])=-1){
        error(lang("error lemon biome1")+lemongrab.typeobj[r]+lang("error lemon biome2"))
    }
    if (getbiomeid(lemongrab.typebg[r])=-1){
        error(lang("error lemon biome1")+lemongrab.typebg[r]+lang("error lemon biome2"))
    }
    /*if (getbiomeid(lemongrab.typemus[r])=-1){
        error(lang("error lemon biome1")+lemongrab.typemus[r]+lang("error lemon biome2"))
    }*/
    if lemongrab.typetime[r]!="day" && lemongrab.typetime[r]!="evening" && lemongrab.typetime[r]!="night" error("is your clock set correctly?")
    
    if (string_starts_with(lv,"2.") && lv!="2.0") lemongrab.water[r]=readshort() //good enough for me
    else lemongrab.water[r]=0
    if (string_starts_with(lv,"2.") && lv!="2.0") lemongrab.horizon[r]=readshort()
    else lemongrab.horizon[r]=0
    w=readshort()
    h=readshort()
    if (string_starts_with(lv,"2.1.")){
        bpm=readshort()
        bpb=readshort()
        lightlevel=readshort()
    } else {
        bpm=110
        bpb=8
        lightlevel=0
    }
    
    size=w*h
    lemongrab.w[r]=w
    lemongrab.h[r]=h
    lemongrab.bpm[r]=bpm
    lemongrab.bpb[r]=bpb
    lemongrab.lightlevel[r]=lightlevel
    
    i=0
    repeat (72) {
        lemongrab.cambitmap[r,i]=readbyte()
        lemongrab.cambitmap2[r,i]=readbyte()
        i+=1
    }
    
    //read entities
    test=1
    if (readstring()!="[nty]") {show_message("can't find entity marker") exit}    
    repeat (readbyte()) {
        test=0
        str=readstring()
        obj=editnameconvert(str)
        realobj=editname2obj(str);
        if (string(realobj)=="-1") {
            //this object is unknown, so let's skip loading it
            ent=readbyte()
            repeat (readuint()) {
                readbyte()
                readushort()
                if (lv == "2.1.6s") { //wastes two whole ushorts on every object for scaling award
                    readushort()
                    readushort()
                } if (ent) repeat (8) readstring()
            }
            converted=1
            show_debug_message("lemon: can't find object called "+qt+str+qt)
        }
        else if obj=="dotter" obj="mushmini"
        else if obj=="undotter" obj="mushroom"
        else {
            i=1 repeat l {if (string(realobj)=string(lemongrab.objlist[i,0])) {spr=lemongrab.objlist[i,1] off=lemongrab.objlist[i,2] did=i break} i+=1}
            ent=readbyte()
            repeat (readuint()) {
                //read one entity
                b=readbyte()
                b=(b<<16)+readushort()

                if (lv == "2.1.6s") { //wastes two whole ushorts on every object for scaling award
                    scalex = readushort()
                    scaley = readushort()
                } else {
                    scalex = 1;
                    scaley = 1;
                }

                if (obj=="waterblock") {
                    w=1 h=1
                    if (ent) {
                        w=unreal(readstring(),1)
                        h=unreal(readstring(),1)
                        repeat (6) readstring()
                    }
                    for (u=0;u<w;u+=1) for (v=0;v<h;v+=1) {
                        o=instance_create(b>>12+u,b&$fff+v,water)
                        o.region=r
                        o.scalex=scalex
                        o.scaley=scaley
                    }
                } else if (obj=="groundsemi"||obj=="slopel1s"||obj=="slopel2s"||obj=="sloper1s"||obj=="sloper2s"||obj=="uslopel1s"||obj=="uslopel2s"||obj=="usloper1s"||obj=="usloper2s") {
                     i=instance_create(b>>12,b&$fff,semi)
                     i.obj=realobj
                     i.spr=spr
                     i.scalex=scalex
                     i.scaley=scaley
                } else if (obj=="groundback"||obj=="slopel1b"||obj=="slopel2b"||obj=="sloper1b"||obj=="sloper2b"||obj=="uslopel1b"||obj=="uslopel2b"||obj=="usloper1b"||obj=="usloper2b") {
                     i=instance_create(b>>12,b&$fff,back)
                     i.obj=realobj
                     i.spr=spr
                     i.scalex=scalex
                     i.scaley=scaley
                }else {
                    i=instance_create(b>>12,b&$fff,deity)
                    i.obj=realobj
                    i.spr=spr
                    i.scalex=scalex
                    i.scaley=scaley
                    i.off=off
                    i.dataid=did
                    if (ent) {
                        k=0 repeat (8) {i.data[k]=readstring() k+=1}
                        if (string(lemongrab.objlist[did,5])="align") {
                            if (obj="fbarblock" && (!string_starts_with(lv,"2.1.")))
                            || ((obj="itembox"||obj="phaser"||obj="brick"||obj="monitor") && !string_starts_with(lv,"2.") && lv!="2.0" && lv!="2.0.5")
                            || ((obj="warpbox"||obj="door") && lv!="2.1.5" && lv!="2.1.6" && lv!="2.1.6s") { //fix objects getting align much later
                                var al;
                                al=7 repeat (8) {i.data[al+1]=i.data[al] al-=1}
                                i.data[0]="0"
                            }

                            if (!string_starts_with(lv,"2.") || lv="2.0") {
                                //convert old align flag
                                if (i.data[0]="1") i.data[0]="-8,0"
                                else i.data[0]="0,0"
                            }
                            unpack_align(i)
                        }

                        if !string_starts_with(lv,"2.1.")  with(i) {
                            if obj=="anchor" {
                                data[1]="0,0"
                                data[2]="0"
                            }
                        }
                        if lv=="2.1" with(i) {
                            if obj=="terrainspring" {
                                data[1]="0"
                            }
                        }
                        if lv!="2.1.5" && lv!="2.1.6" && lv!="2.1.6s" {
                            if (obj == "token") {
                                i.data[0]="0,0"
                                i.data[1]="1"
                            }
                            if (obj=="door") {
                                i.data[6]="key"
                            }
                            if (obj=="warpbox") {
                                i.data[6]="key"
                            }
                            if (obj=="cardreader") {
                                i.data[1]="card"
                            }
                            if (obj=="itemlaunch") {
                                if (i.data[1]="tap") i.obj=crystaltap
                                if (i.data[1]="key") i.obj=keyitem
                                if (i.data[1]="undotter") i.data[1]="mushroom"
                                if (i.data[1]="dotter") i.data[1]="mini"
                            }
                        }
                        if lv!="2.1.6s" {
                            if (obj == "pipeblock" || obj == "downpipe") { //fix alignment
                                i.x -= 1;
                                i.xstart = i.x;
                            }
                        }
                        if (obj=="mark") {
                            //Items
                            if (i.data[0]="undotter" || i.data[0]="mushroom") {i.obj=mushroom i.data[0]="0,0"}
                            if (i.data[0]="dotter")   {i.obj=mushmini i.data[0]="0,0" }
                            if (i.data[0]="flower")   {i.obj = flower i.data[0]="0,0" }
                            if (i.data[0]="star")     {i.obj =starman i.data[0]="0,0" }
                            if (i.data[0]="1up")      {i.obj=lifemush i.data[0]="0,0" }
                            //Misc
                            if (i.data[0]="delfruit") i.obj=delfruit
                            if (i.data[0]="pswitch") { i.obj=pswitch i.data[0]="0,0" }
                            if (i.data[0]="b") {with (i) instance_destroy()} //broken Claw object that isn't used anymore
                        }
                        
                        if (obj == "tyler" || obj == "decortyler"
                         || obj == "objectstyler" || obj == "terraintyler") {
                            if (getbiomeid(data[7]) != -1)
                                global.tylerbiomes[getbiomeid(data[7])] = 1
                        }  
                        if obj=="anchor" {
                            if unreal(data[2],0) global.tylerbiomes[unreal(data[2],0)-1] = 1
                        }
                        
                    }
                    if string(i.obj) != string(i.dataid) {
                        var z;
                        z=1 repeat l {if (string(i.obj)=string(lemongrab.objlist[z,0])) {i.spr=lemongrab.objlist[z,1] i.off=lemongrab.objlist[z,2] i.dataid=z break} z+=1}
                    }
                    
                    if (string(realobj)=="0") {
                        with(i) instance_destroy();
                    }
                }
            }
        }
    }
    with (regionbutton) if (n=r) empty=test
    r+=1
}

with(objcontainer) {
    lemongrasschecker(id);
}
with(semicontainer) {
    lemongrasschecker(id);
}

with(drawregion) UPDATE_THE_DEITIES=1

if (converted && room==lemon) ping(lang("error lemon converted"))
