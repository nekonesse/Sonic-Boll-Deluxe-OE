///savemovie()
//saves a movie, if applicable at the current moment.

if (settings("replaydisabled")) discardmovie() exit;
if (!global.actually_recording_goddamnit) exit
if ((room=stagesel || room=change) && global.stagecount=0) {discardmovie() exit}
if (global.pos<3*60*global.mplay || global.cheater || global.lemontest || global.enteredachardoor) {discardmovie() exit}

var f,s,tn,fn,t;

with (globalmanager) {
    //FMODAllStop()

    directory_create(global.workdir+"replays")

    tn=global.tempdir+"tmp.png"
    fn=global.workdir+"SBDX_replays\"+current_date_filename()+".bmov"
    s=sureface("",224,160)
    if (s=-1) exit
    if (sureface_set_target("")) {
        draw_clear_alpha(0,1)
        if (global.replaythumb) draw_sprite(global.replaythumb,0,0,0)
        t=(global.pos/max(1,global.mplay))/60
        draw_systext(160,56,format(floor(t/60),2)+":"+format(floor(t) mod 60,2),$ffff)
        draw_systext(24,56,formatdate(date_current_datetime()))
        global.halign=2
        draw_systext(200,72,string(global.visualstagecount)+" Lv")
        draw_set_blend_mode(bm_add)
        rect(0,0,224,160,0,1)
        draw_set_blend_mode(0)
        global.halign=1
        draw_sprite(spr_movie,0,0,0)
        if (global.tasing) draw_sprite(spr_movie,1,0,0)
        draw_systext(112,28,gametitle+" v"+version)
        global.halign=0
        surface_reset_target()
        surface_save(s,tn)
        sureface_free("")
    }

    clearbuffer()
    f=fileopen(tn,0)
    fs=filesize(f)
    fileread(f,fs)
    fileclose(f)
    file_delete(tn)

    writestring(movieheader())
    copybuffer(0,global.keylog)
    writeuint(fs)

    f=fileopen(fn,1)
    filewrite(f)
    fileclose(f)

    discardmovie()
    global.length=1
    global.pos=1
}
