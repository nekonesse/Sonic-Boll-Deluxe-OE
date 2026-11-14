/*

lemonsaver

WWWWWWWWWW#....................................................................
WWWWWWWW@:.....................................................................
WWWWWWW*.......................................................................
WWWWW=.........................................................................
WWW@-..........................................................................
WW+.....................:**-...................................................
=.........-....+*.-...=WWW@WW-.................................................
......*=-..@=..=W-=-#WWWW ww =-.................................................
........#=#*#W#+@#*=@-@WWWWWW=+................................................
.........::@WWWWWWW@W=WW#WWW*..::..............................................
........--.-:=WWWWWWWWW*+--#-..................................................
...........+*@#WWWWW#W@@@WW#@W*-...................................:.+WW-......
........:=WWW@WW*#WWWWWWWW@@+....................................-#WW*+=@W*-...
.............:=@WWWWWWWW#WWW#+-..................................+WW@#@WWWWW-..
.....*WWW*=***==WWWW@#WWW#WWWW-#:+=###=--.......................:* @#WWWW#....
.....+@WW#@+###**@WWWW#WWWW@WWW@*:-=##W@+#*-....................*@##W WWW@.....
...-=WWWW*=@W..-.-*@WWWWWWWWWW=-*==@W*:=@WW=**.................:#WWWWWWWW:.....
...+WWWWWWWW@.....-*@=*@WWWW###*+#+:@W#@W#=@@@W*..............::.   WWWWW*......
....=WWWWWW@:.............#@++#*@W@@@@=-@W@@==*@*+...........-#W@WWWWWW@.......
.....@WWWW*..............:WW#WW=#W=:=@@@W*=+W@@=##=..........*@WWWWWWWW+.......
.....#WWW=@...............=@=*W+#WWWW==+@W@@*+W@=@@@#=@#-...=@@W@WWWWW@........
......--.................=#@WW@=@W#*@WW@=#@W@#WW@#WWW+@W@..+@WW@WWWWWW*........
.....@W@.......:@WW#.....#WW:WWWWWWW*=*WWWWWWW+W##WWW*=WW-.+#@WWWWWWWW-.......-
.....#WW-.....=WW:WW*....=WW:WW@WWWWWWWWWW=@WWWWWW#WW#*WW:=@WWWWWWWWW=.......=W
.....=WW:.....=WWW@=+....*WW:@W#*WW=W@*#WWWWWW#+#-.WW@+WW=WWWWWWWW@@@-.....+WWW
.....*WW+.....*WW+#W@....+WW+#W@+WW+:@=-WWWWWW*....:--.---.-#WWWWWWW=....-@WWWW
.....+WW=-....:WW@WW:.....--.-+=:WW*....-+*+..:*#@#=*+++*==......--.....=WWWWWW
.....-WWWW*.....--.-+=@@#**++*=##=*+++*=#@#*:.........................+WWWWWWWW
.....*=*++++*=@#=+-.................................................-@WWWWWWWWW
...................................................................#WWWWWWWWWWW
*/
//--------------------------------HEADER
var t,l,map,moe;

clearbuffer()
t=createbuffer()

//lemon format final
writestring("[lemon]")
l=lemongrab.length

moe = ds_list_create(); //modded object detection
for (r=0;r<8;r+=1) {
    deity=lemongrab.gods[r]
    with(deity) {
        var test;

        if (is_real(obj)) {
            test=object_get_name(lemongrab.objlist[j,0]);
        } else {
            test=string(obj);
        }

        if string_starts_with(test,"MODDEDOBJECT_") {
            test = string_delete(test,1,13) //remove the modded object tag

            if (ds_list_find_index(moe, test) < 0) {
                ds_list_add(moe, test)
            }
        }
    }
}

map=ds_map_create()
ds_map_add(map,"v","2.1.6s")
ds_map_add(map,"spawnx",lemongrab.spawnx)
ds_map_add(map,"spawny",lemongrab.spawny)
ds_map_add(map,"spawnr",lemongrab.spawnr)
ds_map_add(map,"tspawnx",lemongrab.tspawnx) //Lol
ds_map_add(map,"tspawny",lemongrab.tspawny)
ds_map_add(map,"tspawnr",lemongrab.tspawnr)
ds_map_add(map,"stage",lemongrab.stage)
ds_map_add(map,"time",lemongrab.time)
ds_map_add(map,"name",lemongrab.levelname)
ds_map_add(map,"desc",lemongrab.leveldesc)
ds_map_add(map,"modded",ds_list_write(moe))
writestring(ds_map_write(map))
ds_list_destroy(moe);
ds_map_destroy(map)

lemongrab.ky=224

instance_activate_object(objcontainer)
instance_activate_object(watercontainer)
instance_activate_object(semicontainer)
instance_activate_object(backcontainer)
var r,deity,water,w,h,size,i,j,yes,obj,realobj,b,ent,k;

writestring("[reg]")
for (r=0;r<8;r+=1) {
    deity=lemongrab.gods[r]
    water=lemongrab.waters[r]
    semi=lemongrab.semis[r]
    back=lemongrab.backs[r]
    w=lemongrab.w[r]
    h=lemongrab.h[r]
    bpm=lemongrab.bpm[r]
    bpb=lemongrab.bpb[r]
    lightlevel=lemongrab.lightlevel[r]


    lemongrab.ky=max(lemongrab.ky,h*16)

    writestring("[rg"+string(r+1)+"]")
    writestring(lemongrab.typeobj[r])
    writestring(lemongrab.typebg[r])
    writestring(lemongrab.typemus[r])
    writestring(lemongrab.typetime[r])
    writeshort(lemongrab.water[r])
    writeshort(lemongrab.horizon[r])
    writeshort(w)
    writeshort(h)
    writeshort(bpm)
    writeshort(bpb)
    writeshort(lightlevel)
    size=ceil((w*h)/8)
    for (i=0;i<72;i+=1) {
        external_call(global._BufA,lemongrab.cambitmap[r,i],0) //writebyte
        external_call(global._BufA,lemongrab.cambitmap2[r,i],0) //writebyte
    }

    //--------------------------------ENTITIES

    writestring("[nty]")

    //so first we need to count them
    yes=0
    for (j=1;j<=l;j+=1) {
        obj=string(lemongrab.objlist[j,0])
        with (deity) if (string(self.obj)=obj) {yes+=1 break}
        with (semi) if (string(self.obj)=obj) {yes+=1 break}
        with (back) if (string(self.obj)=obj) {yes+=1 break}
    }
    with (water) {yes+=1 break}

    writebyte(yes)

    for (j=1;j<=l;j+=1) {
        if (is_real(lemongrab.objlist[j,0])) {
            obj=object_get_name(lemongrab.objlist[j,0]);
        } else {
            obj=string(lemongrab.objlist[j,0])
        }
        realobj = lemongrab.objlist[j,0]
        ent=lemongrab.objlist[j,21]

        if (obj="waterblock") {
            //this is the same as the block below but watered down hahA
            yes=0 with (water) yes+=1
            if (yes) {
                writestring(object_get_name(realobj))
                writebyte(0)
                writeuint(yes)

                with (water) {
                    b=(x << 12) + y
                    external_call(global._BufA,b>>16,0) //writebyte
                    external_call(global._BufY,b&$ffff,0) //writeushort
                    external_call(global._BufY,scalex,0) //writeushort
                    external_call(global._BufY,scaley,0) //writeushort
                }
            }
        } else if obj="groundsemi"||obj="slopel1s"||obj="sloper2s"||obj="sloper1s"||obj="slopel2s"||obj="uslopel1s"||obj="uslopel2s"||obj="usloper1s"||obj="usloper2s"{
            yes=0 with (semi) if (string(self.obj)=string(realobj)) yes+=1 with (deity) if (string(self.obj)=string(realobj)) yes+=1 //hopefully stop crashes due to wrong layer
            if (yes) {
                writestring(object_get_name(realobj))
                writebyte(0)
                writeuint(yes)

                with (semi) if (string(self.obj)=string(realobj)) {
                    b=(x << 12) + y
                    external_call(global._BufA,b>>16,0) //writebyte
                    external_call(global._BufY,b&$ffff,0) //writeushort
                    external_call(global._BufY,scalex,0) //writeushort
                    external_call(global._BufY,scaley,0) //writeushort
                }

                with (deity) if (string(self.obj)=string(realobj)) {
                    b=(x << 12) + y
                    external_call(global._BufA,b>>16,0) //writebyte
                    external_call(global._BufY,b&$ffff,0) //writeushort
                    external_call(global._BufY,scalex,0) //writeushort
                    external_call(global._BufY,scaley,0) //writeushort
                }
            }
        } else if obj="groundback"||obj="slopel1b"||obj="sloper2b"||obj="sloper1b"||obj="slopel2b"||obj="uslopel1b"||obj="usloper2b"||obj="usloper1b"||obj="uslopel2b"{
            yes=0 with (back) if (string(self.obj)=string(realobj)) yes+=1 with (deity) if (string(self.obj)=string(realobj)) yes+=1
            if (yes) {
                writestring(object_get_name(realobj))
                writebyte(0)
                writeuint(yes)

                with (back) if (string(self.obj)=string(realobj)) {
                    b=(x << 12) + y
                    external_call(global._BufA,b>>16,0) //writebyte
                    external_call(global._BufY,b&$ffff,0) //writeushort
                    external_call(global._BufY,scalex,0) //writeushort
                    external_call(global._BufY,scaley,0) //writeushort
                }
            }
        } else {
            yes=0 with (deity) if (string(self.obj)=string(realobj)) yes+=1

            if (yes) {//write an entity list
                if !is_string(realobj) {
                    writestring(object_get_name(realobj))
                } else {
                    writestring(realobj)
                }
                writebyte(ent) // is entity? ie has data
                writeuint(yes)

                with (deity) if (string(self.obj)=string(realobj)) {//write x, y, then all data fields
                    dataid=j
                    b=(x << 12) + y
                    external_call(global._BufA,b>>16,0) //writebyte
                    external_call(global._BufY,b&$ffff,0) //writeushort
                    external_call(global._BufY,scalex,0) //writeushort
                    external_call(global._BufY,scaley,0) //writeushort
                    if (ent) for (k=0;k<8;k+=1) external_call(global._BufB,string(data[k]),0) //writestring
                }
            }
        }
    }
}

if (!global.lemontest) {
    //we don't want to deactivate them again when we're testing
    //since that saves having to reactivate them right after
    instance_deactivate_object(objcontainer)
    instance_deactivate_object(watercontainer)
    instance_deactivate_object(semicontainer)
    instance_deactivate_object(backcontainer)
    instance_activate_object(drawregion.deity)
    instance_activate_object(lemongrab.waters[drawregion.region])
    instance_activate_object(lemongrab.semis[drawregion.region])
    instance_activate_object(lemongrab.backs[drawregion.region])
}

//--------------------------------THUMBNAIL
var tn,s,thumbsize,f,o,j,w,h;

if (!global.lemontest && global.lemon_compat) {
    if (global.lemoncusthumb!="") {
        f=fileopen(global.lemoncusthumb,0)
        thumbsize=filesize(f)
        clearbuffer(t)
        fileread(f,thumbsize,t)
        fileclose(f)
    } else {
        tn=global.tempdir+"tmp.png"
        s=sureface("",224,160)
        if (s=-1) exit
        if (sureface_set_target("")) {
            draw_clear_alpha(0,1)
            draw_sprite(spr_level,0,0,0)
            global.halign=1
            draw_systext(112,28,lemongrab.levelname+"##"+lemongrab.leveldesc)
            global.halign=0
            draw_omitext(4,4,"v"+version)
            draw_set_blend_mode(bm_add)
            rect(0,0,224,160,0,1)
            draw_set_blend_mode(0)
            surface_reset_target()
            surface_save(s,tn)
            sureface_free("")
        }
        f=fileopen(tn,0)
        thumbsize=filesize(f)
        clearbuffer(t)
        fileread(f,thumbsize,t)
        fileclose(f)
        file_delete(tn)
    }
}

//--------------------------------COMPRESSION
var c,o;

//custom rle v3
size=getpos(0)
setpos(0)
c=0
o=readbyte(0)
for (k=0;k<size;k+=1) {
    b=external_call(global._BufG,0)
    if (b!=o || c=255 || k=size-1) {
        if (c>2 || o=255) {
            external_call(global._BufA,255,t)
            external_call(global._BufA,c,t)
            external_call(global._BufA,o,t)
        } else repeat (c+1) external_call(global._BufA,o,t)
        c=0
    } else c+=1
    o=b
}
clearbuffer()

//--------------------------------FILE
if (!global.lemontest) {
    if global.lemon_compat writeuint(thumbsize,t)

    f=fileopen(argument[0],1)
    setpos(0,t)
    filewrite(f,t)
    fileclose(f)

    freebuffer(t)
} else {
    global.lemonbuffer=t
    global.lemonsize=getpos(0,t)
}
