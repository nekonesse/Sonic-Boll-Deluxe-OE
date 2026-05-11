#define spritelist
stand,wait,lookup,pose,crouch,knock,dead,walk,turn,jumpstart,jump,bonk,fall,fired,firedjump,firedcrouch,throw,throwjump,bombjump,bombfall,superjump,superfall,swim,paddle,shell,shelljump,shellglide,superjumpcharge,land,superland,climbing,flagslide,grind,piping,pipingup,sidepiping,doorenter,doorexit


#define soundlist
duck,swim,fire,spin,stomp,taunt,superjump1,superjump2,hammer


#define movelist
Bowser
#
[dir]+[c]: Shell Spin (ground)
[a]: Shell Glide (air)
[up]+[a]: Highjump
[down]: Groundpound (air)
[b]: Fire
[up]+[b]: Hammer Throw
Hold [b] while firing to control your fire

#define rosterorder
0


#define effectsfront
/*
draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-48,push)
draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-40,turned)     draw_skintext(floor(x)-(string_length(string(hsp))*4)+40,floor(y)-40,turning) 
draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-32,rise)   draw_skintext(floor(x)-(string_length(string(hsp))*4)+40,floor(y)-32,xsc)
draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-24,hsp)    draw_skintext(floor(x)-(string_length(string(hsp))*4)+40,floor(y)-24,h)
*/
//draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-32,superjump)
//draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-24,pound)
//draw_skintext(floor(x),floor(y)-24,id)
//draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-56,spinplus)
//draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-48,hsp)
//draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-40,maxspd)
global.animatePrincess=1

#define start
mask_set(12,12)
//energy=global.energy[p2]
turned=1
turning=1
bigger_light=1.5
//useypos=funnytruefalse(playerskindat(slot,name+" use ypos"))

directory=string_replace(playerskinstr(p2,"infotxt"+string(p2)),"player.txt","") //w games
sheets[1]=skindat("tex_"+name+"0"+string(p2))

fired=0
fired2=0
firedc=0
jumpedoutspin=0
superjumpanim=0
glideanim=0
hurtanim=0
jumpdelay=0
spinplus=0
landanim=0
superlandanim=0
spinspdmax=6
vertbowser=1
if (size=5) {mxsc=0.5 mysc=0.5} else {mxsc=1 mysc=1}
/*
was making a 1.9 bowser charm but not 1.9 anymore! -sani

variables bowser uses

controlfire
superjump
stomp
turned
turning
push

insted
pound
downlok (poundlok now)
spin

___________________
objects to port

bowshammer
bowserfire
deadbowser
*/

#define stop
if (skidding) {soundstop(name+"skid") skidding=0}
star=0
grow=0
hurt=0
braking=0
spin=0
push=0
super=0
boost=0
pound=0
fired=0
fired2=0
firedc=0
superjumpanim=0
glideanim=0
hurtanim=0
jumpdelay=0
spinplus=0
landanim=0
superlandanim=0


#define itemget

if ((!piped && !hurt && !(global.mplay>1 && flash)) || monitem) { //bowser's modified powerup code
	if (type="mushroom") {
			coll=other.id
			if (p2!=other.p2) {
				itemc+=1
				doscore_p(1000,1)
			}
			playgrowsfx("")
			if (skidding) {soundstop(name+"skid") skidding=0}
			
			if (size=5) {
				grow=1
				oldsize=size
				//size=max(size,1)
				size=0
				mxsc=1 mysc=1
			}
			energy+=2
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
        /*
        if (!super && size!=2) grow=1
        oldsize=size
        size=2
        */
        if (size=5) {
            grow=1
            oldsize=size
            size=0
            mxsc=1 mysc=1
        }
		energy+=2
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
        tired=0
        oldsize=size
        size=5
        mxsc=0.5 mysc=0.5
		energy+=2
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
        /*
        if (!super && size!=3) grow=1
        oldsize=size
        size=3
        */
        if (size=5) {
            grow=1
            oldsize=size
            //size=max(size,1)
            size=0
            mxsc=1 mysc=1
        }
		energy+=2
        itemget=1
    }
} 

//execute the rest of the default item code
com_item()


#define grabflagpole
//not grabbing the flagpole is kinda fitting for bowser but he does in multiplayer to be consistent
if (global.mplay>1) {
    grabflagpole=1
    hsp=0
    vsp=0
}

#define endofstage
right=1
grabflagpole=0
if !(jumpdelay || actualjump) akey=(push*!akey || (jump && akey) || instance_place(x+16,y,enemy) || !collision(16,8))
//else akey=0
//if (!jumpdelay && !actualjump) {if (push) akey=1} else akey=0

//so the endofstage script works for characters when there isnt a castle to walk into
//but when there isnt a castle it seems to use hardcoded code instead
//so i cant fix bowser being stuck unless i mess with the push variable or something


#define damager
y=-1000
if ((owner.crouch || owner.firedc) && !owner.jump && !owner.piped && owner.size!=5) {
image_xscale=16
image_yscale=12 
x=owner.x-owner.xsc*5 
y=owner.y-4
go=-1 
}

if (event="create") {
    x=owner.x+owner.hsp 
    y=owner.y+16
    i=instance_create(x-6,y,part) i.hspeed=-1 i.vspeed=-5
    i=instance_create(x+6,y,part) i.hspeed=1 i.vspeed=-5
    i=instance_create(x-12,y,part) i.hspeed=-1.5 i.vspeed=-3
    i=instance_create(x+12,y,part) i.hspeed=1.5 i.vspeed=-3
    i=instance_create(x,y,smoke) i.vspeed=-0.5
    //instance_create(x,y,poundeff)
    alarm0=12
    stomp=1

} else if (event="step") {
hittype="pvp"
ox=x
    oy=y
if (owner.crouch && !owner.piped && owner.size!=5) {
coll=instance_place(x,y,collider)
        if (coll) {
        if (object_is_ancestor(coll.object_index,hittable)) {
        if (coll.object_index=brick) brickc+=1 else brickc=4
        hitblock(coll,owner,1,go,1)
        }    
        }
        
        coll=instance_place(x,y,enemy)
        if (coll) {
            if (coll.object_index!=bombenemy && coll.object_index!=drybones
            && coll.object_index!=boo && coll.object_index!=urchin)
            with (owner) {
                coll=other.coll
                global.coll=id
                enemydie(coll)
            }
        }
        
        coll=instance_place(x,y,player)
        if (coll) {
            if (coll.id!=owner) if (!invincible(coll)) {    
                if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
                    coll.hittype=hittype
                    with (coll) hurtplayer(hittype)
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
}
x=ox
    y=oy

    //Stomping
    if (stomp) {
        hittype="pvp"
        image_xscale=24
        image_yscale=8
        alarm0=max(0,alarm0-1)
        if (!alarm0) {stomp=0 exit}
        x=owner.x+owner.hsp 
        y=owner.y+16
        
        coll=instance_place(x,y,collider)
        if (coll) {
            if (object_is_ancestor(coll.object_index,hittable)) {
                if (coll.object_index=brick) brickc+=1 else brickc=4
                owner.stomp=1
                hitblock(coll,owner,1,1,1)
                owner.stomp=0
            }    
        }
        
        coll=instance_place(x,y,enemy)
        if (coll) {
if (coll.object_index!=bombenemy && coll.object_index!=drybones
&& coll.object_index!=boo && coll.object_index!=urchin)
            with (owner) {
                coll=other.coll
                global.coll=id
                
                //for loops are too much work
                //this is for launching of dead bodies
                deadnumber[0,0]=genericdead
                deadnumber[1,0]=goombadead
                deadnumber[2,0]=koopadead
                deadnumber[3,0]=fishdead
                    
                deadnumber[0,1]=instance_number(genericdead)
                deadnumber[1,1]=instance_number(goombadead)
                deadnumber[2,1]=instance_number(koopadead)
                deadnumber[3,1]=instance_number(fishdead)
                    
                enemydie(coll)
                    
                deadnumber[0,2]=instance_number(genericdead)
                deadnumber[1,2]=instance_number(goombadead)
                deadnumber[2,2]=instance_number(koopadead)
                deadnumber[3,2]=instance_number(fishdead)
                    
                for (i=0;i<4;i+=1) { 
                    if (deadnumber[i,1]!=deadnumber[i,2]) {
                        with (instance_find(deadnumber[i,0],deadnumber[i,2]-1)) {
                            vspeed=-4
                            hspeed=1*esign(x-(global.coll).x,1)
                        }
                    }
                }
            }
        }
        
        coll=instance_place(x,y,player)
        if (coll) {
            if (coll.id!=owner) if (!invincible(coll)) {    
                if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
                    coll.hittype=hittype
                    with (coll) hurtplayer(hittype)
                }
            }
        }
    }
    if (!(owner.crouch || owner.firedc) && !stomp) y=-1000
}


#define projectile
//without typeonce he was able to convert one projectile into another
if (event="create") {type=owner.type}
switch type{ //i did not know this was a thing
    case "bowshammer":
    if (event="create") {
    }
    if (event="step") {
        //calcmoving()
        if !created {
            image_xscale=4
            image_yscale=4
            //frame_sub=0
            //frame=0
            visible=1
    
            vspeed=-2.5
            gravity=0.075
            //breakflag=1
    
            if !owner=other.id owner=noone
    
            created=1
        }
        
        frame_sub=!frame_sub
        if frame_sub frame+=1
        if (frame>=7) frame=0
    
        if (pitdeath()) instance_destroy()
        
        coll=instance_place(x,y,player)
        if (coll) {
            if (coll.name="knux") if (owner!=coll.owner && (coll).upper) {speed*=-1 owner=coll.owner}
            else if (owner!=coll.id) with (coll) {if (!invincible(coll)) hurtplayer(1)}
        }
        coll=instance_place(x,y,collider)
        if (coll) {
            if (object_is_ancestor(coll.object_index,hittable)) {
                /*if (instance_exists(owner))*/ hitblock(coll,owner,1,-1,0)
//else hitblock(coll,0,1,-1,0)
            }
        }

image_xscale=5
image_yscale=5
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

        coll=instance_place(x,y,enemy)
        if (coll) {
if (coll.object_index!=bombenemy && coll.object_index!=drybones
&& coll.object_index!=boo && coll.object_index!=urchin) {
instance_create(mean(x,other.x),mean(y,other.y),kickpart)
global.coll=owner.id
//enemyexplode(coll.id,seqcount)
enemyexplode(coll.id,2)
}
        }
    }
    if (event="draw") {
        draw_sprite_part_ext(owner.sheets[0],0,10+17*frame,88,16,16,round(x-8*xsc),round(y-8),xsc,1,$ffffff,1)
        //draw_sprite_part_ext(sheet,0,10+17*global.framefire,88,16,16,round(x-8*xsc),round(y-8),xsc,1,$ffffff,1)
//draw_skintext(floor(x),floor(y)-24,owner.id)
}
    break
    default:
    if (event="create") {
    }
    if (event="step") {
        if !created {
            //breakflag=1
            frame=0
            frc=0
            frade=0
            timer0=150
            visible=1
        
            image_xscale=6
            image_yscale=6

            created=1
        }

        timer0-=1 if (timer0=0) {if (!fade) fade=1}
        frc+=1 if (frc=4) {frc=0 frame=!frame}

        if (fade) {
            fade+=1
            visible=((fade mod 4)<2)
            if (fade=30) {
                instance_create(x,y,smoke)
                instance_destroy() 
            }
        } else if (abs(x-owner.x)>256) fade=1
        
        coll=instance_place(x,y,player)
        if (coll) {
            if (coll.id!=owner) if (!invincible(coll) && !intangible(coll)) {   
                if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) {
                    if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp)) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
                    with (coll) {/*if (fireinvuln()) exit else */fragplayer(other.owner)}
                }
            }
        }
        coll=instance_place(x,y,collider)
        if (coll) {
            if (owner.size>0 || breakflag || coll.object_index!=brick) {
                if (!coll.hit) {
                    hitcount+=1 if (hitcount=4) fade=1
                }
            }
            if (object_is_ancestor(coll.object_index,hittable)) {
                /*if (instance_exists(owner)) */hitblock(coll,owner,1,-1,0)
//else hitblock(coll,0,1,-1,0)
            }
        }

image_xscale=5
image_yscale=5
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

        coll=instance_place(x,y,enemy)
        if (coll) {
if (coll.object_index!=bombenemy && coll.object_index!=drybones 
&& coll.object_index!=boo && coll.object_index!=urchin 
&& coll.object_index!=beetle
) {
if (coll.object_index=shell) {
                    if coll.type="beetle" exit
                }
    instance_create(mean(x,other.x),mean(y,other.y),kickpart)
    global.coll=owner.id
    //enemyexplode(coll.id,seqcount)
    enemyexplode(coll.id,2)
}
        }
    }
    if (event="draw") {
        draw_sprite_part_ext(owner.sheets[0],0,10+32*frame,107,31,16,round(x-16*xsc),round(y-8),xsc,1,$ffffff,1)
//draw_skintext(floor(x),floor(y)-24,owner.id)
}
}


#define sprmanager
frspd=1//Default animation speed
cantslowanim=0//Flag meant to stop the slowing of animations underwater
keepframebetween=0
prevent_spr_reset=0
if (grabflagpole) {sprite="flagslide"} //Grabbed the flagpole
else if (hurtanim) {sprite="knock"}
else if ((fired || controlfire) && !spin) {
    if (jump) {sprite="firedjump" if (oldspr="fired") keepframebetween=1}
	else {sprite="fired" if (oldspr="firedjump") keepframebetween=1}
	cantslowanim=1
} else if (jumpdelay || actualjump) && !spin && !water {
	sprite="jumpstart"
} else if (firedc && !spin) {
	sprite="firedcrouch" cantslowanim=1
} else if ((fired2) && !crouch && !spin) {
    if (jump) {sprite="throwjump" if (oldspr="throw") keepframebetween=1}
    else {sprite="throw" if (oldspr="throwjump") keepframebetween=1} 
	cantslowanim=1
} else if (jump) {
    if (onvine) {
        sprite="climbing" frspd=sign(left+right+up+down) //Climbing a vine or fence
    } else if (pound && !superjumpanim) {
        if (pound<20) sprite="bombjump"
        else sprite="bombfall"
    } else if (superjumpanim) {
        if (vsp<0) sprite="superjump"
        else if (vsp>0) sprite="superfall"
    } else if (glideanim) {
        sprite="shellglide"
        //frspd=0.1
        //if (vsp<0) frspd=0.25
    } else if (insted) {
        sprite="shell"
    } else {
		if (fall=0) {sprite="shelljump"}
        else if (bonk) {sprite="bonk"}
        else if (water) {sprite="swim" if (swim) sprite="paddle"}
		else {sprite="jump" if (vsp>0) sprite="fall"}
    }

} else {
    if (superjump) {sprite="superjumpcharge"}
	else if (superlandanim && !spin) {sprite="superland"}
	else if (landanim && !spin) {sprite="land"}
    else if (rise!=0) {sprite="crouch"}
    //oldspr isnt used in charms anymore? i dont see it in knux or mecha
    else if (abs(turned)!=1) {sprite="turn" frspd=0 /*oldspr="turn"*/ 
	//if (xsc>0) frame=((turned-1)/-2)*frn
	//else if (xsc<0) frame=((turned+1)/2)*frn
	frame=(abs(turned)<0.33)}
    else if (crouch) {
        if (spindash) {sprite="shell"}
        else {sprite="crouch" if (oldspr="firedcrouch") prevent_spr_reset=1 /*frame=min(1,frame+0.125)*/}
    } else if (hsp=0) {
        if (pose) sprite="pose"
        else if (lookup) {sprite="lookup"}
        else if (waittime>maxwait) {sprite="wait"}
        else {sprite="stand"}
    } else if (spin) {sprite="shell"}
    else {sprite="walk"}
}

#define controls
com_inputstack()

tempbrick=0

//situations in which it should skip controls entirely
if (rise!=0 || hurt || piped || move_lock) {
    di=0
    exit
}

if (up) com_piping()
oup=up

if (up && (!hang || !size) && !controlfire) {
    if (hsp=0 && !jump) lookup=1
    else lookup=0
} else lookup=0

//list of things that prevent you from moving
if (rise!=0 || (crouch && !jump) || (spin || poundcancel || (pound && !superjumpanim) || (controlfire && !jump)) || vinegrab || grabflagpole) h=0


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
        if (!jump && !spin && !crouch && !jumpdelay && !actualjump) {
            if (!myhitbox && !bkey) turning=h push=h
            com_piping()
        } else {com_piping()}
    } else {
        if (push!=h) push=0
        if (!spindash && (!crouch || jump) && !hurt) {
            if (spin) {
                if (sign(hsp)!=h) {hsp+=h*0.025*wf} 
            } else { 
                if (!jump) {
                    turning=h
                    if (sign(hsp)!=h) {
                        if (abs(hsp)>maxspd*0.9) {
                            braking=1
                            skidding=1
                            playsfx(name+"skid")
                            brakedir=h
                        }
                        hsp+=0.33*wf*h
                        if (abs(hsp)<0.5) xsc=h
                    } else {
                        hsp+=0.06*wf*h
                        braking=0
                        xsc=h
                    }
                } else {
                    hsp+=(0.06+0.1*(insted=1))*wf*h
                    //xsc=h
    collwin=instance_place(x+hsp,0,goalblock)
    if collwin {hsp=0 fallsprite="dash" collwin.owner=id with collwin{ event_user(4)}}
                }
            }
        }
    }
} else if (h=0 || push=h) push=0

if (push!=h) push=0

if (abs(turned)!=1) h=0

com_di()

//code for specifically the a button
if ((abut || jumpbufferdo) /*&& !crouch*/ && !springin) {
    if (!jump && !superjump && up && !spin) {
        superjump=1
        playsfx("bowsersuperjump1",0,1+(size==5)/3)
        controlfire=0
fall=1
    } else {
        if (!jump||fall=69||grabflagpole||water) && !jumpdelay { //jump
			if ((water && jump) || spin || size==5 ||fall=69) {jumpdelay=1}
			else if (!superjump && !spin && size!=5) {
				if (!jump) jumpdelay=8
			}
        } else { //air jumps
            //"insted" is typically used to mark if you're used our air action
            if (!insted && !controlfire && !water) {
                insted=1
                vsp=-2.25 //-2
                fall=0
                jumpedoutspin=0
glideanim=1
                playsfx("bowserspin")
            }
            jumpbuffer=4*!jumpbufferdo //jump buffering
        }
    }
}
jumpbufferdo=0
springin=0

//hello im the actual jumping code
if (jumpdelay=1) {
    if (water) {
        if (!pound) {vsp=-1.5-up*0.75 swim=24 crouch=0 playsfx("bowserswim") insted=0 fall=1 superjumpanim=0 jumpedoutspin=0}
    } else {
        jumpsnd=playsfx(name+"jump",0,1+(size==5)/3)
        vsp=-4.5 //-5
        if (water) vsp=-sqrt(sqr(vsp)*wf+2) //water boosts your height
        grabflagpole=0
        latchedtoflagpole=0
        onvine=0

        if (spin) {
            jumpedoutspin=1
            fall=0
            //spinplus=0
			if !ckey spin=0
            //if !down spin=0
        } else {if !star fall=1}
    }
    controlfire=0
    onvine=0
            
    grabflagpole=0
    latchedtoflagpole=0
            
    sprite_angle=0
            
    jump=1
    //fall=0
    braking=0
    //spin=0
    canstopjump=1
    if (mymoving) hsp+=avgmovingh
    if (spin && !star) seqcount=0
    jumpspd=min(1,0.5+abs(hsp)/5)

	jumpdelay=0
}

if (akey) {
    if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {
    if (canstopjump=1 && jump && vsp<-2 && !sprung && !superjump) {
        vsp*=0.5
    }
    canstopjump=0
}

//code for specifically the b button
if (bbut) {
    if (!fired && !fired2 && !firedc && !insted && !spin && !pound) {
        xsc=esign(right-left,xsc)
        turning=xsc
        turned=turning
            
        if (up) {
            kek=0
            with (projectile) {if (type="bowshammer" && owner=other.id) owner.kek+=1}
            
            if (kek<2) {
                fired2=15
                if (sprite="throw") frame=0
                playsfx("bowserhammer")
                type="bowshammer"
with (fire_projectile(x+xsc*12,y-10+16*(size==5))) {
//bowshammer=1
//doonce returns from old giana
                    if (!doonce) {
                        xsc=other.xsc
						hspeed=other.xsc*0.8
                        //hspeed=other.xsc+other.hsp*0.8
                        vspeed+=other.vsp*0.5
                        owner=other.id orig=other.id
doonce=1 
}
}


                //1.9 code
                /*
                with (bowshammer) if (owner=other.id) kek+=1
                if (kek<2) {
                    playsfx("bowserhammer")
                    with (instance_create(x+xsc*12,y-10,bowshammer)) {
                        xsc=other.xsc
                        hspeed=other.xsc+other.hsp*0.5
                        vspeed+=other.vsp*0.25
                        owner=other.id orig=other.id
                    }
                }
                */
            }
        } else {
if (crouch) {firedc=30 if (sprite="firedcrouch") frame=0}
            else {fired=30 if (sprite="fired") frame=0}

            playsfx("bowserfire")
            kek=0
            with (projectile) {if (type="bowserfire" && owner=other.id) fade=1}
            type="bowserfire"
//with (fire_projectile(x+xsc*16,y-10+16*(crouch || size=5))) {
with (fire_projectile(x+xsc*24,y-6+12*(crouch || size==5))) {
//bowserfire=1
if !doonce {
                    hspeed=(2+abs(other.hsp))*other.xsc
                    xsc=other.xsc
                    owner=other.id orig=other.id
                    if (!other.crouch) other.controlfire=id
doonce=1 
}
}


            //1.9 code
            /*
            kek=0
            with (bowserfire) if (owner=other.id) fade=1
            with (instance_create(x+xsc*16,y-10+16*crouch,bowserfire)) {
                hspeed=(2+abs(other.hsp))*other.xsc
                xsc=other.xsc
                owner=other.id orig=other.id
                if (!other.crouch) other.controlfire=id
            }
            */
        }
    }
}
//i forgot youre supposed to control the fire by holding b oops
if (!bkey) {controlfire=noone}

if (ckey) {
    if (!jump && !braking && !spin) {
        if (abs(hsp)<0.5) { //Crouch if not moving 
			if (!crouch) {
                if (!controlfire) {
                    if (right || left) {spin=1 if (spinplus) {hsp=maxspd*xsc} else {hsp=xsc*3} playsfx("bowserspin")}
                }
            }
		} else if (!spin && !crouch && !controlfire) { //or spin if you are
            if (left || right) {
			spin=1
			playsfx(name+"spin") 
			if (spinplus) {hsp=maxspd*xsc} else {hsp=xsc*3}
			} //else hsp=0
        }
    }
    poundlok=1
    com_piping()
} else {
	mask_temp(12,12)
    if (!jump) {
        //if (collision(0,-16) && size!=5) {spin=1} //puts you into a spinning state if you jumped into something
        //crouch=0
    }
}

//crouching and spinning
if (down && !up) {
    if (jump) {
        if (!pound && !poundlok && !insted && !controlfire && fall!=69) {pound=1 spin=0 jumpedoutspin=0 spinplus=0 playsfx("bowserbomb")}
    } else if (!braking /*&& !spin*/) {
        //if (abs(hsp)<0.5) {//Crouch if not moving 
            if (!crouch) {
                if (!controlfire) {
                    /*if (right || left) {spin=1 if (spinplus) {hsp=maxspd*xsc} else {hsp=xsc*3} playsfx("bowserspin")} else*/ 
					{spin=0 crouch=1 playsfx("bowserduck")}
                }
            }
        /*}*/ /*else if (!spin && !crouch && !controlfire) { //or spin if you are
            if (left || right) {
			spin=1
			playsfx(name+"spin") 
			if (spinplus) {hsp=maxspd*xsc} else {hsp=xsc*3}
			} else hsp=0
        }*/
    }
    poundlok=1
    com_piping()
} else {
    if (pound=-1) pound=0
    if (!jump) crouch=0
    poundlok=0
    
    mask_temp(12,12)
	if (!jump) {
        //if (collision(0,-16) && size!=5) {spin=1} //puts you into a spinning state if you jumped into something
		if (collision(0,-8) && size!=5) {spin=1}
        crouch=0
    }
    mask_reset()
    
}

if (size==5) mask_set(9,8)
else if (crouch || spin || insted || jumpedoutspin) && !pipe mask_set(26,22)
else mask_set(26,28)

#define movement
if (piped || move_lock) exit

//speed limits
if (!jump) if (loose || spin || crouch) {
    braking=0
    frick=0.06
    //if (spin) frick=0.005
    hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

//speed cap rubberband formula
maxspd=(2.5-(0.5*jump)+(0.5*spinplus)+(0.5*insted)+((size==5)*0.55)+(0.75*((spin||jumpedoutspin))-!!superjump))*wf //Your Maximum speed
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp) //This is what sets your speed to max if you're goign too fast

if (pound) {
vsp=8
} else vsp=min(7+downpiped,vsp) //It makes it so you can't enter mach 10 while falling
//if (spin) hsp=3*xsc*wf

///movement
//hi moster here dont uncomment the yground or easyground stuff because its required for the cool new slope system to work
//for anyone porting a charm from unfinished build or below to this build, delete or comment all of the commented code and add player_nslopforce()
calcmoving() 

if (!dead && !grabflagpole) {
if fall!=69
player_nslopforce() //Handles some slope stuff (idk i didnt pay attention in sloping school)
player_horstep() //Disables moving like normal if you're climbing
    //yground=easyground()
//if (yground!=verybignumber) yground-=14
    if (jump) {
        //gravity
        hang=0
        stamped=0
        if (pound) {
            if (pound<20 && !superjump) vsp=0
            else vsp=8*wf
        } else if (water) vsp=min(1.5,vsp+0.04)
		else if fall!=69 { //Makes sure you aren't affected by gravity while climbing
            if (insted=1) {
                vsp+=0.05*wf
                if size==5 && vsp>-0.15 vsp-=0.035
            } else {
			    if (superjump && vsp<0) vsp+=0.25*wf
                else vsp+=0.15*wf
                if size==5 && vsp>-0.45 vsp-=0.105
            }
        }
        if (!hurt) vine_climbing() //The common code for all climbing acts
landanim=0
superlandanim=0
        crouch=0
        braking=max(0,braking-1)
        if (!fall && !jumpedoutspin) fall=1
        if (pound=-1) pound=0
        if (sprung && !fall) fall=1
        push=0 spin=0 
        coyote=0
        osld=0
        player_vertstep() //Mmoves you up and down
        if (!jump) sld=point_direction(0,0,1,slobal) //Sets your slope position when you land
    }

sprite_angle=0
if (osld<180 && osld>0 && !instance_place(x-16,y+4,ground)) dy=3 //makes it so you dont look like you're floating when on a slope
else if (osld>180 && osld<320 && !instance_place(x-16,y+4,ground)) dy=3 //makes it so you dont look like you're floating when on a slope

    if (!jump) {
//if (yground!=verybignumber) {y=yground while collision(0,0) && !collision(0,-8) {y-=1 }}
osld=sld
sld=point_direction(0,0,1,slobal)
if (!jump && abs(hsp)>=maxspd && spin) {
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
                if (spin) {/*fall=5*/ fall=0 insted=2}
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
                if (insta) insted=1
            }
        }
    }
}
com_finishmove()


#define actions
com_warping()
com_actions()

/*
if (useypos) {
if (jump && (sprite="fired" || sprite="throw")) {ypos=1}
else ypos=0
} else*/ ypos=0

weight=2


// VULNERABILITY AND PLAYER COLLISION

//Intangibility
is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1) is_intangible=1

//Power levels
power_lv=0
is_coinexplosive=0
if (spin || (jump && (!fall || fall=5))) power_lv=1
if ((crouch || spin)) power_lv=3
if (!poundcancel && pound) power_lv=3
if (star) power_lv=5
if (super) power_lv+=1

//Special interactions
pvp_spin=spin //Rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=!pound //Make sure to set for 0 for the mario bros when pounding
pvp_ignore=pound //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away

if (size!=5) {
if (vsp>5||pound) break_crackedground=2
else break_crackedground=1
//else if (glideanim) break_crackedground=3
} else break_crackedground=0
//1 for Horizontal only, 2 for Vertical 3 for All directions

if (size!=5 && (superjump=16 || glideanim)) {
crack=instance_place(x,y-16+vsp,crackedground)
    if (crack ) {//CRRRACKKKKKKKKK
        with crack event_user(0)
    }
}

if (piped) {jumpedoutspin=0 insted=0 spinplus=0}
//whoputshitinyourpip
if (piped) exit

//waiting animation
if maxwait{
if (sprite="stand")
{waittime+=1}
else if sprite!="wait" waittime=0
}

//grounded state
if (!jump) {
    vsp=0
    if (!star && !spin) seqcount=0
    hang=0
jumpedoutspin=0
superjumpanim=0
glideanim=0

    /*
    //skidding
    if (push=0 && hsp!=0 && braking) {
        playsfx(name+"skid")
        skidding=1
    } else if (skidding) {soundstop(name+"skid") skidding=0}
    */
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
    /*if (braking || fall=3) {
        i=shoot(x,y+10,psmoke) i.depth=depth+2
    }*/
    if (vsp<-5-2*!sprung) {
        shoot(x,y+8,psmoke,0,-1)
    }
    if (vsp>7) {
        speedwagon+=1
        if (speedwagon>60) shoot(x,y,psmoke,0,1)
    } else speedwagon=0
    if (abs(hsp)>4 && boostvar>=0.75 && !jump) shoot(x-12*xsc,y+12,psmoke,0,0)
}


//sspin
global.coll=id
//bowser doesnt use this for some reason
/*
if (spin) {
    coll=instance_position(x-10*sign(hsp),y+22,hittable)
    coll2=instance_position(x,y+22,hittable)
    
     if (coll2) if (coll2.object_index!=brick) coll=coll2
    if (coll) if (coll.hit) coll=0
    if (coll=spinblacklist) coll=0
    if (!coll)
        with (hittable)
            if (id!=other.spinblacklist && (object_index!=brick) && !hit)
                if (instance_place(x,y-4,other.id)) other.coll=id
    
    if (coll) if (!coll.goinup || tempbrick) {
        i=coll.object_index
        hitblock(coll,id,0,1,0)
        if (i=brick) {spinblacklist=coll}
    }
    
    //stop spinning
    if (abs(hsp)<0.2) { 
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
*/

if (spin) {
    //stop spinning
    if (abs(hsp)<0.2) { 
            spinc+=1 if (spinc=8) {
            mask_temp(12,24)
            if (collision(0,0) && size!=5) {
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
				spinplus=0
            }
            mask_reset()
        }   
    }
}

bartype=0
energy=min(6,energy)
maxe=energy
//size=!!energy
    
//if (flash) {fk+=1 if (fk>120) {flash=0 fk=0}}
/*
if (spinonce) {
    if (hsp=0) {hsp=1} xsc=sign(hsp) spinplus=0 hsp=maxspd*xsc
}
*/
if (spin) {
	if (hsp=0) {hsp=1} 
	xsc=sign(hsp) hsp=maxspd*xsc
	if (rise!=0) {risec+=1 if (risec=10-5*(size=0)) {risec=0 rise=0 crouch=down} else {crouch=1 hsp=0 xsc=rise}}
    turning=xsc
    turned=xsc
}
if (jumpdelay) {
    if (!jump) {
        jumpdelay-=1
        //if (jumpdelay=1) {actualjump=1 jumpdelay=0}
    } else jumpdelay=0
}
if (superjump) {
    if (!jump) {
        if (superjump<=16) superjump+=1
        if (superjump=16) {
		    vsp=-7.75 //-7 
			jump=1 playsfx("bowsersuperjump2",0,1+(size==5)/3) 
			shoot(x-8,y+4,psmoke,-2,-1) shoot(x+8,y+4,psmoke,2,-1) 
			/*instance_create(x,y+8,poundeff)*/ superjumpanim=1
		}
    } else {
	    if vsp>=-1 {pound=1 spin=0 jumpedoutspin=0 spinplus=0 superjump=0}
	    //if (vsp>=-2) {superjump=0}
	}
}
if (superjump>16) superjump=0
if (vsp>=-2 && !superjumpanim) {soundstop("bowsersuperjump2")}
turned+=median(-0.1,turning-turned,0.1)
if (abs(turned)!=1) {xsc=esign(turned,1) hsp*=0.9}
if (insted) {
    if (vsp>0) insted=2    
    xsc=esign(hsp,xsc)
    turning=xsc
    turned=turning
}
if (pound) {    
    crouch=1
    if (pound<20) {pound+=1 hsp*=0.95}
    else {if !superjumpanim hsp=0 fall=4}
} else poundcancel=0
if (controlfire) controlfire.y=median(controlfire.ystart-48,controlfire.y+(down-up),controlfire.ystart+32)
if (rise!=0) {crouch=1 hsp=0 xsc=rise risec+=1 if (risec=10) {risec=0 rise=0 crouch=down}}   

if (size!=0 && size!=5) size=0
if alarm[7]=0 energy=0
fired2=max(0,fired2-1)
firedc=max(0,firedc-1)
hurtanim=max(0,hurtanim-1)
swim=max(0,swim-1)
landanim=max(0,landanim-1)
superlandanim=max(0,superlandanim-1)
if (hsp=0 || (abs(hsp)<2)) spinplus=0

if (spinplus>0) spinplus-=0.02
spinplus=min(spinplus,spinspdmax)


if (abs(hsp)<maxspd) {}

if (size=5) {if (vertbowser) vertbowser=0}
else {if (!vertbowser) vertbowser=1}

if (size=5 && (mxsc!=0.5 && mysc!=0.5)) {mxsc=0.5 mysc=0.5} 
else if (size!=5 && (mxsc=0.5 && mysc=0.5)) {mxsc=1 mysc=1}

//WHO IS CLIMBING MY SHIT.
if (up && !down && !onvine) {
    onvine=instance_place(x,y,vine)
    if (onvine) fall=69 //nice
}
if (onvine) {pound=0 superjump=0 superjumpanim=0 insted=0}
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

//Christianity moment (makes you stand on water)
//jesus=(boost && vsp<4 && !water)



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
        
        if (vsp>5) {
			if (size==5) {
				playsfx(name+"jump",0,3.6) vsp=-3-((ckey && spin) || (akey && star))*1.5 canstopjump=akey pound=0 enemydie(coll) exit
			} else enemyexplode(coll) exit
		}
		if (insted) {enemyexplode(coll) exit}
            
        if (coll.object_index=lakitu) if (coll.flee) exit
        if (crouch) {coll.hsp=abs(coll.hsp)*sign(coll.x-x) exit}
        if (star
        || ((spin || jumpedoutspin) && type!=spinyegg && type!=beetle && type!=koopa && !object_is_ancestor(type,koopa) && type!=shell)
        || (pound>13 && type!=piranha && type!=spinyegg && type!=spiny)) {
            if size==5 && !spin && !star && (hurt || piped || (intangible() && !diggity)) {if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"jump",0,3.6) vsp=-3-((ckey && spin) || (akey && star))*1.5 canstopjump=akey if !pound exit else pound=0}
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            if (type=hammerbro) seqcount=max(5,seqcount)
            if (spin || jumpedoutspin) {/*hsp+=3*xsc*/ spinplus+=1}
            enemydie(coll)                
            exit
        }
        
        if (inst) {if (diggity=32) exit enemyexplode(coll) exit}
        
        if (type=piranha) {
            hurtplayer("enemy")
            exit
        }
        
        
         
        if (spin || jumpedoutspin) {
            if (type=shell) {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else if (coll.type!="beetle") {spinplus+=1 enemydie(coll) exit}}
            else if (type=koopa|| object_is_ancestor(type,koopa)) {spinplus+=1 with enemyflip(coll) {y-=3 vspeed=-3 intangible_timer=30} exit }
            else if (type=beetle ) {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else {hsp=0 jump=1 jumpspd=0.5 spin=0 enemystomp(coll) exit}}
            else if (type=spinyegg) {hurtplayer("enemy") exit}
            else {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-ckey*1.5 canstopjump=akey exit} else {spinplus+=1 enemydie(coll) exit}}
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
                            if size==5 playsfx(name+"jump",0,3.6)
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
                    if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey if fall=12 fall=5 exit}
                    with (coll) {hspeed=0 owner=noone phase=other.id stop=0 kicked=0 time=15}
                    vsp=-3-akey*1.5 canstopjump=akey sound("enemystomp") doscore_p() if (fall=12) fall=5 exit
                }
            }                    
        }
        
        if (type=blooper) {
			if (jumpedoutspin) {
				if (jump && (!calcfall || !water) && vsp>0 && size!=5) {if (calcfall) enemystomp(coll,5) else enemyexplode(coll)}
				else if (size==5 && jump && (!calcfall || !water) && vsp>0) {
				   vsp=-3-akey*1.5
				   canstopjump=akey
				   if (fall=12) fall=5
				   playsfx(name+"jump",0,3.6)
				}
				else hurtplayer("enemy") exit
			}
            else if (jump && (!calcfall || !water) && vsp>0) {if (calcfall) enemystomp(coll,5) else enemyexplode(coll)}
            else hurtplayer("enemy") exit
        }
        
        if (type=cheepred || type=cheepwhite) {
			if (jumpedoutspin) {
				if (jump && !calcfall && size!=5) {enemyexplode(coll) exit}
				else if (!calcfall && size==5 && jump) {
					if (vsp>0) {
					vsp=-3-akey*1.5
					canstopjump=akey
					if (fall=12) fall=5
					playsfx(name+"jump",0,3.6)
					} else {hurtplayer("enemy")} exit
				}
			}
            else if (jump && !calcfall) {enemyexplode(coll) exit}
            else {hurtplayer("enemy") exit}
        }
        
        if (jump) {
            if (type=koopa || type=beetle || type=rexbig || object_is_ancestor(type,koopa)) {
                if (vsp<0) {
                    if (calcfall) hurtplayer("enemy")
                    else if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit}
                    else enemyexplode(coll) exit
                }
            } else {
                if (!calcfall && size!=5) {enemyexplode(coll) exit}
                if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey if fall=12 fall=5 exit}
                if (vsp<0) {hurtplayer("enemy") exit}
            }
            
            if (type=bulletbill)
            {
            if (coll.vspeed<0 && coll.y>y+8) {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit} else {jump=1 fall=1 dive=0 vsp=-0.5 enemydie(coll) exit}}
            }
            
            if (type=goomba && seqcount=1 && !scorelok4) {seqcount=0 scorelok4=1}    
            if ((type=koopa || type=redkoopa) && seqcount=1) scorelok1=1    
            if (type=hopkoopa || type=redhover) seqcount=max(seqcount,1)
            if (type=hammerbro) seqcount=max(5,seqcount)
            if (fall=12) fall=5                        
            if size==5 {if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit}
            enemystomp(coll) exit      
        } else if (coll.vspeed<0 && coll.y>y+8) {if size==5 {playsfx(name+"jump",0,3.6) vsp=-3-akey*1.5 canstopjump=akey exit} else {jump=1 fall=1 vsp=-0.5 enemystomp(coll) exit}}
        
        hurtplayer("enemy")   
     } else if (!star && !flash) hurtplayer("enemy")
}    


#define hurt
pipe=0
sprongin=0
speed=0
if (skidding) {soundstop(name+"skid") skidding=0}
if (carry && carryid) {with (carryid) event_user(0) carryid=noone carry=0}

//energy=0
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
onvine=0
if (super) stopsuper()   

if (((!size || size==5) || ohgoditslava) && !shielded && !energy && global.rings[p2]==0) {
   if (global.mplay>1 || global.debug || global.lemontest) alarm[7]=120
   if (global.gamemode="battle") dropcoins(0)
   energy=0
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
    
    fired=0 fired2=0 firedc=0
    flash=1
    if (shielded) {shielded=0} 
else if global.rings[p2]>0 {droprings()} 
else {energy-=2}
hurtanim=24
    /*
    jump=1 
    hurt=1+starhit 
    if (!starhit) if (shielded) {shielded=0} 
    else {if size=3 size=1 else size-=1}
    */
    
}


//Block hitting

#define hitblocks
if typeblockhit=0{
with (blockcoll){
/*if (stonebump || owner.size=0 && insted!=1 && !owner.tempkill && cracked=0) {
    if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
} else */{ 
    if (stonebump || owner.size=5 && insted!=1 && !owner.tempkill && (biggie || cracked=0 || (cracked=1 && owner.size=5))) {
        if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
    } else if (stonebump || owner.size!=5 && insted!=1 && !owner.tempkill && cracked=0 && biggie) { //break spiner
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
 }
} else if typeblockhit=1{
hititembox()
}

#define hitwall
skiphsp=0
//hit blocks sideways
if ((spin && abs(hsp)>0.5) || (insted) || jumpedoutspin) {
    global.coll=id
	coll=collision(hitside,0)
    with (hittable) if (instance_place(x-other.hitside,y,other.id)) {
    go=-1
        insted=1
        event_user(0)
    insted=0
    }
    coll=collision(hitside,0)
    canpipejump=0
}

if (coll=noone) exit

if (!collpos(sign(hitside)*10,8,1)) {        
    //gap running
    if (y<coll.y-12) {y=coll.y-14 coll=noone exit}
}

coll=collision(hitside,0)
if ((coll.object_index!=brick || coll.object_index!=crackedblock || coll.object_index!=monitor || coll.object_index!=monamie || coll.object_index!=monitordead || coll.object_index!=crate) && (spin || jumpedoutspin)) {
	instance_create(x+14,y+4,kickpart) 
	xsc*=-1
	if (abs(hsp)<3) {hsp=3*xsc} else {hsp*=-1} 
	skiphsp=1
	sound("itemblockbump") exit
}
else com_piping()

if (!skiphsp) hsp=0
hyperspeed=0        


#define landing
braking=0
insted=0
jumpedoutspin=0
glideanim=0

if /*!down*/ !ckey {spin=0 spinplus=0}

if (downpiped) {
    shoot(x-8,y+4,psmoke,-2,-1)
    shoot(x+8,y+4,psmoke,2,-1)    
    downpiped=0
}
//if (hurt) {flash=1 fk=0 hsp=0 hurt=0}

if size!=5 {
if (vsp>5 && !stamped) {with (mydamager) {event="create" event_user(p2)} playsfx(name+"stomp") screenshake(x,4) stomp=1 com_piping() stomp=0 stamped=1 
if (!spin) if (pound || superjumpanim) superlandanim=16 else landanim=16}
}
superjumpanim=0

if (!pound || superjumpanim) {
    if (vsp>5 && size!=5) {
        //with (instance_create(x,y+16,robofall)) owner=other.id
        playsfx("bowserstomp") stomp=1 screenshake(x,4) com_piping() stomp=0
    } else {
		if (size!=5) {
			shoot(x-8,y+4,psmoke,-2,-1)
			shoot(x+8,y+4,psmoke,2,-1)    
		}
        //instance_create(x,y+8,poundeff)
        playsfx("bowserstep")
    }
}

//playsfx(name+"step")

//jump buffering
if (jumpbuffer) jumpbuffer=-1

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
        if (size!=5) playsfx(name+"stomp")         
        rise=xsc
        risec=-5
        //with (instance_create(x,y+16,robofall)) owner=other.id
        if (size!=5) screenshake(x,4)
        //shoot(x-8,y+4,psmoke,-2,-1)
        //shoot(x+8,y+4,psmoke,2,-1)    
        poundjump=16
    }
}

//fall into spin
if (!spin && rise=0 && !hurt /*&& down*/ && ckey && abs(hsp)>=0.5) {
	if ((left || right) || abs(hsp)>=0.5) {
		spin=1
		xsc=sign(hsp) turning=xsc turned=xsc playsfx("bowserspin") screenshake(x,2)
		if (spinplus) {hsp=maxspd*xsc} else {hsp=xsc*3}
	} else {spinplus=0 hsp=0}
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
		if (spinplus) {hsp=maxspd*xsc} else hsp=max(abs(hsp),2)*esign(hsp,xsc)
	}
}


#define death
if (event="create"){

alarmmp=60
alarm0=30
alarm1=180
gravity=0.075
sprite="dead"
frame=0
//frspd=1
alpha=1

owner.energy=0
owner.maxe=0

if global.mplay>1 alphadecay=1

if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
xsc=owner.xsc
ysc=owner.ysc
//vspeed=-3.5 gravity=0.1

if (size=5) {mxsc=0.5 mysc=0.5} else {mxsc=1 mysc=1}

} 
else if (event="step"){
if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
alarmmp=max(0,alarmmp-1)
alarm0=max(0,alarm0-1)
alarm1=max(0,alarm1-1)

if alphadecay &&!alarmmp alpha-=0.1

if alarm1=0 instance_destroy()

} else if (event="draw"){
}


#define enterpipe
if (type="side") {
    turning=xsc
    turned=xsc
    if (spin||crouch) {
		set_sprite("shell")
        frspd=min(1,0.1+abs(hsp/4))
        if (abs(hsp)>=(maxspd-1) && !underwater()) {fastpipe=1 playsfx(name+"spin")}
    }
    //set_sprite("shell")
	if (boost) {fastpipe=1}
}
if (type="up") {
	if (superjump) fastpipe=1
    //set_sprite("shell")
}
if (type="down") {
    if (pound=-1) {set_sprite("bomb") frame=frame_number(sprite) vspeed=5 alarm[6]=6 fastpipe=1}
    //else set_sprite("shell")
    if (stomp) {fastpipe=1}
}

if (skidding) {soundstop(name+"skid") skidding=0}
braking=0
crouch=0
push=0     
insted=2
jumpedoutspin=0
superjumpanim=0
glideanim=0
hurtanim=0
jumpdelay=0
spinplus=0
superlandanim=0
landanim=0


#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {turning=0 turned=0 sprite="turn" frame=1 frspd=0}
if (type="down") {}
