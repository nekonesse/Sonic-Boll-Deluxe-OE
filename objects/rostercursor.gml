#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/








canclic=0
input_clear()
alarm[0]=2
canmouse=0
image_speed=0

image_blend=playercol(0)
mybox=-1
might=0
held=0
p2=0
lastp2=verybignumber //for unlock tips (so that the unlock tip doesnt zero out if the first locked character hovered isnt the first character in the roster)

pf1=noone
pf2=noone
pf3=noone
pf4=noone
pf5=noone
pf6=noone
pf7=noone
pf8=noone
pf9=noone
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (p2=0) mousecursor(1)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i,selchar;

if (instance_exists(segafade)) if (segafade.object_index=segafade) exit

input_get(p2)
if (p2=0 && canmouse && !global.ignorejoy) mousecursor(0)
input_keystates()

if (!held) {
    if !cantkeycontrol {
    x=median(view_xview[0]+8,x+(right-left)*(2+1*(xkey)),view_xview[0]+392)
    y=median(view_yview[0]+8,y+(down-up)*(2+1*(xkey)),view_yview[0]+216)
    } else {if (right||left||down||up)&&mybox {x=mybox.x y=mybox.y visible=0}}
    pf1=instance_position(x,y,rostergm) //we are so back rostergmbros
    pf2=instance_position(x,y,rostercard)
    if (mybox) pf3=instance_position(x,y,mybox) else pf3=noone
    pf6=instance_position(x,y,genericbutton)
    pf7=instance_position(x,y,mmicon)
    pf8=instance_position(x,y,rosterrandom)

    canclic=(pf1 || pf3 || pf4)
}

if (canclic) pf2=noone
with (pf3) over=ready
with (pf2) over=1+other.p2
with (pf6) over=1
with (pf7) event_user(1)
with (pf8) over=1

if (pf3) {
    var b2; b2 = pf3.p2
    if cbut global.pal_1[b2]=(global.pal_1[b2]+1) mod playerskindat(b2,"totpal"+string(b2))
    if xbut global.pal_2[b2]=(global.pal_2[b2]+1) mod playerskindat(b2,"totpal"+string(b2))
    if ybut global.pal_3[b2]=(global.pal_3[b2]+1) mod playerskindat(b2,"totpal"+string(b2))
    if zbut global.pal_4[b2]=(global.pal_4[b2]+1) mod playerskindat(b2,"totpal"+string(b2))

    if rbut {
        global.pal_1[mybox.p2]=(playerskindat(mybox.p2,"defaultpal1"+string(mybox.p2)))
        global.pal_2[mybox.p2]=(playerskindat(mybox.p2,"defaultpal2"+string(mybox.p2)))
        global.pal_3[mybox.p2]=(playerskindat(mybox.p2,"defaultpal3"+string(mybox.p2)))
        global.pal_4[mybox.p2]=(playerskindat(mybox.p2,"defaultpal4"+string(mybox.p2)))
    }

    if (cbut || xbut || ybut || zbut || rbut) {
        var sprayloop, mydat;
        sprayloop=2
        repeat (3) {
            mydat = playerskindat(b2,"reroutepal"+string(sprayloop)+string(b2))
            if mydat!=0 {
                variable_global_array_set("pal_"+string(sprayloop),b2,variable_global_array_get("pal_"+string(mydat),b2))
                if ((sprayloop==2 && xbut) || (sprayloop==3 && ybut) || (sprayloop==4 && zbut)) sound("ta_epicfail")

            }
            sprayloop+=1
        }
    }
}

if (pf2) {
if (settings("lock "+global.charname[pf2.p2])) {
    if (pf2.p2 != lastp2) {
        my_rostercard=pf2
        string_execute(global.unlockdata[pf2.p2])
        if (string(global.unlockdata[pf2.p2])=="0" || string(global.unlockdata[pf2.p2])=="" || string(unlocktip)="" || string(unlocktip)="0") {unlocktip="No unlock tip exists for this character."}
        my_rostercard=noone;
    }
    mmlegends.str=unlocktip
}
lastp2=pf2.p2
}

go=0 with (rosterbox) if (ready) other.go=1
if (sbut && go) with (rosterctrl) event_user(0)

if (abut) {
    if (pf1) with (pf1) event_user(0)
    else with (rostergm) pick=0
    if (pf2) {
        selchar=pf2.p2
        if (!settings("lock "+global.charname[pf2.p2]) || selchar=-1) {
            notready=0
            if (!mybox || (keyboard_check(vk_control) && keyboard_check(vk_shift))) for (i=3;i>=0;i-=1) with (rosterbox) if (p2=i && !ready) {other.mybox=id}
            if (mybox) {
                global.input[mybox.p2]=p2
                if (global.option[mybox.p2]!=selchar || !mybox.ready) {
                    global.playerskin[mybox.p2]=0
                    if global.option[mybox.p2]!=selchar {global.topleftplayerskin[mybox.p2]=0 mybox.vertselect=0}
                    global.option[mybox.p2]=selchar
                    for (i=0;i<4;i+=1) if (global.playerskin[mybox.p2]=global.playerskin[i] && mybox.p2!=i && global.option[mybox.p2]=global.option[i] && global.pskins[0,selchar]>1) global.playerskin[mybox.p2]=((global.playerskin[mybox.p2]) mod global.pskins[0,selchar])
                    if (selchar!=-1) {
                        if (global.charmod[selchar]) replaceplayerinfo(p2,globalmanager.moddir+"character\"+global.charname[selchar]+"\"+"player.txt")
                        else replaceplayerinfo(p2,global.pbase+global.charname[selchar]+"\"+"player.txt")
                        global.displayname[mybox.p2]=playerskindat(p2,global.charname[global.option[mybox.p2]]+" name")

                        global.playerskin[i] = skinbak
                        if !(global.playerskin[mybox.p2]=0) applyplayerskin(global.pskins[1+global.playerskin[mybox.p2],global.option[mybox.p2]],mybox.p2,"less",selchar)
                        else applyplayerskin(global.pbase,mybox.p2,"less",selchar)

                        global.pal_1[mybox.p2]=(playerskindat(mybox.p2,"defaultpal1"+string(mybox.p2)))
                        global.pal_2[mybox.p2]=(playerskindat(mybox.p2,"defaultpal2"+string(mybox.p2)))
                        global.pal_3[mybox.p2]=(playerskindat(mybox.p2,"defaultpal3"+string(mybox.p2)))
                        global.pal_4[mybox.p2]=(playerskindat(mybox.p2,"defaultpal4"+string(mybox.p2)))

                        var sprayloop, mydat;
                        sprayloop=2
                        repeat (3) {
                            mydat = playerskindat(p2,"reroutepal"+string(sprayloop)+string(p2))
                            if mydat!=0 {
                                variable_global_array_set("pal_"+string(sprayloop),p2,variable_global_array_get("pal_"+string(mydat),p2))
                            }
                            sprayloop+=1
                        }

                    }
                    with (mybox) chosesnd(p2)
                } else if (room=roster || room=ta_roster) with (mybox) event_user(1)
                pf2.selflash=30
                mybox.card=pf2
                mybox.ready=1
            } else if room==ta_roster ping(lang("ta error too many")) else ping(lang("error too many"))
        }
    }

    if (pf8) {
        notready=0

        if (!mybox || (keyboard_check(vk_control) && keyboard_check(vk_shift))) for (i=3;i>=0;i-=1) with (rosterbox) if (p2=i && !ready) {other.mybox=id}
        if (mybox) {
            global.input[mybox.p2]=p2
            if (global.option[mybox.p2]!=-1 || !mybox.ready) {
                global.playerskin[mybox.p2]=0
                global.topleftplayerskin[mybox.p2]=0 mybox.vertselect=0
                global.option[mybox.p2]=-1
                with (mybox) chosesnd(p2)
            } else if (room=roster || room=ta_roster) with (mybox) alarm[0]=-1
            pf8.selflash=30
            mybox.card=pf8
            mybox.ready=1
        } else if room==ta_roster ping(lang("ta error too many")) else ping(lang("error too many"))
    }

    if mybox with mybox{ if (showbox) {
            showbox=0
            held.canmouse=1
            held.visible=1
            event_user(3)
            if (global.charmod[global.option[p2]]) replaceplayerinfo(p2,globalmanager.moddir+"character\"+global.charname[global.option[p2]]+"\"+"player.txt")
            else replaceplayerinfo(p2,global.pbase+global.charname[global.option[p2]]+"\"+"player.txt")
            global.displayname[p2]=playerskindat(p2,global.charname[global.option[p2]]+" name")
            applyplayerskin(global.pskins[1+global.playerskin[p2],global.option[p2]],p2,"less",global.option[p2])

            global.pal_1[p2]=(playerskindat(p2,"defaultpal1"+string(p2)))
            global.pal_2[p2]=(playerskindat(p2,"defaultpal2"+string(p2)))
            global.pal_3[p2]=(playerskindat(p2,"defaultpal3"+string(p2)))
            global.pal_4[p2]=(playerskindat(p2,"defaultpal4"+string(p2)))

            var sprayloop, mydat;
            sprayloop=2
            repeat (3) {
                mydat = playerskindat(p2,"reroutepal"+string(sprayloop)+string(p2))
                if mydat!=0 {
                    variable_global_array_set("pal_"+string(sprayloop),p2,variable_global_array_get("pal_"+string(mydat),p2))
                }
                sprayloop+=1
            }

            sndi=chosesnd(p2)
            frame=0
            held.pf3=noone
        }
    }
    with (pf3) {held=other.id other.held=id event_user(0)}
    with (pf6) event_user(0)
    with (pf7) event_user(0)
}
if (arel) {
    with (held) event_user(1) held=-1
    if pf2 with pf3{if (global.pskins[0,global.option[p2]]>1) {
        global.playerskin[p2]=(global.playerskin[p2]+1) mod global.pskins[0,global.option[p2]]
        event_user(3)
        if (global.charmod[global.option[p2]]) replaceplayerinfo(p2,globalmanager.moddir+"character\"+global.charname[global.option[p2]]+"\"+"player.txt")
        else replaceplayerinfo(p2,global.pbase+global.charname[global.option[p2]]+"\"+"player.txt")
        global.displayname[p2]=playerskindat(p2,global.charname[global.option[p2]]+" name")
        applyplayerskin(global.pskins[1+global.playerskin[p2],global.option[p2]],p2,"less",global.option[p2])
        global.pal_1[p2]=(playerskindat(p2,"defaultpal1"+string(p2)))
        global.pal_2[p2]=(playerskindat(p2,"defaultpal2"+string(p2)))
        global.pal_3[p2]=(playerskindat(p2,"defaultpal3"+string(p2)))
        global.pal_4[p2]=(playerskindat(p2,"defaultpal4"+string(p2)))

        var sprayloop, mydat;
        sprayloop=2
        repeat (3) {
            mydat = playerskindat(p2,"reroutepal"+string(sprayloop)+string(p2))
            if mydat!=0 {
                variable_global_array_set("pal_"+string(sprayloop),p2,variable_global_array_get("pal_"+string(mydat),p2))
            }
            sprayloop+=1
        }

        sndi=chosesnd(p2)
        frame=0
    }}

}
if (bbut && !held) {
    var selected_spray;
    selected_spray = false;
    if mybox with mybox{
        if (showbox) {
            showbox=0

            held.visible=1
            held.canmouse=1
            event_user(3)
            if (global.charmod[global.option[p2]]) replaceplayerinfo(p2,globalmanager.moddir+"character\"+global.charname[global.option[p2]]+"\"+"player.txt")
            else replaceplayerinfo(p2,global.pbase+global.charname[global.option[p2]]+"\"+"player.txt")
            global.displayname[p2]=playerskindat(p2,global.charname[global.option[p2]]+" name")
            applyplayerskin(global.pskins[1+global.playerskin[p2],global.option[p2]],p2,"less",global.option[p2])
            global.pal_1[p2]=(playerskindat(p2,"defaultpal1"+string(p2)))
            global.pal_2[p2]=(playerskindat(p2,"defaultpal2"+string(p2)))
            global.pal_3[p2]=(playerskindat(p2,"defaultpal3"+string(p2)))
            global.pal_4[p2]=(playerskindat(p2,"defaultpal4"+string(p2)))

            var sprayloop, mydat;
            sprayloop=2
            repeat (3) {
                mydat = playerskindat(p2,"reroutepal"+string(sprayloop)+string(p2))
                if mydat!=0 {
                    variable_global_array_set("pal_"+string(sprayloop),p2,variable_global_array_get("pal_"+string(mydat),p2))
                }
                sprayloop+=1
            }

            sndi=chosesnd(p2)
            frame=0
        } else {
            var changed;
            //first spray
            if point_in_rectangle(other.x,other.y,x-23,y-23,x-23+8,y-23+8) {
                global.pal_1[p2]=wrap_val(global.pal_1[p2]-1, 0, playerskindat(p2,"totpal"+string(p2))-1)
                selected_spray = true;
                changed=1
            }
            if point_in_rectangle(other.x,other.y,x-23+8,y-23,x-23+16,y-23+8) {
                global.pal_2[p2]=wrap_val(global.pal_2[p2]-1, 0, playerskindat(p2,"totpal"+string(p2))-1)
                selected_spray = true;
                changed=2
            }
            if point_in_rectangle(other.x,other.y,x-23+16,y-23,x-23+24,y-23+8) {
                global.pal_3[p2]=wrap_val(global.pal_3[p2]-1, 0, playerskindat(p2,"totpal"+string(p2))-1)
                selected_spray = true;
                changed=3
            }
            if point_in_rectangle(other.x,other.y,x-23+24,y-23,x-23+32,y-23+8) {
                global.pal_4[p2]=wrap_val(global.pal_4[p2]-1, 0, playerskindat(p2,"totpal"+string(p2))-1)
                selected_spray = true;
                changed=4
            }
            if changed {
                var sprayloop, mydat;
                sprayloop=2
                repeat (3) {
                    mydat = playerskindat(p2,"reroutepal"+string(sprayloop)+string(p2))
                    if mydat!=0 {
                        variable_global_array_set("pal_"+string(sprayloop),p2,variable_global_array_get("pal_"+string(mydat),p2))
                        if changed==sprayloop sound("ta_epicfail")
                    }
                    sprayloop+=1
                }
            }
        }
    }


    if (pf3 && !pf3.over && pf3.ready) with (pf3) event_user(2)
    else if (mybox && !selected_spray) {FMODInstanceStop(mybox.sndi) if room!=ta_roster {mybox.showbox=0 shiftdown(mybox.p2)} else {mybox.ready=0} mybox=-1 might=0 ech=0}
    if (!pf1 && !pf2 && !pf3 && !pf6 && !pf7) with (runes) event_user(7)
}

if (akey) {
    if (abut) image_index=1
    image_index=min(2,image_index+0.2)
} else if (bkey) {
    if (bbut) image_index=3
    image_index=min(4,image_index+0.2)
} else image_index=0

if (cbut) {
    if (pf2){
        with pf2{if myswapto!=id {myswapto.page=page myswapto.visible=1 visible=0 page=-1}}

    }
}

cantkeycontrol=0
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_self()

draw_sprite_ext(spr_input,p2>1,x-2,y+17,1,1,0,image_blend,1)
