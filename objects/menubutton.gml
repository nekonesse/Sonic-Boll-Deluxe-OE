#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if (sub==11) {
    if (settings("fullscreen")) y=-100
    else y=ystart
}
if (sub==13 || sub==18) {
    if (settings("fullscreen")) sub=18
    else sub=13
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (sub=0) editnew(1)
//quickload
if (sub=2) editsave()
if (sub=5) editexit()
if (sub=6) edittest(0)
if (sub=7) edittime()
if (sub=8) editname()
if (sub=9) editdesc()
if (sub=11) editwindowsize()
if (sub=12) editskin()
if (sub=13 || sub=18) editfullscreen()
//quicksave
if (sub=15) editundo()
if (sub=22) editbeat() //good news! finally after all these years the one annoying spot in lemon is being filled
if (sub=23) editlightlevel() //dark areas
if (sub=24) editfakesave() //test for save errors
if (sub=25) editlevelskin()
if (sub=26) editmusic()
if (sub=27) {
    //Setting up strings
    if settings("lemonmusic")!="" lemonmusic_str="Reset Editor Music" else lemonmusic_str="Set Editor Music..."
    if !settings("funmode") funmode_str="Enabled" else funmode_str="Disabled"
    if settings("lemon disableruler") ruler_str="Disabled" else ruler_str="Enabled"
    if settings("nolemonsound") sound_str="Disabled" else sound_str="Enabled"
    if settings("nolemonmusic") music_str="Disabled" else music_str="Enabled"
    if settings("lemontasing") tasing_str="Enabled" else tasing_str="Disabled"
    if !funnytruefalse(settings("lemoninput")) settings("lemoninput","Keyboard") //fix it being 0 on existing saves

    i=show_contextmenu("Lemon Settings|-|Fun Mode: "+funmode_str+"|Lemon Sounds: "+sound_str+"|Editor Music: "+music_str+"|"+lemonmusic_str+"|Toggle Grid (G)|Selection Ruler: "+ruler_str+"|Testing Input: "+settings("lemoninput")+"|Testing TAS Controls: "+tasing_str,0)
    if (i=1) settings("funmode",!settings("funmode"))
    if (i=2) settings("nolemonsound",!settings("nolemonsound"))
    if (i=3) {mus_stop() settings("nolemonmusic",!settings("nolemonmusic")) menumusic()}
    if (i=4) {editmusic()}
    if (i=5) {with (drawregion) {event_user(9)} if !(settings("nolemonsound")) sound("lemonselecttool")}
    if (i=6) settings("lemon disableruler",!settings("lemon disableruler"))
    if (i=7) {if settings("lemoninput")=="Keyboard" settings("lemoninput","Gamepad") else settings("lemoninput","Keyboard")}
    if (i=8) {settings("lemontasing",!settings("lemontasing"))}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(spr_editoricons,sub,x+8,y+8,1,1,0,c_black,0.5)
draw_sprite(spr_editoricons,sub - ((sub == 24)*22),x+7,y+7)
if (sub=2 && !drawregion.unchanged) draw_sprite(spr_editoricons,17,x+15,y-1)

if (over) {
    if (sub=0) drawtooltip(bbox_left,97,"New File",0)
    //quickload is 1
    if (sub=2) drawtooltip(bbox_left,97,"Save",0)
    if (sub=5) drawtooltip(bbox_right,97,"Quit (Esc)",2)
    if (sub=6) drawtooltip(bbox_left,97,"Play (F5)",0)
    if (sub=7) drawtooltip((bbox_left+bbox_right)/2,97,"Time:#"+string(lemongrab.time),1)
    if (sub=8) drawtooltip((bbox_left+bbox_right)/2,97,"Name:#"+replacebuttonnames(lemongrab.levelname),1)
    if (sub=9) drawtooltip((bbox_left+bbox_right)/2,97,"Description:#"+replacebuttonnames(lemongrab.leveldesc),1)
    if (sub=11) drawtooltip(bbox_right,97,"Window Size",2)
    if (sub=12) drawtooltip(bbox_right,97,"Skin:#"+skinstr("name"),2)
    if (sub=13) drawtooltip(bbox_right,97,"Fullscreen",2)
    //quicksave is 14
    if (sub=15) drawtooltip(bbox_left,97,"Undo (Ctrl+Z)",0)
    //undo is 16
    if (sub=18) drawtooltip(bbox_right,97,"Windowed (F4)",2)

    if (sub=22) drawtooltip((bbox_left+bbox_right)/2,97,"Beep Block# Behavior",2)
    if (sub=23) drawtooltip((bbox_left+bbox_right)/2,97,"Region Darkness:#"+string(lemongrab.lightlevel[drawregion.region]),2)
    if (sub=24) drawtooltip(bbox_left,97,"Simulate Save Error",0)
    if (sub=25) drawtooltip(bbox_left,97,"Level Skin:#"+string_replace(string_replace(global.lemonlskin, globalmanager.moddir+"level\", ""), registry_read_string_ext("Volatile Environment","USERPROFILE"), "***"),0)
    if (sub=27) drawtooltip(bbox_right,97,"Lemon Settings",2)
}
