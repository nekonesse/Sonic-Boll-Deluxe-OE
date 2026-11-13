#define object_type
enemy

#define create
if !(custom_sprite_exists("pig")) {
    sheet=add_custom_sprite(myobjdir+"pig.png","pig",0,1,0,0);
} else {
    sheet=get_custom_sprite("pig")
}

x+=8

mask_index=spr_goombamask

x+=unreal(data_0,0)
y+=unreal(data_1,0)

frame=0

#define step_begin
if (!inview()) active=0
else {
    if (wait) {
        //limit activation chains to 4 enemies
        test=wait
        repeat (3) {test=test.wait if (test=noone) break}
        if (wait.active || test!=noone) {wait=noone active=1}
    } else active=1
}

if (place_meeting(x,y+4,lavablock)) {instance_create(x,y,smoke) sound("enemykick") instance_destroy()}
if (!active) {x-=hspeed y-=vspeed vspeed-=gravity np=nearestplayer() if (np) hspeed=abs(hspeed)*esign(np.x-x,sign(hspeed)) exit}

if (phase) {if (!place_meeting(x,y,phase) || invincible(phase)) {phasec+=1 if (phasec>=10) {phase=-1 phasec=0}} else phasec=0}

if (lock) {x-=hspeed y-=vspeed}

#define step
time=max(0,time-1)

if (grounded) && !(alarm_get(1)) {
    hspeed=lerp(hspeed,0,0.1)
}

with instance_place(x,y+vspeed,enemy) if id != other.id enemydie(id)

#define step_end
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

            vspeed=0

            belt=collision(0,1)
            if belt.object_index=conveyorbelt && !collision(belt.beltspd,0) && !collision(-belt.beltspd,0)
                x=x+belt.beltspd;

            if (hsp!=0) vspeed=-abs(hsp)
            }
            

            grounded=1
            redturn=1
        } else if !collision(hspeed,1) {
            var dofall;
            dofall=true;

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

#define carry_release
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

#define draw

animframe += 0.125

animframe=wrap_val(animframe,0,4)

draw_sprite_part_ext(sheet,0,9+40*(floor(animframe)),9,39,39,floor(x-20),floor(y-30),1,1,c_white,1)

//if (global.debug) draw_sprite(mask_index,0,x,y)

#define deloaded
if !(custom_sprite_exists("pig")) || get_custom_sprite("pig") == 0 {
	//no need to deload anything.	
}else {
	delete_custom_sprite("pig")
}

#define lemon_display

if !(custom_sprite_exists("pig")) {
    sheet=add_custom_sprite(myobjdir+"pig.png","pig",0,1,0,0);
} else {
    sheet=get_custom_sprite("pig")
}

draw_sprite_part_ext(sheet,0,9,9,39,39,floor((x-10)*16),floor((y-20)*16),1,1,c_white,1)

#define lemon_preview
if !(custom_sprite_exists("pig")) {
    sheet=add_custom_sprite(myobjdir+"pig.png","pig",0,1,0,0);
} else {
    sheet=get_custom_sprite("pig")
}

draw_sprite_part_ext(sheet,0,9,9,39,39,(curx*16)+off-10,(cury*16)+off-20,1,1,c_white,1);

#define editobjmenu
thedefault=argument1
type=argument0

global.cobjectreturn = "----"

if (type==0) {
	global.cobjectreturn = get_string("Alignment in pixels (X): ",thedefault)
	exit;
}
else if (type==1) {
    global.cobjectreturn = get_string("Alignment in pixels (Y): ",thedefault)
    exit;
}

	

#define editobjdataname
i=string(argument1)
type=argument0

if type==0 {
	global.cobjectreturn = "Align X: " + i
	exit;
}else if type==1 {
	global.cobjectreturn = "Align Y: " + i
	exit;
}

#define lemon_data
switch(argument0) {
	case 0: global.cobjectreturn = 0 break;
	case 1: global.cobjectreturn = 0 break;
}