var esc,pinc;
esc=input_esc() && !instance_exists(console)

if (global.playback) {
    if (pause) {
        if (keyboard_check_pressed(vk_left)) {framestep=1 game_unpause() exit}
        if (keyboard_check_pressed(vk_down)) {game_unpause() global.spd=20 exit}
        if (keyboard_check_pressed(vk_right)) game_unpause()
    } else {
        if (keyboard_check(vk_down)) global.spd=20
        if (keyboard_check(vk_right)) global.spd=60
        if (keyboard_check(vk_space)) global.spd=999
        if (esc) {room_goto_safe(replays) exit}
        if (keyboard_check(vk_enter) && !skipresult && !instance_exists(console) && !instance_exists(message)) {
            mus_stop()
            skipresult=1
            global.movieskipping=1
            game_stageend()
            exit
        }
        if (global.spd!=60) {
            FMODGroupSetPitch(2,global.pfps/60)
            FMODGroupSetPitch(1,global.pfps/60)
        } else {
            FMODGroupSetPitch(2,1)
            FMODGroupSetPitch(1,1)
        }
        if (keyboard_check_pressed(vk_left) || framestep) game_pause()
        framestep=0
    }
    exit
}
if (pausequit) exit
if (pause) {
    input_get(pauseinput)
    input_keystates()
    if (quitask) {
        if (up || down) {if (!udlok) {udlok=1 pausel=down sound("systemselect")}} else udlok=0
        if (abut || sbut || esc)&&!reset&&!settings("kidresetbuf") {
            sound("systemreturn")
            if (pausel && !esc) {
                quitask=0
                pausel=2
            } else {
                pausequit=1
                savemovie()
                room_speed=60
                instance_create(0,0,pausefade)
                if (global.gamemode="battle") pausefade.goto=results
            }
        }
    } else if (retryask) {
        if (up || down) {
            if (!udlok) {
                udlok=1
                pausel=modulo(pausel+down-up,0,3)
                sound("systemselect")
            }
        } else udlok=0
        if (abut || sbut || esc)&&!reset&&!settings("kidresetbuf") {

            if (pausel=2 || esc) {
                retryask=0
                pausel=1
                sound("systemreturn")
            } else  if (!pausel && global.check="") {
                sound("systemreturn")
            } else if !instance_exists(pausefade) {
                sound("systemstart")
                global.respawn=1
                if pausel global.check=""
                with (gamemanager) {
                    for (i=0;i<global.mplay;i+=1) {
                        if pausel {
                            global.size[i]=global.startsize[i]
                            global.shielded[i]=global.startshielded[i]
                        } else {
                            global.size[i]=0
                            global.shielded[i]=0
                        }
                    }
                    if (global.gamemode=="classic" && !settings("cog inflives") && !global.lemontest) global.lifes-=1
                    with instance_create(0,0,pausefade) goto=change
                }
            }
        }
    } else {
        if ((up || down) && !(abut || sbut)) {
            if (!udlok) {
                udlok=1
                pausel=modulo(pausel+down-up,0,6)
                sound("systemselect")
            }
        } else udlok=0
        if (pausel=1 && (abut || sbut) && !esc && !quitask) {
            if (global.lifes<=1 && global.gamemode=="classic" && !settings("cog inflives") && global.charname[global.option[pauseplayer]]!="kid") sound("systemreturn")
            else {
                sound("systemselect")
                retryask=1
                pausel=2
            }
        }
        if ((abut || sbut || esc) && !retryask) {
            if (pausel=2 || esc) {
                sound("systemselect")
                quitask=1
                pausel=1
            }
        }

        if (pausel=0 && (arel || sbut) && !esc) {
            if (settings("musbalance")=0) {
                FMODAllStop()
                pl=-1
            }
            game_unpause()
            sound("systempause")
        }
        if (pausel=3) {
            handle=0
            if (left || right) {if (!lrlok) {
                if (left) {
                    if (settings("fullscreen")) {
                        settings("fullscreen",0)
                        settings("zoom",3)
                        handle=1
                    } else {
                        if (settings("zoom")>1) {
                            settings("zoom",settings("zoom")-1)
                            handle=1
                        }
                    }
                } else {
                    if (settings("zoom")<3) {
                        settings("zoom",settings("zoom")+1)
                        handle=1
                    } else if (!settings("fullscreen")) {
                        settings("fullscreen",1)
                        handle=1
                    }
                }
            } lrlok=1} else lrlok=0
            if (handle) {
                sound("systemselect")
                windowhandler()
            }
        }
        if (pausel=5) {
            if (left || right) {if (!lrlok) {
                settings("volbalance",median(0,settings("volbalance")+(right-left)*0.125,1))
                mus_volume(1)
                volumehandler()
                //if (settings("volbalance")=1) FMODAllStop()
                sound("systemselect")
            } lrlok=1} else lrlok=0
        }
        if (pausel=4) {
            if (left || right) {if (!lrlok) {
                settings("musbalance",median(0,settings("musbalance")+(right-left)*0.125,1))
                mus_volume(1)
                volumehandler()
                if (pl!=0 && settings("musbalance") != 0) {if (pl=-1) updatemusic() pl=0 playmusic=1 global.music=""}
                sound("systemselect")
            } lrlok=1} else lrlok=0
        }

        if (cbut) {
            pausepage+=1
        }
    }
} else if (!global.playback && !global.kill) {
    if (esc && global.lemontest) room_goto(lemon)
    else {
        with (player) if ((sbut || esc) && !reset && !settings("kidresetbuf")) with (other) {
            pause=1
            pauseplayer=other.p2

            if (other.super) pinc=4
            else pinc=other.size

            pausepage=global.pagespec[global.option[pauseplayer],pinc]
            while (pausepage=-1) {
                if (pinc) pinc-=1
                else {pausepage=0 pagestr=0}
                pausepage=global.pagespec[global.option[pauseplayer],pinc]
            }
        }
        with (moranboll) if ((sbut || esc) && !stop && !dead && !falling) with (other) {
            pause=1
            pauseplayer=other.p2
        }
        if (!global.focus && settings("autopause") && !instance_exists(changectrl) && !(global.tasing || (global.lemontest && settings("lemontasing")))) {
            pause=1
            pauseplayer=0
        }

        if (pause) {

        if !global.discordoverride {
           if (global.lemontest){discord_update_presence("Playing as "+playerskinstr(top,"name"+string((top))),"Testing Level ("+string(global.levelname)+") (Paused) ","boll-icon","lemon-icon")}
           else if global.movie=1 {discord_update_presence("Player is "+playerskinstr(top,"name"+string((top))),"Watching replay on ("+string(global.levelname)+") (Paused) ","boll-icon","movie-icon")}
           else if global.gamemode="timeattack" {discord_update_presence("Playing as "+playerskinstr(top,"name"+string((top))),"Playing Time Attack on ("+string(global.levelname)+") (Paused) ","boll-icon","timeattack-icon")}
           else {discord_update_presence("Playing as "+playerskinstr(top,"name"+string((top))),"In Game ("+string(global.levelname)+") (Paused) ","boll-icon","")}
        }

            pauseinput=global.input[pauseplayer]
            if (plock) pause=0
            else {game_pause() sound("systempause")}
        } else plock=0
    }
}
