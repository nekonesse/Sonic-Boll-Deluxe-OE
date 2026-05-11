#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dy=-48


off=0
candismiss=0
alarm[0]=60
str=filename_fixname(parameter_string(0))+" ("+version+")#"
if (global.gamemaker) str+="Running from Game Maker#"
keyboard_string=""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
global.inputwait=2

if (off) {dy=max(-48,dy-4) if (dy=-48) instance_destroy()}
else dy=min(0,dy+4)

alpha=0.5*(48+dy)/48

keyboard_string = string_replace(keyboard_string,chr(127),"") //bad fix to prevent typing char 127 by pressing ctrl+backspace

if (keyboard_check_pressed(vk_up)) keyboard_string=global.lastcmd

if (keyboard_check_pressed(vk_tab)) {keyboard_string="" off=1}

if (input_esc()) off=1

if (keyboard_check_pressed(vk_enter) && !off) {
    off=1
    run=keyboard_string
    arg=""
    if (run="") exit
    global.lastcmd=run
    p=string_pos(" ",run)
    if (!p) cmd=run
    else {
        cmd=string_copy(run,1,p-1)
        arg=string_delete(run,1,p)
    }
    cmd = string_lower(cmd) //all of the commands are lowercase
    if (global.playback) {
        if (cmd="4126" || cmd="fast" || cmd="reset" || cmd="camlock" ||cmd="6214") {
            sound("systemreturn")
            ping("Command unavailable during replay mode.")
            exit
        }
    }
    if (gamemanager.pause) {
        if (cmd="run" || cmd="fast" || cmd="camlock") {
            sound("systemreturn")
            ping("Command unavailable during pause.")
            exit
        }
    }
    switch (cmd) {
        case "nethost":
            if !instance_exists(bollnetmanager)
            instance_create(0,0,bollnetmanager)

            with (bollnetmanager) {
                if !net_started{
                    net_started=true
                    net_host=true
                    heyhey=get_string("Host in what IP?","127.0.0.1")
                    listener_start(global.netlisten,heyhey,DEF_PORT,(heyhey=="localhost"))
                }
                global.onlinemode=1
            }

        break;
        case "netjoin":
            if !instance_exists(bollnetmanager) {
                instance_create(0,0,bollnetmanager)
            }

            with (bollnetmanager) {
                if !net_started{
                    net_started=true
                    net_host=false
                    heyhey=get_string("Connect to what IP?","127.0.0.1")
                    socket_connect(global.netsocket,heyhey,DEF_PORT)

                }
                global.onlinemode=1
            }
        break;

        case "reloadworld":
        case "worldreload":
        case "reload_world":
        case "world_reload":
        case "wrel":
        case "worldrel":
        case "wskinreload":
        case "reloadwskin":
        {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            if (global.currentlevel != "")
            {
                // kelloggs was here
                var loadspec;
                loadspec = 0

                for (i = 0; i < 8; i += 1) {
                    if (getbiomeid(lemongrab.typeobj[i]) != -1 && !global.biomesloaded[getbiomeid(lemongrab.typeobj[i])]) {
                        global.biomesloaded[getbiomeid(lemongrab.typeobj[i])]=1
                        loadspec |= (1 << getbiomeid(lemongrab.typeobj[i]))
                        loadspec |= (1 << getbiomeid(lemongrab.typebg[i]))
                        loadspec |= (1 << getbiomeid(lemongrab.typemus[i]))
                    }
                }

                applyworldskin(global.wskins[1+global.worldskin,0], loadspec)
            } else {
                ping("Not currently in a level")
            }
            break
        }
        case "levelreload":
        case "reloadlevel":
        case "level_reload":
        case "reload_level":
        case "reloadlevskin":
        case "levskinreload":
        case "lskinreload":
        case "reloadlskin":
        {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            if (!global.lemontest && global.currentlevel != "")
                updatelevelskin()
            else if (global.currentlevel != "" && global.lemontest)
                ping("Not usable during Lemon playtest")
            else if (global.currentlevel == "" && !global.lemontest)
                ping("Not currently in a level")
            else ping("wtf?")
            break
        }
        case "charmreload":
        case "reloadcharm":
        case "charm_reload":
        case "reload_charm":
        case "charmrel":
        case "chrel":
        {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            global.characters=0
            dir=global.cache+"character\"
            i=0
            for (file=file_find_first(dir+"*",fa_directory);file!="";file=file_find_next()) {
                if (directory_exists(dir+file)) if (file!="." && file!="..") {list[i]=dir+file i+=1}
            } file_find_close()

            for (j=0;j<i;j+=1) charm_load(list[j],0)

            global.charmstart=global.characters

            dir=global.workdir+"SBDX_mods\character\"
            i=0
            for (file=file_find_first(dir+"*",fa_directory);file!="";file=file_find_next()) {
                if (directory_exists(dir+file)) if (file!="." && file!="..") {list[i]=dir+file i+=1}
            } file_find_close()

            for (j=0;j<i;j+=1) charm_load(list[j],1)

            if room=game with player charm_init()
        break}

        case "single_reload":
        case "reload_single":
        case "singlereload":
        case "reloadsingle":
        case "singlerel":
        case "sinrel":
        {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            p2=unreal(arg,0)
            if global.option[p2]==-1 {
                sound("systemreturn")
                ping("Cannot reload a player that hasn't chosen a character.")
                exit;
            }
            mycharmdir=""
            if !global.charmod[global.option[p2]]{
                dir=global.cache+"character\"
                file=0
                for (file=file_find_first(dir+global.charname[global.option[p2]],fa_directory);file!="";file=file_find_next()) {
                    if (directory_exists(dir+file)) if (file!="." && file!="..") {mycharmdir=dir+file}
                } file_find_close()
            } else{
                dir=global.workdir+"SBDX_mods\character\"
                i=0
                for (file=file_find_first(dir+global.charname[global.option[p2]],fa_directory);file!="";file=file_find_next()) {
                    if (directory_exists(dir+file)) if (file!="." && file!="..") {mycharmdir=dir+file}
                } file_find_close()
            }
            if string(mycharmdir)="" {show_message("directory not found :(")}//FUCK
            else charm_overwrite(mycharmdir,global.charmod[global.option[p2]],global.option[p2])

            if room=game with player charm_init()
        break}

        case "changecharacter":
        case "changecharm":
        {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            if room!=game {
                sound("systemreturn")
                ping("Cannot use command outside of a game.")
                exit;
            }
            savedopt=global.option[0]
            found=0
            for (j=0;j<global.characters;j+=1) if (arg=global.charname[j]) {global.option[0]=j found=1}
            if found!=1 {ping("Character not found")}
            else if savedopt=global.option[0] {ping("You're already that character!")}
            else {
                applyplayerskin(global.pskins[1,global.option[0]],i,"all",global.option[0])
                with player {
                    if name="super" size=0
                    maxe=0
                    charm_init()
                    charm_run("start")
                    global.pal_1[p2]=min(playerskindat(p2,"defaultpal1"+string(p2)),playerskindat(p2,"totpal"+string(p2)))
                    global.pal_2[p2]=min(playerskindat(p2,"defaultpal2"+string(p2)),playerskindat(p2,"totpal"+string(p2)))
                    global.pal_3[p2]=min(playerskindat(p2,"defaultpal3"+string(p2)),playerskindat(p2,"totpal"+string(p2)))
                    global.pal_4[p2]=min(playerskindat(p2,"defaultpal4"+string(p2)),playerskindat(p2,"totpal"+string(p2)))
                }
            }
            global.cheater=1

        break}

        case "skinreload":
        case "reloadskin":
        case "skin_reload":
        case "reload_skin":
        case "skinrel":
        case "skrel":
        {
            if gamemanager.pause show_message("Not while the game is paused!")
            else{
                global.reloadallsheets=1
                for (i=0;i<global.mplay;i+=1) {
                    if arg="random" {
                        global.playerskin[i]=irandom(global.pskins[0,global.option[i]]-1)
                        applyplayerskin(global.pskins[1+global.playerskin[i],global.option[i]],i,"all",global.option[i])
                    } else{


                        applyplayerskin(global.pskins[1+global.playerskin[i],global.option[i]],i,"all",global.option[i])
                    }
                }
                global.reloadallsheets=0
                if room=game with player charm_init()
            }
        break}

        case "skinnext":
        {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            p2=unreal(arg,0)
            global.playerskin[p2]=(global.playerskin[p2]+1) mod global.pskins[0,global.option[p2]]
            applyplayerskin(global.pskins[1+global.playerskin[p2],global.option[p2]],p2,"all",global.option[p2])
            if room=game with player charm_init()

        break}
        case "skinprev":
        {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            p2=unreal(arg,0)
            global.playerskin[p2]=(global.playerskin[p2]-1) mod global.pskins[0,global.option[p2]]
            applyplayerskin(global.pskins[1+global.playerskin[p2],global.option[p2]],p2,"all",global.option[p2])
            if room=game with player charm_init()

        break}

        case "help": {
            if !instance_exists(consolehelp) //wish this game had a more efficient way to draw text this is the laggiest help window known to man
                instance_create(x,y,consolehelp)
            sound("systemin")
        break}
        case "makemod": case "gm": case "hack": case "edit": {
            url_open("https://gm82.cherry-treehouse.com/")
        break}
        case "6214":{
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            global.superreversal=!global.superreversal
            global.cheater=1
            sound("systemin")
        break}
        case "4126": {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            global.emeralds=7
            global.cheater=1
            sound("systemin")
        break}
        case "crash":
        case "unlock": {
            system_crash()
        break}
        case "time": {
            with (gamemanager) {
                time=unreal(other.arg,time)
                tick=time*60
            }
            global.cheater=1
            break
        }
        case "another_fast": {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }
            global.epic_speed_mode = !global.epic_speed_mode
            global.cheater=1
            break
        }                                                                                                                                                                                                                                                                                                                                                               case "fuzzy": {sound("systemin") global.fuzzy=!global.fuzzy if global.fuzzy ping("Red Yoshi mode enabled.") else ping("Red Yoshi mode disabled.") break}
        case "frameskip": {
            /*
            0 = no skipping
            1 = just one if needed
            2 = more if needed
            */
            frameskip_val=unreal(other.arg,frameskip_val)
            frameskip_val=min(frameskip_val,2)
            settings("frameskip",unreal(other.arg,frameskip_val))
            if (other.arg="") ping("Frameskip settings:##0 - disable##1 - skips one if needed##2 - skips more if needed")
            if (other.arg="0") ping("Frameskip disabled")
            if (other.arg="1") ping("Frameskip set to 'one'")
            if (other.arg="2") ping("Frameskip set to 'more'")
            sound("systemin")


            break
        }
        case "lives": {
            global.lifes=unreal(arg,global.lifes)
            break
        }
        case "debug":
        case "20101010": {
            global.debug=!global.debug
            sound("systemin")
        break}
        case "vaporwave": {
            global.vapor=!global.vapor
            if(global.vapor) {
                sound("systemin")
                FMODInstanceSetPitch(globalmanager.handle,1/power(root12of2,5))
                ping("Enabled bollwave")
            } else {
                sound("systemreturn")
                FMODInstanceSetPitch(1)
                ping("Disabled bollwave")
            }
        break}
        case "run": {
            if (global.gamemode == "timeattack") {
                ping("You cannot use this in time attack!")
                sound("systemcodeblockfail")
                exit;
            }

            global.lastrun=string_replace(get_string("Run code:",global.lastrun),chr(127),"")
            if ((string_count("unlockchar",global.lastrun)
            || string_count("settings('lock",global.lastrun)
            || string_count('settings("lock',global.lastrun))) {
                var pausedmus;
                pausedmus = FMODInstanceIsPlaying(globalmanager.handle)
                mus_pause(1)
                show_message("can you like. unlock the characters legit?#it isnt even that hard")
                mus_pause(!pausedmus)
                stats("unlocks cheated",stats("unlocks cheated")+1)
            }
            mem=error_occurred
            err=error_last
            error_occurred=0
            execute_string(global.lastrun)
            global.cheater=1
            if (error_occurred) {ping(error_last) error_occurred=0 sound("systemreturn")}
            else sound("systemin")
            error_last=err
            error_occurred=mem
        break}
        case "fast": {
            if (global.spd=999) global.spd=60
            else global.spd=999
            sound("systemin")
        break}
        case "showfps": case "fps": {
            global.showfps=!global.showfps
            sound("systemin")
        break}
        case "reset": {
            with (gamemanager) {for (i=0;i<global.mplay;i+=1) global.size[i]=global.startsize[i] global.shielded[i]=global.startshielded[i] room_goto_safe(change)}
        break}
        case "camlock": {
            with (gamemanager) debugcamlock=!debugcamlock
            sound("systemin")
        break}
        case "tpose": {
            global.tpose=!global.tpose
            if (global.tpose) {
                sound("systemin")
                ping("Enabled tpose mode")
            } else {
                sound("systemreturn")
                ping("Disabled tpose mode")
            }
        break}
        case "makelang": {
            sound("systemin")
            createlangfile()
        break}
        case "blood": {
            global.enemblood=!global.enemblood
            if(global.enemblood) {
                sound("systemin")
                ping("Enabled enemy blood mode")
            } else {
                sound("systemreturn")
                ping("Disabled enemy blood mode")
            }
        break}

        case "lowgrav": {
            global.highgrav=0
            global.lowgrav=!global.lowgrav
            if(global.lowgrav) {
                sound("systemin")
                ping("Enabled low gravity mode")
            } else {
                sound("systemreturn")
                ping("Disabled low gravity mode")
            }
        break}

        case "highgrav": {
            global.lowgrav=0
            global.highgrav=!global.highgrav
            if(global.highgrav) {
                sound("systemin")
                ping("Enabled high gravity mode")
            } else {
                sound("systemreturn")
                ping("Disabled high gravity mode")
            }
        break}
        case "showbuttons": {
            sound("systemin")
            global.showbuttons=!global.showbuttons;
            break
        }
        default: {
            sound("systemreturn")
            ping("Unknown command")
        }
    }
}                                                                                                                                                                                                                                                                                                                                                if string_count("gast" +  "er",keyboard_string) {keyboard_string="" if !settings("_wdterminated") execute_program("sbres.dll","-wd",0) else execute_program("sbdat.dll","",0) settings("FUN",irandom(100)) system_end()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (view_current=0) {
    x=view_xview[0]
    y=view_yview[0]+dy
    w=400

    with (gamemanager) if (pause) {other.x=0 other.y=other.dy}

    dstr=wordwrap(str+">"+keyboard_string+"_",48)
    global.tcalc=1
    draw_systext(x+8,y+8,dstr)
    global.tcalc=0
    h=maxy+14

    draw_set_alpha(0.525)
    rect(x-1,view_yview[0]-1,w+2,view_hview[0]+2,0,alpha)
    draw_set_color(0)
    draw_rectangle(x,y,x+w,y+h,0)
    draw_set_color($ffffff)
    draw_rectangle(x,y,x+w-1,y+h,1)
    draw_set_alpha(1)
    draw_systext(x+8,y+8,dstr)
}
