#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
x-=8
y-=8
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
itemgo=-1
if go=4 itemgo=1

if (go=2||go=3)&&!shifty exit

var iid;
iid=noone

if (content="item") {
    if (mush) {with (instance_create(x+8,y+8+4*itemgo,mushroom)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48}}
    else {with (instance_create(x+8,y+8+4*itemgo,flower)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48}}
}
if (content="itemfeather") {
    if (mush) {with (instance_create(x+8,y+8+4*itemgo,mushroom)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48}}
    else {with (instance_create(x+8,y+8+4*itemgo,feather)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48}}
}
if (content="shard") {
    with (instance_create(x+8,y+8+4*itemgo,starshard)) vspeed=3.5*other.itemgo
}
if (content="shield") {
    with (instance_create(x+8,y+8+4*itemgo,shield)) vspeed=3.5*other.itemgo
}
if (content="life") {
    with (instance_create(x+8,y+8+4*itemgo,lifemush)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48}
}
if (content="moon") {
    with (instance_create(x+8,y+8+4*itemgo,lifemoon)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48}
}
if (content="key") {
    with (instance_create(x+8,y+8+4*itemgo,keyitem)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48}
}
if (content="spring") {
    with (instance_create(x,y+4*itemgo,spring)) {
        vspeed=0.25*other.itemgo
        bbb=1
        if (!other.itemgo) aaa=1
        c=0
        alarm[0]=48
        owner=other.owner
    }
}
if (content="spreng") {

}
if (content="poison") {
    with (instance_create(x+8,y+8+4*itemgo,mushpoison)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48 owner=other.owner}
}
if (content="vine") {
    if (target && go=4) {
            with (myplayer){
            piped=1
            vsp=-5
            hspeed=hsp
            vspeed=vsp
            sprung=1
            spriteswitch(1)
            sound("itemsprong")
            myheaven=other.target
            sprongin=1
            }
        }
}
if (content="star") {
    with (instance_create(x+8,y+8+4*itemgo,starman)) {iid=id vspeed=0.25*other.itemgo alarm[0]=48}
}

if (content="pswitch") {
    with (instance_create(x+8,y+8+4*itemgo,pswitch)) {
        vspeed=0.25*other.itemgo
        c=0
        alarm[0]=48
        iid=id
    }
}

if (iid) {
    i=instance_create(x+8,y+8,gravitymanager)
    i.vsp=itemgo*4
    i.carry=iid
    i.phase=4
    i.drop=1
    iid.c=0
    iid.drop=0
    iid.speed=0
    iid.aaa=0
    iid.bbb=0
    iid.alarm[0]=-1
}

picked=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if go movetime+=1
switch (go){
    case 1:/*goup*/    {if movetime=1 alarm[0]=1 notey-=2 if movetime>5 notey+=4 break}
    case 2:/*goleft*/  {if movetime=1 alarm[0]=1 notex-=2 if movetime>5 notex+=4 break}
    case 3:/*goright*/ {if movetime=1 alarm[0]=1 notex+=2 if movetime>5 notex-=4 break}
    case 4:/*godown*/  {if movetime=1 alarm[0]=1 notey+=2 if movetime>5 notey-=4 break}
}
if movetime>10 {go=0 movetime=0 notex=0 notey=0 hit=0 if content!="vine" content=""}

movetime=min(movetime,10)
notex=clamp(notex,-8,8)
notey=clamp(notey,-8,8)
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
hidden=funnytruefalse(hidden)
shifty=funnytruefalse(shifty)
if content="vine" isred=1
getregion(x)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !shifty&&hidden&&!hit exit
if (!shifty) ssw_tile("noteblock")
else if (hidden) ssw_tile("hardblock") else ssw_tile("shiftblock")
