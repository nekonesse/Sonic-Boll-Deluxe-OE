#define spritelist
stand,wait,fired,lookup,lookupfired,pose,dance,knock,deadair,deadland,walk,walkfired,walkup,walkupfired,brake,jump,bonk,fall,jumpfired,jumpup,jumpupfired,jumpdown,jumpdownfired,suckin,groundpound,poundfall,slide,doublejump,doublejumpbonk,doublejumpfall,triplejump,triplejumpbonk,triplejumpfall,swim,paddle,climbing,flagslide,grind,piping,pipingup,sidepiping,doorenter,doorexit


#define soundlist
skid,swim,pound,stomp,smalljump,flip,spin,slide,kick,fireball,wallkick,smallwallkick,dive,spinjump,puff


#define movelist
Stanley
#
[a]: Puff Jump (air)
[down]: Groundpound (air)
[c]/[b]: Puff 
Bump into trapped enemies for a powerful attack!
Jump out of a Groundpound to reach higher places
Use [b] or [x] to run
<fire>
Stanley [flwr]
#
[a]: Puff Jump (air)
[down]: Groundpound (air) 
[c]/[b]: Puff 
Bump into trapped enemies for a powerful attack!
Jump out of a Groundpound to reach higher places
Use [b] or [x] to run
<feather>
Stanley [fthr]
#
#
[a]: Puff Jump (air)
[down]: Groundpound (air)
[c]/[b]: Puff 
[fthr] Hold A while mid-air to descend very slowly
Bump into trapped enemies for a powerful attack!
Jump out of a Groundpound to reach higher places
Use [b] or [x] to run

#define rosterorder
13

#define grabbedflagpole
grabbedflagpole=1
hsp=0
vsp=0

#define start
mask_set(12,12)
global.stan_canpound[p2]=1 //Later on I'll make it swappable normally in the change screen
can_pound=global.stan_canpound[p2]

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
com_item()

#define endofstage
right=1
akey=(push || (jump && akey) || !collision(16,8))
dance=!jump

#define effectsfront

if iaminsidemyself exit
if gun_loaded{

if !(e_timer mod 4){
	iaminsidemyself=1
	d3d_set_fog(true, c_white, 0, 1)
    ssw_core(0)
    d3d_set_fog(false, c_black, 0, 0)
	iaminsidemyself=0
}
e_timer+=1
}

#define projectile
if (event="create") {
	last=32+((owner.size=2)*30)
	maxlast=32+((owner.size=2)*30)
	last2=128
	friction=0.15
	mask_index=spr_mask2x2
	image_xscale=6
	image_yscale=2
	visible=1
	side=!owner.downer
	xsc=1
	ysc=1
	super_proj=owner.gun_loaded
	owner.gun_loaded=0
	if side hspeed=owner.xsc*((4 +(abs(owner.hsp)>=owner.maxspd)*2) +((owner.size=2)*3))
	else vspeed=4+(2*super_proj)
	
	if super_proj && !side owner.vsp-=2
	if super_proj && side speed*=2
}
if !super_proj{
	if (event="step") {
		if (expand) {
			last2-=1
			if (last2=0) {
				instance_create(x,y,smoke)
				trap.stankillontouch=0
				with (enemy) if (trap=other.id) trap=noone
				with (player) if (trap=other.id) trap=noone
				instance_destroy()
			}
			if (last2<20) visible=((last2 mod 4)<2)
			frame=2+global.frame8
			xsc=1+1*!!trap
			ysc=1+1*!!trap
			trap.x=x
			trap.y=y
			if (!setkill_stanstan) {trap.stankillontouch=1 setkill_stanstan=1}
			if (instance_place(x,y,collider) && owner.size!=2) speed=0
		} else {
			last-=1 
			frame=3-max(0,floor((last/maxlast)*4))
			if (last=0) {
				instance_create(x,y,smoke)
				instance_destroy()
			}
			if (last<10) visible=((last mod 4)<2)
			xsc=esign(hspeed,xsc)
			ysc=esign(-vspeed,ysc)
			if (!stanflame) {
			
				if instance_place(x,y,collider)
				if (instance_place(x,y,collider) && owner.size!=2) {x-=hspeed y-=vspeed speed=0}
				if (gamemanager.status[owner.p2]=6 && y>40) {instance_create(x,y,smoke) instance_destroy()}
			}
		}
		
	coll=instance_place(x,y,collider)
	if (coll) {
		if (object_is_ancestor(coll.object_index,hittable)) {
			if (coll.object_index=brick) brickc+=1 else brickc=4
			hitblock(coll,owner,1,-1,0)
		} else brickc=4
	}
		
		coll=instance_place(x,y,player)
		if coll{
			if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !expand && !coll.trap && coll.id!=owner) {
				expand=1
				coll.trap=id
				friction=0.25
			}
		}
		
		coll=instance_place(x,y,enemy)
		if coll{
			if (!expand && !coll.trap && coll.object_index!=piranha) {
				expand=1
				coll.trap=id
				friction=0.25
				trap=coll
			} else if !expand && !coll.trap enemydie(coll,2)
		}
		
		
	}
	if (event="draw") {
		if (side) draw_sprite_part_ext(sheet,0,10+17*frame,104,16,16,round(x-8*xsc),round(y-8*ysc),xsc,ysc,$ffffff,1)
			else draw_sprite_part_ext(sheet,0,10+17*frame,87,16,16,round(x-8*xsc),round(y-8*ysc),xsc,ysc,$ffffff,1)
	}
} else {
	if event="step"{
	image_xscale=10
	image_yscale=10
	if !inview() instance_destroy()
		coll=instance_place(x,y,collider)
	if (coll) {
		if (object_is_ancestor(coll.object_index,hittable)) {
			if (coll.object_index=brick) brickc+=1 else brickc=4
			hitblock(coll,owner,1,-1,0)
		} else brickc=4
		instance_create(x,y,kickpart)     
		if (brickc=4 && owner.size!=2) {sound("itemblockbump") instance_destroy()}
	}

	coll=instance_place(x,y,enemy)
	if (coll) {
		if (coll.object_index!=beetle) {
			yes=1
			if (coll.object_index=shell) if (coll.type="beetle") yes=0
			if (yes) {
				global.coll=owner.id  
				instance_create(x,y,kickpart)  
				enemydie(coll,2)
			}
		}
	}

	coll=instance_place(x,y,bowserboss)
	if (coll) {
		if (!coll.flash) {
			coll.hp-=1
			coll.flash=64
			coll.owner=owner
			sound("enemybowserhurt")
			instance_create(x,y,kickpart)
		}
	}

	coll=instance_place(x,y,player)
	if (coll) {
		if (coll.id!=owner) if (!invincible(coll)) {    
			if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
				if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
				if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) instance_destroy() exit}
				with(coll) {fragplayer(other.owner) coll.hsp*=2 coll.hyperspeed=sign(hsp)*2}
				
			}
			instance_create(x,y,kickpart) 
		}
	}
		
		if owner.size=2{
		
		
		}
	
	
	friction=0
	}
	if (event="draw") {
		if (side) draw_sprite_part_ext(sheet,0,10+17*3,104,16,16,round(x-8*xsc),round(y-8*ysc),xsc,ysc,$ffffff,1)
			else draw_sprite_part_ext(sheet,0,10+17*3,87,16,16,round(x-8*xsc),round(y-8*ysc),xsc,ysc,$ffffff,1)
	}


}

#define sprmanager
frspd=1
cantslowanim=0
 ypos=0
 keepframebetween=0
if (grabflagpole) {sprite="flagslide"}
else if (hurt) {sprite="knock"}
else if dance {sprite="dance"}
else if (pound) {sprite="groundpound" if (pound>12 || vsp>0) sprite="poundfall"}
else if (slipnslide) {sprite="slide"}
else if (jump) {
	if (onvine) {sprite="climbing" frspd=sign(left+right+up+down)}
    else if (bonk) {sprite="bonk" if (jumpspd=99) {if triplejump>=1 sprite="triplejumpbonk" else if triplejump>=0.5 sprite="doublejumpbonk"}} 
	else if fireddown {sprite="jumpdownfired" if fireddown<20 sprite="jumpdown"   fireddown-=1}
	else if (lookup) {if fired {if sprite="lookupfired" keepframebetween=1 sprite="jumpupfired"} else sprite="jumpup"}
	else if fired {sprite="jumpfired"}
        else if (water) {sprite="swim" if (swim) sprite="paddle"}
	else if (triplejump>=1) {sprite="triplejump" if vsp>0 sprite="triplejumpfall"}
	else if (triplejump>=0.5 && !water) {sprite="doublejump" if vsp>0 sprite="doublejumpfall"}
    else if (fall=6) {sprite="knock"}
    else {sprite="jump" if (vsp>0) sprite="fall"}
	
} else {
    if (spin) {sprite="ball" frspd=0.5+abs(hsp/3)}
    else if (push!=0) {sprite="push" frspd=1+abs(hsp/3)}
	else if (gun_load) {sprite="suckin"}
    else if (hsp=0) {
        if (hang) {sprite="hang"}
        else if (pose) sprite="pose"
	else if (fired) {if lookup {if sprite="jumpupfired" keepframebetween=1 sprite="lookupfired"} else sprite="fired"}
        else if (lookup) {sprite="lookup"}
        else if (waittime>maxwait) {sprite="wait"}
        else {sprite="stand"}
    } else {
        if (braking) sprite="brake"
        else {
			if (sprite="walkfired" || sprite="walkup" || sprite="walkupfired") keepframebetween=1
			sprite="walk" frspd=0.2+abs(hsp/4) 
			if (fired || lookup) {
				if !lookup {sprite="walkfired" keepframebetween=1 /*ypos=1*/}
				else if !fired {sprite="walkup" keepframebetween=1 /*ypos+=2*/}
				else {sprite="walkupfired" keepframebetween=1}
			}
		}
    }
}
//lookup,lookupfired,walkup,walkupfired,jumpup,jumpupfired

#define grabflagpole
grabflagpole=1
hsp=0
vsp=0

#define controls


com_inputstack()
luijump-=1
if (finish && !dead) {
if !jump dance=3
}


tempbrick=0
carryoffsetx=10
carryoffsety=5

if (rise!=0 || watrlock || hurt || piped || move_lock) {
    di=0
    h=0
    exit
}

if (up) com_piping()
oup=up

lookup=0
if (up) lookup=1

if (
rise!=0 || 
flight ||
(crouch && !jump) ||
(poundcancel || pound || spin || dive)
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
    } else {
        if (!jump) {
            if (sign(hsp)!=h) {
                if (abs(hsp)>2 && !carry) {
                    braking=1
                    skidding=1
                    playsfx("stanskid",1)
                    brakedir=h
                }
                hsp+=(0.44-0.175*!water+0.04*(abs(hsp)<1))*wf*h
                if (abs(hsp)<0.5 || carry && !spin) xsc=h
            } else {
                hsp+=(0.06+0.04*(abs(hsp)<0.5)-(0.02*(abs(hsp)<1.5)))*wf*h
                xsc=h
                braking=0
            }
			if dance {hsp=h xsc=h}
			
        } else {
            if (water) {if (h!=sign(hsp)) hsp+=0.1*h else hsp+=0.0475*h}
            else if (dropkick) hsp+=0.1*wf*h
			else if (size==5) hsp+=0.085*wf*h
            else hsp+=0.06*wf*h
            if (!hang && !wallkick && !twist && !spin) xsc=h
        }
    }
}

if (push!=h) push=0

com_di()

if ((abut || jumpbufferdo) && !springin) {
    if (!jump || water ||fall=69||grabflagpole) {
        if (water) {if (!pound) {vsp=-1.5-up*0.75 swim=24 crouch=0 playsfx("stanswim") double=0}}
        else {
            if ((abs(hsp)<=2.5 && triplejump) || triplejump>=1 || (triplexsc!=sign(hsp) && triplexsc!=0) || poundjump) {triplejump=0 triplexsc=0}
            else if (jumptiming && (abs(hsp+hyperspeed)>2.5 || !triplejump)) {triplejump+=0.5 triplexsc=sign(hsp)}
            if (size==0 || size==5) jumpsnd=playsfx("stansmalljump",0,1+triplejump/2+(size==5)/3)
            else jumpsnd=playsfx("stanjump",0,1+triplejump/2)
            if (spin) {vsp=-1 instance_create(x,y+12,smoke)}
            else {vsp=-(4.7+min(1,abs(hsp)/8)+!!poundjump+triplejump) hellothisisajump=1}
            if (water) vsp=-sqrt(sqr(vsp)*wf+2)
        }
        if (poundjump) {springsmoke(x,y+8) crouch=0}
        jumptiming=0
        onvine=0
        jump=1
        if (size==7) luijump=9
        fall=0
        dropkick=0
        braking=0
        canstopjump=1
        if (mymoving) hsp+=avgmovingh
        if (!star) fall=1
        else crouch=0
        if (rise && !down) crouch=0
        jumpspd=min(1,0.5+abs(hsp)/5)
    } else {
        
		if (can_pound && count_projectiles()<3 && insted<3 && !coyote){
			downer=1
			vsp=-3
			fire_projectile(x,y)
			downer=0
			
			insted+=1
			fireddown=30
			playsfx("stanpuff")
		}
		
        jumpbuffer=4*!jumpbufferdo
    }
}
if (!jump) {
    if (jumptiming) jumptiming-=1
    else {triplejump=0 triplexsc=0}
}
jumpbufferdo=0
springin=0

if (akey) {
    if (jumpbuffer) jumpbuffer-=1
} else {
    jumpbuffer=0
    if (canstopjump=1 && jump && vsp<-2 && !sprung && !water) {
        vsp*=0.6
    }
canstopjump=0
luijump=0
}


if ((bkey || xkey)) {
    if (!jump) run=1.5
} else {
    if (carry) {
        updatecarry()
        if (!down) {throw=16 instance_create(carryid.x,carryid.y,kickpart) sound("enemykick")}
        with (carryid) event_user(0)
        carryid=noone
        carry=0
    }
}

if ((cbut || bbut) && can_pound) {
    if (count_projectiles()<3 || (size=3 && count_projectiles()<9)){
	
		
	
		i=fire_projectile(x+4*(xsc>0),y+4-2*(!!size && size!=5) -gun_loaded)
if lookup {i.hspeed=0 i.vspeed=-4 i.side=0}
playsfx("stanpuff")
if size=3  {
i=fire_projectile(x+4*(xsc>0),y+4-2*(!!size && size!=5) -gun_loaded)
i.vspeed=-2
if lookup {i.hspeed=2 i.vspeed=-4 i.side=0}
i=fire_projectile(x+4*(xsc>0),y+4-2*(!!size && size!=5) -gun_loaded)
i.vspeed=2
if lookup {i.hspeed=-2 i.vspeed=-4 i.side=0}
		
		}
		//fired=15
		fired=firelength
		if (sprite="fired" || sprite="lookupfired" || sprite="jumpfired" || sprite="jumpupfired") frame=0
if (gun_load) gun_load=0
	}
}



//crouching
if (down && !up) {
	if can_pound{
		if (jump) {
			if (!carry && fall!=6 && !dive && !pound && !poundlok && fall!=69) {
				pound=1
				nocratebounce=1
				if (water) seqcount=1
				slidejump=0
				dropkick=0
				spinjump=0
				playsfx("stanpound")
			}
		} else if (!braking) {
			if (slobal!=0) {
				slipnslide=1
			} else {
				 
					dance=3
				         
			}
		}
		poundlok=1
	} else {
		crouch=1  
		
	}
    com_piping()
} else {
    if (pound=-1) pound=0
    if (!jump) crouch=0
	if (dance) dance-=1
    poundlok=0
}

if (size==5) mask_set(9,8)
else if (size=0 || crouch || pound || spin || dropkick || dive) mask_set(12,12)
else if (jump) mask_set(12,26)
else mask_set(12,24)


#define movement
if (piped || move_lock) exit



//speed limits
if ((loose && !jump) || (crouch && !jump)) {
if (braking) xsc=brakedir
braking=0
frick=0.06
if (slipnslide) frick=0.01
if !flight hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

maxspd=(1.5+runvar*1.25+water+(size==5)*0.55+slipnslide+!!spin)*wf
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)

if (pound) {
vsp=min(6,vsp)
} else vsp=min(7+downpiped,vsp)

calcmoving()

if (!dead && !grabflagpole) {
if fall!=69
player_horstep()
player_nslopforce()
//yground=easyground()
//if (yground!=verybignumber) yground-=14
if (jump) {
if (flight) {
if !frame1flight{
frame1flight=1
flightdir=sign(xsc)
}
hsp=flightdir*maxspd
if hsp!=0
xsc=sign(hsp)
movevar=xsc*(right-left)

if movevar>0 { //pulling down, make gravity stronk + give speed
vsp=min(4,vsp+0.25)
frame1uppies=0
} else if movevar=0{ //Neutral, let gravity do it's thing
vsp=min(4,vsp+0.15)
frame1uppies=0
} else if movevar<0{  //pulling up, glide and gain upward force based on how hard you're falling
if !frame1uppies{
airtime=vsp*5
savedvsp=vsp
frame1uppies=1
if energy=0 airtime=0
energy-=1
}
if vsp>=1{ //stop falling, transition into gliding/flying
vsp*=0.9  
} else {
if savedvsp<1||airtime<=0{ //No more uppies for you! *vine boom sfx*
vsp=min(1,vsp+0.05)
}
else { //use up airtime 
vsp-=0.6
if vsp<-2.25 vsp=-2.25
airtime-=1
}
}

}
if pound flight=0

if sign(hsp)!=flightdir flight=0
} 
else if (pound>0) {

	hsp=0
	if (pound<14) vsp=0
	else if (pound>=14 && pound<15) vsp=6*wf
	else if (water) {vsp-=0.1*wf if (vsp<1.5) pound=0}
	else vsp+=0.375*wf
}
else if (vsp<-2 && !luijump) vsp+=0.15
else if (water) vsp=min(1.5,vsp+0.04)
else if (twist>5) vsp=min(1,vsp+0.1)
else if fall!=69 && !flight && !luijump{
vsp=min(4,vsp+0.25)
if size==5 && vsp>-0.75 vsp-=0.175
} if (!hurt) vine_climbing() 
	if (onvine) {
		dive=0
		pound=0
		_longjump=0
		crouch=0
		spinjump=0
		triplejump=0
	}

if (!flight && akey && size=3) {if vsp>1 {vsp=1 if random(5)>3 {i=instance_create(x,y+16,smoke) i.hspeed=-2+random(4)} } }
if (hang>0 && vsp>1 && !spinjump && !water) vsp=1.5

if (skidding) {soundstop("stanskid") skidding=0}
braking=0
braking=max(0,braking-1)

if (!fall && !spinjump) fall=1
if (pound=-1) pound=0
if (sprung && !fall) fall=1
if (fall=12) {vsp=6*wf hsp=0}
if fall=69 {dive=0 flight=0}
if !flight frame1flight=0

push=0
rise=0 risec=0
coyote=0
player_vertstep()
}
if (osld<180 && osld>0 && !instance_place(x-16,y+4,ground)) dy=3
else if (osld>180 && osld<320 && !instance_place(x-16,y+4,ground)) dy=3
if (!jump) {
//if (yground!=verybignumber) {y=yground while collision(0,0) && !collision(0,-8) {y-=1 }}
if (finish && ending="retainer" && !jump) coyote=0
if (!collision(0,4) /*&& (y<yground-2)*/) {
coyote+=1
if (down || !run) {y+=1 coyote=3}
if (coyote=3) {
jump=1
fall=1
if (crouch) vsp=1.5
if (spin) {vsp=-1.5 /*dropkick=1*/}
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

weight=0.5+0.5*!!size
bartype=1

if (gun_load){
	gun_load+=1
	if gun_load=20 {gun_loaded=1}

	if gun_load=60 {gun_load=0}
}

if !(pound) {
	nocratebounce=0
}

if (abs(hsp)>=2 && !jump) {
	if (mcs>8) {energy+=1 mcs=0}
} else if (!jump) if (mcs>30) {energy-=1 mcs=0}

is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1 ) is_intangible=1

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
//check for deathpits
if (dive) dive+=1
if (dive=3) dive=0
if (push=0 && hsp!=0 && braking) {
if (!skidding) {skidding=1 playsfx("stanskid",1)}
} else if (skidding) {soundstop("stanskid") skidding=0}
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

if (underwater()) {
	if (!water) {
		if (abs(vsp)>2) sound("itemsplash")
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
if (jump && size==7 && global.fastframe4 != ff4prev) {ff4prev = global.fastframe4 with instance_create(x, y, afterimagenoblend) {event_user(0) alphadecay=1 alarm[0] = 24 maxalarm = 24 maxalpha=0.8}}

twist=max(0,twist-1)
runvar=inch(runvar,run,0.05)
stomplok=max(0,stomplok-1)
wallkick=0
watrlock=max(0,watrlock-1)
throw=max(0,throw-1)
hang=max(0,hang-1)
swim=max(0,swim-1)
poundjump=max(0,poundjump-1)
wsk=(wsk+0.1) mod 4
if (spin) spinframe+=1
else spinframe=0
if (spinframe>=9) spinframe=9*!jump
if (sprung) {triplejump=0 triplexsc=0}

if (!jump && run && !(bkey || xkey)) run=0
if (!collpos(xsc*16,0) || !jump) hang=0
if (pound) {
	crouch=1
	hang=0
	if (pound<15) pound+=1
	else if (up || (water && vsp>5)) {pound=0 dive=-1 fall=0 insted=1 crouch=0 canstopjump=1}
	else fall=4
} else poundcancel=0
if (fall=6 && sign(hsp)=xsc) fall=1
if (rise!=0) {crouch=1 hsp=0 xsc=rise risec+=1 if (risec=10) {risec=0 rise=0 crouch=down}}
sprung=0
if (slipnslide) {
crouch=1
if ((slobal=0 && (hsp=0 || ((left || right) && !down))) || jump) && (!collision(0,-12) || !size || size==5) {slipnslide=0 crouch=0}
}
jumpspd=min(jumpspd,100)





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

jeezus=(((boost && vsp<4)||(size==5 && !down && abs(hsp)>2.8)) && !water)
if jeezus==1 {
    if !plat plat=instance_create(0,0,ground)
    plat.x=x-6
    plat.y=y-80
    plat.image_yscale=0.3
    with instance_place(x,y+4,waterblock) other.plat.y=y
    if plat.y=y-80 {
        if plat with plat instance_destroy() plat=0
    }
    else if instance_place(x,y+4,plat) && splashtime<=0 {splashtime=9 water_splash(-1)}
    splashtime-=1
} else {splashtime=0 plat.x=verybignumber plat.y=verybignumber if plat with plat instance_destroy() plat=0}

com_endactions()


#define enemycoll





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
        
       
        if (slipnslide && type!=spinyegg && type!=bulletbill) {
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            enemydie(coll)                
            exit
        }
        
        if (coll.object_index=lakitu) if (coll.flee) exit
    
        
        if (star  
        || coll.stankillontouch
        || (pound>13 && type!=piranha && type!=spinyegg && type!=spiny)) {
            if size==5 && !spin && !star && !coll.stankillontouch {if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"smalljump",0,3.6) vsp=-3-((ckey && spin) || (akey && star))*1.5 canstopjump=akey if !pound exit else pound=0}
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            if (type=hammerbro) seqcount=max(5,seqcount)
    if coll.stankillontouch {gun_load=1 gun_loadid=type}
    
            enemydie(coll)                
            exit
        }
        
    
        
        if (type=piranha || coll.damage_player_on_contact)  {
            hurtplayer("enemy")
            exit
        }
        
        if (spin) {
            if (type=shell) {if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else if (coll.type!="beetle") {enemydie(coll) exit}}
            else if (type=beetle) {if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else {hsp=0 jump=1 jumpspd=0.5 /*dropkick=1*/ spin=0 enemystomp(coll) exit}}
            else if (type=spinyegg) {hurtplayer("enemy") exit}
            else {if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else enemydie(coll) exit}
        }
                         
        if (type=spiny) {
            hurtplayer("enemy") exit
        }
        if (type=spinyegg) {
            if (punch && punch<=10) enemydie(coll) else hurtplayer("enemy") exit
        }                
                
        if (type=shell && !coll.time) {          
            if (coll.type="spiny" && (coll.vspeed-vsp)*coll.ysc<0) {
                hurtplayer("enemy") exit
            } else if (!coll.kicked || (coll.stop && (coll.owner=id || coll.vspeed>=0))) {
    { 
                    if (coll.stop && !coll.kicked && size!=5) doscore_p(8000)
                    else if size!=5 {seqcount=max(seqcount,2+scorelok1) doscore_p()}
                    if (jump) {
                        if (vsp>0) {
                            vsp=-3-akey*1.5
                            canstopjump=akey
                            if size==5 playsfx(name+"smalljump",0,3.6)
                            if (fall=12) fall=5
                            dive=0
                        }
                    }
                    if size!=5 {
                        kicksound(0)
                        instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
                        with (coll) {spd=max(3,abs(other.hsp)+1) hspeed=spd*esign(x-other.x,other.xsc) owner=other.id kicked=1 stop=0 phase=owner}
                    }
                }
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
                    if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey if fall=12 fall=5 exit}
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
                    else if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit}
                    else enemyexplode(coll) exit
                }
            } else {
                if (!calcfall && size!=5) {enemyexplode(coll) exit}
                if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey if fall=12 fall=5 exit}
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
            dive=0                   
            if size==5 {if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"smalljump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit}
            enemystomp(coll) exit      
        } else if (coll.vspeed<0 && coll.y>y+8) {if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit} else {jump=1 fall=1 dive=0 vsp=-0.5 enemystomp(coll) exit}}
        
        hurtplayer("enemy")   
    } else if (!star && !flash && !coll.stankillontouch) hurtplayer("enemy") 
	else if coll.stankillontouch {gun_load=1 gun_loadid=type instance_create(mean(x,coll.x),mean(y,coll.y),kickpart) enemydie(coll)}   
}        

#define hurt
pipe=0
sprongin=0
speed=0
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
dive=0
oldsize=size
jumpbuffer=0
hyperspeed=0
luijump=0
hp=0
star=0
if (super) stopsuper()   


if (((!size || size==5) || ohgoditslava) && !shielded && global.rings[p2]=0) {
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
    if (shielded) playsfx(name+"shielddamage")
    else playsfx(name+"damage")

    starhit=0

        fired=0
        if (shielded) {shielded=0} else if global.rings[p2]>0 {droprings(0)} else {if size>=3 size=2 size-=1}
        flash=1
        jump=1
        fall=6
		hurt=1
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
	hititembox()
}

#define hitwall
skiphsp=0
flight=0

if (dropkick || spin || flight || dive) {instance_create(x+8*s,y+6,kickpart) x-=hsp dropkick=-1 hsp=-2*esign(hitside,xsc) vsp=-2*spin jump=(jump || spin) spin=0 dive=0 crouch=1 skiphsp=1}

if (hurt) {hurt=0 fall=6 flash=1 fk=0}

if (!collpos(sign(hitside)*10,8,1)) {
    //gap running
    if (y<coll.y-12) {y=coll.y-14 coll=noone exit}
}

if (!skiphsp) hsp=0
hyperspeed=0         




#define landing
hang=0   
kicked=0
braking=0
double=0
flight=0
insted=0
if (hellothisisajump) jumptiming=6
hellothisisajump=0
if spin{spin=0}

spinjump=0
/*
    if (dropkick || (dive && ckey)) {spin=1 dropkick=0 spinframe=7+2*dive}
    else {
        dropkick=0
        if (((right-left=sign(hsp) || hsp=0) && (left || right)) && down && !pound && !water && !carry && !crouch) {spin=1 crouch=0 xsc=(right-left) hsp=2.5*xsc playsfx("stankick")}
    }
*/
dive=0

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
 

#define death
if (event="create"){
alarm0=60
alarm1=120
frame=0
sprite="deadair"
jump=1
frspd=1
frame=0
spindash=0
alpha=1
dest=0

if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
xsc=owner.xsc
ysc=owner.ysc
water=owner.water
frn=owner.frn
mask_index=global.playermask[p2]
alarm0=120


} 
else if (event="step"){
if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
//1.9 moment
alarm0=max(-1,alarm0-1)
if alarm0=0 {gravity=0.2 alarm0=-1}
else if alarm0<0 {
alarm1=max(0,alarm1-1)
if alarm1=0 dest=1

coll=collision(0,vspeed)
if (coll && vspeed>0 && jump) {
    jump=0
    y=coll.y-14
    speed=0
    gravity=0
}

if (jump) {sprite="deadair" owner.sprite="deadair"}
else {sprite="deadland" owner.sprite="deadland"}

if (dest) {c+=1 alpha=(c mod 5>2) if (c>60) instance_destroy()}


}
} else if (event="draw") {
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

if (skidding) {soundstop("stanskid") skidding=0}
braking=0
crouch=0
push=0
pound=0

#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}   
