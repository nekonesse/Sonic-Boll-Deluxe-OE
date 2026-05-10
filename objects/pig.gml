#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
brat=0
phase=-1
phasec=10
wakehit=0
grav=0.25
hspeed=0
vspeed=0
xsc=1
ysc=1
hp=0
carry=0
turncount=0
active=1
enemy2=1

type=0
getregion(x)

type=""
sub="pig"

wait=instance_position(x+24,y,enemy)
if (wait) if (wait.object_index=piranha) wait=noone
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
time=max(0,time-1)

if (grounded) && !(alarm_get(1)) {
    hspeed=lerp(hspeed,0,0.1)
}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
enemy_spritechange()
enemy_animate()
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

if (!active) {x-=hspeed y-=vspeed vspeed-=gravity np=nearestplayer() if (np) hspeed=abs(hspeed)*esign(np.x-x,sign(hspeed)) exit}

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
if (trap) {
    x=(x*4+trap.x)/5
    y=(y*4+trap.y)/5
    flipc-=1
    if (!flipc) {xsc*=-1 flipc=24}
    x-=hspeed
    y-=vspeed
} else if (active && !carry && !throwncolls) {
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
        if (collision(0,esign(vspeed,1))) {

            if !grounded{
            s=esign(vspeed,1)
            y+=vspeed
            while (collision(0,0)) {
                y-=s
            }

            vspeed=0

            belt=collision(0,1)
            if belt.object_index=conveyorbelt && !collision(belt.beltspd,0) && !collision(-belt.beltspd,0)
                x=x+belt.beltspd;

            if (hsp!=0) vspeed=-abs(hsp)
            }

            grounded=1
            if (kicked) {instance_create(x,y,smoke) with (instance_create(other.x,other.y,scoreeffect)) {value=15} doscore_p(5000,1) sound("enemypigdeath") instance_destroy()}
        } else if !collision(hspeed,1){
            grounded=0
            vspeed=min(3,vspeed+grav)
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

sprite="pig"
sprite=type+sub
#define Collision_enemy
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with (other)
enemydie(id)
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
time=10

if (sign(owner.hspeed)=owner.xsc) spd=max(3,abs(owner.hspeed)+1)
else spd=3

vspeed=1

if (owner.up) {vspeed=-6 spd=abs(owner.hspeed*0.75) hspeed=spd*esign(owner.hspeed,owner.xsc) stop=1}
else if (owner.down) {stop=1 vspeed=owner.vspeed+2.25 x+=2*owner.xsc spd=abs(owner.hspeed)+0.1 hspeed=spd*owner.xsc}
else {hspeed=owner.hsp+3*owner.xsc vspeed=-1}
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
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
enemy_animate()
if (active && !carry) ssw_enemy(sprite)
