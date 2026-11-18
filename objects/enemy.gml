#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
enemyspr_index="nothing"
if object_index=lakitu exit
getregion(x)
phase=-1
phasec=0
wakehit=0
grav=0.25
xsc=-1
ysc=1
hp=0
carry=0
turncount=0
trap=noone
redturn=0
active=0
animated=0
sdir="0"
parent_event = noone;

if (object_index!=piranha) {
    wait=instance_position(x+24,y,enemy)
    if (wait) if (wait.object_index=piranha) wait=noone
    if !wait wait=instance_position(x+24,y,litbobomb)
}
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if(powner) powner.items-=1
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///common enemy passive

animated=0
if object_index=lakitu exit
if (!inview()) active=0
else {
    if (wait) {
        //limit activation chains to 4 enemies
        test=wait
        repeat (3) {test=test.wait if (test=noone) break}
        if (wait.active || test!=noone) {wait=noone active=1}
    } else active=1
}

if (!active && object_index!=bulletbill) {x-=hspeed y-=vspeed vspeed-=gravity exit}

if (pitdeath()) {if (object_index=shell || object_index=bombshell) owner.enemyc+=1 instance_destroy()}
if (object_index!=bulletbill && object_index!=cheepfly) if (place_meeting(x,y+4,lavablock)) {instance_create(x,y,smoke) sound("enemykick") instance_destroy()}

if (phase) {if (!place_meeting(x,y,phase) || invincible(phase)) {phasec+=1 if (phasec>=10) {phase=-1 phasec=0}} else phasec=0}

if (lock) {x-=hspeed y-=vspeed}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if firstframe=1 {
visible=1
}
if !firstframe firstframe=1
if object_index=lakitu exit
if object_index=chopper exit
if (trap) {
    x=(x*4+trap.x)/5
    y=(y*4+trap.y)/5
    flipc-=1
    if (!flipc) {xsc*=-1 flipc=24}
    x-=hspeed
    y-=vspeed
} else if (active && !carry && !throwncolls) {
    if (wakehit) {wakehit-=1 if (wakehit=0) with (hitplayer) hurtplayer("enemy")}
    //if hsp!=0|| hspeed!=0 player_magnetslope()
    x+=hsp
    hsp=max(0,abs(hsp)-0.0625)*sign(hsp)
    calcmoving()
    if (vspeed<0) {
        coll=collision(0,vspeed)
        if (coll) {
            y=coll.bbox_bottom+(y-bbox_top)+1
            vspeed=1
        } else vspeed=min(3,vspeed+grav)
    } else {
        //yground=easyground()
        if (collision(0,esign(vspeed,1))) {

            if !grounded{
            s=esign(vspeed,1)
            y+=vspeed
            while (collision(0,0)) {
                y-=s
            }
            if (vspeed!=0 && object_index=spiny && instance_exists(player))
                hspeed=0.5*esign(nearestplayer().x-x,-1)

            vspeed=0

            belt=collision(0,1)
            if belt.object_index=conveyorbelt && !collision(belt.beltspd,0) && !collision(-belt.beltspd,0)
                x=x+belt.beltspd;

            if (hsp!=0) vspeed=-abs(hsp)
            }
            if (object_index=hopkoopa ) vspeed=-2.75
            if (object_index=paragoomba ){
                bouncecount+=1
                if bouncecount=4 {cooldown=60*!brat bouncecount=0 if brat hspeed*=-1}
                if bouncecount=3 vspeed=-2.75-brat
                if bouncecount=2 vspeed=-1
                if bouncecount=1 {if cooldown {cooldown-=1 bouncecount=0} else vspeed=-1 }
                if sign(nearestplayer().x-x)!=sign(hspeed) && cooldown && !brat {cooldown=0 hspeed*=-1}
            }

            grounded=1
            redturn=1
        } else if !collision(hspeed,1) {
            var dofall;
            dofall=true;
            if (((brat && object_index!=paragoomba) || ((object_index=redkoopa || object_index=blukoopa || object_index=bombshellkoopa) && !paramode) || object_index=crabmeat || object_index=wigglerhead || object_index=drybones || object_index=wigglerbod ) && redturn && !collision(hspeed+1*sign(hspeed),4)) {
                redturn=0 hspeed*=-1 x+=hspeed
                dofall=false;
            }
            if ((object_index=yelkoopa && !paramode && grounded) && !collision(hspeed+1*sign(hspeed),4)){
                redturn=0 vspeed=-5.25
            }

            if (dofall) {
                grounded=0
                vspeed=min(3,vspeed+grav)
            }
        }
    }
    turnaround()
    player_climbstep(coll,hspeed)
    if (turncount) turncount-=1
    else {
        oxsc=xsc
        if (!revive) if hspeed!=0 xsc=-esign(hspeed,-1)
        if (xsc!=oxsc) turncount=10
    }
}
#define Collision_enemy
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if object_index != chopper
{
if (carry || kicked || enemycolls) {
    seqcount+=1
    if (carry) seqcount=0
    with (other) {
        instance_create(mean(other.x,x),mean(other.y,y),kickpart)
        if ((object_index=shell && kicked) || other.carry) enemydie(other.id,other.seqcount)
        enemydie(id,other.seqcount)
    }
}
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (collision(0,0)) x=owner.x

carry=0
owner.carry=0
owner.carryid=noone
phase=owner

kicked=1

if (sign(owner.hsp)=owner.xsc) spd=max(3,abs(owner.hsp)+1)
else spd=3

vspeed=1

if (owner.up) {vspeed=-6 spd=abs(owner.hsp*0.75) hspeed=spd*esign(owner.hsp,owner.xsc) stop=1 active=0}
else if (owner.down) {stop=1 vspeed=owner.vsp x+=2*owner.xsc spd=abs(owner.hsp)+0.1 hspeed=spd*owner.xsc active=0}
else hspeed=spd*owner.xsc
throwncolls=1
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
x+=owner.carryoffx*owner.xsc
y+=owner.carryoffy
ssw_enemy()
x-=owner.carryoffx*owner.xsc
y-=owner.carryoffy
#define Other_20
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if string(sdir)=="1" {
    xsc=1
    hspeed=-hspeed
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !animated {enemy_spritechange()

enemy_animate() animated=1}

if object_index=shell && ysc=-1 {y+=4}
if (active && !carry) ssw_enemy(sprite)
if object_index=shell && ysc=-1 {y-=4}
