//set up game directories and caches

global.workdir=working_directory+"\"
global.tempdir=temp_directory+"\"

code_compile("");

global.savedir=global.workdir+"SBDX_save\"
directory_create(global.savedir)
directory_create(global.workdir+"SBDX_skins\world")
directory_create(global.workdir+"SBDX_skins\player")
directory_create(global.workdir+"SBDX_skins\music")
directory_create(global.workdir+"SBDX_mods\character")
directory_create(global.workdir+"SBDX_mods\level")
directory_create(global.workdir+"SBDX_mods\language")
directory_create(global.workdir+"SBDX_mods\extensions")
clearbuffer()

if (global.modded) {
    //generate adler32 checksum of username to use as save file
    writestring(registry_read_string_ext("Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders","Personal"))
    global.addler=string(adler32())
    global.savefile=global.savedir+global.addler+".cfg"
} else {
    global.savefile=global.savedir+gametitle+".cfg"
}
global.cache=global.savedir+"cache\"


if (global.modded) {
    global.cache=global.workdir+global.moddata
    if (!directory_exists(global.cache)) {
        directory_create(global.cache)
        //readbimp("sbdat.dll")
    }
} else {
    directory_create(global.cache)
    //readbimp("sbdat.dll")
}

global.tmpfile=global.tempdir+"res.gms"
global.tasfile=global.tempdir+"tas.gms"

global.boll=makeboll()

system_dllinit()

//globals
global.sysfont=spr_sysfont
global.fontmapbase=""
global.omimap=""

i=1 repeat(135) {global.fontmapbase+=chr(i) global.omimap+=chr(i) i+=1}

global.blastmap=""
i=65 repeat (26) {global.blastmap+=chr(i) i+=1}
i=48 repeat (11) {global.blastmap+=chr(i) i+=1}
global.blastmap+=chr(46)
global.blastmap+=chr(32)

global.sprfont=-1
global.tscale=1

global.debug=debug_mode
global.gamemaker=(program_directory!=working_directory)
global.allowconsoleinlemon=0
global.easter=calceaster() || (date_get_month(date_current_datetime())=4 && date_get_day(date_current_datetime())=1)
global.christmas=(date_get_month(date_current_datetime())=12 && date_get_day(date_current_datetime())=25)

global.setmap=ds_map_create()
global.strmap=ds_map_create()
global.statmap=ds_map_create()
global.timemap=ds_map_create()
global.spentblocks=ds_map_create()
global.tokenspend=ds_map_create()
global.keylog=createbuffer()

global.defaultkeyboard[1]=string(vk_up)+"|"+string(vk_down)+"|"+string(vk_left)+"|"+string(vk_right)+"|"+string(ord("X"))+"|"+string(ord("Z"))+"|"+string(ord("C"))+"|"+string(vk_enter)+"|"+string(ord("A"))+"|"+string(ord("S"))+"|"+string(ord("D"))+"|"+string(ord("V"))+"|"
global.defaultkeyboard[2]=string(ord("I"))+"|"+string(ord("K"))+"|"+string(ord("J"))+"|"+string(ord("L"))+"|"+string(ord("W"))+"|"+string(ord("Q"))+"|"+string(ord("E"))+"|"+string(vk_backspace)+"|"+string(ord("1"))+"|"+string(ord("2"))+"|"+string(ord("3"))+"|"+string(ord("R"))+"|"

global.currentlevel=""
global.kill=0
global.restarting=0
global.quietyou=0
global.lastroom=room
global.replaycache=-1
global.bmovie=-1
global.w=400
global.h=224
global.s=2
global.mplay=0
global.fool=0
global.electric=0
global.bgscroll=0
global.frameskipcounter=0
global.editpicked=-1
global.ref=-1
global.pfps=60
global.spd=60
global.vapor=0
global.vaporkek=0
global.vaporpass=0
global.steamprompt=0
global.lastcmd=""
global.lastrun="show_message("+qt+"hello world"+qt+")"
global.__cachedscript = ""
global.lemonfilename=""
global.levelfname=""
global.lemontest=0
global.lemontestviewhack=0
global.lemonlskin="None"
global.replaythumb=-1
global.actually_recording_goddamnit=0
global.movieskipping=0
global.tasing=0
global.pos=1
global.length=1
global.inputwait=0
global.mousebacklock=0
global.scriptobj=verybignumber
global.scripts=0
global.tcalc=0
global.halign=0
global.valign=0
global.loadstate=0
global.loadtime=0
global.onlinemode=false;
global.specialestr="S# ´`\/O.:t%@!bB123FTM"
global.plattable=
    "a0000000000a000a000a0a00a0a0a0aa0a0aaa0aaa0aaaaaa0aaaaabaaaaaaab"+
    "aaabaabaababababababbababababaabaabaaabaaaabaaaaaaaaaaaa0aaaaa0a"+
    "aa0aa0a0a0a0a0a0a00a00a00a00000a000000c00000000c000c000c0c00c0c0"+
    "c0cc0c0ccc0ccc0cccccc0cccccdcccccccdcccdccdccdcdcdcdcdcddcdcddcd"+
    "cdcdccdccdccdcccdcccccccccccccccccc0cccc0cc0cc0c0c0c0c0c0c00c00c"+
    "0000c00000000000a0000000a0000000a0000000a0000000a0000000a0000000"


for (i=0;i<12;i+=1) { //The sneaky worm, slithering around, decided to make it so that it was 12 instead of 4, becuase sonic&tails baby haha fuck yeah lets go baby hahahahaha  - -S-
    global.playermask[i]=sprite_duplicate(spr_playermask)
}

global.shaderPaletteSwap=psPalSwapSegmented()
global.shaderPaletteSwapAlpha=psPalSwapSegmentedMaxAlpha()

//final preparations
draw_set_color($ffffff)
draw_set_font(global.omifont)
draw_set_circle_precision(64)

rm=room_first do {
    room_set_view_enabled(rm,1)
    room_set_width(rm,1)
    room_set_height(rm,1)
    rm=room_next(rm)
} until (rm=-1)

screen_init()

var setting_load;

setting_load = loadopt()
if !setting_load {
    setlang() //should prevent the game from having No Language if settings fail to load
}
stats("bootups",stats("bootups")+1)

if (stats("red rings collected") >= 80) {
    unlockchar("retromario");
}

if (!global.easter && egg(1)) {
    global.greenmode = true;
}

global.modlist=ds_list_create();
global.modtype=ds_list_create();
global.extensionlist=ds_list_create();
global.customsprites=ds_map_create();
global.levelscripts = ds_map_create();
global.objectscripts = ds_map_create();
global.customobjecttypes = ds_map_create();
global.objectlemonlist = ds_map_create();

indexCustomObjects();
indexExtensions();

instance_create(0,0,lemongrab);
