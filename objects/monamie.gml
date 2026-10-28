#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
alarm[1]=48
vspeed=-3
friction=0.1
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible=0
with (owner) monitem=1
p2=-1 //BUGFIX: player 1 would never get item credit or score from some item sources due to them not using p2 (which defaulted to 0)
fresh=1

if contents="10coin" {
    give_item(owner,"monitor_10coin")
}
else if contents="mush" {
    give_item(owner,"monitor_mush")
}
else if contents="fire" {
    give_item(owner,"monitor_fire")
}
else if contents="mini" {
    give_item(owner,"monitor_mini")
}
else if contents="star" {
    give_item(owner,"monitor_star")
}
else if contents="1up" {
    give_item(owner,"monitor_1up")
}
else if contents="poison" {
    give_item(owner,"monitor_poison")
}
else if contents="feather" {
    give_item(owner,"monitor_bfeather")
}
else if contents="shield" {
    give_item(owner,"monitor_shield")
}
else if contents="beetroot" {
    give_item(owner,"monitor_beetroot")
}
else if contents="greenlui" {
    give_item(owner,"monitor_greenlui")
}
else if contents="superring" {
    give_item(owner,"monitor_superring")
}
else if contents="time" {
    if global.gamemode == "timeattack" {
        sound("smallbumper")
    } else if instance_exists(gamemanager) {
        gamemanager.time+=30
        gamemanager.tick=gamemanager.time*60
        sound("itemclock")
    }
}
else if contents!=""{  give_item(owner,contents)} //yknow theoretically this failsafe makes the shield, poison, 1up, and mini lines irrelevant

with (owner) monitem=0


instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_monitor(contents)
