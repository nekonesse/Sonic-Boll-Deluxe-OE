#define data
name = "The Charm That Loads Boll 2"
desc = "This Charm Loads Boll 2 Levels."

#define start

global.parsejade = code_compile('
var loaded,leveldata,level_properties,i,j,ii,jj,l;
loaded = buffer_create(argument[0]);
buffer_inflate(loaded);
leveldata = json_parse(buffer_read_string(loaded));

with(objcontainer) {
    instance_destroy();
}
with(watercontainer) {
    instance_destroy();
}
with(semicontainer) {
    instance_destroy();
}
with(backcontainer) {
    instance_destroy();
}

lemongrab.thumbx=0
lemongrab.thumby=0
lemongrab.thumbregion=0

if json_array_get_number(leveldata, "spawnpoints", 2) < 8 {
    lemongrab.spawnx=json_array_get_number(leveldata, "spawnpoints",0)/16;
    lemongrab.spawny=json_array_get_number(leveldata, "spawnpoints",1)/16;
    lemongrab.spawnr=json_array_get_number(leveldata, "spawnpoints",2);
}
if json_array_get_number(leveldata, "spawnpoints", 5) < 8 {
    lemongrab.tspawnx=json_array_get_number(leveldata, "spawnpoints",3)/16;
    lemongrab.tspawny=json_array_get_number(leveldata, "spawnpoints",4)/16;
    lemongrab.tspawnr=json_array_get_number(leveldata, "spawnpoints",5);
}

lemongrab.levelname=string(json_dotget_string(level_data, "level_properties.name"));
lemongrab.leveldesc=string(json_dotget_string(level_data, "level_properties.desc"));
lemongrab.time=12001

i=0
repeat(json_array_length(leveldata,"level_data")) {
    ii = string(i);

    lemongrab.w[i]=json_dotget_number(leveldata, "level_data."+ii+".width")
    lemongrab.h[i]=json_dotget_number(leveldata, "level_data."+ii+".height")
    lemongrab.typetime[i]="day"
    deity=lemongrab.gods[i]
    water=lemongrab.waters[i]
    semi=lemongrab.semis[i]
    back=lemongrab.backs[i]
    switch(json_dotget_string(leveldata, "level_data."+ii+".music_track")) {
        case "floragrande":
            lemongrab.typemus[i]="Ground";
        break;
        case "frigiddark":
            lemongrab.typemus[i]="Snow";
        break;
    }

    j=0
    repeat(json_array_length(leveldata,"level_data."+ii+".layers")) {
        jj = string(j);
        switch(json_array_get_string(leveldata, "level_data."+ii+".layers."+jj, 0)) {
            case "TILE":
                switch(json_array_get_string(leveldata, "level_data."+ii+".layers."+jj, 1)) {
                    case "tTilesetMain":
                    case "tTilesetMainDeco":
                        lemongrab.typeobj[i]="Ground";
                    break;
                    case "tTilesetWorld5":
                    case "tTilesetWorld5Deco":
                        lemongrab.typeobj[i]="Snow";
                    break;
                }
            break;
            case "BACK":
                switch(json_array_get_string(leveldata, "level_data."+ii+".layers."+jj, 3)) {
                    case "spr_plains_bg_sky":
                        lemongrab.typebg[i]="Ground";
                    break;
                    case "spr_w5mountain_bg_sky":
                        lemongrab.typebg[i]="Snow";
                    break;
                }
            break;
        }

       j+=1;
    }

    j=0
    repeat(json_array_length(leveldata,"level_data."+ii+".objects")) {
        jj = string(j);
        var obj,realobj,container,xscale,yscale,xpos,ypos;
        container = deity;
        obj = "";
        xscale = json_array_get_number(leveldata, "level_data."+ii+".objects."+jj, 3)*json_array_get_number(leveldata, "level_data."+ii+".objects."+jj, 8);
        yscale = json_array_get_number(leveldata, "level_data."+ii+".objects."+jj, 4)*json_array_get_number(leveldata, "level_data."+ii+".objects."+jj, 9);
        xpos = json_array_get_number(leveldata, "level_data."+ii+".objects."+jj, 1)
        ypos = json_array_get_number(leveldata, "level_data."+ii+".objects."+jj, 2)
        switch(json_array_get_string(leveldata, "level_data."+ii+".objects."+jj, 0)) {
            case "oCollider":
                obj = "groundblock";
            break;
            case "oSlopeCollider":
                obj = "groundblock";
            break;
            case "oSemilider":
                obj = "groundsemi";
                container = semi;
            break;
            case "oSemiSlope":
                obj = "groundsemi";
                container = semi;
            break;
            case "oGrate":
            case "oGrateSemi":
                obj = "grateblock";
            break;
            case "oEnemyGround":
            case "oEnemyGroundSemi":
                obj = "x1F0";
            break;
            case "oItemBox":
                obj = "itembox";
            break;
            case "oLongItemBox":
                obj = "bigitembox";
            break;
            case "oBrick":
                obj = "brick";
            break;
            case "oNoteBlock":
                obj = "noteblock";
            break;
            case "oDonutBlock":
                obj = "platdonut";
            break;
            case "oHardBlock":
                obj = "hardblock";
            break;
            case "oBigHardBlock":
                obj = "bighardblock";
            break;
            case "oCrate":
                obj = "crate";
            break;
        }

        if (obj!="") {
            realobj = editname2obj(obj);

            l=0
            repeat(lemongrab.length) {
                if (string(realobj)==string(lemongrab.objlist[l,0])) {
                    spr=lemongrab.objlist[l,1]
                    off=lemongrab.objlist[l,2]
                }
                l+=1;
            }

            var inst;
            inst = instance_create(xpos/16,ypos/16,container)

            inst.obj = realobj;
            inst.spr = spr;
            inst.off = off;
            inst.scalex = xscale;
            inst.scaley = yscale;
        }

       j+=1;
    }

    i+=1;
}

json_delete(leveldata);
buffer_destroy(loaded);

with(objcontainer) {
    lemongrasschecker(id);
}
with(semicontainer) {
    lemongrasschecker(id);
}

with(drawregion) UPDATE_THE_DEITIES=1

editloadregion(0)
')

var codestr;
codestr = '
var num,i,name;

alarm[2]=15

global.focus=(external_call(global.dll_foc)==global.winhandle)

//drag and drop detection
if (room==lemon || room==speciale) {
    num=external_call(global.dll_dragnum,global.winhandle)
    if (num) {
        for (i=0;i<num;i+=1) {
            name=external_call(global.dll_dragname,global.winhandle,i)
            if (file_exists(name)) {
                if (room==lemon) {
                    if (filename_ext(name)==".png" || filename_ext(name)==".lemon") {
                        if (!drawregion.flooding) {
                            //load lemon file
                            editload(name)
                        }
                    } else if (filename_ext(name)==".jade") {
                        code_execute(global.parsejade, name);
                    }
                } else if (room==speciale) {
                    if (filename_ext(name)==".txt") {
                        if (!instance_exists(moranboll)) {
                            //load special stage
                            specialeload(name)
                        }
                    }
                }
            }
        }
        external_call(global.dll_dragclear)
    }
}
'

object_event_clear(globalmanager,ev_alarm,2);
object_event_add(globalmanager,ev_alarm,2,codestr);