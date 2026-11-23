#define spritelist
stand,wait,lookup,pose,crouch,knock,dead,walk,run,brake,spring,jump,jumpfired,fallfired,bonk,ball,bounceland,bounce,bouncefall,bouncelandfired,bouncefired,bouncefallfired,fired,push,hang,twirl,slide,firedown,climbing,flagslide,grind,piping,pipingup,sidepiping,doorenter,doorexit


#define soundlist
release,skid,spin,spindash,bounce,popgunshot


#define movelist
Fang
#
[a]: Bounce
[b]: Cork Shoot
[c]: Skip
[down]+[c]: Slide
Skip onto a Wall to Wall Bounce

#define rosterorder
14

#define skininit
var looper;

//custom hud
cushud=funnytruefalse(playerskindat(p2,string(name)+" use custom hud"))
customhudgun_screenx=nozerounreal(playerskindat(p2,name+" custom hud gun screen x"),16) //2.0 - 37
customhudgun_screeny=nozerounreal(playerskindat(p2,name+" custom hud gun screen y"),156)  //2.0 - 24

customhudammo_screenx=nozerounreal(playerskindat(p2,name+" custom hud ammo screen x"),27) //2.0 - 48
customhudammo_screeny=nozerounreal(playerskindat(p2,name+" custom hud ammo screen y"),174) //2.0 - 42

//graphic offsets
loopey=0
looper=0
repeat((projcoordbysize*MAXIMUMSIZESARGH)+1) {
	if (projcoordbysize) {
		looper=string(loopey)
	} else {looper=""}
	
	smallcork_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" small cork graphic x"+looper),10) 
	smallcork_sheety[loopey]=nozerounreal(playerskindat(p2,name+" small cork graphic y"+looper),88) 

	mediumcork_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" medium cork graphic x"+looper),10) 
	mediumcork_sheety[loopey]=nozerounreal(playerskindat(p2,name+" medium cork graphic y"+looper),105)
	
	bigcork_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" big cork graphic x"+looper),60) 
	bigcork_sheety[loopey]=nozerounreal(playerskindat(p2,name+" big cork graphic y"+looper),105) 
	
	customhudgun_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" custom hud gun graphic x"+looper),64) 
	customhudgun_sheety[loopey]=nozerounreal(playerskindat(p2,name+" custom hud gun graphic y"+looper),46) 
	
	customhudammo_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" custom hud ammo graphic x"+looper),114) 
	customhudammo_sheety[loopey]=nozerounreal(playerskindat(p2,name+" custom hud ammo graphic y"+looper),46) 
	
	fangenergybar_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" energy bar graphic x"+looper),125) 
	fangenergybar_sheety[loopey]=nozerounreal(playerskindat(p2,name+" energy bar graphic y"+looper),46) 
	
	loopey+=1
}

#define customhud

with other {
	spr=other.sheets[other.size]
	energy=other.energy
	bul1re=other.bul1re
	bul2re=other.bul2re
	bul3re=other.bul3re
	
	has1bul=other.has1bul
	has2bul=other.has2bul	
	has3bul=other.has3bul
	barfxtick=other.barfxtick
}

if (cushud){
	with (other) draw_sprite_part_ext(players[view_current].sheets[players[view_current].size],0,other.customhudgun_sheetx[other.size*other.owner.projcoordbysize],other.customhudgun_sheety[other.size*other.owner.projcoordbysize],47,36,other.customhudgun_screenx,other.customhudgun_screeny,1,1,$ffffff,gamemanager.hud_alpha[p2])
	if bul1re||has1bul with (other) draw_sprite_part_ext(players[view_current].sheets[players[view_current].size],0,other.customhudammo_sheetx[other.size*other.owner.projcoordbysize],other.customhudammo_sheety[other.size*other.owner.projcoordbysize],8,7,other.customhudammo_screenx,other.customhudammo_screeny-other.bul1re,1,1,$ffffff,gamemanager.hud_alpha[p2])
	if bul2re||has2bul with (other) draw_sprite_part_ext(players[view_current].sheets[players[view_current].size],0,other.customhudammo_sheetx[other.size*other.owner.projcoordbysize],other.customhudammo_sheety[other.size*other.owner.projcoordbysize],8,7,other.customhudammo_screenx+8,other.customhudammo_screeny-other.bul2re,1,1,$ffffff,gamemanager.hud_alpha[p2])
	if bul3re||has3bul with (other) draw_sprite_part_ext(players[view_current].sheets[players[view_current].size],0,other.customhudammo_sheetx[other.size*other.owner.projcoordbysize],other.customhudammo_sheety[other.size*other.owner.projcoordbysize],8,7,other.customhudammo_screenx+16,other.customhudammo_screeny-other.bul3re,1,1,$ffffff,gamemanager.hud_alpha[p2])
}else with other{

	
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+17,other.fangenergybar_sheety[other.size*other.projcoordbysize],16,8,16,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+17,other.fangenergybar_sheety[other.size*other.projcoordbysize],16,8,32,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+17,other.fangenergybar_sheety[other.size*other.projcoordbysize],16,8,48,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	if bul1re||has1bul
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+34,other.fangenergybar_sheety[other.size*other.projcoordbysize],bul1re*2,8,16,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	if bul2re||has2bul
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+34,other.fangenergybar_sheety[other.size*other.projcoordbysize],bul2re*2,8,32,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	if bul3re||has3bul
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+34,other.fangenergybar_sheety[other.size*other.projcoordbysize],bul3re*2,8,48,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	
	if has1bul
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize],other.fangenergybar_sheety[other.size*other.projcoordbysize],16,8,16,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	if has2bul
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize],other.fangenergybar_sheety[other.size*other.projcoordbysize],16,8,32,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	if has3bul
	draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize],other.fangenergybar_sheety[other.size*other.projcoordbysize],16,8,48,192,1,1,$ffffff,gamemanager.hud_alpha[p2])
}

with other {	
	//this renders in reverse
	if barfxtick
	if !other.cushud draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+112-9*floor(barfxtick/4),other.fangenergybar_sheety[other.size*other.projcoordbysize],8,8,16+(16*has1bul)+(16*has2bul)+(16*has3bul),192,1,1,$ffffff,gamemanager.hud_alpha[p2])
	else draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+112-9*floor(barfxtick/4),other.fangenergybar_sheety[other.size*other.projcoordbysize],8,8,other.customhudammo_screenx+(8*has1bul)+(8*has2bul)+(8*has3bul),other.customhudammo_screeny-8,1,1,$ffffff,gamemanager.hud_alpha[p2])
	
	i=0
	repeat other.maxte{
		draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+68,other.fangenergybar_sheety[other.size*other.projcoordbysize],16,8,16+i*16,192-8+8*other.cushud,1,1,$ffffff,gamemanager.hud_alpha[p2])
		i+=1
	}
	i=0
	repeat other.twirle{
		draw_sprite_part_ext(spr,0,other.fangenergybar_sheetx[other.size*other.projcoordbysize]+51,other.fangenergybar_sheety[other.size*other.projcoordbysize],16,8,16+i*16,192-8+8*other.cushud,1,1,$ffffff,gamemanager.hud_alpha[p2])
		i+=1
	}
}	

#define start
mask_set(12,12)


#define stop
if (skidding) {soundstop(name+"skid") skidding=0}
star=0
grow=0
hurt=0
braking=0
spindash=0
spin=0
push=0
super=0
boost=0



#define itemget
com_item()


#define grabflagpole
grabflagpole=1
hsp=0
vsp=0


#define endofstage
right=1
grabflagpole=0
if (hsp>=3 || push) {
akey=1
}


#define damager
//Makes bouncing safer
if (owner.fangbounce) 
{


	if debug draw_self()
	x=owner.x y=owner.y+10  image_yscale=6 image_xscale=6
	hittype="tail"
	
	coll=instance_place(x,y,collider)
	if (coll && owner.fangbouncedelay) {
		if (object_is_ancestor(coll.object_index,hittable)) {
		if (coll.object_index=brick) brickc+=1 else brickc=4
			hitblock(coll,owner,0,esign(coll.y-owner.y),1)
		}    
	}
	
	
	coll=instance_place(x,y,enemy)
	if (coll && !owner.fangbouncedelay && lastcoll!=coll) {                    
		global.coll=owner.id
		if coll.object_index=lavabubble{
		coll.vsp=2
		} else if (coll.object_index!=boo && coll.object_index!=piranha && coll.object_index!=shell && coll.object_index!=urchin) {
			with owner {
				do y=y-1 until (floor(y)<other.coll.bbox_top-2) //don't get stuck
				enemystomp(other.coll)
				lasthsp=hsp
				hsp=0
				vsp=0
				twirle=maxte
				
				if !fangbouncedelay fangbouncedelay=10
			}
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
	
	lastcoll=coll
	coll=noone
} else {y=-1000}

#define projectile
if (event="create") {
image_xscale=8
image_yscale=6

frame_sub=0
frame=0
brickc=0
seqcount=2
getregion(x) 
timer0=3
timer1=128
size=owner.size
if !owner.has3bul && owner.size {bigbul=1 image_yscale=8  image_xscale=10}


hspeed=xsc*3+owner.hsp*(xsc=sign(owner.hsp))
speed=median(2,speed,5)
playsfx("fangpopgunshot")
}
if (event="step") {
timer0-=1 if (timer0=0) visible=1
timer1-=1 if (timer1=0) instance_destroy()
calcmoving()

frame_sub=!frame_sub
if frame_sub frame+=1
if (frame>=3) frame=0

if (!inview()) instance_destroy()
xsc=sign(hspeed)
if (!waterdust){
coll=instance_place(x,y,collider)
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll.object_index=brick) brickc+=1 else brickc=2
hitblock(coll,owner,1,-1,0)
} else brickc=2
instance_create(x,y,kickpart)     
if (brickc=2) {sound("itemblockbump") instance_destroy()}
}

coll=instance_place(x,y,enemy)
if (coll) {
if (coll.object_index!=beetle && coll.object_index!=bombenemy 
&& coll.object_index!=drybones && coll.object_index!=boo 
&& coll.object_index!=urchin && coll.object_index!=pokey 
&& coll.object_index!=pokeybody) {
yes=1
if (coll.object_index=shell) if (coll.type="beetle") yes=0
if (yes) {
global.coll=owner.id  
instance_create(x,y,kickpart)  
instance_destroy()
enemydie(coll,2)
}
}
instance_destroy()
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

coll=instance_place(x,y,player)
if (coll) {
if (coll.id!=owner) if (!invincible(coll)) {    
if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) instance_destroy() exit}
with(coll) fragplayer(other.owner)
}
instance_create(x,y,kickpart) instance_destroy()
}
}
} else{
timer0=0
visible=1
if timer1>10 timer1=10 
efxfr=efxfr+0.5 
hspeed=(sign(owner.xsc)*(-3/efxfr*2))
xsc=sign(hspeed)
}
}
if (event="draw") {
if !bigbul draw_sprite_part_ext(sheet,0,owner.smallcork_sheetx[size*owner.projcoordbysize]+25*ceil(frame/2),owner.smallcork_sheety[size*owner.projcoordbysize],24,16,round(x-12*xsc),round(y-8),xsc,1,$ffffff,1)
else draw_sprite_part_ext(sheet,0,owner.mediumcork_sheetx[size*owner.projcoordbysize]+25*ceil(frame/2),owner.mediumcork_sheety[size*owner.projcoordbysize],24,16,round(x-12*xsc),round(y-8),xsc,1,$ffffff,1)
}


#define sprmanager
frspd=1
keepframebetween=0
prevent_spr_reset=0
cantslowanim=0

if (grabflagpole) {sprite="flagslide"}
else if (hurt) {sprite="knock"}
else if (spindash) {sprite="spindash"}
else if (crouch && !fangbouncedelay) { if fired {sprite="firedown" cantslowanim=1} else {sprite="crouch" if (oldspr="firedown") prevent_spr_reset=1} if abs(hsp)>0.5 sprite="slide"}
else if twirl {sprite="twirl"}
else if (jump) {
if (onvine) 
{
sprite="climbing" frspd=sign(left+right+up+down)
}
	else if (sprung) {
		if fired {
			if (vsp<=0) sprite="jumpfired" else sprite="fallfired"
			if (oldspr="bouncefired" || oldspr="bouncelandfired" || oldspr="bouncefallfired") keepframebetween=1
			else if (oldspr="fired" || oldspr="firedown") prevent_spr_reset=1
			cantslowanim=1
		} else sprite="spring" if (vsp>=0) {sprung=0 fall=1}
	}
    else if (fangbounce) if fired {
		if (vsp<=0) sprite="bouncefired" else sprite="bouncefallfired"
		if (oldspr="jumpfired" || oldspr="bouncelandfired" || oldspr="bouncefallfired") keepframebetween=1 
		else if (oldspr="fired" || oldspr="firedown") prevent_spr_reset=1
		cantslowanim=1
	} else {if (vsp<=0) sprite="bounce" else sprite="bouncefall"}
    else if (bonk) sprite="bonk"
    else {
		if fired {
			if (vsp<=0) sprite="jumpfired" else sprite="fallfired"
			if (oldspr="bouncefired" || oldspr="bouncelandfired" || oldspr="bouncefallfired") keepframebetween=1
			else if (oldspr="fired" || oldspr="firedown") prevent_spr_reset=1
			cantslowanim=1
		} else if (fall=6) {sprite="knock"} else if (vsp<=0) sprite="spring" else sprite="jump"
	}
} else {
    if (spin) {sprite="ball" frspd=0.5+abs(hsp/3)}
	else if (fangbouncedelay) if fired {
		sprite="bouncelandfired" 
		if (oldspr="bouncefired" || oldspr="jumpfired") keepframebetween=1 
		else if (oldspr="fired" || oldspr="firedown") prevent_spr_reset=1
		cantslowanim=1
	} else {sprite="bounceland"}
    else if (push!=0) {sprite="push" frspd=1+abs(hsp/3)}
    else if (hsp=0) {
		if (fired) {if crouch {sprite="firedown" if (oldspr="fired") prevent_spr_reset=1 cantslowanim=1} else {
			sprite="fired" 
			if (oldspr="bouncefired" || oldspr="jumpfired" || sprite="bouncelandfired" || sprite="firedown") keepframebetween=1 
			cantslowanim=1}
		}
        else if (hang) {sprite="hang"}
        else if (pose) sprite="pose"
        else if (lookup) {sprite="lookup"}
        else if (waittime>maxwait) {sprite="wait"}
        else {sprite="stand"}
    } else {
        if (braking) sprite="brake"
        else if (abs(hsp)>maxspd*0.9 && !water && !finish) { if fired sprite="fired" else sprite="run" frspd=abs(hsp/3)}
        else {if fired sprite="fired" else sprite="walk" frspd=0.2+abs(hsp/4)}
    }
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

if (up && (!hang || !size || size==5)) {
    if (hsp=0 && !jump) lookup=1
    else lookup=0
} else lookup=0
if fangbouncedelay && !fangbouncecooldown {hsp=0 vsp=0}
if fangbouncecooldown fangbouncedelay=0
//list of things that prevent you from moving
if (spindash || (crouch && !jump) || (super && fall=10) || vinegrab || grabflagpole || move_lock) h=0

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
        if (!jump && !spin && !crouch && !firedash) {
            push=h
            xsc=h
            braking=0
        }
    } else {
        if (spin) {
            if (sign(hsp)!=h) hsp+=h*0.05*wf
        } else {
            if (!jump) {
                if (sign(hsp)!=h) {
                    if (abs(hsp)>maxspd*0.8) {
                        braking=1
skidding=1
playsfx(name+"skid")
                        brakedir=h
                    }
                    hsp+=0.33*wf*h
                    if (abs(hsp)<0.5) if (!firedash) xsc=h
                } else {
                    hsp+=0.06*wf*h
                    if size==5 hsp+=0.02*wf*h
                    braking=0
                    if (!firedash) xsc=h
                }
            } else {
                hsp+=0.08*wf*h
if fangbouncedelay hsp=0
                if (!firedash) xsc=h
else collwin=instance_place(x+hsp,0,goalblock)
if collwin {hsp=0 fallsprite="dash" collwin.owner=id with collwin{ event_user(4)}}
            }
        }
    }
}

if (push!=h) push=0

com_di()

//code for specifically the a button
if ((abut || jumpbufferdo) && (!springin)) {
    if (!jump||vinegrab||fall=69||grabflagpole) { //jump
		jumpsnd=playsfx(name+"jump",0,1+((size==5)/3))
		vinegrab=0
        vsp=-5.2-0.2*super

        if (water) vsp=-sqrt(sqr(vsp)*wf+2)

		onvine=0
        grabflagpole=0
        latchedtoflagpole=0
        //change jump angle in steep slopes
        vd=point_direction(0,0,hsp,vsp)+point_direction(0,0,1,slobal/2)
        vm=point_distance(0,0,hsp,vsp)
        hsp=lengthdir_x(vm,vd)
        vsp=lengthdir_y(vm,vd)

		sprite_angle=0
		TIMETOTAKEAPISS=0

        jump=1
	if (size==7) luijump=9
        fall=4
        braking=0
        spin=0
        canstopjump=1
        if (mymoving) hsp+=avgmovingh
        crouch=0
        if (spin && !star) seqcount=0
        fallspd=min(1,0.5+abs(hsp)/5)	
    } else { //air jumps
		TIMETOTAKEAPISS=1
    }
}
jumpbufferdo=0
springin=0

if (akey) {
    if TIMETOTAKEAPISS {fangbounce=1 fall=4}
if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {
    if (canstopjump=1 && jump && vsp<-2 && !sprung) {
        vsp*=0.5
    }
if (fangbounce=1 && !fangbouncedelay){

fangbounce=0
//vsp*=0.5
}
    canstopjump=0
	luijump=0
}

//code for specifically the b button
if (bbut && (has1bul||has2bul||has3bul)) {
	if has3bul=1 {has3bul=0 bul3re=0}
	else if has2bul=1 {has2bul=0 bul2re=bul3re bul3re=0}
	else if has1bul=1 {has1bul=0 bul1re=bul2re bul2re=bul3re bul3re=0}
	ready2shoot=0
	i=shoot(x+4*xsc,y-2+(8*crouch),psmoke,2*xsc) i.depth=depth+2
	//if (abs(hsp)>0.75&&!jump) {jump=1 vsp=-2 hsp+=sign(hsp)}
	fire_projectile(x+8*xsc,y+(8*crouch)-2)
	//fired=30
	fired=firelength
	barfxtick=16
	frx=0
	fr=0
	if (sprite="fired" || sprite="firedown" || sprite="jumpfired" || sprite="bouncefired" || sprite="bouncelandfired") frame=0
}


if cbut {
	if !fangbouncedelay twirl=20
	jump=1 
	fall=0
	grabflagpole=0
    latchedtoflagpole=0
	onvine=0
	if (twirle || (crouch && !jump) && !fangbouncedelay) {
		if abs(hsp)<=3
		hsp=3*xsc
		hyperspeed=1.5*xsc 
		if !(crouch) {vsp=-1.5} 
		else{twirl=0 jump=0 hyperspeed=0} 
		if (!instance_place(x+(xsc*16),y,collider) || instance_place(x+(xsc*16),y,finalwall) || instance_place(x+(xsc*16),y,barrier)) twirle-=1
	}

}

//crouching and spinning
if (down && !up) {
    if (!jump && !braking && !spin) { 
crouch=1
//hsp*=0.95        
    }
    com_piping()
} else {
    if (!jump) crouch=0
}

if (size==5) mask_set(9,8) //please dont ask why the width has to be 9 pipes are weird and wacky and this is the only way i got to stop players from getting stuck in pipes and turning invisible/
else if (spin|| crouch || fall=5 || size=0) mask_set(12,12)
//else if (jump && (!fall || fly || fall=10)) mask_set(12,15)
else mask_set(12,24)


#define movement
if (piped || move_lock) exit

//speed limits
if (!jump) if (loose || spin || crouch) {
    braking=0
    frick=0.06
    //if (slide) frick=0.005 //not my slide bro
    hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

//speed cap rubberband formula
maxspd=(2.7 + !!size*0.5 + (size==5)*0.55  + spin + (fall==10)*0.5)*wf
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)

vsp=min(7+downpiped,vsp)

///movement
//hi moster here dont uncomment the yground or easyground stuff because its required for the cool new slope system to work
//for anyone porting a charm from unfinished build or below to this build, delete or comment all of the commented code and add player_nslopforce()
calcmoving()

if (!dead && !grabflagpole) {
    player_horstep()
    player_nslopforce()
    //yground=easyground()
//if (yground!=verybignumber) yground-=14
    if (jump) {
        //gravity
        hang=0
        if (fall=10 && super) {
            hsp+=(right-left)*0.25
            if (name="ashura") vsp+=(down-up)*0.15-0.075
            else vsp+=(down-up)*0.15+0.05+0.1*max(0,2-abs(hsp))*(vsp<2)
            l=median(0,point_distance(0,0,hsp,vsp)-0.05,3)
            d=point_direction(0,0,hsp,vsp)
            hsp=lengthdir_x(l,d)
            vsp=lengthdir_y(l,d)
            xsc=esign(hsp,xsc)
        } else {
            if !fangbouncedelay && !luijump vsp+=0.15*wf-(size=5 && vsp>-0.35 && !water)*0.075
        }

if (!hurt) vine_climbing()
        crouch=0
        spindash=0
        braking=max(0,braking-1)
        if (sprung && !fall) fall=1
        push=0 spin=0
        coyote=0
osld=0
player_vertstep()
if (!jump) sld=point_direction(0,0,1,slobal)
    }

sprite_angle=0
if (osld<180 && osld>0 && !instance_place(x-16,y+4,ground)) dy=3
else if (osld>180 && osld<320 && !instance_place(x-16,y+4,ground)) dy=3

    if (!jump) {
//if (yground!=verybignumber) y=yground
osld=sld
sld=point_direction(0,0,1,slobal)
if (!jump && slide) {
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
fallspd=frspd
spin=0
crouch=0
}
        } else coyote=0
        if (jumpbuffer=-1) {
            jumpbuffer=0
            //jump buffering
            if (rise=0 && !down) {
                jumpbufferdo=1
            }
        }
    }
}
com_finishmove()

#define actions
com_warping()
com_actions()
if size!=5 maxte=size-1//feather gets 2 and fire gets 1 now
if maxte<=0 maxte=1
if (size=0 || size==5) maxte=0
if super maxte=3
weight=0.4+0.4*!!size
bartype=0

if (!jump || onvine) twirle=maxte

twirl-=1

is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1 || flash) is_intangible=1

power_lv=0
is_coinexplosive=0
if (spindash || spin || (jump && (!fall || fall=5))) power_lv=1
if (star) power_lv=5
if (super) power_lv+=1

if (piped) exit

//Special interactions
pvp_spin=spin //rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=1 //make sure to set for 0 for the mario bros when pounding
pvp_ignore=0 //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away

//Fang bounce delay
if !fangbouncecooldown
fangbouncedelay-=1
else fangbouncecooldown-=1
if (fangbouncedelay=1 && !hurt && !sprung) {
	jump=1
	vsp=-5
	playsfx("fangbounce")
	hsp=abs(lasthsp)*(right-left)
	fangbouncedelay=0
	fangbouncecooldown=10
}

var springe;
springe=(instance_place(x+hsp,y+vsp,spring) || instance_place(x,y+1,terrainspring) || coll=spring || coll=terrainspring)

if (springe || sprung) {
	fangbouncedelay=0
	fangbounce=0
	fangbouncecooldown=0
}


//Bullet reload
if !fired{
if has3bul {ready2shoot=1}
else if has2bul {if bul3re<9 bul3re+=(0.2)/1.5}
else if has1bul {if bul2re<9 bul2re+=(0.2)/1.5}
else if bul1re<9 bul1re+=(0.2)/1.5

if bul1re=8 has1bul=1
if bul2re=8 has2bul=1
if bul3re=8 has3bul=1
}

//Bar managin'
if !(cushud){
//maxe=6
if has3bul energy=6
else if has2bul energy=4
else if has1bul energy=2
else energy=0
}
if abs(hyperspeed)>0.1 boost=1
if (boost) {
    if (hurt && !super) boost=0
    if (point_distance(0,0,hsp,vsp)<2.5) boost=0
}

//energy bar effect
if (barfxtick) barfxtick-=2

//sliding
slide=crouch && abs(hsp)>0.5
slipnslide=slide

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
    if ((sprite="stand" && hsp=0) || hang) {
        image_xscale=1/6
        hang=(!instance_place(x,y+4,collider) && instance_place(x-7*xsc,y+4,collider))
        image_xscale=1
    } else hang=0

    //skidding
    if (push=0 && hsp!=0 && braking) {
        playsfx(name+"skid")
skidding=1
    } else if (skidding) {soundstop(name+"skid") skidding=0}
}

//w?ter
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
}

if (jump && size==7 && global.fastframe4 != ff4prev) {ff4prev = global.fastframe4 with instance_create(x, y, afterimagenoblend) {event_user(0) alphadecay=1 alarm[0] = 24 maxalarm = 24 maxalpha=0.8}}

if (super) boost=1

//spindash/spin
global.coll=id
if (spindash || spin) {
    coll=instance_position(x-10*sign(hsp),y+22,hittable)
    coll2=instance_position(x,y+22,hittable)
    
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
            if (spindash>3) boost=1
            spin=1
            hsp=xsc*4*(0.75+0.25*median(0,spindash-1,2)/2)
            spindash=0
            
                soundstop(name+"spindash")
                playsfx(name+"release")
            
        }
        if (hsp!=0) spindash=0
    }
    
    //stop spinning
    if (abs(hsp)<0.2 && spin) { 
        spinc+=1 if (spinc=8) {spinc=0
            spin=0    
            hsp=0
            soundstop(name+"spin")
            /*if (name!="mario") */crouch=down            
        }
    }
} else spinblacklist=noone

jesus=(((boost && vsp<4)||(size==5 && !down && abs(hsp)>3.2)) && !water && !fangbounce)

com_endactions()


#define enemycoll
//Code that defines collision with enemies
if (hurt || piped || (intangible() && !diggity)) exit

coll=noone extracheck=id inst=0


with (pswitch) if (phase!=other.id && !lock) {
    mask_index=spr_cratemask
    if (instance_place(x,y-other.vsp-16*!!other.diggity,other.id)) other.coll=id
    mask_index=spr_mask16x16
}
with (enemy) if (phase!=other.id && !lock)
    if (instance_place(x,y-other.vsp-16*!!other.diggity,other.id)) other.coll=id

if (coll) {
    if (!coll.damage_player_on_contact) {
    insted=0
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
        || ((spin||crouch&&hsp!=0) && type!=spinyegg && type!=beetle && type!=koopa && !object_is_ancestor(type,koopa) && type!=shell)
        || (pound>13 && type!=piranha && type!=spinyegg && type!=spiny)) {
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            if (type=hammerbro) seqcount=max(5,seqcount)
            enemydie(coll)                
            exit
        }
        
        if (spindash || inst || firedash) {if (diggity=32) exit enemyexplode(coll) exit}
        
        if (type=piranha) {
    if fangbounce {if !fangbouncedelay fangbouncedelay=10} else
            hurtplayer("enemy")
            exit
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
					if fangbounce {fangbouncedelay=10 hsp=0}
                    else if (jump) {
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
            if (type=koopa || type=beetle || object_is_ancestor(type,koopa)) {
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
        } else if (coll.vspeed<0 && coll.y>y+8) {jump=1 fall=1 vsp=-0.5 enemystomp(coll) exit}
        
        hurtplayer("enemy")   
    } else hurtplayer("enemy")
}    

#define hurt
pipe=0
sprongin=0
speed=0
if (skidding) {soundstop(name+"skid") skidding=0}
if (carry && carryid) {with (carryid) event_user(0) carryid=noone carry=0}

energy=0
braking=0
sprung=0
diggity=0
grow=0
fairdash=0
gianadash=0
gk=0
fk=0
luijump=0
punch=0
bounce=0
twirl=0
oldsize=size
jumpbuffer=0
hyperspeed=0
hp=0
star=0
TIMETOTAKEAPISS=0
if (super) stopsuper()   

if ((!size || size==5 || ohgoditslava) && !shielded) {
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
    playsfx(name+"damage")

    starhit=0
    
jump=1 hurt=1+starhit if (!starhit) if (shielded) {shielded=0} else {if size=3 || size=6 || size=7 size-=1 size-=1} hsp=xsc*-2*wf vsp=-3*wf
    
}


//Block hitting

#define hitblocks
if typeblockhit=0{
with (blockcoll){
if (stonebump || (owner.fangbouncedelay && instance_place(x,y-1,owner)) || owner.size=0 && owner.size!=5 && insted!=1 && !owner.tempkill && cracked=0) {
    if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
} else if (owner.size!=5 || !owner.fangbouncedelay) { 
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
  } else if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
 }
} else if typeblockhit=1{
hititembox()
}

#define hitwall
//hit blocks sideways
if (twirl && knuxcanclimb(coll)){
	lasthsp=-hsp
	hsp=0
	fangbouncedelay=10
	twirl=0
	vsp=0
}


if ((spin||crouch) && abs(hsp)>0.5) {
    global.coll=id
    with (hittable) if (instance_place(x-other.hitside,y,other.id)) {	
		if global.coll.firedash go=sign(global.coll.vsp) else go=-1
        insted=1
        event_user(0)
		insted=0
    }
    coll=collision(hitside,0)
    if (firedash && jump) {fall=5 vsp=0}
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
airdash=0
twirl=0
/*if (fired) {
    frame=(unreal(skindat(name+" "+sprite+" loop"),0))-1
}*/


if (fangbounce && !hurt && !springe){
	lasthsp=hsp
	hsp=0
	fangbouncedelay=10 
}

var stream;
stream=instance_place(x,y,jetstream)
if (stream) {
	if (stream.dir==90) {
		fangbouncedelay=0
		fangbounce=0
		fangbouncecooldown=0
	}
}

if (downpiped) {
	shoot(x-8,y+4,psmoke,-2,-1)
	shoot(x+8,y+4,psmoke,2,-1)    
    downpiped=0
}
if (hurt) {flash=1 fk=0 hsp=0 hurt=0}

playsfx(name+"step")

//jump buffering
if (jumpbuffer) jumpbuffer=-1

//jump into tiny space
if (insted!=2 && !spin) {
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

alarm0=30
alarm1=300
sprite="dead"
frame=0
frspd=1
spindash=0
alpha=1


if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
xsc=owner.xsc
ysc=owner.ysc
water=owner.water
frn=owner.frn
vspeed=-3.5 gravity=0.1

} 
else if (event="step"){
if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
alarm0=max(0,alarm0-1)
alarm1=max(0,alarm1-1)

if alarm1=0 instance_destroy()
} else if (event="draw"){
//no more spriteswitch *vineboom*
}


#define enterpipe
if (type="side") {
	if (firedash) {fastpipe=1 hspeed=xsc*3 set_sprite("run") frspd=1}
	if (boost) {fastpipe=1}
}
if (type="up") {
	//set_sprite("fly")	
}
if (type="down") {}

if (skidding) {soundstop("fangskid") skidding=0}
braking=0
crouch=0
push=0     



#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}
