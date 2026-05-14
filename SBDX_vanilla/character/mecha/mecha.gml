#define spritelist
stand,wait,lookup,pose,crouch,knockstand,knockrun,deadair,prerun,run,turn,fly,jump,ball,spike,dead,claw,armless,armlessalt,climbing,flagslide,grind,piping,pipingup,sidepiping,doorenter,doorexit

#define soundlist
release,skid,spin,spindash,jet,splode,stomp,lookup,chain


#define movelist
Mecha Sonic
#
[a]: Jet (air)
[up] + [a]: Highjump
[b]: Claw
[c]: Charge Dash (hold)
<fire>
Mecha Sonic [flwr]
#
[a]: Jet (air)
[up] + [a]: Highjump
[b]: Spike Attack (air) / Claw (stand)
[c]: Charge Dash (hold)
<feather>
Mecha Sonic [fthr]
#
[a]: Jet (air)
[up] + [a]: Highjump
[b]: Claw
[c]: Charge Dash (hold)
[fthr] Increased energy recharge rate

#define rosterorder
3

#define skininit
var looper;

//graphic offsets
loopey=0
looper=0
repeat((projcoordbysize*MAXIMUMSIZESARGH)+1) {
	if (projcoordbysize) {
		looper=string(loopey)
	} else {looper=""}
	
	deathexplosion_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" death explosion graphic x"+looper),10) 
	deathexplosion_sheety[loopey]=nozerounreal(playerskindat(p2,name+" death explosion graphic y"+looper),87) 
	
	overlayspark_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" overlay spark graphic x"+looper),66) 
	overlayspark_sheety[loopey]=nozerounreal(playerskindat(p2,name+" overlay spark graphic y"+looper),33) 
	
	dashspark_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" dash spark graphic x"+looper),10) 
	dashspark_sheety[loopey]=nozerounreal(playerskindat(p2,name+" dash spark graphic y"+looper),112)
	
	claw_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" claw graphic x"+looper),112) 
	claw_sheety[loopey]=nozerounreal(playerskindat(p2,name+" claw graphic y"+looper),96)
	
	spike_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" spike center graphic x"+looper),125) 
	spike_sheety[loopey]=nozerounreal(playerskindat(p2,name+" spike center graphic y"+looper),68) 
	
	chargedash_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" charge dash graphic x"+looper),183) 
	chargedash_sheety[loopey]=nozerounreal(playerskindat(p2,name+" charge dash graphic y"+looper),88)
	
	loopey+=1
}


#define start
mask_set(18,26)
sparklvl=1
global.animatePrincess=1
vertbowser=1
spinspdmax=6
spinplus=0
jumpedoutspin=0


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
sparkcharge=0
chargestored=0
firedarm=0
spinplus=0
jumpedoutspin=0

#define effectsbehind

#define effectsfront
if iaminsidemyself=1 exit

if projectilepalettes scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[p2*100],global.pal_1[p2]+1,global.pal_2[p2]+1,global.pal_3[p2]+1,global.pal_4[p2]+1,size,alpha*(1-0.75*shadow),totpal+1)

if (hsp!=0 && !jump){
	
	draw_sprite_general(sheets[size* !global.singlesheet[p2]],0,margin+dashspark_sheetx[size*projcoordbysize]+(sparkanim*16),dashspark_sheety[size*projcoordbysize],15,8,x-(sign(hsp)*20),y+6+dy,sign(hsp),1,sign(hsp),$ffffff,$ffffff,$ffffff,$ffffff,1)
}
sparkanim=!sparkanim



if (abs(hyperspeed)) {
    draw_sprite_part_ext(sheets[size* !global.singlesheet[p2]],0,chargedash_sheetx[size*projcoordbysize]+40*floor(abs(hyperspeed*3) mod 2),chargedash_sheety[size*projcoordbysize],39,39,round(x-19.5*xsc),round(y-19.5-9+dy)+4,xsc,1,$ffffff,alpha)
}

if randomsparksGO mod 2{
	draw_sprite_part_ext(sheets[size* !global.singlesheet[p2]],0,overlayspark_sheetx[size*projcoordbysize],overlayspark_sheety[size*projcoordbysize],25,31,round(x-10),round(y-16+dy),1,1,$ffffff,1)
	
}if randomsparksGO randomsparksGO-=1

if projectilepalettes shader_reset()

if e_timer mod 3 || (sparkcharge && sparkanim){
	iaminsidemyself=1
	d3d_set_fog(true, c_white, 0, 1)
    ssw_core(0)
    d3d_set_fog(false, c_black, 0, 0)
	iaminsidemyself=0
}


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
		energy+=3
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
		oldsize=size
		size=2
		energy+=3
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
		oldsize=size
		size=3
		energy+=3
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
		oldsize=size
		size=5
		energy+=3
		itemget=1              
	}
	else if (type="star") {
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
		if (skindat("growsfx5"+string(p2))) playsfx("growsfx5") 
		else playgrowsfx("5")
		energy=maxe
		itemget=1       
	} //else if (type!="jumprefresh" && type!="1up" && type!="coin" && type!="ring") com_item()
}
if (type="coin") {
	sound("itemcoin")
	if (other.fresh) global.scor[p2]+=100
	global.coins[p2]+=1
	coint+=1
	energy+=1
	hit=1
	itemget=1
}
else if (type="ring") {
	sound("itemring")
	if (other.fresh) global.scor[p2]+=100
	global.rings[p2]+=1
	energy+=1
	hit=1
	itemget=1
} 
com_item()



#define endofstage
right=1
grabbedflagpole=0
if (hsp>=3 || push) {
	akey=1
}


#define damager
y=-1000
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
    //Jets and Powersaw
    hittype="pvp"
    ox=x
    oy=y
    image_xscale=12
    if (owner.jet && !owner.piped) {x=owner.x+owner.xsc image_yscale=kek kek=max(8,kek-1) go=1 y=owner.y+12+kek}
    else {
        kek=14
        if (owner.lookup && !owner.piped) {x=owner.x-owner.xsc*5 image_yscale=16 go=-1 y=owner.y-6}
    }
    if (owner.jet || owner.lookup) {
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
                enemyexplode(coll)
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
    if (!owner.jet && !owner.lookup && !stomp) y=-1000
}


#define projectile
if event="create" {
	is_spike=owner.spikin
}
if is_spike{
ignoreoncount=1
if (event="create") {
image_xscale=4
image_yscale=4

frame_sub=0
frame=0
brickc=0
seqcount=2
getregion(x) 
timer0=3
timer1=128
speed=5
}
if (event="step") {
timer0-=1 if (timer0=0) visible=1
timer1-=1 if (timer1=0) instance_destroy()
calcmoving()

frame_sub=!frame_sub
if frame_sub frame+=1
if (frame>=3) frame=0

if (!inview()) instance_destroy()
xsc=1
ignoreoncount=1
coll=instance_place(x,y,collider)
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll.object_index=brick) brickc+=1 else brickc=4
hitblock(coll,owner,1,go,1)
}    
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

}
if (event="draw") {

if owner.projectilepalettes scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[owner.p2*100],global.pal_1[owner.p2]+1,global.pal_2[owner.p2]+1,global.pal_3[owner.p2]+1,global.pal_4[owner.p2]+1,owner.size,1*(1-0.75*shadow),owner.totpal+1)

draw_sprite_part_ext(owner.sheets[owner.size*!global.singlesheet[owner.p2]],0,

(owner.spike_sheetx[owner.size*owner.projcoordbysize])+((direction<90)||direction>240)*13-((direction>90)&&direction<240)*13  ,
(owner.spike_sheety[owner.size*owner.projcoordbysize])-((direction<180)&&direction>0)*13+((direction>180)&&direction<360)*13  ,
12,12,round(x-8),round(y-8),xsc,1,$ffffff,1)
}

if owner.projectilepalettes shader_reset()

} else {
ignoreoncount=0
if (event="create") {
image_xscale=4
image_yscale=8

frame_sub=0
frame=0
brickc=0
seqcount=2
getregion(x) 
visible=1
retract=50
extend=0
captype=-1
}


if (event="step") {
calcmoving()

y=owner.y+4*(owner.size==5)
if extend<5 {
extend+=1
x= owner.x +owner.xsc*((56*extend)/4)
} 
if (extend>=4) {
retract-=1
if retract<=0 {
if captype!=-1 {
switch (captype){
case mushroom:
give_item(owner.id,"mushroom") break;
case lifemush:
give_item(owner.id,"1up")
with (instance_create(x,y-16,scoreeffect)) value=10

break;
case flower:
give_item(owner.id,"fflower") break;
case feather:
give_item(owner.id,"bfeather") break;
case starman:
fuel=660
give_item(owner.id,"star") break;
default:
instance_create(owner.x+owner.hsp,owner.y,captype)
}

}

instance_destroy()
}
x=owner.x +owner.xsc*((56*retract)/50)
}
xsc=owner.xsc

coll=instance_place(x,y,enemy)
if (coll) {
if (coll.object_index!=beetle && coll.object_index!=bombenemy 
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
}
coll=instance_place(x,y,collider)
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll.object_index=brick) brickc+=1 else brickc=4
hitblock(coll,owner,1,-1,1)
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
instance_destroy()
}
}

coll=instance_place(x,y,player)
if (coll) {
if (coll.id!=owner) if (!invincible(coll)) {    
if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
if (coll.name="mecha" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) instance_destroy() exit}
with(coll) fragplayer(other.owner)
}

}
}
coll=instance_place(x,y,item) 
if coll{

if coll.object_index=shard {/*nothinglol*/}
else if (coll.object_index=redcoin) with (coll) {gibcoinred(other.owner) instance_destroy()}
else if (coll.object_index=coin) with (coll) {if (!noglitter) instance_create(x,y,glitter) give_item(other.owner,"coin") instance_destroy()}
else if (coll.object_index=key)||(coll.object_index=card) with (coll) {x=other.owner.x y=other.owner.y}
else if (captype=-1) {captype=coll.object_index biome=coll.biome with (coll) {instance_destroy()}}
}


}

if (event="draw") {
   
if owner.usepalette scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[owner.p2*100],global.pal_1[owner.p2]+1,global.pal_2[owner.p2]+1,global.pal_3[owner.p2]+1,global.pal_4[owner.p2]+1,owner.size,1,owner.totpal+1)
    
depth=owner.depth+1
if global.debug draw_self()
w=8+(abs(x-owner.x))
draw_sprite_part_ext(owner.sheets[owner.size* !global.singlesheet[p2]],0,(owner.claw_sheetx[owner.size*owner.projcoordbysize]+63)-(w),owner.claw_sheety[owner.size*owner.projcoordbysize],w,15,round(x-(w-8)*xsc),round(y-8),xsc,1,$ffffff,1)
    
if owner.usepalette shader_reset()
    
if (captype) {
if (captype=mushroom) ssw_items("mushroom") 
if (captype=flower) ssw_items("fflower")
if (captype=feather) ssw_items("bfeather")
if (captype=lifemush) ssw_items("lifemush")
if (captype=starman) ssw_items("star")
if (captype=starshard) ssw_items("shard")
if (captype=mushpoison) ssw_items("mushpoison")
}

}

}


#define grabflagpole
grabflagpole=1
hsp=0
vsp=0

#define sprmanager
frspd=1
keepframebetween=0
if (grabflagpole) {sprite="flagslide"}
else if (transform) {sprite="transform"}
else if (alarm[5]) {sprite=knockspr}
else if (staydash) {sprite="run"}
else if (fired /*chain>0*/ && !jet && !(turning && turning<maxturning-8 && turning>8)) {cantslowanim=1 sprite="claw" /*frspd=2*/}
else if (spindash) {sprite="ball" frspd=spindash/6}
else if (crouch) {sprite="crouch"}
else if (jump) {
if (onvine) 
{
sprite="climbing" frspd=sign(left+right+up+down)
}
    else if (jet) {sprite="fly" /*frspd=0.4*/}
    else {if (jumpedoutspin) sprite="ball" else if fall=1 sprite="prerun" else if (fall) sprite=fallspr else {if (spikefired) sprite="spike" else sprite="jump"} if (fallspr="turn") fallspr="run" frspd=fallspd}
} else {
    if (spin) {sprite="ball" frspd=0.5+abs(hsp/6)}
    else if (turning && turning<maxturning-8 && turning>8) {sprite="turn" frspd=0.3*sign(turning-middleturning) cantslowanim=1}
    else if (hsp=0) {
        if (posed) sprite="pose"
        else if (lookup) {sprite="lookup"}
        else if (waittime>maxwait) {sprite="wait"}
        else {sprite="stand"}
    } else {
        if (abs(hsp)>1.5 && sign(hsp)=xsc) && (left || right) {sprite="run" if oldspr="prerun" keepframebetween=1 frspd=abs(hsp/3)}
        else if (abs(hsp)<1 && loose) {sprite="stand"}
        else {sprite="prerun" if oldspr="run" keepframebetween=1 frspd=abs(hsp/3)}
    }
}
if !fired && count_projectiles() && sprite!="fly" && sprite!="turn" && sprite!="ball" && sprite!="jump" && sprite!="spike" {
if (hsp=0 || sprite="flagslide") sprite="armlessalt"
else sprite="armless"
}

#define controls
com_inputstack()

tempbrick=0

//situations in which it should skip controls entirely
if (hurt || piped || move_lock) {
    di=0
    exit
}

if (up) com_piping()
oup=up

if (up && (!hang || !size || size==5)) {
    if (hsp=0 && !jump) lookup=1
} else lookup=0 

if (lookup && !taunted && (!position_meeting(x,y+8,door) || !position_meeting(x,y+8,chardoor) && !pipe)) {
	playsfx("mechalookup") 
	taunted=1
} 
if (!lookup) {soundstop("mechalookup") taunted=0}

maxturning=25+((20*wf)*water)
middleturning=floor(mean(0,maxturning))

//list of things that prevent you from moving
if (spindash || (crouch && !jump) || (super && fall=10) || vinegrab || spin /*|| e_timer || (sparkcharge&&!chargestored)*/) h=0

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
        if (!jump && !spin && !crouch && !firedash && /*!ckey &&*/ xsc=h) push=h
    }
    if (!jump) {
        if (hsp=0 && !coll && !instance_place(x,y+4,spring)) {
            playsfx(name+"release") 
            i=instance_create(x-4*t,y+4,smoke) i.hspeed=-2*h i.vspeed=-1 i.friction=0.1
            i=instance_create(x-4*t,y+4,smoke) i.hspeed=-2*h i.vspeed=1 i.friction=0.1
        }
        if (xsc!=h && !count_projectiles() && !(chain>0 && chain<11)) {
            if (!turning) {turning=maxturning turndir=h}
        } else {if (!turning>middleturning) turning+=1 if (turning>=maxturning) turning=0}
        if (!coll) hsp+=(0.3+0.2*(abs(hsp)<1.4)+0.02*(size==5))*wf*h
    } else if (!coll) {
        hsp+=0.06*wf*h
        if (firedash) collwin=instance_place(x+hsp,0,goalblock)
        if collwin {hsp=0 fallsprite="dash" collwin.owner=id with collwin{ event_user(4)}}
        
    }
}

if (turning) {
    turning-=1
    if (turning=middleturning) xsc=turndir
}
if (jump || spin) turning=0

if (push!=h) push=0

com_di()

//code for specifically the a button
if ((abut || jumpbufferdo) && !springin && !spindash) {
    if (!jump||fall=69||grabflagpole) { //jump
        if (hsp==0 && crouch && push==0 && size && size!=5 && !vinegrab && !spindash &&!grabbedflagpole) {
            playsfx(name+"spindash",0,1+(median(0,spindash-1,3)/3)*skindat("pitchdash"+string(p2)))
            spindash=1
            tempbrick=1
        } else {
            jumpsnd=playsfx(name+"jump",0,1+((size==5)/3))
            vsp=-4.20 //swagger
            if (up) {energy=max(0,energy-2) playsfx(name+"step")  vsp-=2 instance_create(x,y+8,smoke)}
			grabflagpole=0
            latchedtoflagpole=0

            if (water) vsp=-sqrt(sqr(vsp)*wf+2)
            onvine=0
            //change jump angle in steep slopes
            vd=point_direction(0,0,hsp,vsp)+point_direction(0,0,1,slobal/2)
            vm=point_distance(0,0,hsp,vsp)
            hsp=lengthdir_x(vm,vd)
            vsp=lengthdir_y(vm,vd)

            sprite_angle=0
if sparkcharge{chargestored=1}
			if (spin) jumpedoutspin=1
			spin=0
            jump=1
            fall=0+up-!!(size=3)
            braking=0
            canstopjump=1
            if (mymoving) hsp+=avgmovingh
            crouch=0
            if (spin && !star) seqcount=0
            fallspd=min(1,0.5+abs(hsp)/5)
        }
    } else { //air jumps
        if (energy>0 && !jetdead) {
            jet=1
            fall=1
            with (instance_create(x-4,y+16,smoke)) {hspeed=-1 vspeed=2 friction=0.1}
            with (instance_create(x+4,y+16,smoke)) {hspeed=1 vspeed=2 friction=0.1}
            playsfx(name+"jet")
			spinplus=0
			jumpedoutspin=0
        }
        jumpbuffer=4*!jumpbufferdo
    }
}
jumpbufferdo=0
springin=0

if (akey) {
    if (spindash) spindash=min(4,spindash+0.04)
    if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {
    if (canstopjump=1 && jump && vsp<-2 && !sprung) {
        vsp*=0.5
    }
    if (jet) {jet=0 soundstop(name+"jet") fall=1 fallspr="stand"}
    canstopjump=0
}

//code for specifically the b button
if (bbut ) {
if (jump && !fall && size=2 && !insted) {
            insted=1
            kek=0
            with (projectile) if (owner=other.id && ignoreoncount) kek+=1
            if (energy=6 && kek<15) {
                energy=0
                jetdead=1
spikin=1
spikefired=25
                playsfx("mechaspike")
                for (kek=0;kek<8;kek+=1) {
                    o=fire_projectile(x,y)
                    o.direction=kek*45
                }
spikin=0
            } else {
                playsfx("mechastep")
                instance_create(x+hsp+2*xsc,y,smoke)
}
}
else {if (!count_projectiles()) && !(chain>0 && chain<11)
if (!count_projectiles()) {fired=19 frame=0}
chain=1 turning=0}
}

if (cbut) {
if chargestored{
//Do the deed

hsp=maxspd*(right-left)
if hsp=0
hsp=maxspd*sign(xsc)
hyperspeed=(sparkcharge)*sign(hsp)
xsc=sign(hsp)

e_timer=0
sparkcharge=0
chargestored=0
turndir=xsc
turning=0
playsfx(name+"release") 
i=instance_create(x-4*t,y+4,smoke) i.hspeed=-2*h i.vspeed=-1 i.friction=0.1
i=instance_create(x-4*t,y+4,smoke) i.hspeed=-2*h i.vspeed=1 i.friction=0.1

}
}

if (ckey){
//Start charging bitch
if e_timer<=0 && !chargestored {
if energy>0 && sparkcharge<6 {
if sparkcharge>-1 energy-=1
sparkcharge+=2
e_timer=30
}

} else e_timer-=1
} else { 
if !chargestored && sparkcharge && abs(hyperspeed)<0.5 {
//Do the deed

hsp=maxspd*(right-left)
if hsp=0
hsp=maxspd*sign(xsc)
hyperspeed=(sparkcharge-1)*sign(hsp)
sparkcharge=0
chargestored=0
xsc=sign(hsp)
turndir=xsc
turning=0
playsfx(name+"release") 
i=instance_create(x-4*t,y+4,smoke) i.hspeed=-2*h i.vspeed=-1 i.friction=0.1
i=instance_create(x-4*t,y+4,smoke) i.hspeed=-2*h i.vspeed=1 i.friction=0.1
} 
e_timer=0
}

//uncurl
if (!jump && spin && up && !down) {
	spin=0
	soundstop(name+"spin")
}


//crouching and spinning
if (down && !up) {
    if (!jump && !braking && !spin) {
        if (abs(hsp)<0.5 || !size || size==5) {
            crouch=1
        } else if (!spin && !crouch) {
            spin=1
            if (spinplus) {hsp=maxspd*xsc} else hsp=3*xsc*wf
            playsfx(name+"spin")
        }
    }
    com_piping()
} else {
    if (!jump) crouch=0
}

if (size==5) mask_set(9,8) //please dont ask why the width has to be 9 pipes are weird and wacky and this is the only way i got to stop players from getting stuck in pipes and turning invisible/
else if (dead) mask_set(12,20)
else if (spin || jumpedoutspin || crouch || fall=5) mask_set(18,22)
else mask_set(18,26)


#define movement
if (piped || move_lock) exit

//speed limits
if (!jump && !spin) if (loose || crouch) {
    braking=0
    frick=0.06
    hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

//speed cap rubberband formula
maxspd=(3 + (0.5*spinplus) + (size==5)*0.55 - jet + (spin) + (fall==10)*0.5 + firedash/24)*wf
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
        stamped=0
            if fall!=69 {

if (!hurt) vine_climbing()
vsp+=0.15*wf-(size=5 && vsp>-0.35 && !water)*0.075
} else{
hsp=h
vsp=(down-up)
}

        crouch=0
        spindash=0
        braking=max(0,braking-1)
		//if (!fall && !jumpedoutspin) fall=1
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
//if (yground!=verybignumber) {y=yground while collision(0,0) && !collision(0,-8) {y-=1 }}
osld=sld
sld=point_direction(0,0,1,slobal)
if (!jump && !spin && abs(hsp)>1.5) {
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

weight=1.5
bartype=1



if chain{
if chain<=22 {
chain+=1 
}
//chain less than 11 is the wind up animation, no special code here
if chain>=11 && firedarm==0 {playsfx("mechachain") fire_projectile(x,y) firedarm=1} 

}

if chain>=22 {
chain=0
firedarm=0
}

//Special interactions
pvp_spin=spin //rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=0 //make sure to set for 0 for the mario bros when pounding
pvp_ignore=0 //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away

break_crackedground=2*(vsp>5) //1 for Horizontal only, 2 for Vertical 3 for All directions


is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1 ) is_intangible=1

power_lv=0
is_coinexplosive=0
if (spindash || spin || (jump && (!fall || fall=5))) power_lv=1
if (star) power_lv=5
if (super) power_lv+=1

if (piped) {jumpedoutspin=0 spinplus=0 exit}

//waiting animation
if dowait{
if (sprite="stand")
{waittime+=1}
else if sprite!="wait" waittime=0
}

//grounded state
if (!jump) {
    vsp=0
	jumpedoutspin=0
    jet=0
    jetdead=0 
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
}

maxe=4+(!!size && size!=5)*2
if (jet || lookup || chargestored || sparkcharge ) mcs=0
if (mcs>=(60-30*(size==3))) {energy+=1 mcs=0}
if (!jump && !sparkcharge && !chargestored) energy=max(2,energy)

if (jet) {
    if (water) with (instance_create(x+hsp+choose(0,8)*xsc,y+14,airbubble)) jet=4
    vsp=min(2,vsp-0.25*(vsp>-1.25))
    mc+=1
    if (mc=60) {
        energy=max(0,energy-1)
        mc=0
        if (energy=0) {jet=0 soundstop(name+"jet") playsfx(name+"step") instance_create(x+hsp+2*xsc,y+16,smoke) jetdead=1}
    }
} else mc=max(mc,30)

if (boost) {
    if (hurt && !super) boost=0
    if (point_distance(0,0,hsp,vsp)<2.5) boost=0
}
if (super) boost=1
//haha fix for hurt hahahaha (help)
if (hurt) {flash=1 fk=0 hsp=0 hurt=0
sparkcharge=0
chargestored=0

}


if (hsp=0 || (abs(hsp)<2)) spinplus=0

if (spinplus>0) spinplus-=0.02
spinplus=min(spinplus,spinspdmax)

//if spin {if (spinplus) {hsp=maxspd*xsc} else hsp=3*xsc*wf}

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
        if (!crouch) {
            spin=1
            hsp=xsc*4*(0.75+0.25*median(0,spindash-1,2)/2)*wf
            spindash=0
            
            soundstop(name+"spindash")
            playsfx(name+"release")
            
        }
        if (hsp!=0) spindash=0
    }
    
    //stop spinning
    if (abs(hsp)<0.2 && spin) { 
        spinc+=1 if (spinc=8) {
            spinc=0
            spin=0    
			spinplus=0
            hsp=0
            soundstop(name+"spin")
            /*if (name!="mario") */crouch=down            
        }
    }
} else spinblacklist=noone

jesus=(((boost && vsp<4)||(size==5 && !down && abs(hsp)>3.2)) && !water)

if (size=5) {if (vertbowser) vertbowser=0}
else {if (!vertbowser) vertbowser=1}

spikefired=max(0,spikefired-1)

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
//sorry for the scuffed code, mecha has stuff
if (hurt || piped || (intangible() && !diggity)) exit

coll=noone extracheck=id inst=0



with (enemy) if (phase!=other.id && !lock)
    if (instance_place(x,y-other.vsp-16*!!other.diggity,other.id)) other.coll=id

if (coll) {
    if (!coll.damage_player_on_contact) {
    
    
        calcfall=fall
        if (fall=5 || fall=12) calcfall=0
        global.coll=id
        type=coll.object_index
            
        seqcount=max(1,seqcount)
        
        if (super||(abs(hyperspeed)>0.5&&size=2)) {
            if (water) seqcount=1
            enemyexplode(coll)
            exit
        }
        
        if (vsp>5) {enemyexplode(coll) exit}
            
        if (coll.object_index=lakitu) if (coll.flee) exit
        
        if (star || (spin || jumpedoutspin)
        || (spin && type!=spinyegg && type!=beetle && type!=shell)
        || (pound>13 || (vsp>5 && size==5) && type!=piranha && type!=spinyegg && type!=spiny)) {
            if size==5 && !spin && !star && vsp>5 {if vsp<=0 {hurtplayer("enemy") exit} else playsfx(name+"jump",0,1.8) vsp=-3-(akey && star)*1.5 canstopjump=akey}
            instance_create(mean(x,coll.x),mean(y,coll.y),kickpart)
            if (type=hammerbro) seqcount=max(5,seqcount)
			if (spin) {hsp=maxspd*xsc spinplus+=1}
            enemydie(coll)                
            exit
        }
        
        if (spindash || inst || firedash) {if (diggity=32) exit enemyexplode(coll) exit}
        
        if (type=piranha || coll.damage_player_on_contact)  {
            hurtplayer("enemy")
            exit
        }
        
        if (spin || jumpedoutspin) {
            if (type=shell) {if (coll.type!="beetle") {spinplus+=1 enemydie(coll) exit}}
            else if (type=beetle) {hsp=0 jump=1 jumpspd=0.5 spin=0 spinplus+=1 enemystomp(coll) exit}
            else if (type=spinyegg) {hurtplayer("enemy") exit}
            else {spinplus+=1 enemydie(coll) exit}
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
    } else if (!star && !flash) hurtplayer("enemy")
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

if ((!size || size==5 || ohgoditslava) && !shielded && global.rings[p2]=0) {
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
sparklvl=1
    starhit=0
randomsparksGO=60
    
hurt=1+starhit if (!starhit) if (shielded) {shielded=0} else if global.rings[p2]>0 {droprings(0)} else {if size>=3 size=2 size-=1}
piped=1
if (abs(hsp)) knockspr="knockrun"
else knockspr="knockstand"
throwsparks(x,y)
alarm[5]=16
charm_run("sprmanager")
    
}


//Block hitting

#define hitblocks
if typeblockhit=0{
with (blockcoll){
if (tpos && owner.stomp) exit
if (stonebump || owner.stomp && owner.size!=5 && !cracked) {
    if (!goinup) {if (insted!=2) owner.vsp=1.5 sound("itemblockbump") tpos=1}
    if (!stonebump) {
        cracked=1
        i=instance_create(x,y,crackedbrick)
        i.owner=id
        i.biome=biome
        i.imcrack=1
        i.go=go
        i.tpos=1
        
    }
} else if (owner.size!=5) { 
    if (!insted) {owner.vsp=1.5}
    owner.blockc+=1
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
if (firedash || ((spin || jumpedoutspin) && abs(hsp)>0.5) || (super && fall=10)) {
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
jet=0
jetdead=0
jumpedoutspin=0
insted=0

if (downpiped) {
shoot(x-8,y+4,psmoke,-2,-1)
shoot(x+8,y+4,psmoke,2,-1)    
    downpiped=0
}

if (vsp>5 && !stamped && size!=5) {with (mydamager) {event="create" event_user(p2)} playsfx(name+"stomp") screenshake(x,4) stomp=1 com_piping() stomp=0 stamped=1}

playsfx(name+"step")

//jump buffering
if (jumpbuffer) jumpbuffer=-1

//fall into spin
if (!spin && rise=0 && !hurt && down && abs(hsp)>=0.5 && !size=0 && size!=5) {
    spin=1
    if (spinplus) {hsp=maxspd*xsc} else hsp=3*xsc*wf
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
if (spinplus) {hsp=maxspd*xsc} else hsp=3*xsc*wf
}
}


#define death
if (event="create"){
alarm0=60
alarm1=120
frame=0
sprite="dead"
jump=1
frspd=1
size=0
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
frn=owner.frn
mask_index=global.playermask[p2]
gravity=0.2-(owner.water*0.015)

} 
else if (event="step"){
if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
//1.9 moment
alarm0=max(0,alarm0-1)
alarm1=max(0,alarm1-1)
if alarm1=0 dest=1

coll=collision(0,vspeed)
if (coll && vspeed>0 && jump) {
    jump=0
    y=coll.y-14
    speed=0
    gravity=0
    playsfx(name+"stomp")
}

if (jump) {sprite="deadair" owner.sprite="deadair"}
else {sprite="dead" owner.sprite="dead"}

if (dest) {c+=1 alpha=(c mod 5>2) if (c>60) instance_destroy()}

if (!irandom(5)) if (owner.water) instance_create(x+irandom_range(-16,16),y+irandom_range(-16,24),airbubble)
if (!irandom(10)) {playsfx(name+"splode") with (instance_create(x+irandom_range(-16,16),y+irandom_range(-16,16),dethplotion)) owner=other.owner sheet=other.sheet}
if (!irandom(30)) playsfx(name+"splode")

} else if (event="draw") {
	if owner.projectilepalettes scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[owner.p2*100],global.pal_1[owner.p2]+1,global.pal_2[owner.p2]+1,global.pal_3[owner.p2]+1,global.pal_4[owner.p2]+1,owner.size,1,owner.totpal+1)
	with dethplotion{
		draw_sprite_part(other.sheet,0,owner.deathexplosion_sheetx[owner.size*projcoordbysize]+frame*25,owner.deathexplosion_sheety[owner.size*projcoordbysize],24,24,round(x-12),round(y-12))
		visible=1
	}
	shader_reset();
}


#define enterpipe
if (type="side") {
if (spin||crouch) {
set_sprite("ball")
frspd=min(1,0.1+abs(hsp/4))
if (abs(hspeed)>=(maxspd-1) && !underwater()) {fastpipe=1 playsfx(name+"spin")}
}
if (boost) {fastpipe=1}
}
if (type="up") {
//set_sprite("fly")
}
if (type="down") {/*set_sprite("pose") */if (stomp) fastpipe=1}

if (skidding) {soundstop("sonicskid") skidding=0}
soundstop("mechalookup")
braking=0
crouch=0
push=0
turning=0
turndir=0
jumpedoutspin=0
spinplus=0



#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}
