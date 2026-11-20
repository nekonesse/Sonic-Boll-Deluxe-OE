#define spritelist
stand,wait,lookup,pose,crouch,knock,dead,walk,run,brake,spring,jump,bonk,fall,ball,airspindash,airspincharge,spindash,spincharge,push,hang,teleport,bounce,dash,flagslide,climbing,grind,piping,pipingup,sidepiping,doorenter,doorexit


#define soundlist
release,skid,spin,spindash,bounce,dash,teleport,dropdash


#define movelist
Ashura
#
[a]: Bounce (air)
[down][a]: Air Spindash (air)
[dir][b]: Swim (water)
<big>
Ashura [mush]
#
[a]: Bounce (air)
[down][a]: Air Spindash (air)
[dir][b]: Teleport / Swim (water)
<fire>
Ashura [flwr]
#
[a]: Bounce (air)
[down][a]: Air Spindash (air)
[dir][b]: Teleport / Swim (water)
<feather>
Ashura [fthr]
#
[a]: Double Jump (air)
[down][a]: Air Spindash (air)
[dir][b]: Chain Teleport / Swim (water)

#define rosterorder
2

#define unlock
if egg() unlocktext="You unlocked ##Green Sonic!" else unlocktext="You unlocked ##Ashura!" unlocktip="What happens in the minus world?" //dude im so hilarious...

#define skininit

pingpongtele=funnytruefalse(playerskindat(p2,name+" ping pong teleport"))

var looper;

//graphic offsets
loopey=0
looper=0
repeat((projcoordbysize*MAXIMUMSIZESARGH)+1) {
	if (projcoordbysize) {
		looper=string(loopey)
	} else {looper=""}
	
	waterfall_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" waterfall graphic x"+looper),10) 
	waterfall_sheety[loopey]=nozerounreal(playerskindat(p2,name+" waterfall graphic y"+looper),88) 

	instashield_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" instashield graphic x"+looper),64)
	instashield_sheety[loopey]=nozerounreal(playerskindat(p2,name+" instashield graphic y"+looper),46)

	bubbles_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" bubbles graphic x"+looper),110)
	bubbles_sheety[loopey]=nozerounreal(playerskindat(p2,name+" bubbles graphic y"+looper),88)

	spindust_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" spindash dust graphic x"+looper),178)
	spindust_sheety[loopey]=nozerounreal(playerskindat(p2,name+" spindash dust graphic y"+looper),88)
	
	loopey+=1
}

disablespindust=funnytruefalse(playerskindat(p2,name+" disable spindust"))
spindustframes=nozerounreal(playerskindat(p2,name+" spindash dust frames"),8)-1 //subtract 1 for Silly
spindustspeed=nozerounreal(playerskindat(p2,name+" spindash dust speed"),1)


#define start
mask_set(12,12)
global.animatePrincess=1

#define stop
if (skidding) {soundstop(name+"skid") skidding=0}
star=0
grow=0
hurt=0
braking=0
push=0
spindash=0
spin=0
insta=0
bounce=0
teleport=0

#define itemget

if ((!piped && !hurt && !(global.mplay>1 && flash)) || monitem) {
	if (type="mushroom") {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			playgrowsfx("")
			if (skidding) {soundstop(name+"skid") skidding=0}
			if (size=0 || size=5) {
				grow=1
				oldsize=size
				size=1
			}
			energy=6
			itemget=1 
	}
	else if (type="fflower") {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			playgrowsfx("2")
			if (skidding) {soundstop(name+"skid") skidding=0}
			if (!super && size!=2) grow=1
			energy=6
			oldsize=size
			size=2
			itemget=1             
	}
	else if (type="bfeather") {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			playgrowsfx("3")
			if (skidding) {soundstop(name+"skid") skidding=0}		
			if (!super && size!=3) grow=1
			energy=6
			oldsize=size
			size=3
			itemget=1             
	}
	else if (type="mini") {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			playgrowsfx("4")
			if (skidding) {soundstop(name+"skid") skidding=0}		
			if (!super && size!=5) grow=1
			energy=6
			oldsize=size
			size=5
			itemget=1               
	} //else if (type!="jumprefresh" && type!="1up" && type!="coin" && type!="ring") com_item()
}
if (type="jumprefresh") {
	energy=6
	mc=0
	insted=0
	itemget=1
} 
if (type="1up") {
    sound("item1up")
    itemc+=1
	global.lifes+=1
	deaths=max(0,deaths-1)
	if (super) superpower=6000
	energy=maxe
	itemget=1
	//with (instance_create(other.x,other.y-16,scoreeffect)) value=10                                                                    
} 
com_item()

#define effectsfront
if (/*teleport && teleport>7*/ insta) {
    draw_sprite_part_ext(sheets[size],0,instashield_sheetx[size*projcoordbysize]+floor((instaframe))*40,instashield_sheety[size*projcoordbysize],39,39,round(x-19.5*xsc),round(y-19.5+dy+4*!size)+4,xsc,1,$ffffff,alpha)
}

if (spindash && !disablespindust) { //spindust
	draw_sprite_part_ext(sheets[size*!global.singlesheet[p2]],0,spindust_sheetx[size*projcoordbysize]+27*(floor(spindust)),spindust_sheety[size*projcoordbysize],26,20,round(x-27*xsc),round(y-5)+dy,xsc,1,$ffffff,alpha)
}

#define grabbedflagpole
grabbedflagpole=1
hsp=0
vsp=0

#define endofstage
right=1
grabbedflagpole=0
if (hsp>=1 || push) {
	akey=1
	bkey=(jump && vsp>-1)
}


#define damager
if (owner.instashieldin){
if alarm0=0 {alarm0=8}
alarm0-=1
if alarm0=0 {owner.instashieldin=0}
x=owner.x+owner.hsp y=owner.y+4+4*!owner.size sprite_index=spr_round32 mask_index=spr_round32 image_yscale=1 image_xscale=1

coll=instance_place(x,y,collider)
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll.object_index=brick) brickc+=1 else brickc=4
hitblock(coll,owner,1,-1,0)
}    
if (brickc=4) {sound("itemblockbump") }
}

coll=instance_place(x,y,enemy)
if (coll) {                    
    if (coll.object_index!=bombenemy && coll.object_index!=drybones
    && coll.object_index!=boo && coll.object_index!=urchin) {
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
} else if owner.bounce{
image_xscale=8
image_yscale=6
sprite_index=spr_mask2x2
mask_index=spr_mask2x2
x=owner.x
y=owner.y+owner.vsp+4+4*!owner.size

coll=instance_place(x,y,collider)
with owner if !collision(0,0) other.coll=noone //only perform bounce if player is going to land on something soon
if (coll) {
if coll.object_index=spring  {  powerbounce=2 /*power bouncing bitch*/}
if coll.object_index=sprong  {  powerbounce=4 /*power bouncing bitch*/}
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll2.object_index=brick) brickc+=1 else brickc=4
if coll.object_index=monitor { powerbounce=1 /*power bouncing bitch*/}
hitblock(coll,owner,1,1,1)
}    
if (brickc=4) {sound("itemblockbump")  }
y+=vsp
}
if (coll){ //second collision + applying the bounce
savey=coll.y
coll.y=-verybignumber
coll2=instance_place(x,y,collider)
if (coll2) {
if (object_is_ancestor(coll2.object_index,hittable)) {
if (coll2.object_index=brick) brickc+=1 else brickc=4
hitblock(coll2,owner,1,1,1)

}    
}
coll.y=savey
with owner {player_nslopforce() charm_run("landing") dy=0 jump=1 y-=1}
}

coll=instance_place(x,y,enemy)
if (coll) {                    
    if (coll.object_index!=bombenemy && coll.object_index!=drybones
    && coll.object_index!=boo && coll.object_index!=urchin) {
        global.coll=owner.id
        enemydie(coll,2)
        with owner {powerbounce=1 charm_run("landing")}  //powerbouncing bitch
    }
}

coll=instance_place(x,y,player)
if (coll) {
if (coll.id!=owner) if (!invincible(coll)) {    
if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { coll.hittype=hittype
with (coll) hurtplayer(hittype)
}
instance_create(x,y,kickpart) with owner charm_run("landing") 
}
}


} else{y=-1000}

#define projectile
if (event="create") {
	image_xscale=20
	image_yscale=12
	
	frame_sub=0
	frame=0
	vspeed=1
	waterdust=0
	brickc=0
	seqcount=2
	xsc=owner.xsc
	timer0=3
	timer1=128
	
}
if (event="step") {
	timer0-=1 if (timer0=0) visible=1
	timer1-=1 if (timer1=0) {instance_destroy() with (mywater) instance_destroy()}
	calcmoving()
	

	if (sonicboom||waterdust){
		if o.size=2 && timer1>30 timer1=30
		coll=instance_place(x,y,collider)
		if (coll) {
			if (object_is_ancestor(coll.object_index,hittable)) {
				if (coll.object_index=brick) brickc+=1 else brickc=4
				hitblock(coll,owner,1,-1,0)
			} else brickc=4    
			if (brickc=4) {sound("itemblockbump") pop=1}
		}

		coll=instance_place(x,y,enemy)
		if (coll) {
			if (coll.object_index!=beetle) {
				yes=1
				if (coll.object_index=shell) if (coll.type="beetle") yes=0
				if (yes) {
					global.coll=owner.id  
					enemydie(coll,2)
				}
			}
			pop=1
		}

		coll=instance_place(x,y,bowserboss)
		if (coll) {
			if (!coll.flash) {
				coll.hp-=1
				coll.flash=64
				coll.owner=owner
				sound("enemybowserhurt")
				pop=1
			}
		}

		coll=instance_place(x,y,player)
		if (coll) {
			if (coll.id!=owner) if (!invincible(coll)) {    
				if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
					if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
					if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {pop=1 exit}
					with(coll) fragplayer(other.owner)
				}
				pop=1
			}
		}
	}
	frame_sub=!frame_sub
	if frame_sub frame+=1
	
	if waterdust{ 
		if pop {
			if !firstframe {frame=0 firstframe=1}
			if (frame>=3) instance_destroy()
		}
	}
	else{
		if owner.size=2 && !mywater{
			mywater=instance_create(x,y,waterblock)
			mywater.image_xscale=20/16}
		mywater.x=x-10 mywater.y=y-8
	}
if (frame>=3) frame=0
	if (!inview()) {instance_destroy() if mywater with (mywater) instance_destroy()}
	
	coll=instance_place(x,y,owner)
	if coll{ if owner.teleport=0 && !waterdust{owner.energy=owner.maxe}}
	
}
if (event="draw") {


if !waterdust{
	draw_sprite_part_ext(sheet,0,owner.waterfall_sheetx[owner.size*owner.projcoordbysize]+25*frame,owner.waterfall_sheety[owner.size*owner.projcoordbysize],24,16,round(x-12*xsc),round(y-8),xsc,1,$ffffff,1)
	} else if pop{
	draw_sprite_part_ext(sheet,0,owner.bubbles_sheetx[owner.size*owner.projcoordbysize]+17*(frame),owner.bubbles_sheety[owner.size*owner.projcoordbysize]+17,16,16,round(x-8*xsc),round(y-8),xsc,1,$ffffff,1)
	} else
	draw_sprite_part_ext(sheet,0,owner.bubbles_sheetx[owner.size*owner.projcoordbysize]+17*(frame),owner.bubbles_sheety[owner.size*owner.projcoordbysize],16,16,round(x-8*xsc),round(y-8),xsc,1,$ffffff,1)
}

#define sprmanager
frspd=1
cantslowanim=0

if (grabflagpole) {sprite="flagslide"}
else if (transform) {sprite="transform"}
else if (grabbedflagpole) {sprite="climb"}
else if (teleport) {sprite="teleport" cantslowanim=1 if (pingpongtele) frame=min(3.9,4-abs(teleport-8)/2) }
else if (hurt) {sprite="knock"}
else if (spindash) {if (spinchargetimer) sprite="spincharge" else sprite="spindash"}
else if (crouch && !(hsp=0 && left && right)) {sprite="crouch"}
else if (jump) {
	if (onvine) {sprite="climbing" frspd=sign(left+right+up+down)}
	else if (grabvine) {if vineinbetween {sprite="climbon2"} else{sprite="climb"} frspd=vsp}
    else if (bounce) {sprite="bounce"}
    else if (sprung&&!bounce) {sprite="spring" if (vsp>=0) {sprung=0 fall=1}}
    else if (fairdash) {if (airspinchargetimer) sprite="airspincharge" else sprite="airspindash"}
    else if (fall) {
        if (fall=1) sprite="walk"
        if (fall=2) sprite="run"
        if (fall=3) sprite="brake"
        if (fall=4) {sprite="recover"}
        if (fall=5) {sprite="ball" frspd=jumpspd}
        if (fall=6) {sprite="knock"}
        if (fall=7) {sprite="spring"}
        if (fall=10) {sprite="dash"}
    } else if (bonk) sprite="bonk"
    else {if (jumpball) {if vsp<=0 sprite="jump" else sprite="fall"} else sprite="jump" frspd=jumpspd}
} else {
    if (spin) {sprite="ball" frspd=0.5+abs(hsp/3)}
    else if (fired) {sprite="fire"}
    else if (push!=0) {sprite="push" frspd=1+abs(hsp/3)}
    else if (hsp=0) {
        if (left && right) {sprite="walk"}
        else if (hang) {sprite="hang"}
        else if (pose) sprite="pose"
        else if (lookup) {sprite="lookup"}
		else if (waittime>maxwait) {sprite="wait"}
        else {sprite="stand"}
    } else {
        if (braking) sprite="brake"
        else if (abs(hsp)>maxspd*0.95 && !water && !finish) {sprite="run" frspd=abs(hsp/3)}
        else {
            sprite="walk" frspd=1.25-abs(hsp/maxspd)
            if (!loose) frspd=1.25-abs(hsp/maxspd)
        }
    }
}


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

#define controls
com_inputstack()

tempbrick=0
luijump -= 1

//situations in which it should skip controls entirely
if (hurt || piped || move_lock) {
    di=0
    exit
}

if (up) com_piping()
oup=up

if (up && (!hang || !size)) {
    if (hsp=0 && !jump) lookup=1
    else lookup=0
} else lookup=0

//list of things that prevent you from moving
if (spindash || (crouch && !jump)|| vinegrab || grabflagpole) h=0

//movement
if (h!=0) {
    loose=0
    coll=noone
    if (h=sign(hsp) || hsp=0) coll=collision(h,0)
    if (coll) if (object_is_ancestor(coll.object_index,moving)) coll=place_meeting(x+h,y+coll.vsp+sign(coll.vsp),coll)
    if (coll) if (player_climbstep(coll)) coll=noone
    if (x<=minx && left) coll=1
    if (coll) {
        com_hitwall(h)
        if (!jump && !spin && !crouch) {
            push=h
            xsc=h
            braking=0
        }
    } else {
        if (spin) {
            if (sign(hsp)!=h) hsp+=h*0.04*wf
        } else {
            if (!jump) { //ground accel
                if (sign(hsp)!=h && hsp!=0) {
                    if (abs(hsp)>maxspd*0.45) {
						if !skidding playsfx(name+"skid")
                        braking=1
						skidding=1
                        brakedir=h
                    }
                    hsp+=(0.08+( 0.08*size==3))*wf*h
                    if (abs(hsp)<0.5) xsc=h
                } else {
					hsp+=(0.04+( 0.02*(size==3 || size==5)))*wf*h
                    xsc=h
                    braking=0
                }
            } else { //air accel
				if !(jump && !fall) || (abs(hsp)<maxspd ||sign(hsp)!=h)
                hsp+=(0.03+0.03*!fairdash +( 0.03*size==3))*wf*h
                xsc=h
            }
        }
    }
}

if (push!=h) push=0

com_di()

//code for specifically the a button
if ((abut || jumpbufferdo) && !springin) {
    if (!jump||fall=69||grabflagpole) { //jump
        if (hsp==0 && crouch && push==0 && fall!=69 && !grabbedflagpole) {
			if (spindash) {
				spinchargetimer=20
			}
            playsfx(name+"spindash",0,2-(median(0,spindash-1,3)/3)*playerskindat(p2,"pitchdash"+string(p2)))
            spindash=min(4,spindash+1)
			
            tempbrick=1
        } else if ((size==5 && !collision(0,-4)) || size!=5){
            jumpsnd=playsfx(name+"jump",0,1+((size==5)/3))

            vsp=-5.5
			onvine=0
			grabflagpole=0
            latchedtoflagpole=0
            if (water) vsp=-sqrt(sqr(vsp)*wf+2)

            //change jump angle in steep slopes
            vd=point_direction(0,0,hsp,vsp)+point_direction(0,0,1,slobal/2)
            vm=point_distance(0,0,hsp,vsp)
            hsp=lengthdir_x(vm,vd)
            vsp=lengthdir_y(vm,vd)

			sprite_angle=0
			
            jump=1
		if (size==7) luijump=9
            fall=0
            braking=0
            spin=0
            canstopjump=1
            if (mymoving) hsp+=avgmovingh
            crouch=0
            if (spin && !star) seqcount=0
            jumpspd=min(1,0.5+abs(hsp)/5)
        }
    } else { //air jumps
		if (!down && !fairdash && !bounce) {
			playsfx("ashurabounce")
			sprung=0
			bounce=1
			nocratebounce=0
			pollenated=0
			//hsp=0
			vsp=6+((size==3)*4)
			fall=0
		}
		if ((down || fairdash) && !bounce && (fall=0 || fall=5)) {
			if (fairdash) airspinchargetimer=20
			playsfx(name+"dropdash",0,2-(median(0,fairdash-1,3)/3)*playerskindat(p2,"pitchdash"+string(p2)))
            fairdash=min(4,fairdash+1)
		}	
        if (!bounce) jumpbuffer=4*!jumpbufferdo
    }
}

if (spindash) {
	spindust+=0.5*spindustspeed
	spindust=wrap_val(spindust,0,spindustframes)
} else spindust=0

jumpbufferdo=0
springin=0

if (akey) {
    if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {
    if (canstopjump=1 && jump && vsp<-2 && !sprung) {
        vsp*=0.5
    }
    canstopjump=0
	luijump=0
}

if (!akey) {
    
}

//code for specifically the b button

if (bbut) {
    if ((hsp==0 && crouch && push==0 && fall!=69 && !grabbedflagpole && (!size || size==5 || !jump)) || (spindash))  {
		if (spindash) spinchargetimer=20
        playsfx(name+"spindash",0,2-(median(0,spindash-1,3)/3)*playerskindat(p2,"pitchdash"+string(p2)))
        spindash=min(4,spindash+1)
        tempbrick=1
    } else {
        if (water) {
            fall=10
            fairdash=0
        } else if (energy=6 || (super && teleport<8)) || ((fairdash) && (!down)) {
			if size=2 {i=fire_projectile(x,y-4) }
            playsfx("ashurateleport")
            teleport=16
            frame=0
			if size=3 {tptwice=1 hsp=0 vsp=0 }
            energy=0
			
            telex=x+(80/(1+ (size==3)*0.25) ) *(right-left)
            if (!finish) telex=median(region.lefthand+8,telex,region.x-8)
            teley=y+(80/(1+(size==3)*0.25) )*(down-up)
        } else if ((fairdash) || ((teleport) && (!down)) || ((!teleport) && (down))) && (jump) {
			if (fairdash) airspinchargetimer=20
			playsfx(name+"dropdash",0,2-(median(0,fairdash-1,3)/3)*playerskindat(p2,"pitchdash"+string(p2)))
            fairdash=min(4,fairdash+1)
		} else if (fairdash) {
			if (fairdash) && (down) teleport=0
			}
		}
	}
if !bkey{
if (fall=10) fall=0
}

if (cbut) {
    if (spindash || (crouch && down)) {
		if (spindash) spinchargetimer=20
        playsfx(name+"spindash",0,2-(median(0,spindash-1,3)/3)*playerskindat(p2,"pitchdash"+string(p2)))
        spindash=min(4,spindash+1)
        tempbrick=1
    }  else if ((down || fairdash) && !bounce && (fall=0 || fall=5) && jump) {
			if (fairdash) airspinchargetimer=20
			playsfx(name+"dropdash",0,2-(median(0,fairdash-1,3)/3)*playerskindat(p2,"pitchdash"+string(p2)))
            fairdash=min(4,fairdash+1)
		}
}

spinchargetimer=(max(0,spinchargetimer-1))
airspinchargetimer=(max(0,airspinchargetimer-1))

//crouching and spinning
if (down && !up) {
    if (!jump && !braking && !spin) {
        if (abs(hsp)<0.5) {
            crouch=1
        } else if (!spin && !crouch) {
            spin=1
            playsfx(name+"spin")
        }
    }
    com_piping()
} else {
    if (!jump) crouch=0
	if jump && fairdash{
	
		spin=1 fall=0
	    hsp=xsc*maxspd*(((abs(vsp)/3.5)+((0.5*fairdash)/1.3))/2)
		hyperspeed=(abs(vsp)*sign(hsp))/3
		fairdash=0
		spindash=0
		soundstop("ashuraspindash")
		playsfx("ashurarelease")
		shoot(x,y+10,psmoke)


	}
}

if (size==5) mask_set(9,8)
else if (spin || spindash || crouch || size=0 || fall=5) mask_set(12,12)
else if (jump && (!fall || fly || fall=10)) mask_set(12,15)
else mask_set(12,24)


#define movement
if (piped) exit

if (!jump) if (loose || spin || crouch) {
    braking=0
    frick=0.03
    if (spin) frick=0.001
    hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

maxspd=(3.5 + !!size*0.5  + (size==5)*0.55 - (fall==10)*0.5)*wf

//There's an extra check in the hsp+= section of h!=0 to compensate!.
if (abs(hsp)>maxspd) {
	if (!spin && !(jump && (!fall || fall==7))) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)
}

vsp=min(7+downpiped+bounce*3,vsp)

///movement
//hi moster here dont uncomment the yground or easyground stuff because its required for the cool new slope system to work
//for anyone porting a charm from unfinished build or below to this build, delete or comment all of the commented code and add player_nslopforce()
calcmoving()

if (!dead && !grabflagpole) {
if fall=69 bounce=0
if fall!=69
    player_horstep()
    player_nslopforce()
    //yground=easyground()
	//if (yground!=verybignumber) yground-=14
    if (jump) {
        hang=0
		if !grabbedflagpole{
        if (fall=10) {
            if (water) {
                hsp+=(right-left)*0.25
                vsp+=(down-up)*0.15-0.075
                l=median(0,point_distance(0,0,hsp,vsp)-0.05,2)
                d=point_direction(0,0,hsp,vsp)
                hsp=lengthdir_x(l,d)
                vsp=lengthdir_y(l,d)
                xsc=esign(hsp,xsc)
            } else vsp=min(1,vsp+0.1)
        } else {
            if fall!=69 && !luijump {
            	vsp+=0.15*wf-(size=5 && vsp>-0.35 && !water)*0.075
        	} if (!hurt) vine_climbing()
        }}
        crouch=0 spindash=0

        braking=max(0,braking-1)
        if (sprung && !fall) {bounce=0 fall=1}
        push=0 spin=0
        rise=0 risec=0
        coyote=0
		osld=0
		player_vertstep()
		if (!jump) sld=point_direction(0,0,1,slobal)
    }
	
	sprite_angle=0
	//if (osld<180 && osld>0 && !instance_place(x-16,y+4,ground)) dy=3
	//else if (osld>180 && osld<320 && !instance_place(x-16,y+4,ground)) dy=3

    if (!jump) {
		//if (yground!=verybignumber) {y=yground while collision(0,0) && !collision(0,-8) {y-=1 }}
		osld=sld
		sld=point_direction(0,0,1,slobal)
		if (!collision_point(x+((mask_w/2)+max(maxspd,hsp)+18)*sign(hsp),bbox_bottom+4,ground,0,0) && (abs(hsp)+abs(hyperspeed))>2 && spin) {
			diff=anglediff(sld,osld)
			if (sign(diff)=sign(hsp) && diff*sign(hsp)>40 && sld=0) {
				jump=1 fall=!spin fallspr=sprite fallspd=frspd
				y=min(y,yp)
				/*hsp=lengthdir_x(hsp,osld)*/ vsp=-abs(lengthdir_y((hsp+hyperspeed+gm8exspd),osld))*1.5 // coolness factor
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
				fallspd=frspd
				spin=0
				crouch=0
			}
        } else coyote=0
        if (jumpbuffer=-1) {
            jumpbuffer=0
            if (rise=0 && !down) jumpbufferdo=1
        }
    }
}
com_finishmove()


#define actions
com_warping()
com_actions()

if !(bounce) {
	nocratebounce=0
}

if (fairdash && !jump) {fairdash=0}

weight=0.25+0.25*!!size
bartype=1

is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || teleport || piped=1) is_intangible=1

power_lv=0
is_coinexplosive=0
if (spindash || spin || (jump && (!fall || fall=5))) power_lv=1
if (bounce) {power_lv=2 is_coinexplosive=1}
if (star || insta) power_lv=5
if (teleport=8) power_lv=6
if (super) power_lv+=1

if (piped) exit

//Special interactions
pvp_spin=spin //rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=0 //make sure to set for 0 for the mario bros when pounding
pvp_ignore=instashieldin //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away


//waiting animation
if maxwait{
if (sprite="stand")
{waittime+=1}
else if sprite!="wait" waittime=0
}


if (!teleport) if (place_meeting(x,y,ashurawaterfall) || place_meeting(x,y,waterfall)) energy=6

if (!jump) {
    vsp=0
    if (!star && !spin && !spindash) seqcount=0
    if ((sprite="stand" && hsp=0) || hang) {
        image_xscale=1/6
        hang=(!instance_place(x,y+4,collider) && instance_place(x-7*xsc,y+4,collider))
        image_xscale=1
    } else hang=0
    if (push=0 && hsp!=0 && braking) {
        playsfx(name+"skid")
    } else if (skidding) {soundstop(name+"skid") skidding=0}
}

//water
if (underwater()) {
    if (!water) {
        if (abs(vsp)>2) water_splash(1)
        vsp=min(1,vsp/2)
        jumpspd=1
    }
    water=1
    wf=0.6
    wbc+=1-hsp/10
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
}

if (jump && size==7 && global.fastframe4 != ff4prev) {ff4prev = global.fastframe4 with instance_create(x, y, afterimagenoblend) {event_user(0) alphadecay=1 alarm[0] = 24 maxalarm = 24 maxalpha=0.8}}


maxe=6*!!size-((size==5)*6)
if (mcs>=20) {energy+=1 mcs=0}
if (fall=7 && vsp>0) fall=1
if (insta) insta+=1
if (left && right && !jump && global.dustframe) shoot(x,y+12,psmoke,xsc*-2,-0.5)
if (vsp<-5) charm_run("checkbounce") //the only notable case of ashura incorrectly sustaining a bounce afaik is from monitors which set your vsp to the exact negative of it so just check if ashura is at bounce-like speed going upwards
if (teleport) {
    mcs=0
    teleport-=1
    vsp=0
    if (place_meeting(x,y,barrier)) hsp=0
    if (teleport=8) {
        if (finish) {visible=0 piped=1}
        else {
            if (!collision_line(x,y,telex,teley,barrier,1,0)) {
                x=telex
                y=teley

                if (!tptwice) {
            	    insted=2
            	    instashieldin=1
					insta=1
					alarm[1]=10

					if (!count_projectiles() && size == 6) {
						var looped, form;
						looped = 1;
						form = (1 + (abs(other.hsp) / 2.2)) * xsc; //yaargh me formula

						p2 = 10;
						repeat (2) {
		                    with fire_projectile(x + (8 * (xsc * sign(looped))), y + 2) {
		                        hspeed = form * looped;
		                        if (abs(hspeed) < 1.2)
		                        	hspeed = 1.2 * sign(hspeed)
		                        vspeed = -2.4;
		                        visible = 0;
		                    }
		                    looped = -0.65;
		                }
	                    p2 = real(ss);
		                playsfx("ashuradash");
	                }
				}
            }
        }
    } else if tptwice && teleport=1{
		tptwice=0
	    telex=x+(80/(1+(size==3)*0.75) ) *(right-left)
        telex=median(region.lefthand+8,telex,region.x-8)
        teley=y+(80/(1+(size==3)*0.75) )*(down-up)
		teleport=12
	}
}
if (size=3 && !hurt) {
    with (coin)
        if (object_index!=redcoin)
            if (point_distance(x,y,other.x,other.y)<100)
                if (!collision_line(x,other.y,other.x,other.y,buffer,0,0))
                    event_user(0)
    with (itemdrop) if (type="coinup") {
        if (follow) {
            follow=other.id
        } else {
            if (point_distance(x,y,other.x,other.y)<100)
                if (!collision_line(x,other.y,other.x,other.y,buffer,0,0))
                    follow=other.id
        }
    }
}

//spindash/spin
global.coll=id
if (spindash || spin) {
    coll=instance_position(x-10*sign(hsp),y+22,hittable)
    coll2=instance_position(x,y+22,hittable)
    collmon=instance_position(x,y+22,monitor)
    if (collmon) {
        jump=1 spindash=0 spin=0 vsp=-2
        with (collmon) event_user(6)
    }
    if (spindash) coll=coll2
    else if (coll2) if (coll2.object_index!=brick) coll=coll2
    if (coll) if (coll.hit) coll=0
    if (coll=spinblacklist) coll=0
    if (!coll)
        with (hittable)
            if (id!=other.spinblacklist && (object_index!=brick || other.spindash) && !hit)
                if (instance_place(x,y-4,other.id)) other.coll=id
    
    if (coll) if (!coll.goinup || tempbrick) {
        i=coll.object_index
        hitblock(coll,id,0,1,0)
        if (i=brick) {spinblacklist=coll if (spindash) {jump=1 spindash=0 crouch=0 vsp=-2*wf}}
    }
    
    if (spindash) {
        spindash=max(1,spindash-0.025)
        if (!crouch) {
            spin=1
            hsp=xsc*6*(0.75+0.25*median(0,spindash-1,2)/2)
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
            if (collision(0,0) && size && size!=5) {
                xsc=esign(h,xsc)
                hsp=xsc
                spinc=0
                spin=1
            } else {
                spinc=0
                spin=0    
                hsp=0
                soundstop(name+"spin")
                crouch=down
            }
            mask_reset()
        }   
    }
} else spinblacklist=noone
//Christianity moment the sequel
jesus=((size==5 && !down && abs(hsp)>3.2 && !bounce && !teleport) && !water)


instaframe+=0.25
if instaframe>3.75 instaframe=0

//WHO IS CLIMBING MY SHIT.
if (up && !down && !onvine) {
    onvine=instance_place(x,y,vine)
    if (onvine) fall=69 //nice
}
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

com_endactions()

#define enemycoll
//Code that defines collision with enemies

if (coll) {
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
            
        if (coll.object_index=lakitu) if (coll.flee) exit
        
        if (star  
        || (spin && type!=spinyegg && type!=beetle && type!=koopa && !object_is_ancestor(type,koopa) && type!=shell)
        || (pound>13 && type!=piranha && type!=spinyegg && type!=spiny)) {
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            if (type=hammerbro) seqcount=max(5,seqcount)
            enemydie(coll)                
            exit
        }
        
        if (spindash || inst || firedash) {if (diggity=32) exit enemyexplode(coll) exit}
        
        if (type=piranha || coll.damage_player_on_contact) {
            hurtplayer("enemy")
            exit
        }
        
        
         
    if (spin) {
    if (type=koopa|| object_is_ancestor(type,koopa)) { with enemyflip(coll) {y-=3 vspeed=-3 intangible_timer=30} exit }
            else if (type=beetle ) {enemystomp(coll) jump=1 jumpspd=0.5 vsp=-((abs(hsp)*1.25)+(abs(gm8exspd))) hsp/=1.5 exit}
            else if (type=spinyegg) {hurtplayer("enemy") exit}
            else {enemydie(coll) exit}
        }
    
     
        if (type=spiny) {
            if (!fall && vsp<0 && size!=5) enemyexplode(coll)
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
            if (jump && (!calcfall || !water) && vsp>0 && size!=5) {if (calcfall) enemystomp(coll,5) else enemyexplode(coll)}
            else if (size==5 && jump && (!calcfall || !water) && vsp>0) {
               vsp=-3-akey*1.5
               canstopjump=akey
               if (fall=12) fall=5
               playsfx(name+"jump",0,1.8)
            }
            else hurtplayer("enemy") exit
        }
        
        if (type=cheepred || type=cheepwhite) {
            if (jump && !calcfall && size!=5) {enemyexplode(coll) exit}
            else if (!calcfall && size==5 && jump) {
                if (vsp>0) {
                vsp=-3-akey*1.5
                canstopjump=akey
                if (fall=12) fall=5
                playsfx(name+"jump",0,1.8)
                } else {hurtplayer("enemy")} exit
            }
            else {hurtplayer("enemy") exit}
        }
        
        if (jump) {
            if (type=koopa || type=beetle || type=rexbig || object_is_ancestor(type,koopa)) {
                if (vsp<0) {
                    if (calcfall || size==5) hurtplayer("enemy")
                    else enemyexplode(coll) exit
                }
            } else {
                if (!calcfall && size!=5) {enemyexplode(coll) exit}
                if (vsp<0) {hurtplayer("enemy") exit}
            }
            
            if (type=goomba && seqcount=1 && !scorelok4) {seqcount=0 scorelok4=1}    
            if ((type=koopa || type=redkoopa) && seqcount=1) scorelok1=1    
            if (type=hopkoopa || type=redhover) seqcount=max(seqcount,1)
            if (type=hammerbro) seqcount=max(5,seqcount)
            if (fall=12) fall=5
    
            if (size==5) {
                if (vsp>0) {
                vsp=-3-akey*1.5
                canstopjump=akey
                if (fall=12) fall=5
                playsfx(name+"jump",0,1.8)
                }
                else hurtplayer("enemy") exit
            }          
            else enemystomp(coll) exit      
        } else if (coll.vspeed<0 && coll.y>y+8) {jump=1 fall=1 vsp=-0.5 if size!=5 enemystomp(coll) else playsfx(name+"jump",0,1.8) exit}
        
        hurtplayer("enemy")   
    } else if (!star && !flash) hurtplayer("enemy")
}    

#define hurt
if ((invincible() && (hurt || flash)) || intangible())
exit
pipe=0
sprongin=0
speed=0
if (skidding) {soundstop(name+"skid") skidding=0}
if (carry && carryid) {with (carryid) event_user(0) carryid=noone carry=0}
onvine=0
energy=0
braking=0
sprung=0
grow=0
fairdash=0
gk=0
fk=0
punch=0
bounce=0
oldsize=size
jumpbuffer=0
hyperspeed=0
luijump=0
hp=0
star=0

if ((!size || size==5 || ohgoditslava) && !shielded && global.rings[p2]==0) {
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

    starhit=0
    jump=1 hurt=1+starhit if (!starhit) if (shielded) {shielded=0} else if global.rings[p2]>0 {droprings()} else {if size=3 size=1 else size-=1} hsp=xsc*-2*wf vsp=-3*wf
    
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

} else if (((owner.size || (!owner.size && owner.spin && !biggie && owner.y>=y)) && !tpos) && owner.size!=5)  { 
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
    i=instance_create(x+4,y+12+(16*biggie),part) i.hspeed=-1 i.vspeed=-1+2*go
    i=instance_create(x+12+(16*biggie),y+12,part) i.hspeed=1 i.vspeed=-1+2*go 
    i=instance_create(x+4,y+4,part) i.hspeed=-1 i.vspeed=-3+2*go
    i=instance_create(x+12+(16*biggie),y+4,part) i.hspeed=1 i.vspeed=-3+2*go
    
    with (turing) event_user(4)
    instance_destroy()
  } else if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
} 
else { 
    com_breakblocks()
  }
 }
} else if typeblockhit=1{
	hititembox()
}

#define hitwall
//hit blocks sideways
if (spin && abs(hsp)>0.5) {
    global.coll=id
    with (hittable) if (instance_place(x-other.hitside,y,other.id)) {
        go=-1
        insted=1
        event_user(0)
        insted=0
    }
    coll=collision(hitside,0)
}

if (coll=noone) exit

if (!collpos(sign(hitside)*10,8,1)) {        
    //gap running
    if (y<coll.y-12) {y=coll.y-14 coll=noone exit}
}

hsp=0
hyperspeed=0           


#define landing
braking=0
insted=0

if (grabbedflagpole){
vsp=0
xsc=-1
}

if (downpiped) {
    shoot(x-8,y+4,psmoke,-2,-1)
shoot(x+8,y+4,psmoke,2,-1)
    downpiped=0
}
if (hurt) {flash=1 fk=0 hsp=0 hurt=0}

charm_run("checkbounce")           	

if (fairdash) {
    spin=1
    hsp=xsc*maxspd*(((abs(vsp)/3.5)+((0.5*fairdash)/1.3))/2)
	hyperspeed=(abs(vsp)*sign(hsp))/3
    fairdash=0
	spindash=0
    soundstop("ashuraspindash")
    playsfx("ashurarelease")
    shoot(x,y+10,psmoke)
}

playsfx(name+"step")

//jump buffering
if (jumpbuffer) jumpbuffer=-1

//fall into spin
if (!spin && rise=0 && !hurt && down && abs(hsp)>=0.5) {
    spin=1
    playsfx(name+"spin")
seqcount=1
}

//jump into tiny space
if (insted!=2 && !spin) {
	mask_temp(12,12)
	coll=collision(0,0)
	mask_reset()
	if (!coll && collision(0,0)) {
	spin=1
	jump=0
	mask_set(12,12) 
	playsfx(name+"spin")
	hsp=max(abs(hsp),2)*esign(hsp,xsc)
	}
}
    

#define death
if (event="create"){
alarm0=30
alarm1=300
sprite="dead"
frame=0
frspd=1
size=0
spindash=0
alpha=1

if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
xsc=owner.xsc
ysc=owner.ysc
frn=owner.frn
vspeed=-3.5 gravity=0.1-(owner.water*0.015)
} else if (event="step"){
if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
alarm0=max(0,alarm0-1)
alarm1=max(0,alarm1-1)

if alarm1=0 instance_destroy()
} else if (event="draw"){


}


#define enterpipe
if (type="side") {
	if (spin) {
		set_sprite("ball")
		frspd=min(1,0.1+abs(hsp/4))
		if (abs(hsp)>=3 && !water) {fastpipe=1 playsfx(name+"spin")}
	}
}
if (type="up") {
	//set_sprite("fly")
}
if (type="down") {
	if (bounce) {vspeed=5 alarm[6]=6 fastpipe=1}
}

if (skidding) {soundstop("ashuraskid") skidding=0}
braking=0
crouch=0
push=0     
teleport=0
bounce=0


#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}


#define checkbounce
if (bounce) {
    playsfx("ashurabounce")
    shoot(x-8,y+4,psmoke,-2,-1)
    shoot(x+8,y+4,psmoke,2,-1)
    com_piping()
    bounce=0
    seqcount=0
	with (hittable) if (instance_place(x,y-max(4,other.vsp),other.id)) {
	go=1    
	event_user(0)
	picked=1
	} 
	jump=1
	vsp=-6+3*!akey-powerbounce
	canstopjump=1
    fall=0
	if powerbounce fall=7
	powerbounce=0
    
	if size=2 {
		pollenated=1
		o=fire_projectile(x,y-4)
		o.waterdust=1
		o.hspeed=2
		o.gravity=0.2
		o.vspeed=-4
		o=fire_projectile(x,y-4)
		o.waterdust=1
		o.hspeed=2
		o.gravity=0.2
		o.vspeed=-2
		o=fire_projectile(x,y-4)
		o.waterdust=1
		o.hspeed=-2
		o.gravity=0.2
		o.vspeed=-2
		o=fire_projectile(x,y-4)
		o.waterdust=1
		o.hspeed=-2
		o.gravity=0.2
		o.vspeed=-4
	}
	
}