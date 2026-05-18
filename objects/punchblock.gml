#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
x-=8
y-=8
xstart=x
ystart=y
sprite="box"
mush=0
untouched=1
content="bros"
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (phaser) y=-verybignumber
if (go=1) {if (position_meeting(x+8,y+24,collider)) go=-1}
else {if (position_meeting(x+8,y-8,collider)) go=1}
with (phaser) y=ystart

var iid;
iid=noone

if (content="item") {
    if (mush) {with (instance_create(x+8,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
    else {with (instance_create(x+8,y+8+4*go,flower)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
}
if (content="itemfeather") {
    if (mush) {with (instance_create(x+8,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
    else {with (instance_create(x+8,y+8+4*go,feather)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
}
if (content="itembeetroot") {
    if (mush) {with (instance_create(x+8,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
    else {with (instance_create(x+8,y+8+4*go,feather)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
}
if (content="itemgreenlui") {
    if (mush) {with (instance_create(x+8,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
    else {with (instance_create(x+8,y+8+4*go,feather)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
}
if (content="mini") {
    with (instance_create(x+8,y+8+4*go,mushmini)) {iid=id vspeed=0.25*other.go alarm[0]=48} //not questioning why punch blocks are full on dupes of ? blocks when the only contents they can have without code blocks is "bros" but ok??
}
if (content="shard") {
    with (instance_create(x+8,y+8+4*go,starshard)) vspeed=3.5*other.go
}
if (content="shield") {
    with (instance_create(x+8,y+8+4*go,shield)) vspeed=3.5*other.go
}
if (content="life") {
    with (instance_create(x+8,y+8+4*go,lifemush)) {iid=id vspeed=0.25*other.go alarm[0]=48}
}
if (content="key") {
    with (instance_create(x+8,y+8+4*go,keyitem)) {iid=id vspeed=0.25*other.go alarm[0]=48}
}
if (content="spring") {
    with (instance_create(x,y+4*go,spring)) {
        vspeed=0.25*other.go
        bbb=1
        if (!other.go) aaa=1
        c=0
        alarm[0]=48
        owner=other.owner
    }
}
if (content="spreng") {
    with (instance_create(x,y+4*go,spreng)) {
        vspeed=0.25*other.go
        c=0
        alarm[0]=48
        owner=other.owner
    }
}
if (content="poison") {
    with (instance_create(x+8,y+8+4*go,mushpoison)) {iid=id vspeed=0.25*other.go alarm[0]=48 owner=other.owner}
}
if (content="vine") {
    with (instance_create(x,y+4*go,sprong)) {
        vspeed=0.25*other.go alarm[0]=48
        target=other.target
        bbb=1
        if (!other.go) aaa=1
        c=0
    }
}
if (content="star") {
    with (instance_create(x+8,y+8+4*go,starman)) {iid=id vspeed=0.25*other.go alarm[0]=48}
}

if (picked && iid) {
    i=instance_create(x+8,y+8,gravitymanager)
    i.vsp=go*4-1
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
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
done=1
#define Alarm_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (inview()) {alarm[2]=60 exit}

if (settings("randblock")) content=randomitem()

hit=0
mush=0
sound("itemrespawn")
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if (!lock && !hit && (content="item" || content="poison")) with (player) if (!dead && !piped && name="kid") with (other)
if (sign((other.x+other.hsp*abs(other.y-y)/6)-(x+8))!=sign(other.x-(x+8))) if (!collision_line(x+8,y+8,x+8,other.y,collider,0,1)) {
    owner=other.id
    picked=2
    untouched=0
    if ((content="item"||content="itemfeather"||content="mini") && global.mplay>1) alarm[1]=400
    go=esign(other.y-y,1)
    owner.blockc+=1
    hit=1
    upwardthrust()
    sprite="box"
    sound("itemappear")

    mush=!((x div 16) mod 2)
    alarm[0]=2

    tpos=1
    spendblock()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (lock) exit

if (global.coll=noone) owner=instance_nearest(x,y,player)
else owner=global.coll
owner.typeblockhit=1
owner.blockcoll=id
with (owner){
charm_run("hitblocks")}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (turing) event_user(4)
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
variant=funnytruefalse(variant)
if (variant == 1) {
    sprite="brick"
    if (skindat("brickvar")) frame=rchoose(0,1,2,3)
    else anim=!skindat("bricd")
}

respawning=(content="item" && global.mplay>1)

if (settings("randblock") && string(target)="0") {
    content=randomitem()
    if (global.mplay>1) respawning=1
}

if ((content="life" || content="shard") && spentblock()) content=""

cc=16
if (content="") {
    content="coins"
    cc=1
}

if (content="none") {
    hit=1
}

if (funnytruefalse(invisible) && content!="bros" && variant < 2) {
    instance_change(invisibox,0)
}
