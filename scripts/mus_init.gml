///mus_init()
var i,c,strmhandle;

with (globalmanager) {
    mushandles=ds_map_create()
    musfade=0
    handle=-1
    global.music=""
    global.musicmem=""

    c=0  mload[c]="boss"
    c+=1 mload[c]="credits"
    c+=1 mload[c]="death"
    c+=1 mload[c]="drowning"
    c+=1 mload[c]="extra"
    c+=1 mload[c]="finish"
    c+=1 mload[c]="finishsign"
    c+=1 mload[c]="finishblock"
    c+=1 mload[c]="finishworld"
    c+=1 mload[c]="gameover"
    c+=1 mload[c]="hurry"
    c+=1 mload[c]="special"
    c+=1 mload[c]="starman"
    c+=1 mload[c]="start"
    c+=1 mload[c]="princess"
    c+=1 mload[c]="pswitch"
    c+=1 mload[c]="finale"
    c+=1 mload[c]="finalboss"
    c+=1 mload[c]="finaldoss"
    c+=1 mload[c]="altunderground"
    c+=1 mload[c]="escape"

    for (i=0;i<global.biomes;i+=1) {
        c+=1 mload[c]=global.biome[i]
        c+=1 mload[c]=global.biome[i]+"fast"
    }

    musc=c
    for (i=0;i<=musc;i+=1) {
        ds_map_add(mushandles,mload[i],0)
        ds_map_add(mushandles,mload[i]+"_filename",0)
    }
    ds_map_add(mushandles,"all",0)
    ds_map_add(mushandles,"allfast",0)
    ds_map_add(mushandles,"options",0)
    ds_map_add(mushandles,"editor",0)
    ds_map_add(mushandles,"all_filename",0)
    ds_map_add(mushandles,"allfast_filename",0)
    ds_map_add(mushandles,"options_filename",0)

    strmhandle=FMODSoundAdd(global.cache+"media\title_screen.wav"    ,2) ds_map_add(mushandles,"_intro"   ,strmhandle) FMODSoundSetGroup(strmhandle,1)
    strmhandle=FMODSoundAdd(global.cache+"media\options.mod" ,2) ds_map_add(mushandles,"_options" ,strmhandle) FMODSoundSetGroup(strmhandle,1) //FMODSoundSetLoopPoints(strmhandle,6656/max(1,FMODSoundGetLength(strmhandle)),1)
    strmhandle=FMODSoundAdd(global.cache+"media\optionsc.ogg",2) ds_map_add(mushandles,"_optionsc",strmhandle) FMODSoundSetGroup(strmhandle,1)
    strmhandle=FMODSoundAdd(global.cache+"media\mfbolloptions.ogg",2) ds_map_add(mushandles,"_optionsmf",strmhandle) FMODSoundSetGroup(strmhandle,1)
    strmhandle=FMODSoundAdd(global.cache+"media\reset.ogg"   ,2) ds_map_add(mushandles,"_reset"   ,strmhandle) FMODSoundSetGroup(strmhandle,1)
    strmhandle=FMODSoundAdd(global.cache+"media\editor.ogg"   ,2) ds_map_add(mushandles,"_editor"   ,strmhandle) FMODSoundSetGroup(strmhandle,1) FMODSoundSetLoopPoints(strmhandle,3820/max(1,FMODSoundGetLength(strmhandle)),1)
    replacesound("systemreturn"       ,global.cache+"media\return.wav"     )
    replacesound("systemselect"       ,global.cache+"media\select.wav"     )
    replacesound("systemrandom"       ,global.cache+"media\random.wav"     )
    replacesound("systemactualrandom" ,global.cache+"media\randomold.wav"  )
    replacesound("systemstart"        ,global.cache+"media\start.wav"      )
    replacesound("systemgo"           ,global.cache+"media\go.wav"         )
    replacesound("systemin"           ,global.cache+"media\debug.wav"      )
    replacesound("systemdel"          ,global.cache+"media\del.wav"        )
    replacesound("systemhit"          ,global.cache+"media\hit.wav"        )
    replacesound("systemcodeblockfail",global.cache+"media\epicfail.wav"   )
    replacesound("ta_settime"         ,global.cache+"media\ta_settime.wav" )
    replacesound("ta_epicfail"        ,global.cache+"media\ta_epicfail.wav")

    lemonpath=global.cache+"media\lemon\"

    replacesound("lemonautosave"      ,lemonpath+"lemonautosave.wav"    )
    replacesound("lemonbucketdrag"    ,lemonpath+"lemonbucketdrag.wav"  )
    replacesound("lemoncontext"       ,lemonpath+"lemoncontext.wav"     )
    replacesound("lemonerase"        ,lemonpath+"lemoneraser.wav"      )
    replacesound("lemonnuke"          ,lemonpath+"lemonnuke.wav"        )
    replacesound("lemonlevelsave"     ,lemonpath+"lemonlevelsave.wav"   )
    replacesound("lemonlevelload"     ,lemonpath+"lemonlevelload.wav"   )
    replacesound("lemonmodechange"    ,lemonpath+"lemonmodechange.wav"  )
    replacesound("lemonselectitem"    ,lemonpath+"lemonselectitem.wav"  )
    replacesound("lemonselecttool"    ,lemonpath+"lemonselecttool.wav"  )
    replacesound("lemonclick"    ,lemonpath+"lemonclick.wav"  )

    mm=settings("menumusic")
    if (mm!="") {
        if (!file_exists(mm)) settings("menumusic","")
        else replaceogg("options",mm)
    }
    mm=settings("lemonmusic")
    if (mm!="") {
        if (!file_exists(mm)) settings("lemonmusic","")
        else replaceogg("editor",mm)
    }
}
