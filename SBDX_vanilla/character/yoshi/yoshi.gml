#define spritelist
stand,wait,lookup,pose,crouch,knock,dead,deadland,walk,run,brake,jump,bonk,fall,tongue,tongueup,tongueharmed,tongueupharmed,spit,swallow,standhold,lookuphold,crouchhold,walkhold,runhold,brakehold,jumphold,bonkhold,fallhold,pound,fire,flutter,swim,paddle,grind,piping,pipingup,sidepiping,doorenter,doorexit,climbing,flagslide,standaim,walkaim,runaim,brakeaim,jumpaim,bonkaim,fallaim,standholdaim,walkholdaim,runholdaim,brakeholdaim,jumpholdaim,bonkholdaim,fallholdaim


#define soundlist
skid,swim,pound,stomp,flip,spin,slide,kick,fireball,aim,flutter,flutterend,tongue,spit,throw,swallow,eggbounce,egghit


#define movelist
Yoshi
#
[a]: Flutter Jump (air)
[b] / [b]+[up]: Lick (Hold [b] to cling)
[down]: Swallow / Groundpound (Air)
[c]: Aim / [down]: Cancel Aim
#
Jump out of a Groundpound , or 
cling to walls to reach higher places

#define rosterorder
4

#define skininit
var looper;

tonguebehind=funnytruefalse(playerskindat(p2,name+" tongue behind yoshi")) 

//graphic offsets
loopey=0
looper=0
repeat((projcoordbysize*MAXIMUMSIZESARGH)+1) {
	if (projcoordbysize) {
		looper=string(loopey)
	} else {looper=""}
	
	tongue_offsetx[loopey]=nozerounreal(playerskindat(p2,name+" tongue offset x"+looper),4)
    tongue_offsety[loopey]=nozerounreal(playerskindat(p2,name+" tongue offset y"+looper),-8)
	
	tongueup_offsetx[loopey]=nozerounreal(playerskindat(p2,name+" tongue up offset x"+looper),-8)
    tongueup_offsety[loopey]=nozerounreal(playerskindat(p2,name+" tongue up offset y"+looper),-9)
	
	loopey+=1
}

#define effectsbehind
    if (aim) {
if aim<2 {
if (aimdirgo=0) aimdir=approach_val(aimdir,90,2.5)
else { 
if !(up && aimdir=90) aimdir=approach_val(aimdir,-45,2.5)
}
if (aimdir=90) && !up aimdirgo=1
if (aimdir=-45) aimdirgo=0
}
draw_sprite_part(sheets[1],0,156+floor(aimframe)*17,104,16,16,round(x+(lengthdir_x(64,aimdir)*aimxdir)-8),round(y+lengthdir_y(64,aimdir)-8))
with (hold) event_user(0)
    }
    
if (aim>1) aim+=1

if (aim=16) aim=0

if (aim) aimframe+=0.5
if (aimframe>1) aimframe=0

//draw_skintext(x,y-32,string(goalenems))
//draw_skintext(x,y-32,pound)

#define grabflagpole
grabflagpole=1
hsp=0
vsp=0

#define start
mask_set(12,12)
yoshideath=funnytruefalse(playerskindat(p2,name+" yoshis island death"))
//instance_activate_object(enemy)
//goalenems=instance_number(enemy)

#define stop
if (skidding) {soundstop(name+"skid") skidding=0}
star=0
grow=0
hurt=0
push=0
pound=0


#define itemget
if (type="jumprefresh") {
	spinjump=0
	insted=0
    mc=0
    itemget=1
}
else if (type="1up") {
    sound("item1up")
    itemc+=1
	global.lifes+=1
	deaths=max(0,deaths-1)
	itemget=1
} 
if (type!="mini") com_item() //remove the mini check if you are adding a mini form

#define endofstage
right=1
akey=(push || (jump && akey) || !collision(16,8))


#define damager
y=-1000
image_xscale=8

breakflag=owner.size
hittype="enemy"
if (owner.diggity && owner.diggity>32 && (owner.diggity<36 || !owner.size)) {x=owner.x y=owner.y+8 image_yscale=10 image_xscale=12}
else if (owner.diggity && owner.diggity<8) {x=owner.x y=owner.y+22 image_yscale=3 image_xscale=12}
else if (owner.glide || owner.slide) {x=owner.x+10*cos(pi*(owner.ggf*-0.5+0.5))+owner.hsp y=owner.y+8+8*sin(pi*(owner.ggf*0.5+0.5)) image_yscale=6+min(1,owner.size)*2}
else if (owner.upper || ((owner.fall=11 || owner.diggity>32) && owner.size)) {x=owner.x+owner.xsc*10+owner.hsp y=owner.y+4-min((owner.upper*2)+10*(owner.fall=11)-!!owner.diggity*(16-min(32,(owner.diggity-32)*2)),20) image_yscale=10 hittype="gut"}
else if (owner.fired) {x=owner.x+owner.xsc*12+owner.hsp y=owner.y image_yscale=10}
coll=instance_place(x,y,collider)
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll.object_index=brick) brickc+=1 else brickc=4
hitblock(coll,owner,0,esign(coll.y-owner.y),0)
}    
}

coll=instance_place(x,y,enemy)
if (coll) {                    
if (coll.object_index!=bombenemy && coll.object_index!=boo
&& coll.object_index!=urchin) {
global.coll=owner.id
enemydie(coll,2)
}
}

coll=instance_place(x,y,player)
if (coll) {
if (coll.id!=owner) if (!invincible(coll)) {    
if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { coll.hittype=hittype
with (coll) hurtplayer(hittype)
}
instance_create(x,y,kickpart) 
}
}




#define projectile
if (event="create") {


mask_index=spr_mask12x12

image_xscale=1
image_yscale=1

eggfollower=noone

jump=0
xsc=1
xp=x
frc=0
frame=0
bob=0
posbob=0
visible=1
eggthrowsmokecount=0
}

if (event="step") {

if tonge 
{
if owner.tonguebehind depth=owner.depth+1

if !up
{
coll=knuxcanclimb(instance_place(x+3*xsc,y,collider)) 

if (c>=56) || (c>56) mode=1
if coll && coll.object_index!=brick  && !mode & !brickpull && capture=0 && coll.nslop=0 && owner.bkey if !instance_place(x+3*xsc,y,phaser)  mode=2
if (mode) c=approach_val(c,0,6)  else c=approach_val(c,56,6) 
while c>57
c-=1


if mode=2
{
owner.toungecling=1
owner.vsp=0
owner.hsp=12*xsc
c-=1
}

if (c<=0) 
if mode
{
    visible=0
    owner.tonge=0
    instance_destroy()
    owner.lick=0
    if capture=-1
    {
    with owner.anemyeat instance_destroy()
    owner.anemyeat=0
    owner.hold=1
    }
    if tile tile_delete(tile)
    
    if brickpull
    {
    owner.holdind=brick
    owner.hold=1
    }
    
}

xsc=owner.xsc

x=owner.x+(6*xsc)+(c/2)*xsc
y=owner.y+4

image_xscale=1

image_xscale=c/12

coll=instance_place(x,y,enemy)

if !owner.anemyeat
if coll && capture=0&& coll.object_index!=boo && coll.object_index!=urchin
{
mode=1
capture=-1
owner.anemyeat=coll.id
if coll.object_index=shell
owner.storedtype=coll.type
owner.holdind=coll.object_index
owner.enemy2store=coll.enemy2
owner.bratstore=coll.brat
}

if owner.anemyeat
{
owner.holdind=owner.anemyeat.object_index
owner.anemyeat.x=x+xx*xsc*0.5
owner.anemyeat.y=y
owner.anemyeat.depth=depth+1
owner.anemyeat.hspeed=0
owner.anemyeat.vspeed=0
owner.anemyeat.stop=1
owner.anemyeat.waking=0
}

coll=instance_place(x,y,brick)

if coll && !brickpull && capture=0
{
mode=1
capture=1
brickpull=1
with coll instance_destroy()
}

if brickpull
{

}

}
else

{
coll=instance_place(x,y-3,collider)
if (c>=56) mode=1
if coll && coll.object_index!=brick && coll.object_index!=phaser if !instance_place(x,y-3,phaser) mode=1
if (mode) c=approach_val(c,0,6)  else c=approach_val(c,56,6) 
while c>57
c-=1
if (c<=0) 
if mode
{
    visible=0
    owner.tonge=0
    instance_destroy()
    owner.lick=0
    if capture=-1
    {
    with owner.anemyeat instance_destroy()
    owner.anemyeat=0
    owner.hold=1
    }
    if tile tile_delete(tile)
    
    if brickpull
    {
    owner.holdind=brick
    owner.hold=1
    }
    
}

xsc=owner.xsc

x=round(owner.x+1*xsc)
y=owner.y-(6)-(c/2)

image_xscale=1.5

image_yscale=c/12

coll=instance_place(x,y,enemy)

if !owner.anemyeat
if coll && capture=0 && abs(x-coll.x)<8 && coll.object_index!=piranha && coll.object_index!=firepiranha
{
capture=-1
owner.anemyeat=coll.id
if coll.object_index=shell
owner.storedtype=coll.type
owner.holdind=coll.object_index
owner.enemy2store=coll.enemy2
owner.bratstore=coll.brat
}

if owner.anemyeat
{
owner.holdind=owner.anemyeat.object_index
owner.anemyeat.x=x
owner.anemyeat.y=y-xx*0.5
owner.anemyeat.depth=depth+1
owner.anemyeat.hspeed=0
owner.anemyeat.vspeed=0
owner.anemyeat.stop=1
owner.anemyeat.waking=0
}

coll=instance_place(x,y,brick)

if coll && !brickpull && capture=0
{
capture=1
brickpull=1
with coll instance_destroy()
}

if brickpull
{

}

}

}
else
{

if eggtype=4
{

xsc=sign(hspeed)
visible=1
sprite_index=spr_mask2x2
mask_index=spr_mask2x2

frame+=0.1

if frame>=3
frame=0

coll=instance_place(x,y,coin)
if (coll)
{
if (coll.object_index=redcoin) with (coll) {instance_create(x,y,glitter) gibcoinred(other.owner) instance_destroy()}
else if (coll.object_index=coin) with (coll) {instance_create(x,y,glitter) give_item(other.owner,"coin") instance_destroy()}
}

coll=instance_place(x,y,bowserboss)
if (coll) {
    if (!coll.flash) {
        coll.hp-=1
        coll.flash=64
        coll.owner=owner
        sound("enemybowserhurt")
        instance_create(x,y,kickpart)
        instance_destroy()
    }
}

coll=instance_place(x,y,enemy)
if coll && owner.anemyeat!=coll.id {
if (coll.object_index!=beetle && coll.object_index!=bulletbill && (coll.object_index!=bombenemy)) {
yes=1
if (coll.object_index=shell) if (coll.type="beetle") yes=0
if (yes) {
global.coll=owner.id  
enemydie(coll,2)
}
}
}

image_xscale=8
image_yscale=8



coll=instance_place(x,y,player)
if (coll) {
if (coll.id!=owner) if (!invincible(coll)) {    
if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) exploding=1 exit}
with(coll) fragplayer(other.owner)
}
}
}

if !inview() instance_destroy()
}

if eggtype=3
{
if !inview() instance_destroy()
}

if eggtype=2
{
gravity=0.2
image_xscale=1
image_yscale=1
mask_index=spr_mask12x12
coll=instance_place(x,y,collider)
if coll
{
i=instance_create(x+4,y+12+(16*biggie),part) i.hspeed=-1 i.vspeed=-1+2*go
    i=instance_create(x+12+(16*biggie),y+12+(16*biggie),part) i.hspeed=1 i.vspeed=-1+2*go 
    i=instance_create(x+4,y+4,part) i.hspeed=-1 i.vspeed=-3+2*go
    i=instance_create(x+12+(16*biggie),y+4,part) i.hspeed=1 i.vspeed=-3+2*go
instance_destroy()
if tile tile_delete(tile)
sound("itemblockbreak")
}

coll=instance_place(x,y,coin)
if (coll)
{
if (coll.object_index=redcoin) with (coll) {instance_create(x,y,glitter) gibcoinred(other.owner) instance_destroy()}
else if (coll.object_index=coin) with (coll) {instance_create(x,y,glitter) give_item(other.owner,"coin") instance_destroy()}
}

coll=instance_place(x,y,bowserboss)
if (coll) {
    if (!coll.flash) {
        coll.hp-=1
        coll.flash=64
        coll.owner=owner
        sound("enemybowserhurt")
        instance_create(x,y,kickpart)
        i=instance_create(x+4,y+12+(16*biggie),part) i.hspeed=-1 i.vspeed=-1+2*go
    i=instance_create(x+12+(16*biggie),y+12+(16*biggie),part) i.hspeed=1 i.vspeed=-1+2*go 
    i=instance_create(x+4,y+4,part) i.hspeed=-1 i.vspeed=-3+2*go
    i=instance_create(x+12+(16*biggie),y+4,part) i.hspeed=1 i.vspeed=-3+2*go
instance_destroy()
if tile tile_delete(tile)
sound("itemblockbreak")
    }
}

coll=instance_place(x,y,enemy)
if coll && owner.anemyeat!=coll.id {
if (coll.object_index!=beetle && coll.object_index!=bulletbill && (coll.object_index!=bombenemy)) {
yes=1
if (coll.object_index=shell) if (coll.type="beetle") yes=0
if (yes) {
global.coll=owner.id  
instance_create(x,y,kickpart)  
enemydie(coll,2)
}
}
i=instance_create(x+4,y+12+(16*biggie),part) i.hspeed=-1 i.vspeed=-1+2*go
    i=instance_create(x+12+(16*biggie),y+12+(16*biggie),part) i.hspeed=1 i.vspeed=-1+2*go 
    i=instance_create(x+4,y+4,part) i.hspeed=-1 i.vspeed=-3+2*go
    i=instance_create(x+12+(16*biggie),y+4,part) i.hspeed=1 i.vspeed=-3+2*go
instance_destroy()
if tile tile_delete(tile)
sound("itemblockbreak")
}
image_xscale=1
image_yscale=1



coll=instance_place(x,y,player)
if (coll) {
if (coll.id!=owner) if (!invincible(coll)) {    
if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) exploding=1 exit}
with(coll) fragplayer(other.owner)
}
instance_destroy()
}
}


}
if eggtype=1
{

sprite_angle=point_direction(0,0,hspeed,vspeed)

eggthrowsmokecount+=1
if eggthrowsmokecount=3 {
with owner shoot(other.x,other.y,psmoke)
    eggthrowsmokecount=0
}


coll=instance_place(x+hspeed,y,collider)

if (coll) {
while !instance_place(x+sign(hspeed),y,collider)
x+=sign(hspeed)
if coll.object_index!=brick
{
hspeed=-hspeed

bump+=1
if bump=4
instance_destroy()
//sound("itemblockbump")
playsfx("yoshieggbounce")
}
hitblock(coll,owner,1,-1,0)
}

coll=instance_place(x,y+vspeed,collider)
if (coll) {
while !instance_place(x,y+sign(vspeed),collider)
y+=sign(vspeed)
if coll.object_index!=brick
{
bump+=1
if bump=4
instance_destroy()
vspeed=-vspeed
//sound("itemblockbump")
playsfx("yoshieggbounce")
}
hitblock(coll,owner,1,-1,0)

}




coll=instance_place(x,y,coin)
if (coll)
{
if (coll.object_index=redcoin) with (coll) {instance_create(x,y,glitter) gibcoinred(other.owner) instance_destroy()}
else if (coll.object_index=coin) with (coll) {instance_create(x,y,glitter) give_item(other.owner,"coin") instance_destroy()}
}

coll=instance_place(x,y,bowserboss)
if (coll) {
    if (!coll.flash) {
    playsfx("yoshiegghit")
        coll.hp-=1
        coll.flash=64
        coll.owner=owner
        sound("enemybowserhurt")
        instance_create(x,y,kickpart)
        instance_destroy()
    }
}

coll=instance_place(x,y,enemy)
if coll && owner.anemyeat!=coll.id {
if (coll.object_index!=beetle && coll.object_index!=bulletbill && (coll.object_index!=bombenemy)) {
yes=1
if (coll.object_index=shell) if (coll.type="beetle") yes=0
if (yes) {
global.coll=owner.id  
instance_create(x,y,kickpart)  
playsfx("yoshiegghit")
enemydie(coll,2)
}
}
instance_destroy()
}
image_xscale=4
image_yscale=4



coll=instance_place(x,y,player)
if (coll) {
if (coll.id!=owner) if (!invincible(coll)) {    
if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) exploding=1 exit}
with(coll) fragplayer(other.owner)
}
playsfx("yoshiegghit")
instance_destroy()
}
}


}
if eggtype=0
{

if owner.dead || owner.finish
{
//ds_queue_destroy(followQueue)
vspeed=-2
hspeed=-2*random_range(-1,1)
gravity=0.2
eggtype=3
owner.eggcount=0
}

calcmoving()
if exploding=0{
frame+=0.1

if frame>=4
frame=0

if (!instance_exists(owner) || !instance_exists(eggfollow)) {instance_create(x,y,smoke) instance_destroy() exit}

if (owner.hold=id) exit

grounded=place_meeting(x,y+2,collider) 
image_xscale=8
walled=place_meeting(x,y,collider)
image_yscale=8

followside=approach_val(followside,xsc,0.1)

    if eggfollow=owner
    ds_queue_enqueue(followQueue, eggfollow.y+7-eggfollow.LAG_STEPS)
    else
    ds_queue_enqueue(followQueue, eggfollow.y)
    
    ds_queue_enqueue(followQueue, eggfollow.x-followside*6)
    ds_queue_enqueue(followQueue, eggfollow.xsc)
    LAG_STEPS = 7
    if (ds_queue_size(followQueue) > (10))
    {
 y = ds_queue_dequeue(followQueue)
 x = ds_queue_dequeue(followQueue)
 xsc = ds_queue_dequeue(followQueue)
}

x=round(x)
if xp!=x {if grounded if offy=0 offysp=-1 xp=x}
offy+=offysp
offysp=approach_val(offysp,0,0.1)
offy=approach_val(offysp,0,0.1)

//x=mean(x,x,list[pos,0]+6*sign(x-owner.x)*!!grounded*!walled)


depth=eggfollow.depth+1


if (owner.piped) depth=owner.depth

}
else if exploding=1
{
exploframe+=0.5
if (exploframe>=3) {visible=0 instance_destroy()}
hspeed=0
vspeed=0
}
}
}

}


if (event="draw") {
if (!tonge) {
if (eggtype=0 || eggtype=3)
draw_sprite_part_ext(sheet,0,10+17*floor(frame),104,16,16,round(x-8*xsc),round(y-8+offy),xsc,1,$ffffff,1)

if (eggtype=4)
draw_sprite_part_ext(owner.sheets[2*!global.singlesheet[p2]],0,190+21*floor(frame),100,20,20,round(x-10*xsc),round(y-10),xsc,1,$ffffff,1)

if (eggtype=1) {
draw_sprite_general(
//  sprite, subimage    
owner.sheets[1*!global.singlesheet[p2]],0,
//  left, top    
10+17*floor(frame),87,
//  width, height    
16,16,
//  left top corner of the quad, accounting for rotation
round(x)+lengthdir_x((margin-12)*xsc,sprite_angle)+lengthdir_x(margin-(8),sprite_angle-90),
round(y)+lengthdir_y((margin-12)*xsc,sprite_angle)+lengthdir_y(margin-(8),sprite_angle-90),
//  scale and rotation
xsc,1,sprite_angle,
//  blending    
$ffffff,$ffffff,$ffffff,$ffffff,1
)
}
if (eggtype=2) {
getregion(x)
if (tile) tile_delete(tile)
tile=tile_dyn(global.master[biome],152,264,16,16,x-2,round(y-8),2)
}

}
if (tonge) {
if (global.debug) draw_omitext(owner.x,owner.y-16,string(c))
getregion(x)
if brickpull {
if (tile) tile_delete(tile)

if (!up) tile=tile_dyn(global.master[biome],152,264,16,16,round(owner.x)+xx*0.8*xsc,round(owner.y-2),depth+2)
else tile=tile_dyn(global.master[biome],152,264,16,16,round(owner.x-8),round(owner.y-12-xx),depth+2)
}

xx=median(0,c,56) 
//if (!up) draw_sprite_part_ext(sheet,0,133+1-xx,102,xx,20,round(owner.x)+4*xsc,round(owner.y-8+(4*(owner.size==0 || owner.size==5))),xsc,1,$ffffff,1)
//else draw_sprite_part_ext(sheet,0,135,66,20,xx,round(owner.x-8*xsc),round(owner.y-9-xx+(7*(owner.size==0 || owner.size==5))),xsc,1,$ffffff,1)

if (!up) draw_sprite_part_ext(sheet,0,133+1-xx,102,xx,20,
round(owner.x)+owner.tongue_offsetx[owner.size*owner.projcoordbysize]*xsc,
round(owner.y)+owner.tongue_offsety[owner.size*owner.projcoordbysize],xsc,1,$ffffff,1)
else draw_sprite_part_ext(sheet,0,135,66,20,xx,
round(owner.x+owner.tongueup_offsetx[owner.size*owner.projcoordbysize]*xsc),
round(owner.y+owner.tongueup_offsety[owner.size*owner.projcoordbysize]-xx),xsc,1,$ffffff,1)

}
}


#define sprmanager
frspd=1
if (grabflagpole) {sprite="flagslide"}
else if (fired) {sprite="fire"}
else if (swallow) {sprite="swallow" cantslowanim=1}
else if (spit) {sprite="spit" cantslowanim=1}
else if (hurt) {sprite="knock"}
else if (throw) {sprite="throw" cantslowanim=1}
else if (pound) {sprite="pound"}
else if lick {cantslowanim=1 if tongue.up sprite="tongueup" else sprite="tongue"}
else if (slipnslide) {sprite="slide"}
else if (crouch) {sprite="crouch"}
else if (flutter) {sprite="flutter"}
else if (jump) {
    if (onvine) {
        sprite="climbing" frspd=sign(left+right+up+down)
    }
    else if (fall=6) {sprite="knock"}
    else if (spinjump) {sprite="twirl"}
    else if (double) {sprite="spin" frspd=0.4}
    else if (water) {sprite="swim" if (swim) sprite="paddle"}
    else if (bonk) {sprite="bonk"}
    else {sprite="jump" if (vsp>0) sprite="fall" if (jumpspd=99) sprite="fly"}
} else {
    if (crouch) {sprite="crouch" frspd=0}
    else if (braking) {sprite="brake" xsc=-brakedir}
    else if (hsp=0) {
        if (lookup) {sprite="lookup"}
        else if (waittime>maxwait &&!carry && !hold && !aim) {sprite="wait"}
        else if (posed) {sprite="pose"}
        else {sprite="stand"}
    } else {
        if (abs(hsp)>3 && !carry) {sprite="run"}
        else {
            sprite="walk"
            frspd=median(0.5,1,0.3+abs(hsp/4))
        }
    }
}
if (hold && aim && sprite!="flutter" && sprite!="fire") sprite=sprite+"holdaim"
else if (aim && sprite!="flutter" && sprite!="fire") sprite=sprite+"aim"
else if (hold  && sprite!="fire") sprite=sprite+"hold"

#define controls
com_inputstack()

tempbrick=0
luijump-=1

//situations in which it should skip controls entirely
if (rise!=0 || watrlock || hurt || piped || move_lock) {
di=0
h=0
exit
}

if (up) com_piping()
oup=up

lookup=0
if (up && hsp=0 && !jump && !carry && !throw) lookup=1

if (
rise!=0 ||
(crouch && !jump) ||
(poundcancel || pound || spin || toungecling=2)
) h=0

if (h!=0 && !wallkick) {
loose=0
coll=noone
if (h=sign(hsp) || hsp=0) coll=collision(h,0)
if (coll) if (object_is_ancestor(coll.object_index,moving)) coll=place_meeting(x+h,y+coll.vsp+sign(coll.vsp),coll)
if (coll) if (player_climbstep(coll)) coll=noone
if (x<=minx && left) coll=1
if (coll) {
com_hitwall(h)
if (!jump && !crouch) {
push=h
xsc=h
braking=0
}
if (!pound && !water && fall!=6 && !crouch && h=xsc && kicked!=h && !carry) if (knuxcanclimb(collision(8*h,0))) {
if (jump) hang=0
if (vsp>1) crouch=0
xsc=h
}
} else {
if (!jump) {
if (sign(hsp)!=h) {
if (abs(hsp)>2 && !carry) {
braking=1
skidding=1
playsfx("yoshiskid",1)
brakedir=h
}
hsp+=(0.33-0.175*!water+0.04*(abs(hsp)<1))*wf*h
if (abs(hsp)<0.5 || carry && !spin) xsc=h
} else {
hsp+=(0.06+0.06*(abs(hsp)<1))*wf*h
xsc=h

braking=0
}
} else {
if (water) {if (h!=sign(hsp)) hsp+=0.1*h else hsp+=0.0375*h}
//else if (dropkick) hsp+=0.05*wf*h
else if (size==5) hsp+=0.085*wf*h
else hsp+=0.12*wf*h
if (!hang && !wallkick && !twist && !spin) xsc=h
}
}
}

if (push!=h) push=0

com_di()

if ((abut || jumpbufferdo) && (!springin)) {
    if (!jump||fall=69 || vinegrab|| toungecling=2 || water || grabflagpole) { //jump
            if (water) {
                if (!pound) {vsp=-1.5-up*0.75 swim=24 crouch=0 playsfx("yoshiswim")
                if (sprite="paddle") frame=0}
            } else {
                jumpsnd=playsfx(name+"jump",0,1+(size==5)/3)
                //vsp=-5.2-0.2*super
vsp=-(4.7+min(1,abs(hsp)/8)+!!poundjump)
                }
                vinegrab=0
onvine=0
                toungecling=0
grabflagpole=0
    
                if (water) vsp=-sqrt(sqr(vsp)*wf+2)
    
            /*
                //change jump angle in steep slopes
                vd=point_direction(0,0,hsp,vsp)+point_direction(0,0,1,slobal/2)
                vm=point_distance(0,0,hsp,vsp)
                hsp=lengthdir_x(vm,vd)
                vsp=lengthdir_y(vm,vd)
*/
    
                sprite_angle=0
                
                if (poundjump) {springsmoke(x,y+8) crouch=0}
                jumptiming=0
                onvine=0
                jump=1
if (size==7) luijump=9
                fall=0
                braking=0
                spin=0
                canstopjump=1
                if (mymoving) hsp+=avgmovingh
                crouch=0
                if (spin && !star) seqcount=0
                fallspd=min(1,0.5+abs(hsp)/5)
    } else { //air jumps
    
        if (!fluttered && !flutter && !pound && !fulbuff && fall!=69 &&!vinegrab && !water) {
          flutter=1
  crouch=0
        }
        
        //lemme try making it use the 1.9 flutter method since that felt better to use
              
        jumpbuffer=4*!jumpbufferdo
    }
}
 jumpbufferdo=0
springin=0

if (akey) {

    if (jumpbuffer) jumpbuffer-=1


} else {jumpbuffer=0}

if (!akey) {
superflutter=0 if (flutter) {if (flutter>=8) {soundstop("yoshiflutter") playsfx("yoshiflutterend")}  flutter=0 }
    if (canstopjump=1 && jump && vsp<-2 && !sprung) {
        vsp*=0.5
    }
    canstopjump=0
luijump=0
}



if !lick
xsctonge=xsc
else
xsc=xsctonge

if bbut && !lick && !hold && !anemyeat && fall!=69 &&!vinegrab && !pound
{
tongue=fire_projectile(x+xsc*4,y)
tongue.tonge=1
tongue.xsc=xsc
tongue.visible=1
playsfx("yoshitongue")
if up
tongue.up=1
lick=1
flutter=0
}

if bbut && !lick && hold && fall!=69 &&!vinegrab
{
if (size!=2 && size!=6)
{
spit=8
playsfx("yoshispit")
if holdind=koopa || holdind=redkoopa || holdind=yelkoopa || holdind=blukoopa || holdind=redhover || holdind=yelhover || holdind=hopkoopa
with instance_create(x+12*xsc+hsp,y,shell) {enemy2=other.enemy2store stop=0 spd=max(3,abs(other.hsp)+1) coll.phase=other.id owner=other.id kicked=1 type=other.storedtype other.anemyeat=id vspeed=-1 hspeed=other.hsp+4*other.xsc}
if holdind=shell
with instance_create(x+12*xsc+hsp,y,shell) {enemy2=other.enemy2store stop=0 spd=max(3,abs(other.hsp)+1) coll.phase=other.id owner=other.id kicked=1 type=other.storedtype other.anemyeat=id vspeed=-1 hspeed=other.hsp+4*other.xsc}
if holdind!=shell && holdind!=koopa && holdind!=redkoopa && holdind!=yelkoopa && holdind!=blukoopa && holdind!=redhover && holdind!=yelhover && holdind!=hopkoopa && holdind!=brick && holdind!=piranha && holdind!=redpiranha && holdind!=firepiranha
with instance_create(x+12*xsc+hsp,y,holdind) {if other.bratstore {brat=1 sprite="goombrat"} enemy2=other.enemy2store owner=other.id gh=other.jeffstore other.anemyeat=id spitted=1 if object_index!=bulletbill && object_index!=cannonball && object_index!=redcannonball vspeed=-1 else xsc=sign(hspeed) hspeed=other.hsp+4*other.xsc}
}
if holdind=brick
with fire_projectile(x+hsp+12*xsc,y-4)
{
xsc=owner.aimxdir
eggtype=2
hspeed=abs(owner.hsp)+6*owner.xsc
hspeed=owner.hsp+6*owner.xsc
vspeed=-1
mask_index=spr_mask12x12
sprite_index=spr_mask12x12
}

if holdind!=brick && size=2
with fire_projectile(x+12*xsc,y-2)
{
xsc=owner.xsc
eggtype=4
//hspeed=abs(owner.hsp)+2*owner.xsc
hspeed=owner.hsp+2*owner.xsc
vspeed=0
visible=1
}
if holdind!=brick && size=6 { spit=8 playsfx("yoshispit") p2 = 10;
with fire_projectile(x+12*xsc,y-2)
{
xsc=owner.xsc
eggtype=4
//hspeed=abs(owner.hsp)+2*owner.xsc
hspeed=owner.hsp+3*owner.xsc
vspeed=-2.4
visible=1
} p2 = real(ss);}
hold=0
anemyeat=0
holdind=0
}

if down && hold && holdind!=brick || (hold && (holdind=piranha || holdind=redpiranha || holdind=firepiranha))
{
eggcount+=1
if eggcount<=6
{
hold=0
holdind=0
anemyeat=0
swallow=26
playsfx("yoshiswallow")
o=fire_projectile(x-xsc*4,y+7)
    if (!eggfollower) {eggfollower=o egglast=o}
    else {o.eggfollower=eggfollower eggfollower.eggfollow=o eggfollower=o}
    o.eggfollow=id
    o.owner=id
    o.eggtype=0
    with o {followQueue = ds_queue_create()}
}
if eggcount>=6
{
hold=0
holdind=0
anemyeat=0
o=fire_projectile(x-xsc*4,y+6)
    o.vspeed=-2
    o.hspeed=-2*xsc
    o.gravity=0.2
    o.eggtype=3
}
}

if eggfollower
if (cbut) {
if !aim
{
aim=1
if up
{
aimdir=90
}
else
aimdir=0
aimxdir=xsc
aimdirgo=0
}
else
{
aim=2
if eggfollower
{
fired=14
eggcount-=1
playsfx("yoshithrow")
with fire_projectile(x+hsp+4*aimxdir,y)
{
xsc=owner.aimxdir
eggtype=1
hspeed=lengthdir_x(10+abs(owner.hsp),owner.aimdir)*owner.aimxdir
vspeed=lengthdir_y(10,owner.aimdir)
mask_index=spr_mask2x2
}

with eggfollower
{
if eggfollower
{
eggfollower.x=mean(x)
eggfollower.y=mean(y)
owner.eggfollower=eggfollower
eggfollower.eggfollow=owner
}

else
{
owner.eggfollower=0
}
instance_destroy()
}

}

}
}

/*
if (ckey) {
if (spinjump && vsp>0) spinjump=1
} else {
if (spinjump=1 && vsp<-2) {
vsp*=0.6
spinjump=2
}
}
*/

//crouching
if (down && !up) {
if (jump) {
if (fall!=6 && !pound && !carry && !pound && !poundlok && fall!=69 && !timing_proj && !timing_misfire) {
pound=1
flutter=0
greenmissile=0
misfire=0
if (water) seqcount=1
playsfx("yoshipound")
}
}
else if (!braking && !timing_proj && !timing_misfire) {
if (!crouch) {
crouch=1
aim=0
}
}
poundlok=1
com_piping()
} else {
if (pound=-1) pound=0
if (!jump && (!collision(0,-12) || !size || size==5)) crouch=0
poundlok=0
}

if (size==5) mask_set(9,8)
else if (size=0 || crouch || pound) mask_set(12,12)
else if (jump) mask_set(12,26)
else mask_set(12,24)


#define movement
if (piped || move_lock) exit

if aim
xsc=aimxdir

if ((loose && !jump) || (crouch && !jump)) {
if (braking) xsc=brakedir
braking=0
frick=0.06
if (slipnslide) frick=0.03
hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

maxspd=(3.1+water+(size==5)*0.55+slipnslide-!!flutter*1.2+!!spin)*wf
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)

if (pound) {
vsp=min(6,vsp)
} else vsp=min(7+downpiped,vsp)

///movement
//hi moster here dont uncomment the yground or easyground stuff because its required for the cool new slope system to work
//for anyone porting a charm from unfinished build or below to this build, delete or comment all of the commented code and add player_nslopforce()
calcmoving()

if (flutter) {
    fulbuff=5
        flutter+=1
        if (flutter=8) playsfx("yoshiflutter",1)
        if (flutter>54+20*superflutter) {fulbuff=5 flutter=0 fluttered=1 superflutter=0 soundstop("yoshiflutter") playsfx("yoshiflutterend")}
    }

if (!flutter) {soundstop("yoshiflutter")}

if (!dead && !grabflagpole) {
if fall!=69
player_horstep()
player_nslopforce()
//yground=easyground()
//if (yground!=verybignumber) yground-=14
    if (jump) {
if (pound>0) {
hsp=0
        if (pound<14) vsp=0
        else if (pound>=14 && pound<15) vsp=6*wf
        else if (water) {vsp-=0.1*wf if (vsp<1.5) pound=0}
        else vsp+=0.375*wf
    } else if (vsp<-2 && !luijump) vsp+=0.15
else if (flutter>8) if size=3 /*|| size=7*/ vsp=median(-3.15,vsp-max(0.125,vsp),1) else vsp=median(-1.95,vsp-max(0.05,vsp),2)
else if (water) vsp=min(1.5,vsp+0.04)
else if toungecling=2 vsp=0
else if fall!=69 && !luijump {vsp=min(4,vsp+0.28) if size==5 && vsp>-0.84 vsp-=0.196}
if (hang>0 && vsp>1 && !spinjump && !water) vsp=1.5
if (skidding) {soundstop("yoshiskid") skidding=0}
braking=0
if (!hurt) vine_climbing()
braking=max(0,braking-1)
if (!fall && !spinjump) fall=1
if (pound=-1) pound=0
if (sprung && !fall) fall=1
if (fall=12) {vsp=6*wf hsp=0}
if fall=69 {flutter=0}
push=0
rise=0 risec=0
coyote=0
player_vertstep()
}
if (osld<180 && osld>0 && !instance_place(x-16,y+4,ground)) dy=3
else if (osld>180 && osld<320 && !instance_place(x-16,y+4,ground)) dy=3
if (!jump) {
//if (yground!=verybignumber) { y=yground while collision(0,0) {y-=1 } }
if (finish && ending="retainer" && !jump) coyote=0
if (!collision(0,4) /*&& (y<yground-2)*/) {
coyote+=1
if (down || !run) {y+=1 coyote=3}
if (coyote=3) {
jump=1
fall=1
if (crouch) vsp=1.5
if (spin) {vsp=-1.5 dropkick=1}
}
} else coyote=0
if (jumpbuffer=-1) {
jumpbuffer=0
//jump buffering
if (rise=0 && !down) {
jumpbufferdo=1
if (insta) insted=1
}
}
}
}



com_finishmove()


#define actions
com_warping()
com_actions()

with enemy
{
if spitted
{

coll=collision(hspeed*1.2,-1)
if coll && object_index!=bulletbill && object_index!=cannonball && object_index!=redcannonball
{
hspeed=2*-xsc
}

coll=collision_rectangle(bbox_left+8-hspeed,bbox_bottom+8+vspeed,bbox_right+8+hspeed,bbox_top+8+vspeed,enemy,1,1)
if coll 
{
enemydie(id)
with coll {enemydie(id)}
}

coll=instance_place(x+hspeed,y+vspeed,enemy)
if coll 
{
enemydie(id)
with coll {enemydie(id)}
}

coll=instance_place(x,y,enemy)
if coll 
{
enemydie(id)
with coll {enemydie(id)}
}

if instance_place(x,y+2,collider) && object_index!=bulletbill && object_index!=cannonball && object_index!=redcannonball
{
hspeed=approach_val(hspeed,0,0.1)
}

if hspeed=0 && spitted && object_index!=bulletbill && object_index!=cannonball && object_index!=redcannonball
{
spitted=0
hspeed=0.5*-xsc
}

}

}

if holdind=koopa || holdind=hopkoopa
storedtype=""

if holdind=redkoopa || holdind=redhover
storedtype="red"

if holdind=yelkoopa || holdind=yelhover
storedtype="yel"

if holdind=blukoopa
storedtype="blu"

weight=0.5+0.5*!!size
bartype=1

is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1 || flash) is_intangible=1

power_lv=0
if (spin || dropkick) power_lv=1
if (spinjump) power_lv=1
if (!poundcancel && pound) power_lv=3
if (star) power_lv=5
if (super) power_lv+=1

if (piped) {
updatecarry()
exit
}

if toungecling=2
{
hsp=0
vsp=0
flutter=0
fulbuff=1
}

//Special interactions
pvp_spin=spin //rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=!pound //make sure to set for 0 for the mario bros when pounding
pvp_ignore=pound //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away

//waiting animation
if maxwait{
if (sprite="stand")
{waittime+=1}
else if sprite!="wait" waittime=0
}

if (!jump) {
vsp=0
if (!star) seqcount=0
if (push=0 && hsp!=0 && braking) {
if (!skidding) {skidding=1 playsfx("yoshiskid",1)}
} else if (skidding) {soundstop("yoshiskid") skidding=0}
if (abs(hsp)<0.2 && spin) { //stop spinning
spinc+=1 if (spinc=8) {
spinc=0
spin=0    
hsp=0
soundstop(name+"spin")
crouch=down            
}
}
}
//water
if (underwater()) {
if (!water) {
if (abs(vsp)>2) water_splash(1)
watrlock=10 spinjump=0 fall=1 hang=0
if (!pound) vsp=min(1,vsp/2)
if (dive) {vsp+=2 hsp=max(0,abs(hsp)-2)*xsc dive=0}
jumpspd=1
dropkick=0
}
water=1 wf=0.45 eoll=0 dropkick=0 run=0
if (carry && carryid) {with (carryid) event_user(0) carryid=noone carry=0}
} else {
if (water) {
water=0
if (vsp<-1) vsp=min(vsp,-3)
else {vsp=1 y+=1 water=underwater() y-=1}
if (abs(vsp)>2) water_splash(0)
}
wf=1
}

//smoke generation
if (global.dustframe) {
if (slipnslide) {
i=shoot(x,y+10,psmoke) i.depth=depth+2
}
if (spin) {
i=shoot(x,y+10,psmoke) i.depth=depth+2
}
if (vsp<-5-2*!sprung) {
shoot(x,y+8,psmoke,0,-1)
}
if (vsp>7) {
speedwagon+=1
if (speedwagon>60) shoot(x,y,psmoke,0,1)
} else speedwagon=0
}

if vsp>2
fulbuff=approach_val(fulbuff,0,1)
maxe=6
twist=max(0,twist-1)
stomplok=max(0,stomplok-1)
wallkick=max(0,wallkick-1)
watrlock=max(0,watrlock-1)
throw=max(0,throw-1)
hang=max(0,hang-1)
swim=max(0,swim-1)
poundjump=max(0,poundjump-1)
wsk=(wsk+0.1) mod 4
if (spin) spinframe+=1
else spinframe=0
if (spinframe>9) spinframe=9-9*jump

swallow=max(0,swallow-1)
spit=max(0,spit-1)

if (!collpos(xsc*16,0) || !jump) hang=0
if (pound) {
crouch=1
hang=0
if (pound<15) pound+=1
else if (up || (water && vsp>5)) {pound=0 fall=0 insted=1 crouch=0 canstopjump=1}
else fall=4
} else poundcancel=0
if (fall=6 && sign(hsp)=xsc) fall=1
if (rise!=0) {crouch=1 hsp=0 xsc=rise risec+=1 if (risec=10) {risec=0 rise=0 crouch=down}}
sprung=0
if (slipnslide) {
crouch=1
if ((slobal=0 && (hsp=0 || ((left || right) && !down))) || jump) && (!collision(0,-12) || !size || size==5) {slipnslide=0 crouch=0}
}
if (energy!=maxe || sign(hsp)=xsc) jumpspd=min(jumpspd,100)

if (abs(hsp)>=3 && !jump) {
if (mcs>8) {energy+=1 mcs=0}
} else if (energy!=maxe || !jump) if (mcs>30) {energy-=1 mcs=0}

if (dropkick) xsc=esign(hsp,xsc)

//WHO IS CLIMBING MY SHIT.
if (up && !down && !onvine) {
    onvine=instance_place(x,y,vine)
    if (onvine) fall=69 //nice
}
if (onvine) pound=0
if (fall=69) {
    rightvine=instance_place(x+8,y,vine)
    leftvine=instance_place(x-8,y,vine)
    if (rightvine=noone) rightvine=0
    if (leftvine=noone) leftvine=0
    
    downvine=instance_place(x,y+8,vine)
    upvine=instance_place(x,y-8,vine)
    if (upvine=noone) rightvine=0
    if (downvine=noone) leftvine=0
    
    if (!rightvine && abs(x-onvine.x)>mask_h/2 && x>(onvine.x)) {
        x=onvine.x+mask_h/2
    } else if (rightvine && abs(x-onvine.x)>mask_h/2 && x>(onvine.x)) onvine=rightvine

    if (!leftvine && abs(x-onvine.x)>mask_h/2 && x<(onvine.x)) {
        x=onvine.x-mask_h/2
    } else if (leftvine && abs(x-onvine.x)>mask_h/2 && x<(onvine.x)) onvine=leftvine
    //Imagine adding separation just so that it doesn't look bad

    if !downvine && abs(y-onvine.y)>mask_v/2 && y>(onvine.y) {
        fall=0
        onvine=0
    } else if downvine && abs(y-onvine.y)>mask_v/2 && y>(onvine.y) onvine=downvine
    
    if (!upvine && abs(y-onvine.y)>mask_v/2 && y<(onvine.y)) {
        fall=0
        vsp=-2
        onvine=0
    } else if (upvine && abs(y-onvine.y)>mask_v/2 && y<(onvine.y)) onvine=upvine
    
    if (onvine.movingnation) {
        x+=onvine.hsp
        y+=onvine.vsp
    }
}

jesus=(((boost && vsp<4)||(size==5 && !down && abs(hsp)>2.8)) && !water)

if (jump && size==7 && global.fastframe4 != ff4prev) {ff4prev = global.fastframe4 with instance_create(x, y, afterimagenoblend) {event_user(0) alphadecay=1 alarm[0] = 24 maxalarm = 24 maxalpha=0.8}}

com_endactions()


#define enemycoll
if (coll.id=anemyeat || piped ) exit



if (coll) 
if coll.id!=anemyeat {
    if (!coll.damage_player_on_contact) {
        calcfall=fall
        if (fall=5 || fall=12) calcfall=0
        global.coll=id
        type=coll.object_index
            
        seqcount=max(1,seqcount)
        
        if (super) {
            if (water) seqcount=1
            enemyexplode(coll)
            exit
        }
        
       
        if (slipnslide && type!=spinyegg && type!=bulletbill) {
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            enemydie(coll)                
            exit
        }
        
        if (coll.object_index=lakitu) if (coll.flee) exit
    
        
        if (star  
        || (spin && type!=spinyegg && type!=beetle && type!=shell)
        || (pound>13 && type!=piranha && type!=spinyegg && type!=spiny)) {
		    if size==5 && !spin && !star //&& (hurt || piped || (intangible() && !diggity)) 
			{
			if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"jump",0,3.6) 
			vsp=-3-((ckey && spin) || (akey && star))*1.5 
			canstopjump=akey 
			if !pound exit else pound=0
			}
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            if (type=hammerbro) seqcount=max(5,seqcount)
            enemydie(coll)                
            exit
        }
        

        
        
        if (spin) {
		    if (type=shell) {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else if (coll.type!="beetle") {enemydie(coll) exit}}
            else if (type=beetle) {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else {hsp=0 jump=1 jumpspd=0.5 dropkick=1 spin=0 enemystomp(coll) exit}}
            else if (type=spinyegg) {hurtplayer("enemy") exit}
            else {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else enemydie(coll) exit}
        }
                         
        if (type=spinyegg || type=spiny || type=piranha) {
            if (y<coll.y-8 && type!=shell) {
                instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
                sound("enemystomp")
                vsp=-3-akey*1.5
                canstopjump=akey
                pound=0
                coll.phase=id
            } else if (type=spinyegg || type=spiny) {
			
			    if (type=spiny) {
                    if (!fall && vsp<0) enemyexplode(coll)
                    else hurtplayer("enemy") exit
                }
                if (type=spinyegg) {
                    if (punch && punch<=10) enemydie(coll) else hurtplayer("enemy") exit
                } 
			
			} else hurtplayer("enemy") exit
			//if hurtplayer("enemy")
            //exit
        }
                
        if (type=shell && !coll.time) {          
            if (coll.type="spiny" && (coll.vspeed-vsp)*coll.ysc<0) {
                hurtplayer("enemy") exit
            } else if (!coll.kicked || (coll.stop && (coll.owner=id || coll.vspeed>=0))) {
                //if (bkey && !carry && !spin && !dropkick) {
                    //coll.carry=id coll.owner=id coll.alarm[1]=600 coll.alarm[2]=-1 carryid=coll
                    //carry=1
                //} else { 
                    if (coll.stop && !coll.kicked && size!=5) doscore_p(8000)
                    else if size!=5 {seqcount=max(seqcount,2+scorelok1) doscore_p()}
                    if (jump) {
                        if (vsp>0) {
                            vsp=-3-akey*1.5
                            canstopjump=akey
							if size==5 playsfx(name+"jump",0,3.6)
                            if (fall=12) fall=5
                        }
                    }
					if size!=5 {
                    kicksound(0)
                    instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
                    with (coll) {spd=max(3,abs(other.hsp)+1) hspeed=spd*esign(x-other.x,other.xsc) owner=other.id kicked=1 stop=0 phase=owner}}
                //}
                exit
            } else {
                if (coll.kicked && !coll.stop && sign(hsp)=sign(coll.hspeed) && abs(hsp)>abs(coll.hspeed)) {
                    kicksound(0)
                    instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
                    coll.spd=max(3,abs(hsp)+1)
                    coll.owner=id
                    coll.phase=id
                    exit
                } else if (coll.kicked && (!coll.stop || (coll.owner!=id && coll.vspeed<0)) && (vsp<0 || !jump)) {hurtplayer("enemy") exit}
                else {
                    if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey if fall=12 fall=5 exit}
					with (coll) {hspeed=0 owner=noone phase=other.id stop=0 kicked=0 time=15}
                    vsp=-3-akey*1.5 canstopjump=akey sound("enemystomp") doscore_p() if (fall=12) fall=5 exit
                }
            }                    
        }
        
        if (type=blooper) {
            if (jump && (!calcfall || !water) && vsp>0) {if (calcfall) enemystomp(coll,5) else enemyexplode(coll)}
            else hurtplayer("enemy") exit
        }
        
        if (type=cheepred || type=cheepwhite) {
            if (jump && !calcfall) {enemyexplode(coll) exit}
            else {hurtplayer("enemy") exit}
        }
        
        if (jump) {
            if (type=koopa || type=beetle || object_is_ancestor(type,koopa)) {
                if (vsp<0) {
                    if (calcfall) hurtplayer("enemy")
					else if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit}
                    else enemyexplode(coll) exit
                }
            } else {
                if (!calcfall && size!=5) {enemyexplode(coll) exit}
                if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey if fall=12 fall=5 exit}
                if (vsp<0) {hurtplayer("enemy") exit}
            }
			
			if (type=bulletbill)
            {
            if (coll.vspeed<0 && coll.y>y+8) {if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit} else {jump=1 fall=1 dive=0 vsp=-0.5 enemydie(coll) exit}}
            }
            
            if (type=goomba && seqcount=1 && !scorelok4) {seqcount=0 scorelok4=1}    
            if ((type=koopa || type=redkoopa) && seqcount=1) scorelok1=1    
            if (type=hopkoopa || type=redhover) seqcount=max(seqcount,1)
            if (type=hammerbro) seqcount=max(5,seqcount)
            if (fall=12) fall=5                        
			if size==5 {if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit}
            enemystomp(coll) exit      
        } else if (coll.vspeed<0 && coll.y>y+8) {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit} else {jump=1 fall=1 vsp=-0.5 enemystomp(coll) exit}} //boll team watching me paste this same line 12 times like an idiot:
        
        hurtplayer("enemy")   
    } else if (!star && !flash) hurtplayer("enemy")
}    

#define hurt
pipe=0
sprongin=0
speed=0
if (flutter) {soundstop('yoshiflutter') flutter=0} fluttered=0 superflutter=0
if (skidding) {soundstop(name+"skid") skidding=0}
if (carry && carryid) {with (carryid) event_user(0) carryid=noone carry=0}
onvine=0
energy=0
braking=0
sprung=0
diggity=0
grow=0
gk=0
fk=0
punch=0
bounce=0
twirl=0
oldsize=size
jumpbuffer=0
hyperspeed=0
luijump=0
hp=0
star=0
if (super) stopsuper()   


if (((!size || size==5) || ohgoditslava || name="kid") && !shielded) {
   if (global.mplay>1 || global.debug || global.lemontest) alarm[7]=120
   if (global.gamemode="battle") dropcoins(0)
   die()
} else {
    rise=0
    slide=0
    sprung=0
    fall=0
    pound=0  
    braking=0
    boost=0
    upper=0
    hyperspeed=0
    playsfx(name+"damage")

    starhit=0

        fired=0
        if (shielded) {shielded=0} else if global.rings[p2]>0 {droprings(0)} else {if size>=3 size=2 size-=1}
        flash=1
        jump=1
        fall=6
        hsp=xsc*-2*wf vsp=-3*wf

}

//Block hitting

#define hitblocks
if typeblockhit=0{
with (blockcoll){
if (stonebump || (owner.size=0 || owner.size=5) && insted!=1 && !owner.tempkill && (biggie || cracked=0 || (cracked=1 && owner.size=5))) {
    if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
} else if (stonebump || owner.size && owner.size!=5 && insted!=1 && !owner.tempkill && cracked=0 && biggie) { //break spiner
    if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
    if (!stonebump){
    owner.vsp=1.5
    cracked=1
    i=instance_create(x,y,crackedbrick)
    i.owner=id
    i.biome=biome
    i.imcrack=1
    i.go=go
    i.tpos=1
    i.biggie=biggie
    }
}   
else { 
    com_breakblocks()
  }
 }
} else if typeblockhit=1{
    if (blockcoll.cc!=0 && !blockcoll.hit)
    	hititembox()
    if !(stoppounding) && place_meeting(x,y+max(4,vsp),blockcoll) {
        if (pound && !poundcancel && !piped) {
            playsfx(name+"stomp")         
            shoot(x-8,y+4,psmoke,-2,-1)
            shoot(x+8,y+4,psmoke,2,-1)    
            poundjump=16
        }
    }
}
if blockcoll.object_index == goalblock hititembox()

#define hitwall
if greenmissile{com_piping()}

if (object_is_ancestor(coll.object_index,hittable)) {
    if (dropkick)|| (spin && abs(hsp)>0.5){
        s=vsp
        global.coll=id
        with (coll) {
go=1
            event_user(0)
        }
        if (coll.object_index=brick && coll.hit || !instance_exists(coll)) coll=noone

        if ((dropkick || spin) && instance_exists(coll)) {instance_create(x+8*s,y+6,kickpart) x-=hsp dropkick=-1 hsp=-2*argument[0] vsp=-2*spin jump=(jump || spin) spin=0 crouch=1 coll=noone}
    }
}



if (hurt) {hurt=0 fall=6 flash=1 fk=0}

if (!collpos(sign(hitside)*10,8,1)) {        
    //gap running
    if (y<coll.y-12) {y=coll.y-14 coll=noone exit}
}

hsp=0
hyperspeed=0         

if toungecling=1
toungecling=2

#define landing
hang=0   
kicked=0
braking=0
double=0
insted=0
fluttered=0 if (flutter) {if (flutter>=8) {soundstop('yoshiflutter') playsfx('yoshiflutterend')} flutter=0}

spinjump=0

if (downpiped) {
    shoot(x-8,y+4,psmoke,-2,-1)
shoot(x+8,y+4,psmoke,2,-1)
    downpiped=0
}
if (hurt) {flash=1 fk=0 hsp=0 hurt=0}
           
playsfx(name+"step")

//jump buffering
if (jumpbuffer) jumpbuffer=-1

hang=0   
kicked=0

if (pound) {
	com_piping()
	if (!poundcancel && !piped) {
        playsfx(name+"stomp")         
        shoot(x-8,y+4,psmoke,-2,-1)
        shoot(x+8,y+4,psmoke,2,-1)    
		poundjump=16
    }
	with (itembox) if (instance_place(x,y-max(4,other.vsp),other.id)) {
		go=1    
		event_user(0)
		picked=0
		other.stoppounding=!hit
		other.jump=1
		other.vsp=-0.1
	}
	with (crate) if (instance_place(x,y-max(4,other.vsp),other.id)) {
		event_user(0)
		other.stoppounding=1
		other.jump=1
		other.vsp=-0.1
	}
	if (stoppounding=1 && !down) {stoppounding=0}
	if stoppounding=0 {pound=0}     
}

/*
if (pound) {
com_piping()
with (itembox) if (instance_place(x,y-max(4,other.vsp),other.id)) {
go=1    
event_user(0)
picked=0
other.stoppounding=!hit
other.jump=1
other.vsp=-0.1
} 
if (stoppounding=1 && !down) {stoppounding=0}
if stoppounding=0 {pound=0} 

    
    if (!poundcancel && !piped) {
        playsfx(name+"stomp")         
        shoot(x-8,y+4,psmoke,-2,-1)
        shoot(x+8,y+4,psmoke,2,-1)    
poundjump=16
    }
}
*/

fulbuff=0
 

#define death
if (owner.flutter) {soundstop('yoshiflutter') owner.flutter=0} owner.fluttered=0 

if (event="create"){

	alarmmp=60

    yoshideath=owner.yoshideath
	sprite="dead"
	frame=0
	frspd=1
	spindash=0
	alpha=1
	dest=0

	if global.mplay>1 alphadecay=1

	if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
	name=owner.name
	p2=owner.p2
	owner=owner.id
	size=owner.size
	xsc=owner.xsc
	ysc=owner.ysc
	water=owner.water
	frn=owner.frn
	
	if yoshideath {
		fakeframe=floor(frame)
		turnarounds=0
		if (frn<=1) alarm0=84 else alarm0=24
		alarm1=480
		vspeed=0 gravity=0
	} else {
		alarm0=30
		alarm1=300
	}

} 
else if (event="step"){
	alarmmp=max(0,alarmmp-1)
	alarm1=max(0,alarm1-1)

	if alphadecay &&!alarmmp alpha-=0.1

	if yoshideath {
	    if (sprite="dead" && animf>0 && frn>1) {
		    if frame>fakeframe {fakeframe=floor(frame)}
			if fakeframe>frame {
			    turnarounds+=1 
				if (turnarounds=1 || turnarounds=3) animf*=(2/3)
				if turnarounds=2 animf*=0.75
				fakeframe=floor(frame)
			}
			if (turnarounds=3 && frame>=frn-1 && animf!=0) animf=0
		} 
		if sprite="dead" && ((turnarounds=3 && animf=0) || frn<=1) {
		    alarm0=max(0,alarm0-1)
		}
		
		if (alarm0=0 && !didonce) {animf=1 owner.sprite="deadland" sprite="deadland" frn=5 didonce=1}
		if alarm1=0 dest=1
        if (dest) {c+=1 alpha=(c mod 5>2) if (c>60) instance_destroy()}
	} else {
	    alarm0=max(0,alarm0-1)
		if (alarm0=0 && !didonce) {
			vspeed=-3.5 gravity=0.1-(owner.water*0.015) didonce=1
		}
		if alarm1=0 instance_destroy()
	}
	
	if owner.sprite!=sprite {
		//frn=owner.frn
		//frs=owner.frs
		//frl=owner.frl
		//fox=owner.fox
		//foy=owner.foy
		with owner set_sprite(sprite)
		owner.sprite=sprite 
	}
} else if (event="draw"){

}

#define enterpipe
if (type="door") {
	//set_sprite("stand")
}
if (type="side") {
	if (carry) {crouch=1 set_sprite("crouch")}
}
if (type="down") {
	if (pound) {set_sprite("pound") frame=frame_number(sprite) vspeed=5 alarm[6]=6 fastpipe=1}
}

if (skidding) {soundstop("yoshiskid") skidding=0}
braking=0
crouch=0
push=0
pound=0

#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}   
