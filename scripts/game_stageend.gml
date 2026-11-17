///game_stageend()
//end stage
var i;

with (gamemanager) {
    for (i=0;i<4;i+=1) {
        global.size[i]=players[i].size
        global.energy[i]=players[i].energy
        global.shielded[i]=players[i].shielded
    }

    global.check=""

    instance_activate_object(skullblock)
    instance_activate_object(skullbloff)
    with (skullblock) restoreblock()
    with (skullbloff) restoreblock()

    with (scriptblock) event_user(2)

    if global.lemontest {segafadeto(lemon) exit}

    if (global.playback && global.pos>=global.length && global.gamemode!="timeattack") {
        segafadeto(replays) exit;
    }

    global.stagecount+=1
    if ((global.stages=2 || string(global.nextlevel)="0")) global.nextlevel=global.randstage[global.stagecount]
    if (global.stages=0) global.randstage[global.stagecount]=global.nextlevel

    if (global.gamemode="battle" && global.visualstagecount>=settings("playstages")) global.nextlevel=""

    if (global.gamemode="classic") inputclassic()

    if global.gamemode!="timeattack" {

        if (global.gamemode="battle") {
            inputresults()
            if (skipresult) {
                if (global.nextlevel="") segafadeto(results)
                else {
                    var path,fn,file,kek;
                    path=global.lskins[global.levelskin+1,0]

                    if (path=global.lbase) fn=path
                    else fn=globalmanager.moddir+path
                    if !file_exists(fn+global.nextlevel+".lemon") && !file_exists(fn+global.nextlevel+".lemon.png") {
                        if global.debug show_message(lang("error level gone1")+global.nextlevel+lang("error level gone2"))
                        savemovie()
                        segafadeto(results)
                    } else {
                        discord_update_presence("","Loading a level","boll-icon","dice-icon")
                        segafadeto(change)
                    }
                }
            } else segafadeto(scoring)
        } else if (global.nextlevel="") {savemovie() segafadeto(credroll)}
        else if (global.stages=1) segafadeto(stagesel) else {

            var path,fn,file,kek;
            path=global.lskins[global.levelskin+1,0]

            if (path=global.lbase) fn=path
            else fn=globalmanager.moddir+path
            if !file_exists(fn+global.nextlevel+".lemon") && !file_exists(fn+global.nextlevel+".lemon.png") {
                if global.debug show_message(lang("error level gone1")+global.nextlevel+lang("error level gone3"))
                savemovie()
                segafadeto(credroll)
                exit
            }
            discord_update_presence("","Loading a level","boll-icon","dice-icon")
            segafadeto(change)
        }
        inputstats()
    } else {
        global.my_ta=players[0].tick
        savemovie()
        if (global.playback) segafadeto(ta_results)
        else segafadeto(name_the_fallen_human)
    }
}
