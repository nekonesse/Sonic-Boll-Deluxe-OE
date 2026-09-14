#define spritelist
stand,lookup,wait,pose,run,jump,ball,thwick,dead,climbing,flagslide


#define soundlist
release,skid,spin,damage,die,thok,boom


#define movelist
Earless
#
[a]: Thok (air)
[b]: Ring Sling


#define rosterorder
999999


#define start
if (!size) size=1
mask_set(12,24)
wack=1  //thok fix

#define stop
star=0
grow=0
hurt=0
spin=0

#define itemget
if (type="jumprefresh") {
	insted=0
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
		if (!super && size<3) grow=1
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
        itemget=1
    }   
}
if (type="coin") {
	if (name!="kid") {
		sound("itemcoin")
		if (other.fresh) global.scor[p2]+=100
		global.coins[p2]+=1
		coint+=1
		hit=1
	}
	itemget=1	
}

#define grabflagpole
grabflagpole=1
hsp=0
vsp=0

#define endofstage
right=1
grabbedflagpole=0
if (hsp>=3 || push) {
	akey=1
}


#define damager
//None

#define projectile
if (event="create") {
image_xscale=8
image_yscale=4

frame_sub=0
frame=0
brickc=0
seqcount=2
getregion(x) 
timer0=3
timer1=128

hspeed=xsc*5*(xsc=sign(owner.xsc))
speed=median(2,speed,5)
playsfx("earlessboom")
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
ignoreoncount=1
if (!waterdust && !feathdash){
ignoreoncount=0
coll=instance_place(x,y,collider)
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll.object_index=brick) brickc+=1 else brickc=4
hitblock(coll,owner,1,-1,0)
} else brickc=4
instance_create(x,y,kickpart)     
if (brickc=4) {sound("itemblockbump") instance_destroy()}
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
if timer1>14 timer1=14 
if timer1=14 setxsc=owner.xsc
efxfr=efxfr+0.25 
if waterdust{
hspeed=(sign(setxsc)*(-3/efxfr*2))
xsc=sign(hspeed)
}
else {xsc=setxsc hspeed=-setxsc}


}
}
if (event="draw") {
if !waterdust && !feathdash{
draw_sprite_part_ext(sheet,0,10+25*frame,88,24,24,round(x-12*xsc),round(y-8),xsc,1,$ffffff,1)
}
else if !feathdash{
draw_sprite_general(global.effectssheet[biome],0,8+25*floor(efxfr),158,24,24,x,round(y-8)-13,-1,-xsc,90,$ffffff,$ffffff,$ffffff,$ffffff,1)
draw_sprite_general(global.effectssheet[biome],0,8+25*floor(efxfr),158,24,24,x,round(y-8)+15,1,-xsc,90,$ffffff,$ffffff,$ffffff,$ffffff,1)
if efxfr<3{draw_sprite_general(global.effectssheet[biome],0,8+25*floor(efxfr*2),183,24,24,x,round(y-8)+18,1,-xsc,90,$ffffff,$ffffff,$ffffff,$ffffff,1)}
} 
else {
draw_sprite_part_ext(owner.sheets[3],0,227+40*floor(efxfr),46,39,39,round(x-19.5*xsc),round(y-19.5)+4,xsc,1,$ffffff,owner.alpha)
savedepth=depth
depth=owner.depth+1
draw_sprite_part_ext(owner.sheets[3],0,227+40*floor(efxfr),86,39,39,round(x-19.5*xsc),round(y-19.5)+4,xsc,1,$ffffff,owner.alpha)
depth=savedepth
}
}

#define sprmanager
frspd=1
if (transform) {sprite="transform"}
if (grabflagpole) {sprite="flagslide"}
else if (crouch) {sprite="ball" frspd=0}
else if (jump) {
if (onvine) {sprite="climbing" frspd=sign(left+right+up+down)}
else if (thokkin) {sprite="thwick"}
else sprite="jump" frspd=fallspd}
else {
    if (spin) {sprite="ball" frspd=0.5+abs(hsp/3)}
    else if (hsp=0) {
        if (pose) {sprite="pose"}
	else if (lookup) {sprite="lookup"}
        else if (waittime>maxwait) {sprite="wait"}
        else {sprite="stand"}
    } else {sprite="run" frspd=max(0.5,abs(hsp/3))}
}


#define controls
com_inputstack()

//gonna make a buffer so earless can do his dorifto stuff
if (h=0) {if (!dirbuffer) dirbuffer=1}
else {dirbuffer=0 bufferdone=0}
if (dirbuffer && !bufferdone) {
lasttime=timeaccel
dorifto=8
bufferdone=1
}
dorifto=max(0,dorifto-1)

tempbrick=0

//situations in which it should skip controls entirely
if (hurt || piped) {
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
if (vinegrab || grabflagpole) h=0

//movement

//NANI
if (dorifto) timeaccel=lasttime
if (hsp!=0) {timeaccel=min(2,timeaccel+0.05)}
else if (!jump) timeaccel=0
if (!insted) hsp=2*h*max(0.1,timeaccel)
else hsp+=right-left

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
            xsc=h
        }
    } else {
        if (jump) {
            collwin=instance_place(x+hsp,0,goalblock)
            if collwin {hsp=0 collwin.owner=id with collwin{ event_user(4)}
            }
	xsc=right-left
        }
        else xsc=h
    }
}

com_di()

//code for specifically the a button
if ((abut || jumpbufferdo) && (!springin)) {
    if (!jump||fall=69||grabflagpole) { //jump
        jumpsnd=playsfx(name+"jump")
        onvine=0
        vsp=-5.2-0.2*super

        if (water) vsp=-sqrt(sqr(vsp)*wf+2)
	grabflagpole=0

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
        if (mymoving) hsp+=avgmovingh
        crouch=0
        if (spin && !star) seqcount=0
        fallspd=min(1,0.5+abs(hsp)/5)
    } else { //air jumps
//had to swap the "insted" variable out for "wack" for the thok, since the thok cancels no matter what if you're fire
//it still registers for other things it's just really for here
	if (fall=0 && wack){
	//thoks
	
	hsp=5.5*xsc
        vsp=0 
	thokkin=1
	insted=1
	wack=0
        if (size=3) {hsp=4.5*xsc vsp=-3} //jump thok
	if (size=2) {wack=1}
	playsfx(name+"thok")
        }
        jumpbuffer=4*!jumpbufferdo
    }
}

jumpbufferdo=0
springin=0

if (akey) {
///ceiling sticking
if  //stickable table

//do not
(!instance_place(x,y-4,phaser) && 

//ok you can
instance_place(x,y-4,ground) || instance_place(x,y-4,moving)

) {//sticking
canistick=1 vsp=-0.15 if (vsp>0) {vsp=-0.15}

}

    if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {
    if (canstopjump=1 && jump && vsp<-2 && !sprung) {
        vsp*=0.5
    }
canistick=0
    canstopjump=0
}

if (bbut) {
           //ringslinger
        if (!count_projectiles() && global.coins[p2]>0) {
		    fire_projectile(x+8*xsc,y+2) 
			global.coins[p2]-=1
            fired=16
			}
      

    }

//crouching and spinning
if (down && !up) {
    if (!spin && !jump) {
        if (abs(hsp)<0.5) {
            crouch=1
        } else if (!spin) {
            spin=1
            crouch=0
            playsfx(name+"spin")
        }
    }
    com_piping()
} else {
    if (!jump) crouch=0
}

if (spin || spindash || crouch || fall=5 || jump && !fall) mask_set(12,12)
else mask_set(12,24)


#define movement
if (piped) exit

//speed limits
if (!jump) if (loose || spin || crouch) {
    braking=0
    frick=0.06
    if (spin) frick=0.005
    hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

//speed cap rubberband formula
maxspd=(3.5 + thokkin)*wf
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)

vsp=min(7+downpiped,vsp)

//movement
calcmoving()

if (!dead && !grabflagpole) {
if fall!=69
    player_horstep()
    yground=easyground()
if (yground!=verybignumber) yground-=14
    if (jump) {
        //gravity
        hang=0
if fall!=69 || !canistick {
            vsp+=0.15*wf
        }
		vine_climbing()
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
if (yground!=verybignumber) y=yground
osld=sld
sld=point_direction(0,0,1,slobal)
if (!jump && abs(hsp)>1.5) {
diff=anglediff(sld,osld)
if (sign(diff)=sign(hsp) && diff*sign(hsp)>20 && sld=0) {
jump=1 fall=1 fallspd=min(1,0.5+abs(hsp)/5)
y=min(y,yp)
hsp=lengthdir_x(hsp,osld) vsp=-abs(lengthdir_y(hsp,osld))*1.5 // coolness factor
}
}

        if (finish && ending="retainer" && !jump) coyote=0
        if (!collision(0,4) && (y<yground-2)) {
            coyote+=1
            if (coyote=3) {
jump=1
fall=0
fallspd=min(1,0.5+abs(hsp)/5)
if (spin) fall=5
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

weight=0.4+0.4*!!size
bartype=0

is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1 || flash) is_intangible=1

power_lv=0
is_coinexplosive=0
if (spin || (jump && (!fall || fall=5))) power_lv=1
if (star) power_lv=5
if (super) power_lv+=1

if (piped) exit
                            
    //if (luckythok) luckythok-=1
    //glitchtime+=1
    //if (glitchtime>50) glitchtime=-2

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
}

//w?ter
if (underwater()) {
    if (!water) {
        if (abs(vsp)>2) water_splash(1)
        vsp=min(1,vsp/2)
    }
    water=1
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
//flyaway coins lose the player intangibility if they touch something and keep existing offscreen
//solution: micromanagement

with (coin) if (youshouldstopcollidingNOW=1) {

{mask_index=-1 sprite_index=-1 if !inview() instance_destroy()
alarm1-=1
if alarm1<=0 instance_destroy()
}
}

//spring flip thing idk 
if (sprung){
if (!havespringflipped){hsp=hsp*-1 havespringflipped=1}
}
if (!sprung){havespringflipped=0}

maxe=0
if (boost) {
    if (hurt && !super) boost=0
    if (point_distance(0,0,hsp,vsp)<2.5) boost=0
}
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
    if (abs(hsp)<0.1 && spin) { 
        spinc+=1 if (spinc=8) {spinc=0
            spin=0    
            hsp=0
            soundstop(name+"spin")
            if (name!="mario") crouch=down            
        }
    }
} else spinblacklist=noone

jesus=(boost && vsp<4 && !water)

com_endactions()


#define enemycoll
//Code that defines collision with enemies

if (random_range(1,4)>3 && !star && !intangible()) {hurtplayer()}

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
    || (spin && type!=spinyegg && type!=beetle && type!=shell)
    || (pound>13 && type!=piranha && type!=spinyegg && type!=spiny)) {
        instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
        if (type=hammerbro) seqcount=max(5,seqcount)
        enemydie(coll)                
        exit
    }
    
    if (spindash || inst || firedash) {if (diggity=32) exit enemyexplode(coll) exit}
    
    if (type=piranha) {
        hurtplayer("enemy")
        exit
    }
    
    if (spin) {
        if (type=shell) {if (coll.type!="beetle") {enemydie(coll) exit}}
        else if (type=beetle) {hsp=0 jump=1 jumpspd=0.5 spin=0 enemystomp(coll) exit}
        else if (type=spinyegg) {hurtplayer("enemy") exit}
        else {enemydie(coll) exit}
    }
                     
    if (type=spiny) {
        if (!fall && vsp<0) enemyexplode(coll)
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
                else enemyexplode(coll) exit
            }
        } else {
            if (!calcfall) {enemyexplode(coll) exit}
            if (vsp<0) {hurtplayer("enemy") exit}
        }
        
        if (type=goomba && seqcount=1 && !scorelok4) {seqcount=0 scorelok4=1}    
        if ((type=koopa || type=redkoopa) && seqcount=1) scorelok1=1    
        if (type=hopkoopa || type=redhover) seqcount=max(seqcount,1)
        if (type=hammerbro) seqcount=max(5,seqcount)
        if (fall=12) fall=5                        
        enemystomp(coll) exit      
    } else if (coll.vspeed<0 && coll.y>y+8) {jump=1 fall=1 vsp=-0.5 enemystomp(coll) exit}
    
    hurtplayer("enemy")   
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
punch=0
bounce=0
twirl=0
oldsize=size
jumpbuffer=0
hyperspeed=0
hp=0
star=0
if (super) stopsuper()   

if ((size=1 && global.coins[p2]=0 || ohgoditslava) && !shielded) {
   if (global.mplay>1 || global.debug || global.lemontest) alarm[7]=120
		if (global.gamemode="battle") {		
		//bro's already lost everything by the time you kill him, and we're not gonna create coins out of thin air for you to have some
		}
   
   
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
                                     //gotta love that global.coins[p2]              //my favorite 
	jump=1 hurt=1+starhit if (!starhit) if (shielded) {shielded=0} else {
if size>1 size=1 if (global.coins[p2]>0) { 
global.coins[p2]=0


//create flyaway coins
i1=instance_create(x+hsp,y-24,coin) //up
i1.youshouldstopcollidingNOW=1
i1.gravity=0
i1.direction=90
i1.speed=1.5
i1.friction=0
i1.mask_index=-1
i1.sprite_index=-1
i1.alarm1=480

i2=instance_create(x+16+hsp,y,coin) //right
i2.youshouldstopcollidingNOW=1
i2.gravity=0
i2.direction=0
i2.speed=2.2
i2.friction=0
i2.mask_index=-1
i2.sprite_index=-1
i2.alarm1=480

i3=instance_create(x-16+hsp,y,coin) //left
i3.youshouldstopcollidingNOW=1
i3.gravity=0
i3.direction=180
i3.speed=2
i3.friction=0
i3.mask_index=-1
i3.sprite_index=-1
i3.alarm1=480
}
} //hsp=0 vsp=0     //unused hurtstun
    
}


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
if (firedash || (spin && abs(hsp)>0.5)) {
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

if (hurt) {hurt=0 fall=6 flash=1 fk=0}

if (!collpos(sign(hitside)*10,8,1)) {        
    //gap running
    if (y<coll.y-12) {y=coll.y-14 coll=noone exit}
}

hsp=0
hyperspeed=0        


#define landing
braking=0
insted=0
wack=1
airdash=0
thokkin=0



if (downpiped) {
	shoot(x-8,y+4,psmoke,-2,-1)
	shoot(x+8,y+4,psmoke,2,-1)    
    downpiped=0
}
if (hurt) {flash=1 fk=0 hsp=0 hurt=0}

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


name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
xsc=owner.xsc
ysc=owner.ysc
water=owner.water

} 
else if (event="step"){
alarm0=max(0,alarm0-1)
alarm1=max(0,alarm1-1)

if alarm1=0 instance_destroy()
} else if (event="draw"){
}


#define enterpipe
if (type="side") {
	if (firedash) {fastpipe=1 hspeed=xsc*3 set_sprite("run") frspd=1}
	if (spin||crouch) {
		set_sprite("ball")
		frspd=min(1,0.1+abs(hsp/4))
		if (abs(hspeed)>=(maxspd-1) && !underwater()) {fastpipe=1 playsfx(name+"spin")}
	}
	if (boost) {fastpipe=1}
}
if (type="up") {
	set_sprite("fly")	
}
if (type="down") {}

if (skidding) {soundstop("sonicskid") skidding=0}
braking=0
crouch=0
push=0     



#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}
