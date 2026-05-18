#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
sprite="box"
mush=0
untouched=1
content=""
offset=0
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

/* the normal way
if (content="item") {
    if (mush) {with (instance_create(x+8+offset,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
    else {with (instance_create(x+8+offset,y+8+4*go,flower)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
}
if (content="itemfeather") {
    if (mush) {with (instance_create(x+8+offset,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
    else {with (instance_create(x+8+offset,y+8+4*go,feather)) {iid=id vspeed=1*other.go alarm[0]=1}}
}
if (content="itembeetroot") {
    if (mush) {with (instance_create(x+8+offset,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
    else {with (instance_create(x+8+offset,y+8+4*go,beetroot)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
}
if (content="itemgreenlui") {
    if (mush) {with (instance_create(x+8+offset,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
    else {with (instance_create(x+8+offset,y+8+4*go,greenlui)) {iid=id vspeed=0.25*other.go alarm[0]=48}}
}
if (content="shield") {
    with (instance_create(x+8+offset,y+8+4*go,shield)) vspeed=3.5*other.go
}*/
if (content="item" || content="itemfeather" || content="itembeetroot" || content="itemgreenlui" || content="shield") {
    if global.gamemode=="coop" {
        alilextra=1
        j=0
        repeat (global.mplay) {
            if gamemanager.players[j].size {alilextra=0}
            j+=1
        }
        i=0
        repeat (global.mplay) {
            if (content="shield") {
                my_obj=shield
            } else if (!gamemanager.players[i].size && !alilextra) {
                my_obj=mushroom
            } else {
                if content="itemfeather" my_obj=feather
                else if content="itembeetroot" my_obj=beetroot
                else if content="itemgreenlui" my_obj=greenlui
                else my_obj=flower
                alilextra=0
            }
            with instance_create(x+8+offset,y+8+4*go,my_obj) {
                c=1 vspeed=(4+1*(!!other.i && other.i!=global.mplay-1))*other.go
                if global.mplay=4 {hspeed=-1.5+other.i*0.75 if other.i>=2 hspeed+=0.75}
                else if global.mplay=3 {hspeed=-1.5+other.i*1.5}
                else {hspeed=-0.5+1*other.i}
                if object_index=feather {alarm[0]=1 hspeed*=2}
                if object_index=shield {hspeed*=2}
            }
            i+=1
        }
    } else { //Single-player / Battle Mode drops here
        if (content="shield") {
            with (instance_create(x+8+offset,y+8+4*go,shield)) vspeed=3.5*other.go
        } else if (mush) {
            with (instance_create(x+8+offset,y+8+4*go,mushroom)) {iid=id vspeed=0.25*other.go alarm[0]=48}
        } else {
            if content="item" with (instance_create(x+8+offset,y+8+4*go,flower)) {iid=id vspeed=0.25*other.go alarm[0]=48}
            else if content="itemfeather" with (instance_create(x+8+offset,y+8+4*go,feather)) {iid=id vspeed=1*other.go alarm[0]=1}
            else if content="itembeetroot" with (instance_create(x+8+offset,y+8+4*go,beetroot)) {iid=id vspeed=0.25*other.go alarm[0]=48}
            else if content="itemgreenlui" with (instance_create(x+8+offset,y+8+4*go,greenlui)) {iid=id vspeed=0.25*other.go alarm[0]=48}
        }
    }
}
if (content="mini") {
    with (instance_create(x+8+offset,y+8+4*go,mushmini)) {iid=id vspeed=0.25*other.go alarm[0]=48}
}
if (content="shard") {
    with (instance_create(x+8+offset,y+8+4*go,starshard)) vspeed=3.5*other.go
}
if (content="life") {
    with (instance_create(x+8+offset,y+8+4*go,lifemush)) {iid=id vspeed=0.25*other.go alarm[0]=48}
}
if (content="moon") {
    with (instance_create(x+8+offset,y+8+4*go,lifemoon)) {iid=id vspeed=0.25*other.go alarm[0]=48}
}
if (content="key") {
    with (instance_create(x+8+offset,y+8+4*go,keyitem)) {iid=id vspeed=0.25*other.go alarm[0]=48}
}
if (content="spring") {
    with (instance_create(x+offset,y+4*go,spring)) {
        vspeed=0.25*other.go
        bbb=1
        if (!other.go) aaa=1
        c=0
        alarm[0]=48
        owner=other.owner
    }
}
if (content="spreng") {
    with (instance_create(x+offset,y+4*go,spreng)) {
        vspeed=0.25*other.go
        c=0
        alarm[0]=48
        owner=other.owner
    }
}
if (content="poison") {
    with (instance_create(x+8+offset,y+8+4*go,mushpoison)) {iid=id vspeed=0.25*other.go alarm[0]=48 owner=other.owner}
}
if (content="vine") {
    with (instance_create(x+offset,y+4*go,sprong)) {
        vspeed=0.25*other.go alarm[0]=48
        target=other.target
        bbb=1
        if (!other.go) aaa=1
        c=0
    }
}
if (content="star") {
    with (instance_create(x+8+offset,y+8+4*go,starman)) {iid=id vspeed=0.25*other.go alarm[0]=48}
}

if (content="pswitch") {
    with (instance_create(x+8+offset,y+8+4*go,pswitch)) {
        vspeed=0.25*other.go
        c=0
        alarm[0]=48
        iid=id
    }
}

if (picked && iid) {
    i=instance_create(x+8+offset,y+8,gravitymanager)
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
if object_index==bigitembox offset=16

if (!lock && !hit && (content="item" || content="poison" || content="itemfeather" || content="itembeetroot" || content="itemgreenlui" || content="mini")) with (player) if (!dead && !piped && name="kid") with (other)
if (sign((other.x+other.hsp*abs(other.y-y)/6)-(x+8))!=sign(other.x-(x+8))) if (!collision_line(x+8,y+8,x+8,other.y,collider,0,1)) {
    owner=other.id
    picked=2
    untouched=0
    if ((content="item" || content="itemfeather" || content="itembeetroot" || content="itemgreenlui" || content="mini") && global.mplay>1) alarm[1]=400
    go=esign(other.y-y,1)
    owner.blockc+=1
    hit=1
    upwardthrust()
    sprite="box"
    if (object_index == bigitembox) {
        with (instance_create(x+8,y+8+16*go,coinup)) {vspeed=-1.5+2*other.go p2=other.owner.p2 fresh=1}
        with (instance_create(x+8+(offset*2),y+8+16*go,coinup)) {vspeed=-1.5+2*other.go p2=other.owner.p2 fresh=1}
        global.scor[owner.p2]+=200
        global.coins[owner.p2]+=2
        owner.coint+=2
        sprite="bigbox"
    }
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
seeit=1
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

//on block
if variant = 2 {
    on_block = 1
}
//off block
else if variant = 3 {
    off_block = 1
    blue = 1
    instance_change(offblock,0)
}
//kaeru block
else if variant = 4 {
    kblock = 1
    instance_change(koffblock,0)
}
