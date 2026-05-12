var opt,str,o,p;

if (argument[0] && global.editpicked!=-1) opt=global.editpicked
else {
    str=""
    o=0

    p=ds_priority_create()
    for (i=0;i<global.characters;i+=1)
        if (!settings(global.charname[i]+" disabled") && !settings(global.charname[i]+" broken") && !(settings("lock "+global.charname[i]) && !global.gamemaker))
            ds_priority_add(p,i,global.rosterorder[i] + (global.charmod[i]*10000))

    l=ds_priority_size(p)
    for (i=0;i<l;i+=1) {
        c=ds_priority_delete_min(p)
        str+=global.charname[c]
        if (i<l-1) str+="|"
        pl[o]=c o+=1
    }

    ds_priority_destroy(p)

    if !(settings("nolemonsound")) sound("lemoncontext")
    opt=show_contextmenu(str,-1)
    if !(settings("nolemonsound")) sound("lemonselectitem")
    if (opt=-1) exit
    opt=pl[opt]
}

global.editpicked=opt
global.lemontest=1
global.lemontestviewhack=1
global.lemonchanged=drawregion.unchanged
global.lemonviewx=drawregion.viewx
global.lemonviewy=drawregion.viewy
global.lemonzoom=editzoom.levelgo
global.lemonregion=drawregion.region

settings("mirrormem",settings("mirror")) settings("mirror",0)
settings("ratchetmem",settings("ratchet")) settings("ratchet",0)
settings("randblockmem",settings("randblock")) settings("randblock",0)

game_reset()

global.bundled=editmanager.bundled

with(drawregion) {
    myarray_i=1
    savema=selected_array[0]
    repeat (savema) {
        with (selected_array[myarray_i]) {selected=0 event_user(0)}
        myarray_i+=1
        selected_array[0]-=1
    }

    selected_array[0]=0

    UPDATE_THE_DEITIES=1 event_user(7)
}

lemonsaver("test")

global.levelfname=filename_fixname(global.lemonfilename)
global.levelname=lemongrab.levelname
global.leveldesc=lemongrab.leveldesc
global.time=lemongrab.time

global.gamemode="classic"
global.option[0]=opt
if settings("lemoninput")=="Gamepad" global.input[0]=2 else global.input[0]=-1
applyplayerskin(global.pbase,0,"all",global.option[0])
global.pal_1[0]=(playerskindat(0,"defaultpal1"+string(0)))
global.pal_2[0]=(playerskindat(0,"defaultpal2"+string(0)))
global.pal_3[0]=(playerskindat(0,"defaultpal3"+string(0)))
global.pal_4[0]=(playerskindat(0,"defaultpal4"+string(0)))

var sprayloop, mydat;
sprayloop=2
repeat (3) {
    mydat = playerskindat(0,"reroutepal"+string(sprayloop)+"0")
    if mydat!=0 {
        variable_global_array_set("pal_"+string(sprayloop),0,variable_global_array_get("pal_"+string(mydat),0))
    }
    sprayloop+=1
}

game_start()

global.actually_recording_goddamnit=0

room_goto(change)
