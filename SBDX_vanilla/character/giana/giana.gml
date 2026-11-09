#define spritelist
stand,wait,lookup,pose,crouch,walk,run,brake,jump,bonk,fall,grow,knock,die,fire,firewalk,firejump,twirl,dash,specialfall,swim,paddle,stride1,stride1fall,stride2,stride2fall,slide,climbing,flagslide,grind,piping,pipingup,sidepiping,doorenter,doorexit


#define soundlist
smalljump,fireball,pop,explosion,twirl,dash,swim


#define movelist
Giana
#
[up]+[b]: Twirl
[a]>[a]>[a]: Stride Jump
[left]+[a]: Side Somersault
<big>
Punk Giana 
#
[b]: Energy Ball
[up]+[b]: Twirl
[c]: Dash
[a]>[a]>[a]: Stride Jump
[left]+[a]: Side Somersault
<feather>


#define rosterorder
12

#define skininit

addbde=funnytruefalse(playerskindat(p2,name+" additive blend dash effects"))

var looper;

//graphic offsets
loopey=0
looper=0
repeat((projcoordbysize*MAXIMUMSIZESARGH)+1) {
	if (projcoordbysize) {
		looper=string(loopey)
	} else {looper=""}
	
	fireball_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" fireball graphic x"+looper),10) 
	fireball_sheety[loopey]=nozerounreal(playerskindat(p2,name+" fireball graphic y"+looper),87)

	dashgraphics_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" dash assets graphic x"+looper),80) 
	dashgraphics_sheety[loopey]=nozerounreal(playerskindat(p2,name+" dash assets graphic y"+looper),55)	
	
	items_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" items graphic x"+looper),218) 
	items_sheety[loopey]=nozerounreal(playerskindat(p2,name+" items graphic y"+looper),38)	
	
	loopey+=1
}

#define start
mask_set(12,15)
autorun=0
skipmush=1
global.animatePrincess=1

#define grabflagpole
grabflagpole=1
hsp=0
vsp=0
twirl=0
insted=0
gianadash=0

#define stop
if (skidding) {soundstop(name+"skid") skidding=0}
star=0
grow=0
hurt=0
braking=0
gianadash=0
push=0
mynewitems=0


#define itemget

if ((!piped && !hurt && !(global.mplay>1 && flash)) || monitem) {
	if (type="mushroom") {
		if (!growing_rn && !hurting_rn) {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			if (skidding) {soundstop(name+"skid") skidding=0}
			energy+=1
			itemget=1
			if (size=0 || size=5 || size=6 || size=7) {playgrowsfx("") set_sprite("grow") growing_rn=60 sprite_angle=0 } else {playgrowsfx("2")}
		}
	}
	else if (type="fflower") {
		if (!growing_rn && !hurting_rn) {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			if (skidding) {soundstop(name+"skid") skidding=0}
			energy+=1
			itemget=1
			if (size=0 || size=5 || size=6 || size=7) {playgrowsfx("") set_sprite("grow") growing_rn=60 sprite_angle=0 } else {playgrowsfx("2")}           
		}
	}
	else if (type="bfeather") {
		if (!growing_rn && !hurting_rn) {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			if (skidding) {soundstop(name+"skid") skidding=0}
			energy+=1
			itemget=1
            if (size=0 || size=5) {playgrowsfx("") set_sprite("grow") growing_rn=60 sprite_angle=0 } else {playgrowsfx("2")}               
		}
	}
	else if (type="mini") {
		if (!growing_rn && !hurting_rn) {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			playgrowsfx("4")
			if (skidding) {soundstop(name+"skid") skidding=0}
			if (!super && size!=5) grow=1
			tired=0
			oldsize=size
			size=5
			itemget=1
		}
	}      
	else if (type="star") {
		if (!growing_rn && !hurting_rn) {
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
					mus_play("starman",1,p2)
					global.music="star"
				}                      
			}
			if (playerskindat(slot,"growsfx5"+string(p2))) playsfx("growsfx5") 
			else playgrowsfx("5")
			itemget=1          
		}
	}
	else if (type="shield") {
		if (!growing_rn && !hurting_rn) {
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
	else if (type="btroot") {
        coll=other.id
        if (p2!=other.p2) {
            itemc+=1
            doscore_p(1000,1)
        }
        playgrowsfx("6")
        if (skidding) {
            soundstop(name+"skid")
            skidding=0
        }
        if (!super && size!=6) grow=1
        //oldsize=size
        //size=6
        itemget=1
		{playgrowsfx("2") set_sprite("grow") mynewitems=1 growing_rn=60 sprite_angle=0 }
    }
    else if (type="glui") {
        coll=other.id
        if (p2!=other.p2) {
            itemc+=1
            doscore_p(1000,1)
        }
        playgrowsfx("7")
        if (skidding) {
            soundstop(name+"skid")
            skidding=0
        }
        if (!super && size!=7) grow=1
        //oldsize=size
        //size=7
        itemget=1
		{playgrowsfx("2") set_sprite("grow") mynewitems=2 growing_rn=60 sprite_angle=0 }
    }
	
	//else if (type!="jumprefresh" && type!="1up" && type!="coin" && type!="ring") com_item()
}
if (type="1up") {
    sound("item1up")
    itemc+=1
	global.lifes+=1
	deaths=max(0,deaths-1)
	if (super) superpower=6000
	itemget=1
} 
com_item()

#define endofstage
right=1
grabbedflagpole=0
autorun=1







#define projectile
if (event="create") {
if ((owner.hang && owner.vsp>1) || owner.braking) {hspeed*=-1 x-=8*xsc}
image_xscale=3
image_yscale=2
imaproj=1
frame_sub=0
frame=0
vspeed=1
seqcount=2
wait=8
energy=owner.energy
alarm1=256
frame_sub=0
frame=0
brickc=0
seqcount=2
kek=8
hspeed=owner.xsc*3.2+owner.hsp*0.2
vspeed=0.7
exploding=0
exploframe=0
visible=1

frame1proj=1
}

if (event="step") {
calcmoving()
ignoreoncount=0
if exploding=0 && !trail{

xsc=esign(hspeed,1)

frame_sub=!frame_sub
frame_sub+=1
if (frame_sub==4) {frame=(frame+1) mod 4 frame_sub=0}

if (!inview()) instance_destroy()
alarm1-=1 if alarm1<0{exploding=1}
xsc=esign(hspeed,xsc)

if energy>2{
od=96 
with (enemy) {
other.d=point_distance(x,y,other.x,other.y)
if (other.d<other.od) {
other.od=other.d
other.targeter=id
}
}
if (targeter) {
dir=point_direction(x,y,targeter.x,targeter.y)
lock=targeter
hspeed=lengthdir_x(3,dir)
vspeed=lengthdir_y(3,dir)
} else {vspeed=min(2.75,vspeed+0.25)}
} else {vspeed=min(2.75,vspeed+0.25)}

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

coll=collision(0,0)
if (coll) {
if (coll.object_index=lavablock) {instance_destroy() exit}
if (y<coll.y+4 && !instance_place(x,y-8,collider)) {vspeed=-2.75 y-=2 exit}
if energy>1{
if ((x<coll.x+4 && !instance_place(x-8,y,collider))||(x>coll.x-4 && !instance_place(x+8,y,collider)))  {hspeed=-hspeed exit}}

exploding=1
sound("itemblockbump")
}

coll=instance_place(x,y,enemy)
if coll {
if (coll.object_index!=beetle 
&& coll.object_index!=bombenemy && coll.object_index!=drybones 
&& coll.object_index!=boo && coll.object_index!=urchin
&& coll.object_index!=pokey && coll.object_index!=pokeybody) {
yes=1
if (coll.object_index=shell) if (coll.type="beetle") yes=0
if (yes) {
global.coll=owner.id  
instance_create(x,y,kickpart)  
enemydie(coll,2)
}
}
exploding=1
}



coll=instance_place(x,y,player)
if (coll) {
if (coll.id!=owner) if (!invincible(coll)) {    
if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp)) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) instance_destroy() exit}
with (coll) hurtplayer("enemy")
}
exploding=1
}
}
} else if exploding=1 && !trail{
exploframe+=0.5
if (exploframe>=3) {visible=0 instance_destroy()}
hspeed=0
vspeed=0
} else if trail {
ignoreoncount=1
hspeed=0
vspeed=0
gravity=0
depth=3
framesub+=1
if framesub>4 if frame!=3 {frame+=1 framesub=0} else instance_destroy()
}

}

if (event="draw") {

if (owner.addbde && trail) draw_set_blend_mode(bm_add)
if trail{draw_sprite_part_ext(sheet,0,80+floor(frame)*33,90,32,32,floor(x)-16,floor(y-16),1,1,$ffffff,1)  }
else 
if exploding=0{
draw_sprite_part_ext(sheet,0,10+frame*17,87,16,16,round(x-7*xsc),round(y-7),xsc,1,$ffffff,1)
} else{
draw_sprite_part(sheet,0,10+floor(exploframe)*17,106,16,16,round(x-7),round(y-7))
}
if (owner.addbde && trail) draw_set_blend_mode(0)
}


#define effectsbehind
cantslowanim=0

var myvis;
myvis = visible;
visible = 1;
with item if gianadrawon {
	cusframesub+=1
	if cusframesub>3 {cusframe+=1*sign(hspeed) cusframesub=0}
	if cusframe>7 {cusframe=0 }
	if cusframe<0 {cusframe=7}
	if (other.size=0 || other.size==5) draw_sprite_part_ext(other.sheets[size],1,218+cusframe*17,38,16,16,x-8,floor(y-7),1,1,$ffffff,1) 
	else if other.energy=0 draw_sprite_part_ext(other.sheets[size],1,218+cusframe*17,55,16,16,x-8,floor(y-7),1,1,$ffffff,1) 
	else if other.energy=1 draw_sprite_part_ext(other.sheets[size],1,218+cusframe*17,72,16,16,x-8,floor(y-7),1,1,$ffffff,1) 
	else if other.energy>=2 draw_sprite_part_ext(other.sheets[size],1,218+cusframe*17,89,16,16,x-8,floor(y-7),1,1,$ffffff,1)
}
visible = myvis;
//visible is false when in a pipe, so we need to temporarily enable it while drawing and set it back

if (addbde) draw_set_blend_mode(bm_add)
if (gianadash) {
    draw_sprite_part_ext(sheets[size],0,80+(floor(gianadash/2) mod 4)*33,55,32,32,round(x-16),round(y-16+dy),1,1,$ffffff,alpha)
}
if (addbde) draw_set_blend_mode(0)

#define sprmanager
frspd=1

if (grabflagpole) {sprite="flagslide"}
else if (growing_rn) {sprite="grow"}
else if (hurting_rn) {sprite="knock"}
else if (jump) {
if (onvine) 
{
sprite="climbing" frspd=sign(left+right+up+down)
}
else if (hurt) {sprite="knock" onvine = 0}
else if (gianadash) sprite="dash"
    else if (twirl) {sprite="twirl" frspd=0.5+0.25*bkey if (vsp>0 && down) frspd=max(0.5+0.25*bkey,vsp/4)}
else if (gianadashed) sprite="specialfall"
    else if (fired) {sprite="firejump" cantslowanim=1}
    else if (bonk) sprite="bonk"
    else if (hurt) sprite="knock"
    else if (water) {sprite="swim" if (swim) sprite="paddle"}
    else if (fall=13) sprite="specialfall"
    else if (strideanim) {
        sprite="stride"+string(stridealt+1)
        if (vsp>=0 || hasfired) sprite+="fall"
    }
    else if (vsp>=0 || hasfired) sprite="fall"
    else sprite="jump"
} else {
	if slide sprite="slide"
    else if (crouch) {
        if (fired) {sprite="fire" cantslowanim=1}
        else sprite="crouch"
    }	else if (hsp=0 && loose || push!=0) {
        if (fired) {sprite="fire" cantslowanim=1}
        else if (pose) sprite="pose"
        else if (lookup) sprite="lookup"
		else if (waittime>maxwait) {sprite="wait"}
		else if (pose||posed) sprite="pose"
        else sprite="stand"
    } else {
        if (fired) {sprite="firewalk" cantslowanim=1}
        else if (push) sprite="stand"
        else if (braking) sprite="brake"
        else if (abs(hsp)>1.8 && !water) {sprite="run" frspd=abs(hsp/3)}
        else {if!autorun {sprite="walk" frspd=0.5+abs(hsp/2)}else{sprite="run" frspd=abs(hsp/3)} }
    }
}

#define grabflagpole
grabflagpole=1
hsp=0
vsp=0

#define controls
com_inputstack()

tempbrick=0
luijump-=1

//situations in which it should skip controls entirely
if (rise!=0 || hurt || piped || move_lock || transforming) {
    di=0
    exit
}

if (up) com_piping()
oup=up

if (up && (!hang || !size || size==5)) {
    if (hsp=0 && !jump) lookup=1
    else lookup=0
} else lookup=0

//list of things that prevent you from moving
if ((crouch && !jump) || (slide)) h=0

//movement
if (h!=0) {
    loose=0
    coll=noone
    if (h=sign(hsp) || hsp=0) coll=collision(h,0)
    if (coll) if (object_is_ancestor(coll.object_index,moving)) coll=place_meeting(x+h,y+coll.vsp+sign(coll.vsp),coll)
    if (coll) if (player_climbstep(coll)) coll=noone
    if (x<=minx && left) coll=1
    if (coll) {
        if (!gianadash) com_hitwall(h)
        if (!jump && !crouch) {
            push=h
            if (!gianadash && !twirl) xsc=h
            braking=0
        }
    } else {
        if (!crouch) {
            if (!jump) {
                if (sign(hsp)==xsc && sign(hsp)!=h && abs(hsp)>0.1 && !fired) {
					if !skidding playsfx(name+"skid")
                    braking=1
					skidding=1

                    brakedir=h
                    hsp=median(-2,hsp,2)
                } else {
                    braking=0
                    if (!gianadash && !twirl) xsc=h
                }
            } else if (!gianadash && !twirl) xsc=h
            if (twirl) hsp+=0.2*h
            else hsp+=(0.08+0.05*((abs(hsp)<1 && sign(hsp)=h))+0.025*(size==5))*h
        }
    }
}

if (push!=h) push=0

com_di()

if (gianadash) di=0

///code for specifically the a button
if ((abut || jumpbufferdo) && !springin && !transforming) {
    if (water) {jump=1 vsp=-1.5-up*0.75 swim=24 crouch=0 playsfx("gianaswim")
    if (sprite="paddle") frame=0}
    else if (!jump||fall=69||grabflagpole) { //jump
        if (size==0 || size==5) jumpsnd=playsfx("gianasmalljump",0,1+(size==5)/3)
        else jumpsnd=playsfx("gianajump")
        

vsp=-4.7
        

		grabflagpole=0
        latchedtoflagpole=0
        onvine=0


        if (stride && abs(hsp)>1.5) {
            stridejump=min(1.8,stridejump+0.90)
            stridealt=!stridealt
            strideanim=1
        }
        else strideanim=0
        
        jump=1
		if (size==7) luijump=9
        fall=0
if braking && (right||left) && brakedir!=(left-right) {vsp-=1 hsp=(right-left)*2 braking=0 fall=13 strideanim=0 stridejump=0}
        braking=0
        spin=0
        canstopjump=1
        if (mymoving) hsp+=avgmovingh
        crouch=0
        insted=1
        jumpspd=min(1,0.5+abs(hsp)/5)
    } else { //air jumps
            if (!insted) {
            shoot(x,y+8,psmoke,0,1)
            insted=1
            vsp=-4.7
            canstopjump=1
            if (size=0 || size==5) jumpsnd=playsfx("gianasmalljump",0,1+(size==5)/3)
            else jumpsnd=playsfx("gianajump")
        }
        jumpbuffer=4*!jumpbufferdo   
    }
}
if (stride) stride-=1
else if (!jump || abs(hsp)<2.6) stridejump=max(0,inch(stridejump,0,0.075))
else if (twirl && bkey) stridejump=max(0,inch(stridejump,0,0.03))
jumpbufferdo=0
springin=0

if (strideanim){
	if (vsp<0 && abs(hsp)>3.25) boost=1 
	else boost=0
}

if (akey) {
    if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {
    if (canstopjump=1 && jump && vsp<-1 && !sprung && !gianadash) {
        vsp=-1
    }
    canstopjump=0
}

//code for specifically the b button
if (bbut) {
if (up) {
        if (!twirl && fall!=13 && !gianadash) {
            shoot(x,y+8,psmoke,0,1)
            playsfx("gianatwirl")
            vsp=-4
            jump=1
            insted=1
            twirl=1
			if (size==7) luijump=9
            run=0
        }
} else if (energy || size=6) && (size!=7) && (!gianadash) {
        if (size!=6 && size!=7 && count_projectiles()<2) {
            if (h) {xsc=h braking=0}
		    hasfired=1
            fire_projectile(x+7*xsc,y)
			playsfx("gianafireball")
            //fired=12
            fired=firelength
			if (sprite="fire" || sprite="firewalk" || sprite="firejump") frame=0
		} else if (size=6 && count_projectiles() < 2) {
		    p2 = 10;
            with fire_projectile(x+8*xsc,y+2) {
                hspeed=max((1 + (abs(other.hsp) / 2.2)),1.2) * xsc; //yaargh me formula
                vspeed = -2.4;
                visible = 0;
            }
			p2 = real(ss);
			playsfx("gianafireball")
            fired=12
            if (sprite="fire" || sprite="firewalk" || sprite="firejump") frame=0
		}
    }
}

if (cbut) {
    if (fall!=13 && !gianadash) {
hasfired=0
        if (twirl) {
            fall=13
            twirl=0
            insted=1
        } else if energy && size!=6 && size!=7{
            gianadash=15-(7*energy<2)
            playsfx("gianadash")
            dashlock=(size!=1)
            dashbounce=1
            jump=1
            dashdir=point_direction(0,0,right-left,down-up)
            if (!left && !right && !up && !down) dashdir=90-90*xsc
            od=96 coll=noone
if energy=3
            with (enemy) {
                other.d=point_distance(x,y,other.x,other.y)
                if (other.d<other.od && abs(anglediff(other.dashdir,point_direction(other.x,other.y,x,y)))<45) {
                    other.od=other.d
                    other.coll=id
                }
            }
            if (coll) {
                gianadash+=10
                dashdir=point_direction(x,y,coll.x,coll.y-12)
                dashlock=coll
            }
            hsp=lengthdir_x(3+gianadash/3,dashdir)
            vsp=lengthdir_y(3+gianadash/3,dashdir)
        }
    }
}

if (!ckey) {
    dashbounce=0
}

if (!jump) {
    if (down && !up){
if (abs(hsp)<0.5) {
slide=0
if (!braking) crouch=1
com_piping()
} else if (!crouch) {
slide=1
com_piping()
} 
} else {crouch=0 slide=0}
}else {crouch=0 slide=0}


if (size==5) mask_set(9,8) 
else if (crouch) mask_set(12,12)
else mask_set(12,15)        

#define movement
if (piped || move_lock || transforming || growing_rn || hurting_rn) exit

if (loose) {
    hsp=max(0,abs(hsp)-0.1+(0.05*slide))*sign(hsp)
    if (braking) xsc=brakedir
    braking=0
}

collmon=instance_position(x,y+22,monitor)
if (collmon) {
jump=1 vsp=-2
with (collmon) event_user(6)
}


maxspd=(2-0.5*twirl+stridejump+(size==5)*0.55)*wf
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)

vsp=min(7+downpiped,vsp)

///movement
//hi moster here dont uncomment the yground or easyground stuff because its required for the cool new slope system to work
//for anyone porting a charm from unfinished build or below to this build, delete or comment all of the commented code and add player_nslopforce()
calcmoving()

if (!dead && !grabflagpole) {
if (gianadash) {
hsp=lengthdir_x(3+gianadash/3,dashdir)
vsp=lengthdir_y(3+gianadash/3,dashdir)
coll=collision(hsp,0)
if (coll) {
with (shoot(x,y+4,gianadashbox)) {
with (brick) if (place_meeting(x,y,other.id)) hitblock(id,other.owner,2,esign((y+15)-other.y,1),0)
with (itembox) if (place_meeting(x,y,other.id)) hitblock(id,other.owner,2,esign((y+15)-other.y,1),0)
with (monitor) if (place_meeting(x,y,other.id)) event_user(6)
}        
if (!instance_exists(coll)) coll=noone
else {
if (dashbounce) {
hsp=-hsp                                      
dashdir=anglediff(0,90-(dashdir-90))
gianadash=15
dashlock=1
sound("itemblockbump")
} else {
hsp=-hsp *0.02     
vsp=vsp *0.02    
dashdir=anglediff(0,90-(dashdir-90))
gianadash=0
sound("itemblockbump")}
}
}  

player_nslopforce() //comment this if giana Explodes and dies while dashing -moster
//yground=easyground()
coll=collision(0,vsp)
if (coll /*|| y>easyground-14*/) {
with (shoot(x,y+4,gianadashbox)) {
with (brick) if (place_meeting(x,y,other.id)) hitblock(id,other.owner,2,esign((y+15)-other.y,1),0)
with (itembox) if (place_meeting(x,y,other.id)) hitblock(id,other.owner,2,esign((y+15)-other.y,1),0)
}        
if (!instance_exists(coll)) coll=noone
else if (dashbounce) {
vsp=-vsp
dashdir=anglediff(0,-dashdir)
gianadash=15
dashlock=1
sound("itemblockbump")
}
}
x+=hsp y+=vsp
} else {
player_horstep()
player_nslopforce()
//yground=easyground()
//if (yground!=verybignumber) yground-=14
if (jump) {
if (twirl && !luijump) {
	vsp=min(vsp+0.1*wf,3-(2.5*!down)+(2.5*down))
	if (vsp>3.5) {
		if !boost && !count_owned(psmoke) shoot(x,y,psmoke,0,0)
		boost=1
	}
}
else if (water) vsp=min(1.5,vsp+0.04)
else if fall!=69 && !luijump {
vsp=min(4,vsp+0.15*wf)
if size==5 && vsp>-0.45 vsp-=0.105
} if (!hurt) vine_climbing()
crouch=0
braking=0

if (sprung && !fall) fall=1
push=0
player_vertstep()
coyote=0
}

if (!jump) {
twirl=0
//if (yground!=verybignumber) {y=yground while collision(0,0) && !collision(0,-8) {y-=1 }}
if (finish && ending="retainer" && !jump) coyote=0
if (!collision(0,4) /*&& (y<yground-2)*/) {
coyote+=1
if ((down || !run) && coyote=1) {y+=1 coyote=3}
if (coyote=3) {
jump=1
crouch=0
fall=1
}
} else coyote=0
if (jumpbuffer=-1) {
jumpbuffer=0
if (!down) jumpbufferdo=1
}
}
}
}
com_finishmove()


#define actions
com_warping()
com_actions()


weight=0.7
bartype=1
maxe=3
if (size=0 || size==5) energy=0 else if energy<1 energy=1
is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1 ||transforming || is_growing || is_hurting) is_intangible=1

power_lv=0
if (twirl) power_lv=1
if (gianadash) power_lv=2+(size=1)
if (star) power_lv=5
if (super) power_lv+=1
//Special interactions
pvp_spin=!!gianadash //rolling clash
pvp_avoid=(hurting_rn||growingrn) //I don't like social interactions
pvp_stomper=!gianadash //make sure to set for 0 for the mario bros when pounding
pvp_ignore=0 //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away

if (piped||transforming) exit
//custom powerups
with item { if object_index=mushroom
if global.mplay<=1 || instance_nearest(x,y,player).name="giana"
{
visible=0
gianadrawon=1
is_beingdrawnonbycharm=1
} else {gianadrawon=1 is_beingdrawnonbycharm=0 visible=1}
}



//waiting animation
if maxwait{
if (sprite="stand")
{waittime+=1}
else if sprite!="wait" waittime=0
}





if (!jump) {
    vsp=0
hasfired=0
    if (!star) seqcount=0
    hang=0
    if (push=0 && hsp!=0 && braking) {
        if !skidding playsfx(name+"skid")
		skidding=1
    } else if (skidding) {soundstop(name+"skid") skidding=0}
}

if (underwater()) {
    if (!water) {
        if (abs(vsp)>2) water_splash(1)
        watrlock=10 spinjump=0 fall=1 hang=0 strideanim=0
        vsp=min(1,vsp/2)
        jumpspd=1
    }
    water=1 wf=0.7
} else {
    if (water) {
        water=0
        vsp=max(-4,vsp*2)
        if (abs(vsp)>2) water_splash(0)
    }
    wf=1
}

//smoke generation
if (global.dustframe && !gianadash) {
    if (vsp<-5-2*!sprung) {
        shoot(x,y+8,psmoke,0,-1)
    }
    if (vsp>7) {
        speedwagon+=1
        if (speedwagon>60) shoot(x,y,psmoke,0,1)
    } else speedwagon=0
}

if (jump && !fall) fall=1

dashcooldown=max(0,dashcooldown-1)
swim=max(0,swim-1)
growing_rn=max(0,growing_rn-1)
if growing_rn{set_sprite("grow")
hsp=0
hspeed=0
vsp=0
vspeed=0
gianadash=0
twirl=0
if growing_rn=1 {if mynewitems=1 {size=6 mynewitems=0} else if mynewitems=2 {size=7 mynewitems=0} else size=1}
}
hurting_rn-=1
if hurting_rn{set_sprite("knock")
if shielded {shielded=0 hurting_rn=0 flash=30}
if global.rings[p2]>0 {droprings(0) hurting_rn=0 flash=30}
hsp=0
hspeed=0
vsp=0
vspeed=0
gianadash=0
twirl=0
if hurting_rn=1 {size=0 flash=30}
}
if (!stridejump && !jump) {stridealt=1 strideanim=0}

if (gianadash) {
    gianadash-=1
    insted=1
    if (!(gianadash mod 2)) i=fire_projectile(x,y)i.trail=1
    if (!gianadash) {fall=13 dashcooldown=8}
    if ((left || right || up || down) && !dashlock) {
        d=anglediff(dashdir,point_direction(0,0,right-left,down-up))
        if (abs(d)>90) {dashdir+=d dashlock=1}
        else dashdir+=median(-16,d,16)
    }
    if (dashlock>1) {
        if (instance_exists(dashlock)) dashdir+=median(-8,anglediff(dashdir,point_direction(x,y,dashlock.x,dashlock.y-12)),8)
        else gianadash=min(gianadash,10)
    }
    if (hsp>=0) {
       // if (xsc=-1) {sprite_angle=(sprite_angle+180) mod 360 xsc=1}
		//sprite_angle=dashdir
    } else {
       // if (xsc=1) {sprite_angle=(sprite_angle+180) mod 360 xsc=-1}
        //sprite_angle=dashdir-180
    }
} else sprite_angle=0

if (jump && size==7 && global.fastframe4 != ff4prev) {ff4prev = global.fastframe4 with instance_create(x, y, afterimagenoblend) {event_user(0) alphadecay=1 alarm[0] = 24 maxalarm = 24 maxalpha=0.8}}

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
if (hurt || piped || (intangible() && !diggity)) exit

coll=noone extracheck=id inst=0
if (insta) {extracheck=myhitbox inst=1}



with (enemy) if (phase!=other.id && !lock && !carry)
    if (instance_place(x,y-other.vsp-16*!!other.diggity,other.id) || instance_place(x,y,extracheck)) other.coll=id

if (coll) {
    if (!coll.damage_player_on_contact) {
        calcfall=fall
        if (fall=5 || fall=12) calcfall=0
        global.coll=id
        type=coll.object_index
            
        seqcount=max(1,seqcount)
    
    if (growing_rn||hurting_rn){exit}
        
        if (gianadash || dashcooldown) {
            gianadash=0
            fall=1
            vsp=-4
            hsp=median(-1,hsp,1)
    if !enemyflip(coll)
            enemyexplode(coll)
            exit
        }
        twirl=0 
        if (super) {
            if (water) seqcount=1
            enemyexplode(coll)
            exit
        }
    
        
        if (coll.object_index=lakitu) if (coll.flee) exit
    
        
        if (star  
        || (spin && type!=spinyegg && type!=beetle && type!=shell)
        || (pound>13 && type!=piranha && type!=spinyegg && type!=spiny)) {
            if size==5 && !spin && !star {if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"smalljump",0,3.6) vsp=-3-((ckey && spin) || (akey && star))*1.5 canstopjump=akey if !pound exit else pound=0}
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            if (type=hammerbro) seqcount=max(5,seqcount)
            enemydie(coll)                
            exit
        }
        
        if (type=piranha || coll.damage_player_on_contact)  {
            hurtplayer("enemy")
            exit
        }
        
        if (slide) {
            if (type=shell) {/*if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else*/ if (coll.type!="beetle") {enemydie(coll) exit}}
            else if (type=beetle|| object_is_ancestor(type,koopa) || type=koopa) {
                //if (type=beetle) {if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit}}
                
                with (coll) {
                //WE'RE GONNA FLIP 'EM
                sound("enemykick")
                owner=other.owner
                doscore_e(800,id)
                heorng=instance_create(x,y,shell)
                with (heorng) {owner=other.owner phase=owner}
                if (object_index=redkoopa) heorng.type="red"
                if (object_index=blukoopa) {heorng.type="blu" enemy2=1}
                if (object_index=yelkoopa) {heorng.type="yel" enemy2=1}
                if (object_index=beetle) heorng.type="beetle"
                if (object_index=spiny) heorng.type="spiny"
                heorng.ysc=-1
                instance_destroy()
            } exit}
            else if (type=spinyegg) {hurtplayer("enemy") exit}
            else {/*if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else*/ enemydie(coll) exit}
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
                    if (coll.stop && !coll.kicked && size!=5) doscore_p(8000)
                    else if size!=5 {seqcount=max(seqcount,2+scorelok1) doscore_p()}
                    if (jump) {
                        if (vsp>0) {
                            vsp=-3-akey*1.5
                            canstopjump=akey
                            if size==5 playsfx(name+"smalljump",0,3.6)
                            twirl=0 insted=1
                            if (fall=12) fall=5
                        }
                    }
                    if size!=5 {
                        kicksound(0)
                        instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
                        with (coll) {spd=max(3,abs(other.hsp)+1) hspeed=spd*esign(x-other.x,other.xsc) owner=other.id kicked=1 stop=0 phase=owner}
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
                    vsp=-3-akey*1.5 canstopjump=akey sound("enemystomp") doscore_p() twirl=0 insted=1 if (fall=12) fall=5 exit
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
            if size==5 {if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"smalljump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit}
            enemystomp(coll) exit      
        } else if (coll.vspeed<0 && coll.y>y+8) {if size==5 {playsfx(name+"smalljump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit} else {jump=1 fall=1 vsp=-0.5 enemystomp(coll) exit}}
        
        hurtplayer("enemy")   
    } else if (!star && !flash) hurtplayer("enemy")
} 

#define hurt
if ((invincible() && (hurt || flash)) || intangible() || hurting_rn || growing_rn) exit

pipe=0
sprongin=0
speed=0
if (skidding) {soundstop(name+"skid") skidding=0}
if (carry && carryid) {with (carryid) event_user(0) carryid=noone carry=0}

onvine=0
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
    glide=0
    sprung=0
    fall=0
    pound=0  
    braking=0
    upper=0
    hyperspeed=0
    if (shielded) playsfx(name+"shielddamage")
    else playsfx(name+"damage")

    starhit=0
    set_sprite("knock") 
frspd=!shielded 
hurting_rn=30
}
//Block hitting

#define hitblocks
if typeblockhit=0{
with (blockcoll){
if (stonebump || (owner.size=0 || owner.size=5 || owner.twirl) && insted!=1 && !owner.tempkill && (cracked=0 || (cracked=1 && owner.size=5))) {
    if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
    if (owner.gianadash && !stonebump/* && owner.size!=5*/){
        owner.vsp=1.5
        cracked=1
        i=instance_create(x,y,crackedbrick)
        i.owner=id
        i.biome=biome
        i.imcrack=1
        i.go=go
        i.tpos=1
    }
} else { 
if (!insted) {owner.vsp=1.5}
tpos=1
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
}  else if typeblockhit=1{
hititembox()
}

#define hitwall
//hit blocks sideways
if (twirl && size && size!=5) {
    global.coll=id
    with (hittable) if (instance_place(x-other.hitside,y,other.id)) {
        go=-1
        insted=0
        event_user(0)
        insted=0 picked=0
    }
    coll=collision(hitside,0)
}

if (coll=noone) exit

hsp=0
hyperspeed=0         


#define landing
braking=0
stride=3

if (downpiped) {
	shoot(x-8,y+4,psmoke,-2,-1)
	shoot(x+8,y+4,psmoke,2,-1)
    downpiped=0
}
if (hurt) {flash=1 fk=0 hsp=0 hurt=0}

playsfx(name+"step")

//jump buffering
if (jumpbuffer) jumpbuffer=-1

if (twirl && boost) {
	with (hittable) if (instance_place(x,y-max(4,other.vsp),other.id)) {
		go=1    
		event_user(0)
		picked=1
	} 
	boost=0
}
if (boost && hsp<maxspeed && !hyperspeed && !gm8exspd) boost=0


#define death
if (event="create"){

gravity=0.1
vspeed=-3
sprite_angle=0
c=4

frame=0
frspd=1
name="giana"
sprite="die"
alpha=1


alarm1=300

if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
depth=-4
name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
if size==5 size=0
xsc=owner.xsc
ysc=owner.ysc
frn=owner.frn

vspeed=-3.5 gravity=0.1-(owner.water*0.015)
} 
else if (event="step"){
if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
alarm1=max(0,alarm1-1)

if (rotate) {
    c-=1
    if (!c) {c=4 sprite_angle-=8 xsc+=0.05*sign(xsc) ysc+=0.05}
}
spriteswitch(1)

if alarm1=0 instance_destroy()
} else if (event="draw"){
}

#define enterpipe
if (gianadash) fastpipe=1
gianadash=0
braking=0
crouch=0
push=0


#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}
