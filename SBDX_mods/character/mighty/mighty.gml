#define spritelist
stand,wait,lookup,pose,crouch,knock,dead,walk,run,maxrun,brake,spring,jump,bonk,ball,spindash,push,hang,hammerdrop,mightybounce,thunup,wall,climbing,flagslide


#define soundlist
release,skid,spin,spindash,double,hammerland,drill,walhang,unspin,deflect


#define movelist
Mighty
#
[a][mush]: Hammer Drop
[b]: Uncurl
Uncurl near wall: Wall Cling


#define rosterorder
8


#define start
mask_set(12,12)
doonce=5

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
if ((!piped && !hurt && !(global.mplay>1 && flash)) || monitem) {
if (type="mini") {
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
} else com_item()
}

#define effectsfront
if (shieldef && size>1 && size!=5) {
    //draw_sprite_part_ext(sheets[size],0,64+40*(floor(shieldef)-1),46,39,39,round(x-19.5*xsc),round(y-19.5+dy)+4,xsc,1,$ffffff,alpha)
	draw_sprite_part_ext(sheetshields,0,209+40*(floor(shieldef)-1),9+40*!!(size=3),39,39,round(x-19.5*xsc),round(y-19.5+dy)+4,xsc,1,$ffffff,alpha)
}
with item if mightydrawon{
	with other{
	    if other.object_index=flower draw_sprite_part_ext(sheetshields,0,209+17*global.itemframe,169,16,16,round(other.x-8),round(other.y-8),1,1,$ffffff,1)
		else if other.object_index=feather || other.object_index=mushmini
		draw_sprite_part_ext(sheetshields,0,209+17*global.itemframe,186,16,16,round(other.x-8),round(other.y-8),1,1,$ffffff,1)
		else if other.object_index=crysflower
		draw_sprite_part_ext(sheetshields,0,209+17*global.itemframe,186,16,16,round(other.x-8),round(other.y-8),1,1,$ffffff,1)
	
	    /*
		if other.object_index=flower draw_sprite_part_ext(sheets[2],0,320+17*global.itemframe,35,16,16,round(other.x-8),round(other.y-8),1,1,$ffffff,1)
		else if other.object_index=feather || other.object_index=mushmini
		draw_sprite_part_ext(sheets[3],0,320+17*global.itemframe,52,16,16,round(other.x-8),round(other.y-8),1,1,$ffffff,1)
		else if other.object_index=crysflower
		draw_sprite_part_ext(sheets[4],0,320+17*global.itemframe,52,16,16,round(other.x-8),round(other.y-8),1,1,$ffffff,1)
		*/
	}
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
if (owner.drop){
x=owner.x+owner.hsp y=owner.y+8 sprite_index=spr_round32 mask_index=spr_round32 image_yscale=1.2 image_xscale=0.75
if owner.thunder=1 hittype="gut" else { 
hittype="hammerdrop"}

	coll=instance_place(x,y,collider)
	if (coll) {
		if (object_is_ancestor(coll.object_index,hittable)) {
			if (coll.object_index=brick) brickc+=1 else brickc=4
			hitblock(coll,owner,0,esign(coll.y-owner.y),0)
		}    
	}
	if coll{
		savey=coll.y
		coll.y=-verybignumber
		coll2=instance_place(x,y,collider)
		if (coll2) {
			if (object_is_ancestor(coll2.object_index,hittable)) {
				if (coll2.object_index=brick) brickc+=1 else brickc=4
				hitblock(coll2,owner,0,esign(coll2.y-owner.y),0)
			}    
		}
		coll.y=savey
	}

	coll=instance_place(x,y,enemy)
	if (coll) {                    
		global.coll=owner.id
		enemyexplode(coll,2)
	}
} else {y=-1000}

#define projectile
if (event="create") {
	
}
if (event="step") {
	
}
if (event="draw") {
	
}


#define sprmanager
frspd=1
cantslowanim=0
if (grabflagpole) {sprite="flagslide"}
else if (hurt) 	   {sprite="knock"}
else if (wall)     {sprite="wall"}
else if (mightybounce)   {if size=3  sprite="thunup" else sprite="mightybounce"}
else if (spindash) {sprite="spindash"}
else if (crouch)   {sprite="crouch"}
else if (jump) {
	if (onvine) {sprite="climbing" frspd=sign(abs(hsp)+(vsp))}
	else if (drop) {sprite="hammerdrop"}
	else if (double||(insted&fall=1)) {if size=2 sprite="thunup" else sprite="mightybounce"}
	else if (sprung) {sprite="spring" if (vsp>=0) {sprung=0 fall=1 fallspr="walk"}}
    else if (bonk) sprite="bonk"
	else if walljumpanim=1 sprite="mightybounce"
    else if (fall=6) {sprite="knock"}
    else {if (fall) sprite=fallspr else sprite="jump" frspd=fallspd}
} else {
    if (spin) {sprite="ball" frspd=0.5+abs(hsp/3)}
    else if (push!=0) {sprite="push" frspd=1+abs(hsp/3)}
    else if (hsp=0) {
        if (hang) {sprite="hang"}
        else if (pose) sprite="pose"
        else if (lookup) {sprite="lookup"}
        else if (waittime>maxwait) {sprite="stand"}///////CHANGE IT LATER
        else {sprite="stand"}
    } else {
        if (braking) sprite="brake"
		else if (abs(hsp+hyperspeed+gm8exspd)>maxspd*1.1 || (abs(hsp)>maxspd*0.9 && boost) && !water && !finish) {sprite="maxrun" frspd=abs((hsp+hyperspeed+gm8exspd)/3)}
        else if (abs(hsp)>maxspd*0.9 && !water && !finish) {sprite="run" frspd=abs(hsp/3)}
        else {sprite="walk" frspd=0.2+abs(hsp/4)}
    }
}


#define controls
com_inputstack()

tempbrick=0
luijump -= 1

//situations in which it should skip controls entirely
if (hurt || piped || grabbedflagpole) {
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
if (spindash || (crouch && !jump) || (super && fall=10) || grabflagpole ) h=0
if wall hsp=0
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
        if (!jump && !spin && !crouch && !wall) {
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
                    if (abs(hsp)<0.5) if (!wall) xsc=h
                } else {
                    hsp+=0.06*wf*h
                    braking=0
                    if (!wall) xsc=h
                }
            } else {
                if (drop) hsp*=0.5 else if (wall) hsp=0 else
				hsp+=0.08*wf*h
                if !wall xsc=h
            }
        }
    }
}
if wall hsp=0
if (push!=h) push=0

//code for specifically the a button
if ((abut || jumpbufferdo) && (!springin)) {
    if (!jump|| wall||fall=69||grabflagpole ||tailsgrab) { //jump
        if (hsp==0 && crouch && push==0 && size &&!vinegrab) {
		    soundstop("mightydrill")
            playsfx(name+"spindash",0,1+(median(0,spindash-1,3)/3)*skindat("pitchdash"+string(p2)))
            spindash=min(4,spindash+1)
            tempbrick=1
        } else {
			double=0
			if (wall&&size=3) insted=0
			else if (wall) walljumpanim=1
			wall=0
            jumpsnd=playsfx(name+"jump")
			onvine=0
			grabflagpole=0
            latchedtoflagpole=0
            vsp=-5.2-0.2*super
			onvine=0
            if (water) vsp=-sqrt(sqr(vsp)*wf+2)
			if tailsgrab{
				tailsgrab=0
				graber.tailsgrabbed=0
			}
			if tailsgrabbed && instance_exists(grabvictim){
				grabvictim.x=x
				grabvictim.y=y+8
				grabvictim.fall=0
				grabvictim.hsp=0
				grabvictim.vsp=0
			}
            //change jump angle in steep slopes
            vd=point_direction(0,0,hsp,vsp)+point_direction(0,0,1,slobal/2)
            vm=point_distance(0,0,hsp,vsp)
            hsp=lengthdir_x(vm,vd)
            vsp=lengthdir_y(vm,vd)
			
			i=shoot(x,y+4,psmoke,hsp,-2) i.growsize=-1 i.image_xscale=0.75 i.image_yscale=0.75 i.gravity=0.05
			i=shoot(x,y+16,psmoke,2,-0.5) i.growsize=-1 i.image_xscale=0.75 i.image_yscale=0.75
			i=shoot(x,y+16,psmoke,-2,-0.5) i.growsize=1 i.image_xscale=0.75 i.image_yscale=0.75			
			
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
            fallspd=min(1,0.5+abs(hsp)/5)
        }
    } else { //air jumps
	if (!insted && (fall=0 || fall=10) && size && (!mightybounce||size=3) && (vsp<1||!collision(0,vsp*3))) {
		insted=1
		drop=1
		playsfx("mightydrill")
		mightybounce=0 
		
		pollenated=0
		double=0
		if (size>=2) shieldef=1
	}
	
	jumpbuffer=4*!jumpbufferdo
    }
}
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

//code for specifically the b button
if (bbut) {
    if (spindash || (hsp=0 && crouch && push=0 && size)) {
	    soundstop("mightydrill")
        playsfx(name+"spindash",0,1+(median(0,spindash-1,3)/3)*skindat("pitchdash"+string(p2)))
        spindash=min(4,spindash+1)
        tempbrick=1
    } else {
		if size=4 && !count_projectiles(){
			fire_projectile()
		}
		
	
		if (jump && !insted && !tailsgrab) {
			insted=1
			double=1
			fall=1
			if (size=2) shieldef=1
			vsp=-3-(size=2)*2
			if size=2 playsfx("mightydouble")
			else playsfx("mightyunspin")
			drop=0
			mightybounce=0
		}
	}
}

if (cbut) {
    if (spindash || (hsp=0 && crouch && down && size)) {
	    soundstop("mightydrill")
        playsfx(name+"spindash",0,1+(median(0,spindash-1,3)/3)*skindat("pitchdash"+string(p2)))
        spindash=min(4,spindash+1)
        tempbrick=1
    }
}

//crouching and spinning
if (down && !up) {
    if (!jump && !braking && !spin) {
        if (abs(hsp)<0.5) {
            crouch=1
			hsp=0
        } else if (!spin && !crouch) {
            spin=1
            playsfx(name+"spin")
			soundstop("mightydrill")
        }
    }
    com_piping()
} else {
    if (!jump) crouch=0
}

if (spin || spindash || crouch || size=0 || fall=5) mask_set(12,12)
else if (jump && (!fall || fly || fall=10)) mask_set(12,15)
else mask_set(12,24)


#define movement
if (piped) exit

//shield effect countup
if (!!shieldef){
if shieldef>=6 shieldef=0
if shieldef shieldef+=1
}

//speed limits
if (!jump) if (loose || spin || crouch) {
    braking=0
    frick=0.06
    if (spin) frick=0.005
    hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

//speed cap rubberband formula
maxspd=(3.5 + !!size*0.5 + (fall==10)*0.5 + firedash/24)*wf
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)

vsp=min(7+downpiped,vsp)

//movement
calcmoving()

if (!dead  && !grabflagpole) {
	if fall!=69 
		player_horstep()

    player_nslopforce()
	//if (yground!=verybignumber) yground-=14
    if (jump) {
        //gravity
        hang=0
		if drop drop+=1
        if ((drop<4.5 && drop)||wall) {
		if wall if !coll=collision(hitside,0) wall=0
			vsp=0
        } else if drop>=4.5 {
            vsp=7+drop*0.1
			canpipejump=1
        } else {
            if fall!=69 && !luijump {
            vsp+=(0.15 - (size == 5 && vsp > 0.5) * 0.03) *wf
			} else{
				hsp=h
				vsp=(down-up)
			}
			canpipejump=0
        }
		vine_climbing()
        crouch=0
        spindash=0
        braking=max(0,braking-1)
        if (sprung && !fall) fall=1
        push=0
        coyote=0
		osld=0
		player_vertstep()
		if (!jump) sld=point_direction(0,0,1,slobal)
    }
	
	sprite_angle=0

    if (!jump) {
		wall=0
		//if (yground!=verybignumber) {y=yground while collision(0,0) && !collision(0,-8) {y-=1 }}
		osld=sld
		sld=point_direction(0,0,1,slobal)
		if (!jump && abs(hsp)>2.5 && spin){
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

#define cpu
	if !auto &&  (global.joynum>global.input[p2]-1) input_get(global.input[p2])
	if (left||right||down||up||akey||bkey||ckey||skey||xkey||ykey||zkey)
		&& !(left&&right&&down&&up&&akey&&bkey&&ckey&&skey&&xkey&&ykey&&zkey){
		player_controlled=1
	}
	if !player_controlled { 
		akey=0 
		bkey=0 
		ckey=0 
		skey=0
		left=0 
		xkey=0 
		ykey=0 
		zkey=0
		backtocputimer=0
	} else { backtocputimer+=1 if backtocputimer>480 {player_controlled=0 backtocputimer=0} }
	
	if player_controlled exit
	
	if !instance_exists(my_leader) exit
	
	//the actual bot itself
	
	akey=0
	if my_leader.x>x+(16*!jump) right=1
	if my_leader.x<x-(16*!jump) left=1

	if my_leader.y<=(y-32)&&my_leader.jump =0 akey=1
	//if my_leader.y<(y-12)&&my_leader.jump akey=1
	if my_leader.down down=1
	if my_leader.spindash&&abs(hsp)<0.5&&!jump{xsc=my_leader.xsc spindash=my_leader.xsc}
	if my_leader.abut && !jump && my_leader.jump {jumpwait=abs(my_leader.x-x)/max(abs(my_leader.hsp),1)  }
	
	if !jump {if jumpwait {jumpwait-=1 if jumpwait<=1 akey=1}}
	
	
	//Sonic characters only
	if !right && !left && down && my_leader.spindash {akey=1 spindash=my_leader.spindash}

	if vsp>0 canstopjump=0
	if jump && (my_leader.vsp+my_leader.y) <(y+16)&&canstopjump &&vsp<-1 {akey=1 cpu_akeystuck=0}
	if size=2 && my_leader.bbut && !my_leader.jump &&!jump && abs(my_leader.x-x)<32 if !collision(xsc*4,0) {bkey=1}
	
	
	////Some good pathfinding to avoid bots spamming jump/GEtting stuck with obvious solutions
	if push!=0 && !instance_place(x+8*xsc,y-32,collider) akey=1
	if !jump
	if collision_line(x,y-8,my_leader.x,my_leader.y,collider,0,1){
		//Determine where the thing is.
		
		if push=0{ //Unlikely that there's something between us horizontally, let's check vertically.
			
	
		} else{	//Ah shit there's something here, it's unlikely I can just jump it away.
			if collision_line(x,bbox_bottom-2,my_leader.x,my_leader.bbox_bottom-2,collider,0,1){
				//It's not a tube. (From here characters would likely react differently)
				
				//Okay uhhhh... Yeah shit.
				
			} else if push!=0{ //Oh it's just a tube lmao (Found a small tunnel, characters will react differently.)
				if crouch akey=1
				down=1
				if spindash>3 down=0
			}
			
		}	
	}
	
	
	//Back to general stuff
	if akey cpu_akeystuck+=1 else cpu_akeystuck=0
	if cpu_akeystuck>5{akey=0 cpu_akeystuck=0}
	
    if !inview() {x=my_leader.x y=my_leader.y}

#define actions
com_warping()
com_actions()


weight=0.4+0.4*!!size
bartype=0


//Multiplayer shits, Mighty uses the same mechanism Tails does, jst check for wall instead.
if global.mplay>1{

	if tailsgrab wall=0
	if wall{
		y+=8
		image_yscale=0.5
		image_xscale=0.5 //This way you only cling ot him if you WANT to cling to him.
		coll=instance_place(x,y,player)
		image_xscale=1
		image_yscale=1
		y-=8
		if coll && !tailsgrabbed && !tailsgrab_cooldown && (coop_toggle){
			if !coll.down //"dont fucking grab me you piece of shit" "Bitch just fucking press DOWN".
			if coll.vsp>0 //Makes more sense this way.
			if !coll.piped //If I didn't add thsi check shit would very likely break.
			if !coll.tailsgrab {
				coll.jump=1
				coll.tailsgrab=1
				coll.graber=id
				tailsgrabbed=1
				tailsgrab_cooldown=30
				grabvictim=coll.id
			}
		}
	}
	if tailsgrabbed && instance_exists(grabvictim){
		if !wall && !superdashactive tailsgrabbed=0
		if grabvictim.jump==0 {tailsgrabbed=0 tailsgrabbed.y-=vsp grabvictim.vsp=0}
	} //Rechecking just in case
	if tailsgrabbed && instance_exists(grabvictim){
		grabvictim.x=x
		grabvictim.y=y+8
		grabvictim.fall=0
		grabvictim.hsp=0
		grabvictim.vsp=0
	}
	if !tailsgrabbed {
		if tailsgrab_cooldown{tailsgrab_cooldown-=1}
	}
	
}

// VULNERABILITY AND PLAYER COLLISION


//Intangibility
is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1) is_intangible=1

power_lv=0
is_coinexplosive=0
if (spindash || spin || (jump && (!fall || fall=5))) power_lv=1
if (star) power_lv=5
if (super) power_lv+=1
if (drop) power_lv=4

//Special interactions
pvp_spin=(spin&& !jump) //rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=0 //make sure to set for 0 for the mario bros when pounding
pvp_ignore=instashieldin //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away
break_crackedground=(spin && !jump) +(!!drop)*2

//waiting animation
if maxwait{
if (sprite="stand")
{waittime+=1}
else if sprite!="wait" waittime=0
}

with item { if alarm[0]=-1 if object_index=flower || object_index=feather || object_index=crysflower || object_index=mushmini
if global.mplay<=1 || string(instance_nearest(x,y,player).name)="mighty"
	{
		if mightydrawon=0 {
			instance_create(x,y,smoke)
			if object_index==mushmini {
				i=instance_create(x,y,feather)
				i.hspeed=0;
				i.vspeed=0;
				i.hsp=0;
				i.vsp=0;
				i.mightydrawon=1;
				i.is_beingdrawnonbycharm=1
				instance_destroy();
			}
		}
		if fall && !drop {
			drop=1 
			vspeed=0 
		}
		
		hspeed=0;
		hsp=0;
		vsp=0;
		visible=0
		mightydrawon=1
		is_beingdrawnonbycharm=1
		
	} else {if mightydrawon {instance_create(x,y,smoke)}mightydrawon=0 is_beingdrawnonbycharm=0 visible=1}
}


//whoputshitinyourpip
if (piped) exit

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

//woter
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
	if (abs(hsp)>=maxspd-0.25)&&!jump {
		i=shoot(x-12*xsc,y+12,psmoke,-hsp*0.25,0) i.drag=1 i.growsize=-1
		vd=point_direction(0,0,-hsp*0.25,vsp)+point_direction(0,0,1,slobal/1.5)
		vm=point_distance(0,0,-hsp*0.25,vsp)
		i.hspeed=lengthdir_x(vm,vd)
		i.vspeed=lengthdir_y(vm,vd)
	}
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
                crouch=down
            }
            mask_reset()
        }   
    }
} else spinblacklist=noone

jesus=(boost && vsp<4 && !water)



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

if harmtype="spike"||harmtype="muncher" {
	if ((fall=0||fall=5)||spin) {
		
		
		
		if drop || vsp<1{
			jump=1
			fall=1
			insted=1
		} 
		
		if spin vsp=-6 else if drop vsp=-3 else vsp=-1
		drop=0
		spin=0
		pipe=0
		sprongin=0
		speed=0
		playsfx("mightyunspin")
		return 0
	}
}

pipe=0
sprongin=0
speed=0
if (skidding) {soundstop(name+"skid") skidding=0}
if (carry && carryid) {with (carryid) event_user(0) carryid=noone carry=0}

wall=0
energy=0
braking=0
sprung=0
diggity=0
grow=0
fairdash=0
gianadash=0
gk=0
fk=0
drop=0
mightybounce=0
twirl=0
oldsize=size
jumpbuffer=0
hyperspeed=0
luijump=0
hp=0
star=0
onvine=0
if (super) stopsuper()   

if ((!size || ohgoditslava) && !shielded) {
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
	double=0
	drop=0
	mightybounce=0
    if (shielded) playsfx(name+"shielddamage")
    else playsfx(name+"damage")

    starhit=0
    
	jump=1 hurt=1+starhit if (!starhit) if (shielded) {shielded=0} else {if size=3 size=1 else size-=1} hsp=xsc*-2*wf vsp=-3*wf
    
}


//Block hitting
#define hitblocks
if typeblockhit=0{
with (blockcoll){
if (stonebump || (((owner.size=0 || owner.size=5)) || (owner.size && owner.size!=5)) && insted!=1 && !owner.tempkill && (!cracked || (cracked=1 && owner.size=5))) {
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
		if global.coll.firedash go=sign(global.coll.vsp) else go=-1
        insted=1
        event_user(0)
		insted=0
    }
    coll=collision(hitside,0)
    if (firedash && jump) {fall=5 vsp=0}
}

if (double) {
	if (knuxcanclimb(coll)) {xsc=sign(hitside) playsfx("mightywallhang") wall=1}
}

if (coll=noone) exit

if (!collpos(sign(hitside)*10,8,1)) {        
    //gap running
    if (y<coll.y-12) {y=coll.y-14 coll=noone exit}
}
com_piping()
hsp=0
hyperspeed=0        


#define landing
braking=0
insted=0
fall=1
walljumpanim=0
airdash=0
double=0
i=shoot(x,y+16,psmoke,2,0.25) i.growsize=-1 i.image_xscale=0.75 i.image_yscale=0.75
i=shoot(x,y+16,psmoke,-2,0.25) i.growsize=1 i.image_xscale=0.25 i.image_yscale=0.25
if (mightybounce) mightybounce=0
if (drop) {
	com_piping()
	drop=0
	i=shoot(x-8,y+4,psmoke,-2,-1) i.growsize=-1
	i=shoot(x+8,y+4,psmoke,2,-1)  i.growsize=-1
	vsp=-1-((size=3)*5)-(!!instance_place(x,y+12,spring)*2)
	mightybounce=1
	if (size=3) {shieldef=1}
	jump=1
	playsfx("mightyhammerland")
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

//fall into spin
if (!spin && rise=0 && !hurt && down && abs(hsp)>=0.5) {
    spin=1
	soundstop("mightydrill")
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
		soundstop("mightydrill")
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

if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
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
if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
alarmmp=max(0,alarmmp-1)
alarm1=max(0,alarm1-1)

if alphadecay &&!alarmmp alpha-=0.1

if alarm1=0 instance_destroy()

} else if (event="draw"){

}


#define enterpipe
if (type="side") {
	if (spin||crouch) {
		set_sprite("ball")
		frspd=min(1,0.1+abs(hsp/4))
		if (abs(hsp)>=(maxspd-1) && !underwater()) {fastpipe=1 soundstop("mightydrill") playsfx(name+"spin")}
	}
	if (boost) {fastpipe=1}
}
if (type="up") {
	set_sprite("fly")	
}
if (type="down") {
	if (drop) {fastpipe=1 vspeed=3 set_sprite("drop") frspd=1}
}

if (skidding) {soundstop("sonicskid") skidding=0}
braking=0
crouch=0
push=0     



#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}