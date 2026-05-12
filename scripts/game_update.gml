//updates ingame timer and related music tasks




if (timeleft>0) {tl+=1 if (tl=60) {tl=0
    timeleft-=1
    if (timeleft=12) {mus_play("drowning",0) drowning=1}
    if (timeleft=0 && !global.debug) {
        drowning=0
        for (i=0;i<global.mplay;i+=1) if (!flag.passed[i]) with (players[i]) com_cancel()
        timedead=1
        with (flag) if (count) {
            count=global.mplay
            frspd=1
            yup=1
            ending=1
            sound("itemflagpole")
            alarm[0]=30
        }
    }
}}

if (!flag.yup && !timedead && !deathtimer && !instance_exists(bollgate) && !global.wanna && global.inf_time!=1) {
    tick=max(0,tick-1)
    for (i=0;i<global.mplay;i+=1) if (!flag.passed[i]) players[i].tick=tick
    if (tick/60<time) {
        time=max(0,tick div 60)
        for (i=0;i<global.mplay;i+=1) if (!flag.passed[i]) players[i].time=time
        var supermusic;
        supermusic=0 with (player) if (super && playsupermusic) supermusic=1
        if (!stop && global.music!="boss" && !supermusic && !skindat("nofast")) {
            if (time<=skindat("hurrytime") && timeleft=-1 && !fasting) {
                fasting=1
                l=0 if (skindat("hurry")) l=FMODSoundGetLength(ds_map_find_value(globalmanager.mushandles,"hurry"))
                if (l<8) {fasttimer=1 fasttime=current_time-1}
                else {mus_play("hurry",0) fasttimer=1 fasttime=current_time+l+200}
            }
        }
    }
    if (tick=0 && !sekiro && timeleft=-1 && !flag.count && !global.debug) {
        with (player) if (!finish) com_cancel()
        if (global.mplay>1) {flag.alarm[7]=380 sekiro=1}
        else deathtimer=1
        timeleft=-1
    }
}

if (global.inf_time==1 && global.gamemode="timeattack" && !gamemanager.timedead /* :P */) { //time attack upward-counting timer
    if tick && !resettimer {tick=0 resettimer=1}
        tick=max(tick+1,0)
    for (i=0;i<global.mplay;i+=1) if (!flag.passed[i]) {players[i].tick=tick}
    if (tick/60>time) {
        time=max(0,tick div 60)
        for (i=0;i<global.mplay;i+=1) if (!flag.passed[i]) {players[i].time=time}
        var supermusic;
        supermusic=0 with (player) if (super && playsupermusic) supermusic=1
        //dont need hurry time its time attack
    }
}

if (fasttimer && current_time>fasttime) {//play music after hurry
    fasttimer=0 fasttime=0
    if (!timedead && !stop) playfast()
}

for (i=0;i<4;i+=1) {
    if (players[i].highcoinmax || settings("cog inflives")){
        while global.coins[i]>999
        global.coins[i]=999
    } else
    while (global.coins[i]>99) {
        global.coins[i]-=100
        sound("item1up")
        players[i].coinc+=1
        if (global.mplay=1) {
            give_item(id,"100coin1up")
        }
    }
}

shakek=!shakek
if (shakek) for (i=0;i<4;i+=1) {
    if (shake[i]!=0) shake[i]=(abs(shake[i])-1)*-sign(shake[i])
}

if (playmusic) {
    if (skindat("muspos")=-1 && global.music=skindat("musmem")) skindat("muspos",0)
    else {
        stagemusic(player,-1)
        if (playmusic=2) FMODInstanceSetPosition(globalmanager.handle,skindat("muspos"))
    }
    playmusic=0
    if (global.wanna) global.lifes=-settings("kiddeath")

}
if settings("kidresetbuf")>0 settings("kidresetbuf",settings("kidresetbuf")-1)

if (specialreset) {
    if (deathplayer.rkey) {
        specialreset=0
        segafadeto(title)
    }
}

if (deathtimer && (deathtimer<300 || global.wanna)) {deathtimer+=1
    if (global.wanna) {
        if (deathtimer=2) skindat("muspos",FMODInstanceGetPosition(globalmanager.handle))
        if (deathtimer=20) {mus_play("reset",0,deathplayer.p2)}
        if (deathplayer.rkey) {skindat("musmem",global.music) io_clear() loadtas()}
    } else {
        if (global.gamemode!="battle" && deathtimer=30) { //WHY would you check SPECIFICALLY for CLASSIC MODE? YOU CHECK FOR BATTLE EVERY SINGLE OTHER TIME!!
            if (skindat("deathmusic")) {
                if (global.lifes=1) mus_play("death",0)
                else if (fasting) {mus_fade() global.music=""}
            } else mus_play("death",0)
        }
        if (deathtimer=300 || (deathtimer>60 && (deathplayer.skey || deathplayer.akey || deathplayer.bkey || deathplayer.ckey))) {
            //death handler
            deathtimer=300
            if (global.gamemode!="battle") {

                global.lifes-=(1-(settings("cog inflives") || global.gamemode=="timeattack")) //this is cheap i know
                global.respawn=1
                if (global.lifes<=0 && !settings("cog inflives") && !global.the_cooler_infinite_lives && global.gamemode!="timeattack" && global.gamemode!="coop") {
                    if (global.playback) segafadeto(replays)
                    else instance_create(0,0,gameoverctrl)
                } else if (!checkend()) {
                    inputclassic()
                    discord_update_presence("","Loading a level ("+global.nextlevel+")","boll-icon","dice-icon")
                    segafadeto(change)
                } else segafadeto(replays)
                for (i=0;i<global.mplay;i+=1) {
                    global.size[i] = 0
                    global.shielded[i] = 0
                    global.startsize[i] = 0
                    global.startshielded[i] = 0
                }
            }
        }
    }
}

//load and save tas
if ((global.tasing || (global.lemontest && settings("lemontasing")))) {
    if (mouse_check_button(mb_right)) {with (memory) instance_destroy() with (player) spawnmemory() savetas()}
    if (mouse_check_button(mb_left) || player.rbut) {loadtas()}
}

if (!deathtimer && global.gamemode == "coop") {
    deadamount=0
    for (i=0;i<global.mplay;i+=1) {
        if (players[i].dead == 1) {
            deadamount+=1
            if deadamount == global.mplay {deathtimer=1}
        }
    }
}
