#define spritelist
stand,wait,lookup,pose,crouch,crawl,knock,closedoorshock,dead,walk,run,maxrun,megaspeed,brake,runturn,machturn,splat,splatknock,spring,jump,bonk,ball,dive,dash,wallrun,stomp,stompland,superjumpcharge,superjump,bonkwallr,taunt1,taunt2,taunt3,taunt4,taunt5,taunt6,punchhit,climbing,flagslide,enterdoor,levelend,treasure,enterdoorhappy,scared,suprise,scream


#define soundlist
release,skid,spin,spindash,insta,dash,boom,firedash,peelcharge,peelrelease,parry,taunt,sndmach1,sndmach2,sndmach3,sndmach4,machskid,sjumpcharge,sjumprelease,groundpound


#define movelist
Sonic
#
[a]: Instashield (air)
[b]: Spin Bash
[c]: Mach Run
[x]: Taunt
[up]: Super Jump (during Mach Run)
[down]: Dive (during Mach Run)

#define rosterorder
6

#define customchange
if file_exists(filename_dir(global.lemonfilename)+"/"+global.levelname+"-titlecard-1.png") && file_exists(filename_dir(global.lemonfilename)+"/"+global.levelname+"-titlecard-2.png") {

	if !(entrancesoundplay)
	{
	if variable_global_exists("titlecard1")
	if sprite_exists(global.titlecard1)
	sprite_delete(global.titlecard1)
	if variable_global_exists("titlecard2")
	if sprite_exists(global.titlecard2)
	sprite_delete(global.titlecard2)
	global.titlecard1=sprite_add(filename_dir(global.lemonfilename)+"/"+global.levelname+"-titlecard-1.png",0,0,false,0,0)  
	global.titlecard2=sprite_add(filename_dir(global.lemonfilename)+"/"+global.levelname+"-titlecard-2.png",0,1,false,0,0) 
	replacesound("entrance",filename_dir(global.lemonfilename)+"/"+global.levelname+"-entrance.wav")
	sound("entrance")
	entrancesoundplay=1
	}

	draw_sprite(global.titlecard1,0,0,0)
	draw_sprite(global.titlecard2,0,random(1),random(1))
}

else if file_exists(filename_dir(global.lemonfilename)+"/"+global.levelname+"-bosscard-1.png") && file_exists(filename_dir(global.lemonfilename)+"/"+global.levelname+"-bosscard-vs.png") && file_exists(filename_dir(global.lemonfilename)+"/"+global.levelname+"-bosscard-enemy.png") {

	if !(entrancesoundplay)
	{	//I used this as a general init too, sorry
		if variable_global_exists("bosscard1")
		if sprite_exists(global.bosscard1)
		sprite_delete(global.bosscard1)
		if variable_global_exists("enemyboss")
		if sprite_exists(global.enemyboss)
		sprite_delete(global.enemyboss)
		if variable_global_exists("bossvs")
		if sprite_exists(global.bossvs)
		sprite_delete(global.bossvs)

		global.bosscard1=sprite_add(filename_dir(global.lemonfilename)+"/"+global.levelname+"-bosscard-1.png",0,0,false,0,0)  
		global.enemyboss=sprite_add(filename_dir(global.lemonfilename)+"/"+global.levelname+"-bosscard-enemy.png",0,1,false,0,0)
		global.bossvs=sprite_add(filename_dir(global.lemonfilename)+"/"+global.levelname+"-bosscard-vs.png",0,1,false,0,0)
		

		//Yeahhhh, I had to do this for the playervs shit I'm sorry
		moddir=global.workdir+"SBDX_mods\"
		skindir=global.workdir+"SBDX_skins\"
		path=global.pskins[1+global.playerskin[p2],global.option[p2]]
		if (skindat("bundleplayer") || path=global.pbase) skin=path
			else skin=skindir+path

			if (skin=global.pbase) {
					directory=moddir+"character\"+global.charname[global.option[p2]]+"\"   
			} else {
		directory=skin
				
			}
		ss=string(p2)
		slot=p2
		if sprite_exists(global.playervs)	sprite_delete(global.playervs)
		global.playervs=sprite_add(directory +  "pepsonic-boss.png",0,1,0,0,0)
		
		
		
		//PLays entrance, need to make it change later
		sound("entrance")
		entrancesoundplay=1
		myframe=0
	}
	myframe+=1
	draw_sprite(global.bosscard1,0,0,0-(myframe mod 224))
	draw_sprite(global.bosscard1,0,0,224-(myframe mod 224))
	
	draw_sprite(global.bossvs,0,0,0)
	color=c_black
	if myframe>60 color=c_white
	draw_sprite_ext(global.enemyboss,0,207-min(207,(myframe*207)/60),224-min(224,(myframe*224)/45),1,1,0,color,1)
	if sprite_exists(global.playervs)
	draw_sprite_ext(global.playervs,0,-207+min(207,(myframe*207)/60),224-min(224,(myframe*224)/45),1,1,0,color,1)
}

#define start
mask_set(12,24)

global.facechase = 1

idlemaxfr=unreal(playerskindat(p2,name+" tv idle max frames"),9999)
collectmaxfr=unreal(playerskindat(p2,name+" tv collect max frames"),9999)
hurtmaxfr=unreal(playerskindat(p2,name+" tv hurt max frames"),9999)
combomaxfr=unreal(playerskindat(p2,name+" tv combo max frames"),9999)
mach3maxfr=unreal(playerskindat(p2,name+" tv mach3 max frames"),9999)
mach4maxfr=unreal(playerskindat(p2,name+" tv mach4 max frames"),9999)
firebuttmaxfr=unreal(playerskindat(p2,name+"tv firebutt max frames"),9999)

//This is all made by Scarf, huge credits to him, saved me a lot of trouble
moddir=global.workdir+"SBDX_mods\"
skindir=global.workdir+"SBDX_skins\"
path=global.pskins[1+global.playerskin[p2],global.option[p2]]
if (skindat("bundleplayer") || path=global.pbase) skin=path
    else skin=skindir+path

    if (skin=global.pbase) {
            directory=moddir+"character\"+global.charname[global.option[p2]]+"\"   
    } else {
directory=skin
        
    }
ss=string(p2)
slot=p2
if (global.ranksheet[slot] && sprite_exists(global.ranksheet[slot])) sprite_delete(global.ranksheet[slot])
if (global.hudsheet[slot] && sprite_exists(global.hudsheet[slot])) sprite_delete(global.hudsheet[slot])
global.ranksheet[slot]=sprite_add(directory + "\ranks\rank.png",15,1,0,0,0)
global.hudsheet[slot]=sprite_add(directory + global.charname[global.option[p2]] +"-hud.png",0,1,0,0,0)

tvchange=-1
tvani="idle"
taunt=-1
hp=6
canwall=1

#define stop
if (skidding) {soundstop(name+"skid") skidding=0}
soundstop(name+"sndmach4") soundstop(name+"sndmach3") soundstop(name+"sndmach2") soundstop(name+"sndmach1")
peelsound=0
newbonk=0
newbonktimer=0
star=0
grow=0
hurt=0
braking=0
spindash=0
spin=0
push=0
super=0
boost=0
firedash=0
insta=0


#define itemget
if (type="jumprefresh") {insted=0
mc=0
}
if (type="mushroom") {
if (!piped && !hurt && !(global.mplay>1 && flash)) {
coll=other.id
if (p2!=other.p2) {
itemc+=1
doscore_p(1000,1)
}
playgrowsfx("")
if (skidding) {soundstop(name+"skid") skidding=0}

if (size=0) grow=1
oldsize=size
size=max(size,1)

itemget=1
}   
}
if (type="fflower") {
if (!piped && !hurt && !(global.mplay>1 && flash)) {
coll=other.id
if (p2!=other.p2) {
itemc+=1
doscore_p(1000,1)
}
playgrowsfx("2")
if (skidding) {soundstop(name+"skid") skidding=0}
if (!super && size!=2) grow=1
oldsize=size
size=2
itemget=1
combotimer+=30
}                
}
if (type="bfeather") {
if (!piped && !hurt && !(global.mplay>1 && flash)) {
coll=other.id
if (p2!=other.p2) {
itemc+=1
doscore_p(1000,1)
}
playgrowsfx("3")
if (skidding) {soundstop(name+"skid") skidding=0}
if (!super && size!=3) grow=1
oldsize=size
size=3
itemget=1
}                
}
if (type="star") {
if (!piped && !hurt && !(global.mplay>1 && flash)) {
coll=other.id
doscore_p(1000)
sound("itemstar")
itemc+=1
if (!super) {
star=1
alarm[2]+=other.fuel+2
alarm[3]=-1
kek=0 with (player) if (super) other.kek=1
if (!kek) {
mus_play("starman",1)
global.music="star"
}                      
}
if (skindat("growsfx3"+string(p2))) playsfx("growsfx3") 
else playgrowsfx("3")
itemget=1
}            
} 
if (type="1up") {
    sound("item1up")
    itemc+=1
global.lifes+=1
deaths=max(0,deaths-1)
if (super) superpower=6000
else energy=maxe
itemget=1
combotimer+=20
}
if (type="shield") {
    if (!piped && !hurt && !(global.mplay>1 && flash)) {
        coll=other.id
        if (p2!=other.p2) {
            itemc+=1
            doscore_p(1000,1)
        }
        sound("itemshield")
        shielded=1
        itemget=1
    }   
}
if (type="poison") {
    if ((!piped && !hurt && !(global.mplay>1 && flash))) {
        coll=other.id
         if !invincible() hurtplayer("enemy")
 if (insta && insta<14 &&!star) hurtplayer("enemy")
        itemget=1
    }   
}
if (type="coin") {
sound("itemcoin")
if (other.fresh) global.scor[p2]+=100
global.coins[p2]+=1
coint+=1
if (name="robo") energy+=1
hit=1
itemget=1
combotimer+=20
}
if (type="ring") {
sound("itemcoin")
if (other.fresh) global.scor[p2]+=100
global.rings[p2]+=1
coint+=1
if (name="robo") energy+=1
hit=1
itemget=1
combotimer+=20
}
if (type="topping") {

if (other.fresh) global.scor[p2]+=10
if (name="robo") energy+=1
hit=1
itemget=1
combotimer+=20
}
if (type="bigtopping") {
if (other.fresh) global.scor[p2]+=100
if (name="robo") energy+=1
hit=1
itemget=1
tv_collect=30
combo+=1
}

if (type="treasure") {
	combo+=1
	tv_collect=30
	doscore_p(1000)
}

#define effectsbehind
if (abs(hsp)>(maxspd-0.1) && runspd>=1.46 && !piped) {
    draw_sprite_part_ext(sheets[size],0,227+40*floor((efxframe)),46,39,39,round(x-19.5*xsc),round(y-22)+4,xsc,1,$ffffff,alpha)
}
efxframe+=0.5
if efxframe>=2 efxframe=0

#define effectsfront
if (insta && insta<14) {
    draw_sprite_part_ext(sheets[size],0,64+(floor((insta-1)/2) mod 4)*40,46,39,39,round(x-19.5*xsc),round(y-19.5+dy+4*!size)+4,xsc,1,$ffffff,alpha)
}


//draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-32,soundframe)

#define grabflagpole
grabflagpole=1
hsp=0
vsp=0


#define endofstage
right=1
grabflagpole=0
if (hsp>=3 || push) {
	akey=1
	bkey=(jump && vsp>-3)
}


#define damager
if (owner.instashieldin){
if alarm0=0 {alarm0=14}
alarm0-=1
if alarm0=0 {owner.instashieldin=0}
x=owner.x+owner.hsp y=owner.y+4+4*!owner.size sprite_index=spr_round32 mask_index=spr_round32 image_yscale=1 image_xscale=1
hittype="instashield"

	coll=instance_place(x,y,collider)
	if (coll) {
		if (object_is_ancestor(coll.object_index,hittable)) {
			if (coll.object_index=brick || coll.object_index=bigbrick || coll.object_index=pizzablock || coll.object_index=bigpizzablock) brickc+=1 else brickc=4
			hitblock(coll,owner,0,esign(coll.y-owner.y),0)
		}    
	}
	coll=instance_place(x,y,itembox)
	if (coll) {
		if (object_is_ancestor(coll.object_index,hittable)) {
			if (coll.object_index=brick || coll.object_index=bigbrick || coll.object_index=pizzablock || coll.object_index=bigpizzablock) brickc+=1 else brickc=4
			hitblock(coll,owner,0,esign(coll.y-owner.y),0)
		}    
	}


	coll=instance_place(x,y,enemy)
	if (coll) {                    
		global.coll=owner.id
		if coll.object_index=lavabubble || coll.object_index=boo {
		coll.vsp=2
		} else 
		enemyexplode(coll,2)
		owner.vsp=-owner.vsp
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
} else {y=-1000}

#define projectile
if (event="create") {
image_xscale=7
image_yscale=7
getregion(x) 
visible=1
}
if (event="step") {
if (!inview()) instance_destroy()
if hspeed!=0
xsc=sign(hspeed)
}
if (event="draw") {
draw_sprite_part_ext(owner.sheets[1],0,8+15*floor(fr),113,14,14,round(x-7*xsc),round(y-7),xsc,1,$ffffff,1)
}


#define sprmanager
frspd=1
cantslowanim=0
if (grabflagpole) {sprite="flagslide"}
else if (hurt) {sprite="knock"}
else if (taunt) {if tauntspr=1 sprite="taunt1"  
if tauntspr=2 sprite="taunt2" 
if tauntspr=3 sprite="taunt3" 
if tauntspr=4 sprite="taunt4"
if tauntspr=5 sprite="taunt5"
if tauntspr=6 sprite="taunt6"}
//why doesnt sprite="taunt"+tauntspr work
else if parry {sprite="punchhit"}
else if (sjump=1) sprite="superjumpcharge"
else if (sjump=2) sprite="superjump"
else if (newbonk=1) sprite="splat"
else if (newbonk=2) sprite="splatknock"
else if (newbonk=3) sprite="bonkwallr"
else if (crouch) {if (h!=0 && !jump) {sprite="crawl"} else sprite="crouch"}
else if (dash) {sprite="dash"}
else if (wall) {sprite="wallrun" fallspr="spring"}
else if (brakingmach) {
if (brakingmach=1) {sprite="brake"}
else if (brakingmach=2) {sprite="machturn"}
}
else if (dive) {sprite="dive"}
else if (jump) {
if (onvine) {sprite="climbing" frspd=sign(left+right+up+down)}
    else if (sprung) {sprite="spring" fallspr="spring" if (vsp>=0) {sprung=0 fall=1}}
    else if (fall=10) {if ((vsp>2 && dashanim>30) || sprite="spring") sprite="spring" else sprite="dash" dashanim+=1}
    else if (bonk) sprite="bonk"
    else {if (fall) sprite=fallspr if sprite="walk"||sprite="run" sprite="spring" if !fall sprite="jump" frspd=1} //frspd=fallspd
} else {
    if (spin) {sprite="ball" frspd=0.5+abs(hsp/3)}
    //else if (fired) {sprite="fire" cantslowanim=1}
    //else if (push!=0) {sprite="push" frspd=1+abs(hsp/3)}
    else if (hsp=0) {
        if (hang) {sprite="hang"}
        else if (pose) sprite="pose"
else if (peelout){
if (peelout<25) {sprite="walk" frspd=abs(peelout/15)}
else if (peelout<45) {sprite="run" frspd=abs(peelout/20)}
else {sprite="maxrun" frspd=abs(peelout/20)}
}
        else if (lookup) {sprite="lookup"}
        //else if (waittime>maxwait) {sprite="wait"}
        else {sprite="stand"}
    } else {
        if (braking) sprite="brake"
	else if (abs(hsp)>(maxspd-0.1) && !finish && runspd>=2) {sprite="megaspeed" frspd=runspd/2}
	else if (abs(hsp)>(maxspd-0.1) && !finish && runspd>=1.5) {sprite="maxrun" frspd=runspd/2}
        else if (abs(hsp)>2.5 && !finish) {sprite="run" frspd=abs(hsp/3)}
        else {sprite="walk" frspd=0.2+abs(hsp/4)}
    }
}


#define controls
com_inputstack()

tempbrick=0

//situations in which it should skip controls entirely
if (hurt || piped || parry || taunt || sjumpcancel || brakingmach || machdump) {
    di=0
    dive=0
    wall=0
    exit
}

if (up) com_piping()
oup=up

if (up && (!hang || !size)) {
    if (hsp=0 && !jump && !peelout) lookup=1
    else lookup=0
} else lookup=0

//list of things that prevent you from moving
if (spindash || /*(crouch && !jump) ||*/ (super && fall=10) || vinegrab || grabflagpole || peelout || brake || brakingmach=1 || newbonk) h=0

if (ckey && h=0) h=xsc

//movement
if (h!=0) {
    loose=0
    coll=noone
    if (h=sign(hsp) || hsp=0) coll=collision(h,0)
    if (coll) if (object_is_ancestor(coll.object_index,moving)) coll=place_meeting(x+h,y+coll.vsp+sign(coll.vsp),coll)
    if (coll) if (player_climbstep(coll)) coll=noone
    if (x<=minx && left) coll=1
    if (coll) {
        
if (knuxcanclimb(collision(8 * /*h*/ xsc,0))) && !water && !bonk && !dive && canwall {  //Don't start climbing walls while diving??? and make sure you can wall??? also why is this dependant on which direction you're Pressing???
            if (jump && !sjump && ckey /*<- why was this not here before*/) {walljumped=0 wall=4 if runspd<1 runspd=1}
if (place_meeting(x+8*h,y-8,nslopl) || place_meeting(x+8*h,y-8,nslopr)) && !place_meeting(x,y-8,ground) && (ckey)&& !sjump {wall=4 hsp=maxspd*h y-=16 jump=1} //have to offset by 16 because he'll get stuck otherwise, used for climbing into slopes
else if (place_meeting(x,y+4,nslopl) || place_meeting(x,y+4,nslopr)) && (ckey) && !sjump{wall=4  jump=1} //set to airborne so he doesnt get stuck, used for climbing off slopes
            //xsc=h  //Why would you be able to turn around on the wall
        }
//hitwall removes your speed, that's probably why you lost speed when trying to wallrun
com_hitwall(h)
        if (!jump && !spin && !crouch && !firedash && !brakingmach) {
            xsc=h
            braking=0
com_piping()
        } else{com_piping()}
    } else {
		if wall {  //<- don't forget this lol
			if !(knuxcanclimb(collision(8 * /*h*/ xsc,0))) && !water {
				x+=2*xsc jump=0 wall=0 dive=0 hsp=maxspd*xsc
			}
		}
        else /*<- that's the right spot*/ if (spin) {
            if (sign(hsp)!=h) hsp+=h*0.05
        } else { //Preeetty sure that is not the variable you are looking for and also thats the wrong spot
            if (!jump) {
                if (sign(hsp)!=h) {
                	if (ckey && runspd<0.2) { //instaturn while mach running under
                		hsp = 0.33 * h
                		xsc = h
                	} else {
	                    if (abs(hsp)>maxspd*0.8) {
				            braking=1
							skidding=1
							playsfx(name+"skid")
	                        brakedir=h
							soundstop(name+"sndmach3")
							soundstop(name+"sndmach4")
							soundstop(name+"sndmach2")
							soundstop(name+"sndmach1")
	                    }
	                    hsp+=0.33*h
	                    if (abs(hsp)<0.5) if (!firedash) xsc=h
	                }
                } else {
                    hsp+=0.06*h
                    braking=0
                    if (!firedash) xsc=h
                }
            } else if sjump!=2{
                if !(fall=10 && boost) hsp+=0.08*h else {hsp+=0.01*h  }
                if (!firedash && runspd<3 && !dive) xsc=h
else collwin=instance_place(x+hsp,0,goalblock)
if collwin {hsp=0 fallsprite="dash" collwin.owner=id with collwin{ 
event_user(4)
}
}
            }
        }
    }
}

if !wall && !dive && !newbonk && !sjump com_di() //if you don't add this if then pepsonic floats away from walls
else di=0

//code for specifically the a button
if ((abut || jumpbufferdo) && (!springin) && !sjump) {
    if (!jump||fall=69||grabflagpole) { //jump
        if !peelready {
            jumpsnd=playsfx(name+"jump")
            vsp=(-5.2-0.2*super)+(crouch+min(1,abs(hsp)/8))
            onvine=0
            if (water) vsp=-sqrt(sqr(vsp)*wf+2)

            grabflagpole=0
            latchedtoflagpole=0
            //change jump angle in steep slopes
            vd=point_direction(0,0,hsp,vsp)+point_direction(0,0,1,slobal/2)
            vm=point_distance(0,0,hsp,vsp)
            hsp=lengthdir_x(vm,vd)
            vsp=lengthdir_y(vm,vd)

sprite_angle=0

jump=1
fall=0
braking=0
spin=0
canstopjump=1
dashtimer=60
if (mymoving) hsp+=avgmovingh
//crouch=0
if (spin && !star) seqcount=0
fallspd=min(1,0.5+abs(hsp)/5)
soundstop(name+"sndmach2")
soundstop(name+"sndmach1")
runsfx=0
}
} else if !peelready { //air jumps
if (wall && ckey && !bonk) {
dive=0
hang=0
canstopjump=1
xsc*=-1 
jump=1
vsp=-5
hsp=4*xsc
walljumped=1
canwall=1
wall=0 //Make sure you stop climbing wall when you wall jump off of it (????????????)
kicked=12
hsp=xsc*maxspd instance_create(x-6*xsc,y+8,kickpart) 
playsfx(name+"walljump")
soundstop(name+"sndmach2")
soundstop(name+"sndmach1")
        }else 
        if (!insted && (fall=0 || fall=10) && !crouch) {
            insted=1
            fall=0
            firedash=0
            boost=0
            insta=1 alarm[1]=20+water*10-(name="ashura")*10
            instashieldin=1
kicked=12
            if (super) {
                braking=0
                sprung=0
                d=point_direction(0,0,right-left,down-up)
                if (!right && !left && !down && !up) d=90
                hsp+=lengthdir_x(4,d)
                vsp+=lengthdir_y(4,d)-1
                vsp=median(-7,vsp,7)
                throwsparks(x,y)
                screenshake(x,2)
                playsfx(name+"release")
            } else playsfx(name+"insta")
        }
        jumpbuffer=4*!jumpbufferdo
    }
}
jumpbufferdo=0
springin=0

if walljumped
{
soundstop(name+"sndmach4")
soundstop(name+"sndmach3")
soundstop(name+"sndmach2")
soundstop(name+"sndmach1")
}

if (akey) {

    if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {

    if (canstopjump=1 && jump && vsp<-2 && !sprung) {
        vsp*=0.5
    }
    canstopjump=0
}

//code for specifically the b button
if (bbut && !sjump && !newbonk && !dive && !wall && !brakingmach && !wallkicked) {
    
        if (jump && super && fall=10) {
            fall=1 airdash=0
        } else if (!dash && !dashcooldown) {
            dash=20
dashcooldown=50
playsfx(name+"release")
            if (abs(hsp)>3.5 && dashtimer) {boosted=1 boost=1}
            t=esign(right-left,xsc)
            xsc=t
            hsp=maxspd*(right-left)
            if hsp=0 hsp=maxspd*xsc
            {
shoot(x-4*t,y+4,psmoke,-2*t,-1)
shoot(x-4*t,y+4,psmoke,-2*t,1)
            }
        }
}

if !jump && !spin && !sjump && !walljumped  { //run speed does not change in pt when one is jumping, also, running from a spin might be op
	if (ckey){
	if (!runhalt) {hsp=0.33*h runhalt=1}
	if abs(hsp)>=abs(maxspd-0.1){
	runstate=4
	if runspd<1.5
	runspd=max(0,runspd+0.03)
	else 
	runspd=max(0,runspd+(0.003 * (left - right != 0)))
	}
	if runspd>3 runspd=3

	} else if !wall {runhalt=0 runspd=max(0,runspd-0.05)}
}

if !walljumped
if runspd>=2 {soundstop(name+"sndmach3") playsfxmach(name+"sndmach4",0)}
else if runspd>=1.5 {soundstop(name+"sndmach2") playsfxmach(name+"sndmach3",0)} //boll tower i remember your lying ass mach states
else if runspd>=0.2 && !jump {playsfxmach(name+"sndmach2",0)}
else if ckey && abs(hsp)>0.5 && !jump playsfxmach(name+"sndmach1")
else {soundstop(name+"sndmach1") soundstop(name+"sndmach2") soundstop(name+"sndmach3") soundstop(name+"sndmach4")  runsfx=0}



//why is there !jump the entire point is for you to jump and then dive
//there should maybe also be a dive delay, i tried making a 'divedelay' timer variable and it doesnt work though.

//It was made under the idea that you can't dive unless you're running off of ground

if down && !wall && /*!collision(0,16)*/ jump && hsp != 0 && (ckey) {dive=1 dash=0} //boll tower likes to do this thing where it checks for ground by checking if there's ground there instead of. checking the variable that decides if you are jumping or not

if abs(hsp)<2 && !wall {
runstate-=1
if runstate<=0
runspd=0
}

if (xbut) && !taunt && !fireass
{
taunt=20
tauntspr=choose(1,2,3,4,5,6)
playsfx(name+"taunt",0,random_range(0.98,1.02))
hsp=0
vsp=0
}

//crouching and spinning
if (down && !up) {
    if (!jump && !braking && !spin) {
        if (abs(hsp)<0.5) {
            crouch=1
hsp=1.5*h
        } else if (!spin && !crouch) {
            spin=1
            playsfx(name+"spin")
        }
    }
com_piping()
} else {
    mask_temp(12,12)
    if (!jump) {
        if (collision(0,-16) && size) spin=1
        crouch=0
    }
    mask_reset()
}

//Cancel from a roll
if !(down) && spin == 1 && !collision(0,-16) {spin=0}

if (!grabflagpole && (spin || spindash || crouch) && !piped ) mask_set(12,12)
else if (jump && !grabflagpole && (!fall || fly || fall=10 )  && wall!=4 && !piped) mask_set(12,15)
else {mask_set(12,24) mask_h=24}


#define movement
if (piped || sjumpcancel) exit

size=1

dash=max(0,dash-1)
dashcooldown=max(0,dashcooldown-1)
//wall=max(0,wall-1) //this isn't even accurate to pizza tower what the hell is wrong with you
kicked=max(0,kicked-0.01)
if !kicked walljumped=0
if !ckey && wall {wall=0 canwall=0 } //remember this canwall

if dash{
hsp=maxspd*xsc
if runspd<1 runspd=1
runhalt=1
boost=1
if right-left!=0 if xsc!=right-left{
{hsp=0 dash=0 dashcooldown=0}

}
} else if runspd<1 {boost=0} else boost=1

coll = instance_place(x+16*sign(hsp),y,hittable)
if (coll) && (dash) || (coll) && runstate=4{
        hitblock(coll,id,0,1,0)
}

if runstate && !jump
{

if !ckey && runstate && runspd >= 0.2 && !spin && !jump && !walljumped && !brakingmach {
	brakingmach=1
	runstate=0
	playsfx(name+"skid")
	soundstop(name+"sndmach3")
	soundstop(name+"sndmach4")
	soundstop(name+"sndmach2")
	soundstop(name+"sndmach1")
}
if (xsc != h && h != 0  && !spin && !jump && !walljumped  && !brakingmach)
{

brakingmach=2
runstate=0
machsp=abs(hsp)
playsfx(name+"machskid")
soundstop(name+"sndmach3")
soundstop(name+"sndmach4")
soundstop(name+"sndmach2")
soundstop(name+"sndmach1")
}

}

if brakingmach=1
{
braking=0
if abs(hsp)<=0.1 && !jump {
	brakingmach=0
	runspd=0
}
}

if brakingmach=2
{
if !FMODInstanceIsPlaying(skindat("sfx_"+name+"machskid"+string(p2)+"inst")) playsfx(name+"machskid")
if machsp!=0
machsp-=0.2
braking=0
if machsp=0 && !jump || machsp<0 && !jump
{
brakingmach=0
xsc*=-1
runspd=1.5
hsp=abs(maxspd-0.1)*xsc
runstate=4
}
}

if taunt
{
hsp=0
vsp=0
}

if taunt=0
{
hsp=storedhsp
vsp=storedvsp
}

if combo{

if combo!=savedcombo{
combotimer=120
}
savedcombo=combo
combotimer=max(0,combotimer-0.25) //can you make a limit for this too pls...

if combotimer=0 {global.scor[p2]+=totalscore combo=0}
if combotimer>120 combotimer = 120
} 
if combo=0{ //an else would fit, but this is best for bug prevention (combo runs out at the same frame as you kill enemy) to prevent combo counter reset but no reward being given
combotimer=120
totalscore=0
}
tv_collect=max(0,tv_collect-0.25)
//Handling TV animations
savedtvani=string(tvani)

if hurt tvani="hurt"
else if tv_collect tvani="collect"
else if runspd>=2 tvani="mach4"
else if runspd>=1.5 tvani="mach3"
else if combo>=10 tvani="combo"
else tvani="idle"

if savedtvani!=tvani tvchange=0

if tvchange>-1 if tvchange!=5 tvchange+=0.5 else { hudfr=0 tvchange=-1 }
if tvchange>=5
{
hudfr=0
tvchange=-1
}

//speed limits
if (!jump) if (loose || spin || crouch || brakingmach || parry) {
    braking=0
    frick=0.1
    if sjump=1 frick=maxsp
    if brakingmach frick=0.2
    if parry frick=0.05
    if (spin) frick=0.005
    hsp=max(0,abs(hsp)-frick)*sign(hsp)
}
if parry
{
if hsp=0
parry=0
hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

//speed cap rubberband formula
maxspd=(2.2 + !!size*0.5 + spin*2 + (runspd)*1.8 + dash*0.2*!runstate)
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)

vsp=min(7+downpiped,vsp)

//movement
calcmoving()

/*if (hsp != 0)
{
if slop
}*/ 

if (!dead && !grabflagpole) {
if fall!=69
player_horstep()
player_nslopforce()
	//yground=easyground()
//if (yground!=verybignumber) yground-=14
    if (jump) {
        //gravity
        hang=0
        if fall!=69 {
if sjump=2 {vsp = -8
crack=instance_place(x,y-16+vsp,crackedground)
    if (crack ) {//CRRRACKKKKKKKKK
        with crack event_user(0)
        }
		
coll=instance_place(x,y-16+vsp,metalblock)
    if (coll ) {
        with coll {
		sound("metalbreak")
        instance_destroy();
            i=instance_create(x+4,y+12,metalblockpart) with(i){hspeed=-1 vspeed=-1+2*go}
            i=instance_create(x+12,y+12,metalblockpart) with(i){hspeed=1 vspeed=-1+2*go}
            i=instance_create(x+4,y+4,metalblockpart) with(i){hspeed=-1 vspeed=-3+2*go}
            i=instance_create(x+12,y+4,metalblockpart) with(i){hspeed=1 vspeed=-3+2*go}
		}
    }
	
coll=instance_place(x,y-16+vsp,bigbrick)
    if (coll ) {
        with coll {
		sound("itemblockbreak")
        instance_destroy();
            i=instance_create(x+4,y+12,part) with(i){hspeed=-1 vspeed=-1+2*go}
            i=instance_create(x+12,y+12,part) with(i){hspeed=1 vspeed=-1+2*go}
            i=instance_create(x+4,y+4,part) with(i){hspeed=-1 vspeed=-3+2*go}
            i=instance_create(x+12,y+4,part) with(i){hspeed=1 vspeed=-3+2*go}
		}
    }
	
coll=instance_place(x,y-16+vsp,pizzablock)
    if (coll ) {
        with coll {
		sound("itemtopping")
        instance_destroy();
		}
    }

coll=instance_place(x,y-16+vsp,bigpizzablock)
    if (coll ) {
        with coll {
		sound("itemtopping")
        instance_destroy();
		}
    }
}
if wall{ vsp=-maxspd  playsfxmach(name+"sndmach2",0)   crack=instance_place(x+16*xsc,y-8,crackedground)
    if (crack ) {//CRRRACKKKKKKKKK
        with crack event_user(0)
    }
	
	} else if dive {vsp=6 hsp=max(abs(hsp),5)*xsc} else if taunt vsp=0 else if newbonk {hsp=0 vsp=0} else vsp+=0.15*wf //newbonk 3 is the unused ceiling bonk
        }
vine_climbing()
        //crouch=0
        spindash=0
        braking=max(0,braking-1)
if (sprung && !fall) fall=1
push=0 spin=0
coyote=0
osld=0
player_vertstep()
if (coll && instance_exists(coll) && !object_is_ancestor(coll.object_index,hittable) && ((vsp>0 && wall) || (vsp>0 && sjump==2))) { //bonk off ceiling if you hit it while wallrunning or superjumping (remember canwall too)
	y=coll.bbox_bottom+1 canwall=0 newbonk=3 newbonktimer=20 sjump=0 wall=0 vsp=0 hsp=0
} 
if (!jump) sld=point_direction(0,0,1,slobal)
    }

sprite_angle=0


    if (!jump) {
//if (yground!=verybignumber) {y=yground while collision(0,0) && !collision(0,-8) {y-=1 }}
osld=sld
sld=point_direction(0,0,1,slobal)
if (!jump && abs(hsp)>=maxspd+1 && spin) {
diff=anglediff(sld,osld)
if (sign(diff)=sign(hsp) && diff*sign(hsp)>20 && sld=0) {
jump=1 fall=1 fallspr=sprite fallspd=frspd
y=min(y,yp)
hsp=lengthdir_x(hsp,osld) vsp=-abs(lengthdir_y(hsp,osld))*1.5 // coolness factor
}
}

        if (finish && ending="retainer" && !jump) coyote=0
        if (!collision(0,4) /*&& (y<yground-2)*/) {
            coyote+=1
            if (coyote=3) {
jump=1
fall=1
fallspr=sprite
if (spin || spindash) fall=5
if (firedash) fall=10
fallspd=frspd
spin=0
//crouch=0
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
if sjumpcancel{
sjumpcancel-=1
if sjumpcancel==0{
piped=0
if abs(runspd)<1.5
runspd=1.5
hsp=6*sign(xsc)
dash=30
}
}
com_warping()
com_actions()

   

weight=0.4+0.4*!!size
bartype=0

if runspd>1 && up && !jump && !brakingmach && !wall && !dive {
sjump=1
hsp=0
}
if !up && !collision(0,-8) && sjump=1
{
sjump=2
jump=1
hsp=0
break_crackedground=2 
playsfx(name+"sjumprelease")
}
if sjump=2
{
if piped sjump=0
vsp=-15/2
hsp=0 //lol?
if bbut
{
if h!=0 xsc=h
set_sprite("ball")
sjumpcancel=20
sjump=0
vsp=0
}
if (y-16+vsp)<=view_yview[p2]-360
{
	gamemanager.shake[p2]=ceil(4*(max(0,200-abs(x))/200))
	canwall=0
	newbonk=3 newbonktimer=20
	sjump=0 wall=0 vsp=0
	playsfx(name+"groundpound")
	with (instance_create(x,y,koopadead)) {
		hspeed*=random_range(-1.25,1.25)
		alarm[0]=520
		type=choose("redshell","shell","yelshell","blushell") if (type="yelshell" || type="blushell") enemy2=1
		biome=other.biome
		vspeed=random_range(-0.35,-0.7)
	}
}
}

if sjump=1
{
hsp=0.5*h
playsfxmach(name+"sjumpcharge")
if piped sjump=0
}

if dash
{
coll=collision(hsp,y) 
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
hitblock(coll,id,0)
}    
}
}

// VULNERABILITY AND PLAYER COLLISION

//Intangibility
is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1 || taunt || parry) is_intangible=1

//Power levels
power_lv=0
is_coinexplosive=0
if (spindash || spin || (jump && (!fall || fall=5))) power_lv=1
if (firedash) power_lv=4
if (star || insta) power_lv=5
if (super) power_lv+=1
if (firedash) is_coinexplosive=1

//Special interactions
pvp_spin=spin //rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=0 //make sure to set for 0 for the mario bros when pounding
pvp_ignore=instashieldin //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away

break_crackedground=runspd>1*(!!superjump)||!!dash

//whoputshitinyourpip
if (piped || sjumpcancel) exit

//waiting animation
if maxwait{
if (sprite="stand")
{waittime+=1}
else if sprite!="wait" waittime=0
}

//grounded state
if (!jump) {
    vsp=0
    if (!star && !spin && !spindash) seqcount=0
    //ledge hang animation detection
    /*if ((sprite="stand" && hsp=0) || hang) {
        image_xscale=1/6
        hang=(!instance_place(x,y+8,collider) && instance_place(x-7*xsc,y+4,collider))
        image_xscale=1
    } else */hang=0

    //skidding
    if (push=0 && hsp!=0 && braking) {
        skidding=1
    } else if (skidding) {soundstop(name+"skid") skidding=0}
}

//water
if (underwater()) {
    if (!water) {
        if (abs(vsp)>2) water_splash(1)
        vsp=min(1,vsp/2)
    }
    water=1 wf=0.45
} else {
    if (water) {
        water=0
        vsp=max(-4,vsp*2)
        if (abs(vsp)>2) water_splash(0)
    }
    wf=1
}

//smoke generation
if (global.dustframe) {
    if (braking || fall=3) {
        i=shoot(x,y+10,psmoke) i.depth=depth+2
    }
    if (vsp<-5-2*!sprung) {
        shoot(x,y+8,psmoke,0,-1)
    }
    if (vsp>7) {
        speedwagon+=1
        if (speedwagon>60) shoot(x,y,psmoke,0,1)
    } else speedwagon=0
    if (abs(hsp)>4 && boostvar>=0.75 && !jump) shoot(x-12*xsc,y+12,psmoke,0,0)
}


if (insta) insta+=1
if (dashtimer) dashtimer-=1
if !(jump && fall=10)
boostvar=inch(boostvar,0.75*boost*!jump*!spin,0.014+(0.002*jump))
if (boost) {
    if (hurt && !super) boost=0
    if (point_distance(0,0,hsp,vsp)<3.5 || (boostvar<=0 && !boosted)) boost=0
} else boostvar=0
if (super) boost=1
if (firedash) {firedash-=1 boost=1}

//spindash/spin
global.coll=id
if (spindash || spin) {
    coll=instance_position(x-10*sign(hsp),y+22,hittable)
    coll2=instance_position(x,y+22,hittable)
    
    if (spindash) coll=coll2
    else if (coll2) if (coll2.object_index!=brick || coll2.object_index!=bigbrick || coll2.object_index!=pizzablock || coll2.object_index!=bigpizzablock) coll=coll2
    if (coll) if (coll.hit) coll=0
    if (coll=spinblacklist) coll=0
    if (!coll)
        with (hittable)
            if (id!=other.spinblacklist && (object_index!=brick || object_index!=bigbrick || object_index!=pizzablock || object_index!=bigpizzablock || other.spindash) && !hit)
                if (instance_place(x,y-4,other.id)) other.coll=id
    
    if (coll) if (!coll.goinup || tempbrick) {
        i=coll.object_index
        hitblock(coll,id,0,1,0)
        if (i=brick || i=bigbrick || i=pizzablock || i=bigpizzablock) {spinblacklist=coll if (spindash) {jump=1 spindash=0 crouch=0 vsp=-2*wf}}
    }
    
    if (spindash) {
        spindash=max(1,spindash-0.025)
        if (!crouch) {
            //if (spindash>3) boost=1
            spin=1
            hsp=xsc*6*(0.75+0.25*median(0,spindash,2)/2)
            spindash=0
            
                soundstop(name+"spindash")
                playsfx(name+"release")
            
        }
        if (hsp!=0) spindash=0
    }
    
    //stop spinning
    if (abs(hsp)<0.2 && spin) { 
            spinc+=1 if (spinc=8) {
            mask_temp(12,24)
            if (collision(0,0) && size) {
                xsc=esign(h,xsc)
                hsp=xsc
                spinc=0
                spin=1
            } else {
                spinc=0
                spin=0    
                hsp=0
                soundstop(name+"spin")
                if (name!="mario") crouch=down
            }
            mask_reset()
        }   
    }
} else spinblacklist=noone
//Christianity moment
jesus=(boost && vsp<4 && !water) || (runspd>1 && vsp<7 && !water)

if taunt>-1
taunt-=1

if taunt=-1 && !brakingmach
{
storedhsp=hsp
storedvsp=vsp
}

newbonktimer=max(0,newbonktimer-1)
if (!newbonktimer && newbonk!=2) newbonk=0

//how do i do this
/*
*/

com_endactions()


#define enemycoll
//Code that defines collision with enemies

if (coll) {
    calcfall=fall
    if (fall=5 || fall=12) calcfall=0
    global.coll=id
    type=coll.object_index
        
    seqcount=max(1,seqcount)
    
    if (super) {
        if (water) seqcount=1
        enemyexplode(coll)
        combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5)))
        exit
    }

if taunt
{
soundstop("pepsonictaunt")
playsfx(name+"parry")
taunt=-1
hsp=-3*xsc
parry=1
if !coll.damage_player_on_contact
{
enemydie(coll)
}
combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5)))
exit
}
    if dash { if jump vsp=-4 dash=20}
    if (coll.object_index=lakitu) if (coll.flee) exit
    //Kill enemies in machrun
    if ((star||runspd>1) 
    || ((spin||dash) && type!=spinyegg && type!=beetle && (type!=koopa ||dash) && (!object_is_ancestor(type,koopa) ||dash) && (type!=shell ||dash))
    || (pound>13 && type!=piranha && type!=spinyegg && type!=spiny) && !coll.damage_player_on_contact) {
        instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
        if (type=hammerbro) seqcount=max(5,seqcount)
combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5)))
        enemydie(coll)  
        x-=hsp*2
        y-=vsp*2             
        exit
    }
    
    if (spindash || inst || firedash) {if (diggity=32) exit  combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) enemyexplode(coll) exit}
    
    if (type=piranha || coll.damage_player_on_contact) {
        hurtplayer("enemy")
        exit
    }
    
    
     
if (spin) {
        if (type=shell) {if (coll.type!="beetle") {combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) enemydie(coll) exit}}
else if (type=koopa|| object_is_ancestor(type,koopa)) {combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) with enemyflip(coll) {y-=3 vspeed=-3 intangible_timer=30} exit }
        else if (type=beetle ) {hsp=0 jump=1 jumpspd=0.5 spin=0 enemystomp(coll) combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) exit}
        else if (type=spinyegg) {hurtplayer("enemy") exit}
        else {enemydie(coll) combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) exit}
    }

 
    if (type=spiny) {
        if (!fall && vsp<0||dash) {combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) enemyexplode(coll)}
        else hurtplayer("enemy") exit
    }
    if (type=spinyegg) {
        if (punch && punch<=10) enemydie(coll) else hurtplayer("enemy") exit
    }               
            
    if (type=shell && !coll.time) {          
        if (coll.type="spiny" && (coll.vspeed-vsp)*coll.ysc<0) {
            hurtplayer("enemy") exit
        } else if (!coll.kicked || (coll.stop && (coll.owner=id || coll.vspeed>=0))) {
                if (coll.stop && !coll.kicked) doscore_p(8000)
                else {seqcount=max(seqcount,2+scorelok1) doscore_p()}
                if (jump) {
                    if (vsp>0) {
                        vsp=-3-akey*1.5
                        canstopjump=akey
                        if (fall=12) fall=5
                    }
                }
                kicksound(0)
                instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
                with (coll) {spd=max(3,abs(other.hsp)+1) hspeed=spd*esign(x-other.x,other.xsc) owner=other.id kicked=1 stop=0 phase=owner}
            
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
                with (coll) {hspeed=0 owner=noone phase=other.id stop=0 kicked=0 time=15}
                vsp=-3-akey*1.5 canstopjump=akey sound("enemystomp") doscore_p() if (fall=12) fall=5 exit
            }
        }                    
    }
    
    if (type=blooper) {
        if (jump && (!calcfall || !water) && vsp>0) {if (calcfall) enemystomp(coll,5) else {enemyexplode(coll) combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5)))}}
        else hurtplayer("enemy") exit
    }
    
    if (type=cheepred || type=cheepwhite) {
        if (jump && !calcfall) {enemyexplode(coll) combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) exit}
        else {hurtplayer("enemy") exit}
    }
    
    if (jump) {
        if (type=koopa || type=beetle || type=rexbig || object_is_ancestor(type,koopa)) {
            if (vsp<0) {
                if (calcfall) hurtplayer("enemy")
                else {enemyexplode(coll) combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5)))} exit
            }
        } else {
            if (!calcfall) {enemyexplode(coll) combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) exit}
            if (vsp<0) {hurtplayer("enemy") exit}
        }
        
        if (type=goomba && seqcount=1 && !scorelok4) {seqcount=0 scorelok4=1}    
        if ((type=koopa || type=redkoopa) && seqcount=1) scorelok1=1    
        if (type=hopkoopa || type=redhover) seqcount=max(seqcount,1)
        if (type=hammerbro) seqcount=max(5,seqcount)
        if (fall=12) fall=5                        
        enemystomp(coll) exit      
    } else if (coll.vspeed<0 && coll.y>y+8) {jump=1 fall=1 vsp=-0.5 enemystomp(coll) combo+=1 global.scor[p2]-=200 totalscore+=(10 + floor((combo * 0.5))) exit}
    
    hurtplayer("enemy")   
}    

#define hurt
pipe=0
sprongin=0
speed=0
if (skidding) {soundstop(name+"skid") skidding=0}
soundstop(name+"sndmach4") soundstop(name+"sndmach3") soundstop(name+"sndmach2") soundstop(name+"sndmach1")
if (carry && carryid) {with (carryid) event_user(0) carryid=noone carry=0}


newbonk=0
newbonktimer=0
energy=0
braking=0
sprung=0
diggity=0
grow=0
fairdash=0
gianadash=0
gk=0
fk=0
punch=0
bounce=0
twirl=0
oldsize=size
jumpbuffer=0
hyperspeed=0
star=0
onvine=0
if (super) stopsuper()   

if (boss && hp=1) {
   if (global.mplay>1 || global.debug || global.lemontest) alarm[7]=120
   if (global.gamemode="battle") dropcoins(0)
   die()
} else {
    fly=0
    jet=0
    climb=0 
    rise=0
    slide=0
    glide=0
    sprung=0
    fall=0
    pound=0  
    braking=0
    boost=0
    upper=0
    hyperspeed=0
    if (shielded) playsfx(name+"shielddamage")
    else playsfx(name+"damage")
if global.scor[p2]<50
global.scor[p2]=0
else
global.scor[p2]-=50
    starhit=0
repeat 5 with fire_projectile(x,y) {fr=choose(0,1,2,3) gravity=0.2 xsc=other.xsc vspeed=random_range(-1,-5) hspeed=random_range(-5,5)} 
jump=1 hurt=1+starhit if (!starhit) if (shielded) {shielded=0} else {if boss hp-=1} hsp=xsc*-2*wf vsp=-3*wf
    
}


//Block hitting

#define hitblocks
if typeblockhit=0{
with (blockcoll){
if (stonebump || owner.size=0 && insted!=1 && !owner.tempkill && cracked=0) {
    if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
} else { 
    if (!insted) {owner.vsp=1.5}
    owner.blockc+=1
upwardthrust()
    global.scor[owner.p2]+=10
    sound("itemblockbreak")
    hit=1
    if (skindat("bricd")) {
        i=instance_create(x,y,bricd)
        i.biome=biome
        i.depth=depth
    }
    if (stoned="1") with (instance_create(x,y+8,stone)) phase=1
    i=instance_create(x+4,y+12,part) i.hspeed=-1 i.vspeed=-1+2*go
    i=instance_create(x+12,y+12,part) i.hspeed=1 i.vspeed=-1+2*go 
    i=instance_create(x+4,y+4,part) i.hspeed=-1 i.vspeed=-3+2*go
    i=instance_create(x+12,y+4,part) i.hspeed=1 i.vspeed=-3+2*go
    
    with (turing) event_user(4)
    instance_destroy()
  }
 }
} else if typeblockhit=1{
with (blockcoll){

if (!insted) {
owner.vsp=1.5             
}
if (!wait || owner.tempbrick) {
    if (object_index!=turing) sound("itemblockbump")
    wait=13
    if (!hit) {
		if (content="coins"){ picked=owner.is_coinexplosive || other.is_coinexplosive}
        x=xstart
        if (object_index=invisibox) {
            with (player) if (instance_place(x,y,other.id)) y+=other.bbox_bottom-bbox_top
        }
        untouched=0
        if (respawning) alarm[2]=400
        upwardthrust()
        if (object_index=goalblock) {
			hsp=0
            event_user(4)
        } else if (object_index=turing) {
            if (mode=0) turingblock()
        } else if (content!="bros") {
            if (object_index=talkbox) {
                if (string_pos("sfx",text)) {
                    sound(string_delete(text,1,4))
                } else {
                    if (!open) {
                        with (talkbox) open=0
                        open=1
                        cur=0
                        sound("itemmessage")
                    } else {
                        if (trans) cur+=1
                        if (cur+1>=pages) open=0
                        else {sf=0 trans=1}
                    }
                }
            } else if (content="coins") {
                if (picked) {
                    with (instance_position(x+8,y+8+16*go,brick)) {insted=1 owner=other.owner event_user(0)}
                    if (go=1) if (instance_position(x+8,y+24,collider)) {
                        go=-1
                        with (instance_position(x+8,y-8,brick)) {insted=1 owner=other.owner event_user(0)}
                    }
                    i=cc
                    if (done || picked=2) i=1
                    cc-=i
                    picked=0
                    repeat (i) with (instance_create(x+8,y+8+16*go,itemdrop)) {
                        hspeed=myrand(2)-1
                        vspeed=(2+myrand(2))*other.go
                        drop=0
                        type="coinup"
                    } 
                } else {
                    global.scor[owner.p2]+=100           
                    with (instance_create(x+8,y+8+16*go,coinup)) {vspeed=-1.5+2*other.go p2=other.owner.p2}
                    global.coins[owner.p2]+=1
                    owner.coint+=1
                    cc-=1  
                }
                if (done || cc=0) {
                    owner.blockc+=1
                    //if object_index=bigitembox sprite="bigbox" else sprite="box"
                    hit=1       
                }
                if (alarm[1]=-1) alarm[1]=256
                tpos=0
            } else {
                owner.blockc+=1
                hit=1
                //if object_index=bigitembox sprite="bigbox" else sprite="box"
                sound("itemappear")
                mush=!owner.size
                alarm[0]=18
            } 
        }
        tpos=1
        spendblock()
    }
}

if (object_index=bigitembox) {
    if (!hit) {
		if (content="coins")
		{
		picked=owner.is_coinexplosive || other.is_coinexplosive
		}
				
                if (picked) {
                    with (instance_position(x+8,y+8+16*go,brick)) {insted=1 owner=other.owner event_user(0)}
                    if (go=1) if (instance_position(x+8,y+24,collider)) {
                        go=-1
                        with (instance_position(x+8,y-8,brick)) {insted=1 owner=other.owner event_user(0)}
                    }
                    i=cc
                    if (done || picked=2) i=1
                    cc-=i
                    picked=0
                    repeat (i) with (instance_create(x+8,y+8+16*go,itemdrop)) {
                        hspeed=myrand(2)-1
                        vspeed=(2+myrand(2))*other.go
                        drop=0
                        type="coinup"
                    } 
                } else {
                    global.scor[owner.p2]+=100           
                    with (instance_create(x+8,y+8+16*go,coinup)) {vspeed=-1.5+2*other.go p2=other.owner.p2}
                    global.coins[owner.p2]+=1
                    owner.coint+=1
                    cc-=1  
                }
                if (content2="coins") {
                if (picked) {
                    with (instance_position(x+8,y+8+16*go,brick)) {insted=1 owner=other.owner event_user(0)}
                    if (go=1) if (instance_position(x+8,y+24,collider)) {
                        go=-1
                        with (instance_position(x+8,y-8,brick)) {insted=1 owner=other.owner event_user(0)}
                    }
                    i=cc
                    if (done || picked=2) i=1
                    cc-=i
                    picked=0
                    repeat (i) with (instance_create(x+8+16,y+8+16*go,itemdrop)) {
                        hspeed=myrand(2)-1
                        vspeed=(2+myrand(2))*other.go
                        drop=0
                        type="coinup"
                    } 
                } else {
                    global.scor[owner.p2]+=100           
                    with (instance_create(x+8+16,y+8+16*go,coinup)) {vspeed=-1.5+2*other.go p2=other.owner.p2}
                    global.coins[owner.p2]+=1
                    owner.coint+=1
                    cc-=1  
                }
                if (content3="coins") {
                if (picked) {
                    with (instance_position(x+8,y+8+16*go,brick)) {insted=1 owner=other.owner event_user(0)}
                    if (go=1) if (instance_position(x+8,y+24,collider)) {
                        go=-1
                        with (instance_position(x+8,y-8,brick)) {insted=1 owner=other.owner event_user(0)}
                    }
                    i=cc
                    if (done || picked=2) i=1
                    cc-=i
                    picked=0
                    repeat (i) with (instance_create(x+8+16+16,y+8+16*go,itemdrop)) {
                        hspeed=myrand(2)-1
                        vspeed=(2+myrand(2))*other.go
                        drop=0
                        type="coinup"
                    } 
                } else {
                    global.scor[owner.p2]+=100           
                    with (instance_create(x+8,y+8+16*go,coinup)) {vspeed=-1.5+2*other.go p2=other.owner.p2}
                    global.coins[owner.p2]+=1
                    owner.coint+=1
                    cc-=1  
                }
                if (done || cc=0) {
                    owner.blockc+=1
                    if object_index=bigitembox sprite="bigbox" else sprite="box"
                    hit=1       
                }
                if (alarm[1]=-1) alarm[1]=256
                tpos=0
            } else {
                owner.blockc+=1
                hit=1
                if object_index=bigitembox sprite="bigbox" else sprite="box"
                sound("itemappear")
                mush=!owner.size
                alarm[0]=18
            } 
        }
        tpos=1
        spendblock()
    }
}

}
}

#define hitwall
//hit blocks sideways
if (firedash || (runspd > 1) || dash || (super && fall=10) || dive && !wall) {
    global.coll=id
    with (hittable) if (instance_place(x-other.hitside,y,other.id)) {
if global.coll.firedash go=sign(global.coll.vsp) else go=-1
        insted=1
        event_user(0)
insted=0
    }

if (runspd > 1) 
{
with (metalblock) if (instance_place(x-other.hitside,y,other.id)) {
if global.coll.firedash go=sign(global.coll.vsp) else go=-1
        insted=1
sound("metalbreak")
        instance_destroy();
            i=instance_create(x+4,y+12,metalblockpart) with(i){hspeed=-1 vspeed=-1+2*go}
            i=instance_create(x+12,y+12,metalblockpart) with(i){hspeed=1 vspeed=-1+2*go}
            i=instance_create(x+4,y+4,metalblockpart) with(i){hspeed=-1 vspeed=-3+2*go}
            i=instance_create(x+12,y+4,metalblockpart) with(i){hspeed=1 vspeed=-3+2*go}
insted=0
    }
}
with (bigbrick) if (instance_place(x-other.hitside,y,other.id)) {
if global.coll.firedash go=sign(global.coll.vsp) else go=-1
        insted=1
sound("itemblockbreak")
        instance_destroy();
            i=instance_create(x+4,y+12,part) with(i){hspeed=-1 vspeed=-1+2*go}
            i=instance_create(x+12,y+12,part) with(i){hspeed=1 vspeed=-1+2*go}
            i=instance_create(x+4,y+4,part) with(i){hspeed=-1 vspeed=-3+2*go}
            i=instance_create(x+12,y+4,part) with(i){hspeed=1 vspeed=-3+2*go}
insted=0
    }
	
with (pizzablock) if (instance_place(x-other.hitside,y,other.id)) {
if global.coll.firedash go=sign(global.coll.vsp) else go=-1
        insted=1
		sound("itemtopping")
		global.scor[p2]+=10
		other.combotimer+=20
        instance_destroy();

	insted=0
    }

with (bigpizzablock) if (instance_place(x-other.hitside,y,other.id)) {
if global.coll.firedash go=sign(global.coll.vsp) else go=-1
        insted=1
		sound("itemtopping")
		global.scor[p2]+=10
		other.combotimer+=20
        instance_destroy();

	insted=0
    }
	
    coll=collision(hitside,0)
    if (firedash && jump) {canpipejump=1 com_piping() fall=5 vsp=0} else canpipejump=0
}




if (coll=noone) exit

if (!collpos(sign(hitside)*10,8,1)) {        
    //gap running
    if (y<coll.y-12) {y=coll.y-14 coll=noone exit}
}
com_piping()

//if ((runspd > 1) && !wall && !braking && !brakingmach && !dash && !dive && !jump && slobal=0) {
//if ((!object_is_ancestor(coll.object_index,hittable)) || (!object_is_ancestor(coll.object_index,metalblock)) || (!object_is_ancestor(coll.object_index,bigbrick))) 
//{instance_create(x+8,y+6*s,kickpart) 
//sound("itemblockbump") 
//x-=hsp 
//hsp=-2*xsc 
//vsp=-2 
//jump=1 
//newbonk=2
//soundstop(name+"sndmach3")
//soundstop(name+"sndmach4")
//soundstop(name+"sndmach2")
//soundstop(name+"sndmach1")
//runspd=0
//}
//} else 
hsp=0

hyperspeed=0

#define landing
braking=0
insted=0
dive=0
divedelay = 60
if (downpiped) {
shoot(x-8,y+4,psmoke,-2,-1)
shoot(x+8,y+4,psmoke,2,-1)    
    downpiped=0
}
if (hurt) {flash=1 fk=0 hsp=0 hurt=0}
if (newbonk=2) {newbonk=0}

playsfx(name+"step")

//jump buffering
if (jumpbuffer) jumpbuffer=-1

//fall into spin
if (!spin && !crouch && rise=0 && !hurt && down && abs(hsp)>=0.5) {
    spin=1
    playsfx(name+"spin")
seqcount=1
}

walljumped=0
canwall=1
ceilbonk=0

//jump into tiny space
if (insted!=2 && !spin && !piped && !sjumpcancel) {
mask_temp(12,12)
coll=collision(0,0)
mask_reset()
if (!coll && collision(0,0)) {
spin=1
mask_set(12,12) 
playsfx(name+"spin")
hsp=max(abs(hsp),2)*esign(hsp,xsc)
}
}


#define death
if (event="create"){

alarmmp=60
alarm1=300
sprite="dead"
frame=0
frspd=1
spindash=0
alpha=1

if global.mplay>1 alphadecay=1

name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
xsc=owner.xsc
ysc=owner.ysc
water=owner.water
vspeed=-3.5 gravity=0.1

} 
else if (event="step"){
alarmmp=max(0,alarmmp-1)
alarm1=max(0,alarm1-1)

if alphadecay &&!alarmmp alpha-=0.1

if alarm1=0 instance_destroy()

} else if (event="draw"){

}


#define enterpipe
if (type="door") {set_sprite("levelend") /*if instance_exists(bollface_pursuit) with(bollface_pursuit){instance_destroy()}*/}
if (type="side") {
	/*if instance_exists(bollface_pursuit) with(bollface_pursuit){instance_destroy()}*/
	
	
	if (firedash) {set_sprite("dash") frspd=1 hspeed=xsc*3 fastpipe=1  }
	if (spin||crouch) {
		set_sprite("ball")
		frspd=min(1,0.1+abs(hsp/4))
		if (abs(hsp)>=(maxspd) && !underwater()) {fastpipe=1 playsfx(name+"spin")}
	}
	if (boost) {fastpipe=1}
}
if (type="up") {
/*if instance_exists(bollface_pursuit) with(bollface_pursuit){instance_destroy()}*/
set_sprite("fly")
}
if (type="down") {
/*if instance_exists(bollface_pursuit) with(bollface_pursuit){instance_destroy()}*/
}



if (skidding) {soundstop(name+"skid") skidding=0}
soundstop(name+"sndmach4") soundstop(name+"sndmach3") soundstop(name+"sndmach2") soundstop(name+"sndmach1")
newbonk=0
newbonktimer=0
braking=0
insta=0
crouch=0
push=0     
firedash=0
dash=0


#define exitpipe
mask_reset()

#define customhud
dontdrawdefaulthud=1
if global.ranks||keepwhite exit
hudfr+=0.25
if hudfr >= maxtvfr hudfr=0

//if tvchange=4 
switch tvani
{
case "idle": tvaniyf=0 maxtvfr=idlemaxfr break;
case "collect": tvaniyf=5 maxtvfr=collectmaxfr break;
case "hurt": tvaniyf=6 maxtvfr=hurtmaxfr break;
case "combo": tvaniyf=7 maxtvfr=combomaxfr break;
case "mach3": tvaniyf=8 maxtvfr=mach3maxfr break;
case "mach4": tvaniyf=9 maxtvfr=mach4maxfr break;
case "fireass": tvaniyf=10 maxtvfr=firebuttmaxfr break;
}
with other{
p=other                   
spr=other.sheets[other.size]


///BOSS HP
if other.boss{
i=0
hpframe+=0.2
hpframe = hpframe mod 8
repeat(6){

draw_sprite_part_ext(global.hudsheet[slot],0,77+21*floor(hpframe),8,20,20,8+26*(i mod 3),12+26*(i>2),1,1,c_black,1)
i+=1
}
i=0
repeat(other.hp){

draw_sprite_part_ext(global.hudsheet[slot],0,77+21*floor(hpframe),8,20,20,8+26*(i mod 3),12+26*(i>2),1,1,c_white,1)
i+=1
}
exit
}

///BOSS HP END

draw_sprite_part_ext(global.hudsheet[slot],0,8,8,68,17,8,30,1,1,$ffffff,1)
if global.levelname!="Hub" draw_sprite_part_ext(global.hudsheet[slot],0,352,8,25,25,78,17,1,1,$ffffff,1)
global.halign=1
draw_skintext(42,30,global.scor[view_current],$ffffff)
global.halign=0
draw_skintext(26,21,chr(42)+drawlivestring(),c_white)
//draw_skintext(14,49,chr(36)+chr(42)+format(global.coins[view_current],2),$ffffff)


timecolor=$ffffff
if (gamemanager.time>=600) {
   //draw_skintext(180,208,"-:--",timecolor) we're not drawing anything, so that the stage works better
} else {    
//////////////////////////////////////////////////////////////YEah, 457 full texture width, because I'm an idiot like that
draw_sprite_part_ext(global.hudsheet[slot],0,8+457-floor(gamemanager.tick mod 457),99,187,15,107,198,1,1,$ffffff,1)
offset=floor(gamemanager.tick mod 457)
if offset<192
draw_sprite_part_ext(global.hudsheet[slot],0,8,99,186-offset,15,107+offset,198,1,1,$ffffff,1)
draw_sprite_part_ext(global.hudsheet[slot],0,8,29,196,15,102,198,1,1,$ffffff,1)
if gamemanager.tick!=0
draw_sprite_part_ext(global.hudsheet[slot],0,8+48*floor(bollfaceframelol),44,47,54,292,170,1,1,$ffffff,1)
else
draw_sprite_part_ext(global.hudsheet[slot],0,200,44,42,42,289,181,1,1,$ffffff,1)
bollfaceframelol+=0.1
if bollfaceframelol>=3.5
bollfaceframelol=0
if (gamemanager.time<=skindat("hurrytime") && global.frame8) timecolor=$ff
if (skindat("mariotime")) 
t=floor(players[view_current].tick/22.5)
else 
t=floor(players[view_current].tick/60)

draw_skintext(180,202,chr(17)+string(t div 60)+":"+format(t mod 60,2),timecolor)
}

draw_sprite_part_ext(global.hudsheet[slot],0,8,869,64,56,331,5,1,1,$ffffff,1)

draw_sprite_part_ext(global.hudsheet[slot],0,8+65*floor(other.hudfr/1),128+57*other.tvaniyf,64,56,331,5,1,1,$ffffff,1)

if other.tvchange>-1
draw_sprite_part_ext(global.hudsheet[slot],0,8+65*floor(other.tvchange/1),299,64,56,331,5,1,1,$ffffff,1)

//Combo

if other.combo{
draw_sprite_part(global.hudsheet[slot],0,245,8,80,31,320,53)
draw_sprite_part(global.hudsheet[slot],0,245,40,8+other.combotimer/2,31,320,53)
draw_sprite_part(global.hudsheet[slot],0,326,8,25,31,320-8+floor(other.combotimer/2),53)
draw_skintext(355,87,string(other.combo),c_white)
}


//emblem
draw_sprite_part(other.sheets[other.size],0,78,10,16,16,9,12)
//name tag
draw_sprite_part(other.sheets[other.size],0,10,10,65,9,26,12)

with p if star with other{
d3d_set_fog(true, c_white, 0, 1)
//emblem
draw_sprite_part_ext(other.sheets[other.size],0,78,10,16,16,9,12,1,1, c_white, (-(cos((p.tick / 6)))) * 0.6)
//name tag
draw_sprite_part_ext(other.sheets[other.size],0,10,10,65,9,26,12,1,1, c_white, (-(cos((p.tick / 6)))) * 0.6)
d3d_set_fog(false, c_black, 0, 0)
if p.tick mod 8{
i=instance_create(16+random_range(0,80),8+random_range(0,20),playerstars)
i.setview=view_current
i.myp=p.p2
}
}
}

