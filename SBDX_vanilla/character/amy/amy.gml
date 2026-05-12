#define spritelist
stand,wait,lookup,pose,crouch,knock,dead,walk,run,brake,jump,fall,bonk,hammerspin,ball,pikoball,skip,push,hang,piko,twirl,hammerfall,hammerslam,kick,upper,climb,flagslide,grind,piping,pipingup,sidepiping,doorenter,doorexit

#define soundlist
release,skid,spin,spindash,insta,dash,boom,firedash,slam,tatsu,upper,firekick,pikostart,piko,walljump,vault,kick


#define movelist
Amy
#
[a]: Piko Ball (Air)
[b]: Hammer Swing / Hammer Twirl (Running / Air)
[up]+[b]: Rising Swing (Air)
[down]+[b]: Hammer Slam (Air)
[c]: Slide Kick / [c]->[a]: Skip 
#
Amy can use her powerful hammer to#wall jump, and break fragile objects.

#define rosterorder
7

#define skininit
var looper;

oldhammerspin=funnytruefalse(playerskindat(p2,name+" old hammer rotation")) 

//graphic offsets
loopey=0
looper=0
repeat((projcoordbysize*MAXIMUMSIZESARGH)+1) {
	if (projcoordbysize) {
		looper=string(loopey)
	} else {looper=""}
	
	hammerspin_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" hammer rotate graphic x"+looper),21)
	hammerspin_sheety[loopey]=nozerounreal(playerskindat(p2,name+" hammer rotate graphic y"+looper),85)
	
	hammerspin_offsetx[loopey]=nozerounreal(playerskindat(p2,name+" hammer rotate offset x"+looper),-10)
    hammerspin_offsety[loopey]=nozerounreal(playerskindat(p2,name+" hammer rotate offset y"+looper),-4)
	
	firewave_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" fire wave graphic x"+looper),64)
	firewave_sheety[loopey]=nozerounreal(playerskindat(p2,name+" fire wave graphic y"+looper),62)
	
	fireboom_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" fire boom graphic x"+looper),98)
	fireboom_sheety[loopey]=nozerounreal(playerskindat(p2,name+" fire boom graphic y"+looper),62)
	
	trailheart_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" trail heart graphic x"+looper),64)
	trailheart_sheety[loopey]=nozerounreal(playerskindat(p2,name+" trail heart graphic y"+looper),46)
	
	effectfire_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" effect fire graphic x"+looper),151)
	effectfire_sheety[loopey]=nozerounreal(playerskindat(p2,name+" effect fire graphic y"+looper),62)
	
	pikoballfx_sheetx[loopey]=nozerounreal(playerskindat(p2,name+" pikoball effect graphic x"+looper),64)
	pikoballfx_sheety[loopey]=nozerounreal(playerskindat(p2,name+" pikoball effect fire graphic y"+looper),81)
	
	
	loopey+=1
}

#define start
mask_set(12,12)
cantwirl=0
global.animatePrincess=1

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
firedash=0
insta=0
pikoball=false;
pikovault=false;


#define itemget
com_item() 

#define effectsfront
//draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-32,"afterhang:"+string(afterhang))

if (firedash && !piped) {
    draw_sprite_part_ext(sheets[2],0,227+40*(firedash mod 4),46,39,39,round(x-19.5*xsc),round(y-19.5+dy)+4,xsc,1,$ffffff,alpha)
}
if (insta && insta<14) {
    draw_sprite_part_ext(sheets[size],0,64+(floor((insta-1)/2) mod 4)*40,46,39,39,round(x-19.5*xsc),round(y-19.5+dy+4*!size)+4,xsc,1,$ffffff,alpha)
}

if oldhammerspin && sprite="pikoball" {
        kekkek+=1
        if (xsc>0) kek=kekkek
        else if (xsc<0) kek=19-kekkek
        if (kekkek>=18) kekkek=2
		if (kekkek<2) kekkek=17
		
		if !hamfry hamfry=hammerspin_sheety[size*projcoordbysize]
		if !hamfrx hamfrx=hammerspin_sheetx[size*projcoordbysize]
		
		if !hamofy hamofy=hammerspin_offsety[size*projcoordbysize]
		if !hamofx hamofx=hammerspin_offsetx[size*projcoordbysize]
                
        if (kek=2 || kek=3 || kek=18 || kek=19) draw_sprite_part(sheets[size*!global.singlesheet[p2]],0,hamfrx,hamfry,18,18,round(x+hamofx),round(y+hamofy-16))
        if (kek=4 || kek=5) draw_sprite_part(sheets[size*!global.singlesheet[p2]],0,hamfrx+19,hamfry,18,18,round(x+hamofx+14),round(y+hamofy-14))
        if (kek=6 || kek=7) draw_sprite_general(sheets[size*!global.singlesheet[p2]],0,hamfrx,hamfry,18,18,round(x+hamofx+18+16),round(y+hamofy),1,1,-90,$ffffff,$ffffff,$ffffff,$ffffff,1)
        if (kek=8 || kek=9) draw_sprite_general(sheets[size*!global.singlesheet[p2]],0,hamfrx+19,hamfry,18,18,round(x+hamofx+18+14),round(y+hamofy+14),1,1,-90,$ffffff,$ffffff,$ffffff,$ffffff,1)
        if (kek=10 || kek=11) draw_sprite_part_ext(sheets[size*!global.singlesheet[p2]],0,hamfrx,hamfry,18,18,round(x+hamofx+18),round(y+hamofy+18+16),-1,-1,$ffffff,1)
        if (kek=12 || kek=13) draw_sprite_part_ext(sheets[size*!global.singlesheet[p2]],0,hamfrx+19,hamfry,18,18,round(x+hamofx+18-14),round(y+hamofy+18+14),-1,-1,$ffffff,1)
        if (kek=14 || kek=15) draw_sprite_general(sheets[size*!global.singlesheet[p2]],0,hamfrx,hamfry,18,18,round(x+hamofx-16),round(y+hamofy+18),-1,-1,-90,$ffffff,$ffffff,$ffffff,$ffffff,1)
        if (kek=16 || kek=17) draw_sprite_general(sheets[size*!global.singlesheet[p2]],0,hamfrx+19,hamfry,18,18,round(x+hamofx-14),round(y+hamofy+18-14),-1,-1,-90,$ffffff,$ffffff,$ffffff,$ffffff,1)
} else {if kek kek=0 if kekkek kekkek=0}
//draw_skintext(floor(x)-string_length(string(hsp))*4,floor(y)-40,hammerspin_offsety[size*projcoordbysize])

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
if alarm0=0 {owner.instashieldin=0 owner.fall=1}
x=owner.x+owner.hsp y=owner.y+4+4*!owner.size sprite_index=spr_round32 mask_index=spr_round32 image_yscale=1 image_xscale=1
hittype="instashield"

coll=instance_place(x,y,collider)
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll.object_index=brick) brickc+=1 else brickc=4
hitblock(coll,owner,0,esign(coll.y-owner.y),0)
}    
}


coll=instance_place(x,y,enemy)
if (coll) {                    
    global.coll=owner.id
    if coll.object_index=lavabubble{
    coll.vsp=2
    } else if (coll.object_index!=bombenemy && coll.object_index!=drybones
    && coll.object_index!=boo && coll.object_index!=urchin) {
    enemyexplode(coll,2)
    if owner.instashieldin
    owner.vsp=-owner.vsp
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
}
else if (owner.twirl){
x=owner.x+owner.hsp y=owner.y+4 sprite_index=spr_round32 mask_index=spr_round32 image_yscale=0.7 image_xscale=1.1
hittype="instashield"

coll=instance_place(x,y,collider)
if (coll) {
if (object_is_ancestor(coll.object_index,hittable)) {
if (coll.object_index=brick) brickc+=1 else brickc=4
hitblock(coll,owner,0,esign(coll.y-owner.y),0)
}
}


coll=instance_place(x,y,enemy)
if (coll) {                    
global.coll=owner.id
if coll.object_index=lavabubble{
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
}

else if (owner.piko)
{
hittype="enemy"
sprite_index=spr_mask2x2
mask_index=spr_mask2x2
if (owner.piko>12 && owner.piko<15) {x=owner.x+owner.xsc2*14+owner.hsp y=owner.y-7 image_yscale=11 image_xscale=11}
if (owner.piko>15 && owner.piko<19) {x=owner.x+owner.xsc2*17+owner.hsp y=owner.y-4 image_yscale=11 image_xscale=11}
if (owner.piko>19 && owner.piko<23) {x=owner.x+owner.xsc2*17+owner.hsp y=owner.y+5 image_yscale=11 image_xscale=11}
if (owner.piko=24) {y=-1000}

if (owner.piko=1 || owner.piko=8 || owner.piko=13 || owner.piko=18 || owner.piko=22) with owner with (fire_projectile(other.x,other.y)) {type="trailheart" depth=owner.depth+1 hspeed=0 vspeed=0}


coll=instance_place(x,y,collider)
if (coll) {
	if (object_is_ancestor(coll.object_index,hittable)) {
		if (coll.object_index=brick) brickc+=1 else brickc=4
		hitblock(coll,owner,0,esign(coll.y-owner.y),0)
	}    
}

if owner.size && owner.size!=5{
	coll=instance_place(x,y,crackedground)
	if coll {
		with coll {
			event_user(0)
		}
	}
}

coll=instance_place(x,y,enemy)
if (coll) {                    
	global.coll=owner.id
	if coll.object_index=lavabubble{
	coll.vsp=2
	} else if coll.object_index!=shell {
		enemystomp(coll)
	} else {enemyexplode(coll,2)}
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
}

else if (owner.droplag) //hammer slam
{
hittype="enemy"
sprite_index=spr_mask2x2
mask_index=spr_mask2x2

x=owner.x+owner.xsc2*18+owner.hsp y=owner.y+8 image_yscale=13 image_xscale=12

coll=instance_place(x,y,collider)
if (coll) {
	if (object_is_ancestor(coll.object_index,hittable)) {
		if (coll.object_index=brick) brickc+=1 else brickc=4
		hitblock(coll,owner,0,esign(coll.y-owner.y),0)
	}    
}

if owner.size{
	coll=instance_place(x,y,crackedground)
	if coll {
		with coll {
			event_user(0)
		}
	}
}

coll=instance_place(x,y,enemy)
if (coll) {                    
global.coll=owner.id
if coll.object_index=lavabubble{
coll.vsp=2
} else 
enemyexplode(coll,2)
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
}

else if (owner.upper) {
	sprite_index=spr_mask2x2
	mask_index=spr_mask2x2	
	image_xscale=12
	image_yscale=16
	x=owner.x+owner.xsc*6 
	y=owner.y-8-min(owner.upper,16)
	
	coll=instance_place(x,y,collider)
	if (coll) {
		if (object_is_ancestor(coll.object_index,hittable) && coll.object_index!=itembox) {
			if (coll.object_index=brick) brickc+=1 else brickc=4
			hitblock(coll,owner,0,esign(coll.y-owner.y),0)
		}    
	}
	
	if owner.size {
		coll=instance_place(x,y,crackedground)
		if coll {
			with coll {
				event_user(0)
			}
		}
	}
coll=instance_place(x,y,enemy)
if (coll) {                    
global.coll=owner.id
if coll.object_index=lavabubble{
coll.vsp=2
} else 
enemyexplode(coll,2)
//owner.vsp=-owner.vsp
}
}

else if (owner.dropkick) {
	sprite_index=spr_mask2x2
	mask_index=spr_mask2x2	
	image_xscale=16
	image_yscale=8
	x=owner.x 
	y=owner.y+14
	
	coll=instance_place(x,y,collider)
	if (coll) {
		if (object_is_ancestor(coll.object_index,hittable)) {
			if (coll.object_index=brick) brickc+=1 else brickc=4
			hitblock(coll,owner,0,esign(coll.y-owner.y),0)
		}    
	}
	
	if owner.size {
		coll=instance_place(x,y,crackedground)
		if coll {
			with coll {
				event_user(0)
			}
		}
	}	
}

else if (owner.dash) {
	x=owner.x 
	y=owner.y+4 
	image_yscale=8 image_xscale=18
	
coll=instance_place(x,y,collider)
	if (coll) {
		if (object_is_ancestor(coll.object_index,hittable)) {
			if (coll.object_index=brick) brickc+=1 else brickc=4
			hitblock(coll,owner,0,esign(coll.y-owner.y),0)
	}    
}


coll=instance_place(x,y,enemy)
if (coll) {
    if (coll.object_index!=bombenemy && coll.object_index!=boo && coll.object_index!=urchin)
    with (owner) {
        coll=other.coll
       // if (coll.object_index=spiny || coll.object_index=spinyegg) {hurtplayer("enemy") exit}
        
        global.coll=id
        instance_create(mean(other.x,coll.x),mean(other.y,coll.y),kickpart)
        
        if (object_get_parent(coll.object_index)=koopa || coll.object_index=koopa || coll.object_index=beetle) {
            enemyc+=1
            doscore_p()
            with (instance_create(coll.x,coll.y,shell)) {
                if (other.coll.object_index=redkoopa || other.coll.object_index=redhover) type="red"
                else if (other.coll.object_index=beetle) type="beetle"
                spd=5
                hspeed=spd*esign(x-other.x,other.xsc)
                owner=other.id
                kicked=1
                stop=0
                phase=owner
                if (powner) powner.items+=1
                powner=other.powner
            }
            with (coll) instance_destroy()
            kicksound(0)
        } else {
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
                        vspeed=-3
                        hspeed=5*esign(x-(global.coll).x,1)
                    }
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
		instance_create(x,y,kickpart)
	}
}
	
if owner.size{
	coll=instance_place(x,y,crackedground)
	if coll {
		with coll {
			event_user(0)
		}
	}
}
	
}

else 
{y=-1000}

#define projectile
if (event="create") {type=owner.type}
switch type{
	
	case "trailheart":
		if !notnotcreated {
			created=1
			frame=0
			framesub=0
			visible=1
			notnotcreated=1
		}
    if (event="step") {
		framesub+=1
        if framesub=3 {frame+=0.5 framesub=0}
        if (frame>=5) {instance_destroy()}
    }
    if (event="draw") {
		visible=1
        draw_sprite_part_ext(owner.sheets[owner.size],0,owner.trailheart_sheetx[owner.size*owner.projcoordbysize]+floor(frame)*14,owner.trailheart_sheety[owner.size*owner.projcoordbysize],13,13,round(x-7),round(y-7),1,1,$ffffff,1)
    }
	break
	
	
	case "notfballexplosion":
		if !notnotcreated {
			created=1
			frame=0
			visible=1
			notnotcreated=1
		}
    if (event="step") {
        frame+=0.5
        if (frame>=3) {instance_destroy()}
    }
    if (event="draw") {
		visible=1
        draw_sprite_part_ext(owner.sheets[owner.size],0,owner.effectfire_sheetx[owner.size*owner.projcoordbysize]+floor(frame)*17,owner.effectfire_sheety[owner.size*owner.projcoordbysize],16,16,round(x-7),round(y-7),1,1,$ffffff,1)
    }
	break
	
	
	
	
    case "fballexplosion":
    if (!created) {
        frame=0
        visible=1
    }
    if (event="step") {
        frame+=0.5
        if (frame>=3) {instance_destroy()}
    }
    if (event="draw") {
		visible=1
        draw_sprite_part_ext(owner.sheets[owner.size],0,owner.fireboom_sheetx[owner.size*owner.projcoordbysize]+floor(frame)*17,owner.fireboom_sheety[owner.size*owner.projcoordbysize],16,16,round(x-7),round(y-7),1,1,$ffffff,1)
    }
    break
    case "amykaboom":
    if (!created) {
        //if ((owner.hang && owner.vsp>1) || owner.braking) {hspeed*=-1 x-=8*xsc}
        image_xscale=12
        image_yscale=12
        kaboom=0
        frame_sub=0
        frame=0
        brickc=0
        seqcount=2
        kek=8
        //hspeed=owner.xsc*4
        visible=1

        created=1
    }
    if (event="step") {
        calcmoving()
        {           
            if (kaboom=8) {
                with (fire_projectile(x,y+8)) {type="fballexplosion" owner=other.owner hspeed=3 vspeed=-1}
                with (fire_projectile(x,y+8)) {type="fballexplosion" owner=other.owner hspeed=-3 vspeed=-1}
            }
            if (kaboom=0 || kaboom=16) {
                with (fire_projectile(x,y+8)) {type="fballexplosion" owner=other.owner hspeed=1 vspeed=-3}
                with (fire_projectile(x,y+8)) {type="fballexplosion" owner=other.owner hspeed=-1 vspeed=-3}
            }
            
            kaboom+=1                                        
            
            if (kaboom=24) instance_destroy()
            
            coll=instance_place(x,y,collider)
            if (coll) {
                if (coll.object_index=lavablock) {instance_destroy() exit}
                if (y<coll.y+4 && !instance_place(x,y-8,collider)) {vspeed=-2.75 y-=2 exit}
                if coll.object_index=phaser exit
                //exploding=1
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
            
            coll=instance_place(x,y,enemy)
            if coll {
                if (coll.object_index!=beetle && coll.object_index!=bulletbill 
                && (coll.object_index!=bombenemy) && coll.object_index!=drybones 
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
                //exploding=1
            }
            
            coll=instance_place(x,y,player)
            if (coll) {
                if (coll.id!=owner) if (!invincible(coll)) {    
                    if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
                        
                        with(coll) fragplayer(other.owner)
                    }
                    //exploding=1
                }
            }
        }
    }
    if (event="draw") {
    
    }
    break
    default:
    if (!created) {
        image_xscale=8
        image_yscale=4
        
        frame_sub=0
        frame=0
        brickc=0
        seqcount=2
        getregion(x) 
        timer0=3
        timer1=32
        
        hspeed=xsc*3+owner.hsp*(xsc=sign(owner.hsp))
        speed=median(2,speed,5)
        //playsfx("sonicboom")
        
        created=1
    }
    if (event="step") {
        timer0-=1 if (timer0=0) visible=1
        timer1-=1 if (timer1=0) destroy=1
        
        if (destroy) {
            with (orig) playsfx("amyfirekick")
            i=fire_projectile(x,y)
            i.type="amykaboom"
            i.owner=orig
            instance_destroy()
            destroy=0
        }
        calcmoving()
        
        frame_sub=!frame_sub
        if frame_sub frame+=1
        if (frame>=2) frame=0
        
        if (!inview()) destroy=1 //instance_destroy()
        xsc=sign(hspeed)
        ignoreoncount=1
        {
            ignoreoncount=0
            if (!instance_place(x+sign(hspeed)*12,y+8,collider)) {
                destroy=1
            }
            
            coll=instance_place(x,y,collider)
            if (coll) {
                if (object_is_ancestor(coll.object_index,hittable)) {
                    if (coll.object_index=brick) brickc+=1 else brickc=4
                    hitblock(coll,owner,1,-1,0)
                } else brickc=4
                instance_create(x,y,kickpart)     
                if (brickc=4) {sound("itemblockbump") destroy=1 /*instance_destroy()*/}
            }
            
            coll=instance_place(x,y,enemy)
            if (coll) {
                if (coll.object_index!=beetle) && (coll.object_index!=bombenemy) 
                && coll.object_index!=drybones && coll.object_index!=boo 
                && coll.object_index!=urchin && coll.object_index!=pokey 
                && coll.object_index!=pokeybody {
                    yes=1
                    if (coll.object_index=shell) if (coll.type="beetle") yes=0
                    if (yes) {
                        global.coll=owner.id  
                        instance_create(x,y,kickpart)  
                        enemydie(coll,2)
                    }
                }
                destroy=1 //instance_destroy()
            }
            
            coll=instance_place(x,y,bowserboss)
            if (coll) {
                if (!coll.flash) {
                    coll.hp-=1
                    coll.flash=64
                    coll.owner=owner
                    sound("enemybowserhurt")
                    instance_create(x,y,kickpart)
                    destroy=1 //instance_destroy()
                }
            }
            
            coll=instance_place(x,y,player)
            if (coll) {
                if (coll.id!=owner) if (!invincible(coll)) {    
                    if (!flag.passed[owner.p2] && !flag.passed[coll.p2] && !coll.flash && !coll.piped) { 
                        //if (coll.name="knux" && coll.glide && sign(hspeed)=-sign(coll.hsp) && object_index!=powah_wave) {hspeed=abs(coll.hsp+1)*esign(coll.hsp,1) owner=coll.id with (owner) playsfx("knuxreflect") exit}                                                                   
                        if (coll.name="robo" && coll.lookup && coll.xsc=sign(hspeed)) {instance_create(x,y,kickpart) destroy=1 /*instance_destroy()*/ exit}
                        with(coll) fragplayer(other.owner)
                    }
                    instance_create(x,y,kickpart) destroy=1 //instance_destroy()
                }
            }
        }
    }
    if (event="draw") {
        draw_sprite_part_ext(owner.sheets[owner.size],0,owner.firewave_sheetx[owner.size*owner.projcoordbysize]+floor(frame)*17,owner.firewave_sheety[owner.size*owner.projcoordbysize],16,16,round(x-8*xsc),round(y-8),xsc,1,$ffffff,1)
    }
    break
}


#define sprmanager
frspd=1
if (sprite="piko") cantslowanim=1 else cantslowanim=0
if (grabflagpole) {sprite="flagslide"}
else if (hurt) {sprite="knock"}
else if (kick) {sprite="kick"}
else if (droplag) {sprite="hammerslam"}
else if (crouch) {sprite="crouch"}
else if (trip) {sprite="trip" frspd=1 cantslowanim=1}
else if (piko) {sprite="piko" frspd=1}
else if (dash) {sprite="twirl" frspd=1}
else if (jump) {
if (onvine) 
{
sprite="climbing" frspd=sign(left+right+up+down)
}
    else if (bonk) {
    	pikovault = false;
    	sprite="bonk"
    }
	else if (upper) sprite="upper"
	else if (dropkick) sprite="hammerfall"
	else if (pikoball) sprite="hammerfall"
    else if (fall=8) {sprite="skip"}
    else if (fall=9) {sprite="flip" if vsp>0 fall=1}
    else if (fall=6) {sprite="knock"}
    else {sprite="jump" if (vsp>0) sprite="fall"}
    
    if (pikovault) sprite="pikoball"
} else {
    if (spin) {sprite="ball" frspd=0.5+abs(hsp/3)}
    else if (push!=0) {sprite="push" frspd=1+abs(hsp/3)}
    else if (hsp=0) {
        if (balancing) {sprite="hang"}
        else if (pose) sprite="pose"
        else if (lookup) {sprite="lookup"}
        else if (waittime>maxwait) {sprite="wait"}
        else {sprite="stand"}
    } else {
        if (braking) sprite="brake"
else if (abs(hsp)>maxspd*0.9 && !water && !finish && boost && boostvar>=0.75) {sprite="maxrun" frspd=abs(hsp/3)}
        else if (abs(hsp)>maxspd*0.9 && !water && !finish) {sprite="run" frspd=abs(hsp/3)}
        else {sprite="walk" frspd=0.2+abs(hsp/4)}
    }
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

if (up && (!balancing || !size)) {
    if (hsp=0 && !jump) lookup=1
    else lookup=0
} else lookup=0

//list of things that prevent you from moving
if (spindash || (crouch && !jump) || twirl || dash || (super && fall=10) || vinegrab || grabflagpole) h=0

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
		if (fall!=6 && !crouch && h=xsc && kicked!=h) if (knuxcanclimb(collision(8*h,0))) {
            if (jump) hang=4
            xsc=h
        }
		
        if (!jump && !spin && !crouch && !firedash) {
            push=h
            xsc=h
            braking=0
com_piping()
        } else{com_piping()}
    } else {
        if (spin) {
            if (sign(hsp)!=h) hsp+=h*0.05*wf
        } else {
            if (!jump) {
                if (sign(hsp)!=h) {
                    if (abs(hsp)>maxspd*0.8 && !kick) {
						if !skidding playsfx(name+"skid")
                        braking=1
						skidding=1

                        brakedir=h
                    }
                    hsp+=0.33*wf*h
                    if (abs(hsp)<0.5) if (!firedash) xsc=h
                } else {
                    hsp+=0.06*wf*h
                    braking=0
                    if (!upper) xsc=h
                }
				
				if (jump) dashside=h       
            } else {
                hsp+=0.08*wf*h
                if (!upper) xsc=h
else collwin=instance_place(x+hsp,0,goalblock)
if collwin {hsp=0 fallsprite="dash" collwin.owner=id with collwin{ event_user(4)}
}
if (jump) dashside=h       
            }
        }
    }
}

if (push!=h) push=0

com_di()

//code for specifically the a button
if ((abut || jumpbufferdo) && (!springin)) {
    if (!jump&&!piko||fall=69||grabflagpole&&!droplag) { //jump
        if (kick && push==0 && fall!=69) {
            jumpsnd=playsfx(name+"jump")
			with shoot(x+8*xsc,y+8,psmoke,-1.5*xsc,-1) {friction=0.1 depth=other.depth+1}
			
            fall=8
            if size=3 hsp=5*xsc else hsp=3*xsc
            jump=1
            vsp=-2
            skip=1
        } else {
		
            trip=0
            jumpsnd=playsfx(name+"jump")
            vsp=-5-0.2*super
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
            fall=1
            braking=0
            spin=0
            canstopjump=1
            dashtimer=60
            if (mymoving) hsp+=avgmovingh
            crouch=0
            if (spin && !star) seqcount=0
            fallspd=min(1,0.5+abs(hsp)/5)
        }
    } else { //air jumps
	
			if !(pikoball && !hang && !afterhang && !dropkick && !droplag) {
				pikoball=true;
				pikovault=false;
				fall=4
			} else pikoball=false; //to be cancellable
		  /*if (cantwirl!=1) {
				if !twirl {
					playsfx(name+"tatsu")
					if twirlpre!=0 
					twirl=twirlpre 
					else 
					twirl=1
				}
			}*/
	jumpbuffer=4*!jumpbufferdo
	}
}
jumpbufferdo=0
springin=0

if (hang && jump && pikoball) {
	screenshake(x,4)
	playsfx(name+"walljump")
	afterhang=16
	hsp=esign((right)+(-left),xsc)*-3.5 instance_create(x+6*xsc,y+8,kickpart)
	xsc*=-1 vsp=-3.5
	//if (size) playsfx(name+"wallkick") else playsfx(name+"smallwallkick",0,1+(size==5)/3)
	crouch=0
	pikovault=true;
	canstopjump=0
}

if (akey) {
    if (jumpbuffer) jumpbuffer-=1
} else jumpbuffer=0

if (!akey) {
	/*if twirl{
		twirl=0 soundstop("amytatsu")
	}*/
		if (canstopjump=1 && jump && vsp<-2 && !sprung && fall!=9) {
			vsp*=0.5
		}
		canstopjump=0
}

if (bbut) {
	/*if (jump && !insted && (fall=1 || fall=10)) {
				insted=1
				fall=0
				firedash=0
				boost=0
				insta=1 alarm[1]=20+water*10-(name="ashura")*10
				instashieldin=1
				playsfx(name+"insta")
	}*/
	if (!down && !up && !insted) {
		if (!piko && !upper && !kick && (jump || abs(hsp)>=maxspd*0.9) && (left || right)) {
			    if (!dash) { 
					if (size==2 || size==3) {dash=25}
					else dash=20
					dashside=xsc
					dashtype=1
					divekick=0                    
					playsfx(name+"tatsu")
					hsp+=3*xsc
					if jump insted=1
					pikoball=false;
					pikovault=false;					
					
					
					with shoot(x-4*xsc,y+4,psmoke,-2*xsc,-1) {friction=0.1 depth=other.depth+1}
					with shoot(x-4*xsc,y+4,psmoke,-2*xsc, 1) {friction=0.1 depth=other.depth+1}
					
                }
			
		}
		
		if (!jump && !piko && abs(hsp)<maxspd*0.9) {
			piko=1
			xsc=xsc2
			jump=0
			crouch=0
			playsfx("amypikostart")
			}
	}
		
	if (up && !upper && !insted && !dropkick && (!pikovault || !pikoball))  {
			kick=0
			kickjump=0
			shoot(x,y+8,psmoke)
			upper=1
			pikoball=false;
			pikovault=false;
			insted=1
			fall=1 
			//energy-=2 
			if size=3 vsp=-(5.25-1*jump-1.5*water) else vsp=-(5-1*jump-1.5*water)
			jump=1       
			hsp=(3+!water)*xsc
			tatsu=0 
			playsfx('amyupper')
		}
		
	if (down && jump && !pikoball) {
			kick=0
			kickjump=0
			upper=0
			dropkick=1
			fall=5
			energy-=2
			tatsu=0
			playsfx('amydive')
            }	
	
}

if (cbut) {

if (!jump && (size && size!=5) && !kick && !spin) {
	playsfx(name+"kick")
	kick=48
}

	/*if (abs(hsp)>1 && !trip) {
		jump=1
		fall=1
		trip=1
		hsp=hsp*1.2
		vsp=-2
		xsc=xsc2
		}*/
		//if (spindash || (crouch && down && size)) {
    //    playsfx(name+"spindash",0,1+(median(0,spindash-1,3)/3)*skindat("pitchdash"+string(p2)))
    //    spindash=min(4,spindash+1)
    //   tempbrick=1
    //}
}

//crouching and spinning
if (down && !up) {
    if (!jump && !braking && !spin && !kick) {
            crouch=1
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
if (!grabflagpole && !piped && size==5) mask_set(9,8) //please dont ask why the width has to be 9 pipes are weird and wacky and this is the only way i got to stop players from getting stuck in pipes and turning invisible/
else if (!grabflagpole && (trip || dash || spin || crouch || (kick) || size=0 || fall=5)) mask_set(12,12)
else mask_set(12,24)

#define movement
if (piped || move_lock) exit

//speed limits
if (!jump) if (loose || spin || crouch || piko || trip && !jump) {
    braking=0
    frick=0.06+(trip*0.1)+crouch*0.5
    if (spin) frick=0.005
    hsp=max(0,abs(hsp)-frick)*sign(hsp)
}

//speed cap rubberband formula
maxspd=(3 + !!size*0.5 + spin + (boostvar) + skip*0.5 + water*0.1 + (dash && !jump))*wf
if (abs(hsp)>maxspd) hsp=(abs(hsp)*2+maxspd)/3*sign(hsp)

vsp=min(7+downpiped,vsp)

///movement
//hi moster here dont uncomment the yground or easyground stuff because its required for the cool new slope system to work
//for anyone porting a charm from unfinished build or below to this build, delete or comment all of the commented code and add player_nslopforce()
calcmoving()

if (!dead && !grabflagpole) {
if fall!=69
player_horstep()
    player_nslopforce()
    //yground=easyground()
	//if (yground!=verybignumber) yground-=14
    if (jump) {
        //gravity
        balancing=0
        if (fall=10 && super) {
            if !twirl hsp+=(right-left)*0.25
			vsp+=(down-up)*0.15+0.05+0.1*max(0,2-abs(hsp))*(vsp<2)
            l=median(0,point_distance(0,0,hsp,vsp)-0.05,3)
            d=point_direction(0,0,hsp,vsp)
            hsp=lengthdir_x(l,d)
            vsp=lengthdir_y(l,d)
            if !twirl xsc=esign(hsp,xsc)
        } else if fall!=69 {
            if twirl || dash {
				vsp=max(0.05,abs(vsp)-0.1)*sign(vsp)
			} 
			else if (dropkick) {vsp+=0.35*wf}
			else {vsp+=0.15*wf}
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
if (spin || spindash) fall=5
if (firedash) fall=10
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

weight=0.4+0.4*!!size
bartype=0
maxe=0 if (size=2) maxe=6
if (mcs>=10) {energy+=1 mcs=0}

if !dropkick boost=0

// VULNERABILITY AND PLAYER COLLISION

//Intangibility
is_intangible=0
with (flag) if (passed[other.p2]) other.is_intangible=1
if (transform || finish || piped=1 || piko || upper) is_intangible=1

//Power levels
power_lv=0
is_coinexplosive=0
if (spindash || spin || kick ||(jump && (!fall || fall=5))) power_lv=1
if (firedash) power_lv=4
if (star || insta) power_lv=5
if (super) power_lv+=1
if ((upper && size=2) || (droplag && !!size && size!=5)) is_coinexplosive=1

//Special interactions
pvp_spin=spin //rolling clash
pvp_avoid=0 //I don't like social interactions
pvp_stomper=0 //make sure to set for 0 for the mario bros when pounding
pvp_ignore=instashieldin //For when you wanna hit the others but not yourself
pvp_knockaway=0 //I won't hurt you, just go away

//shimming
if (abs(hsp)>(maxspd-boostvar)*0.9 && !water && !finish) sham+=1
else {sham=0 shimming=0}
if (sham>=60) shimming=1

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
    if (!star && !spin && !spindash) seqcount=0
    //ledge hang animation detection
    if ((sprite="stand" && hsp=0) || balancing) {
        image_xscale=1/6
        balancing=(!instance_place(x,y+4,collider) && instance_place(x-7*xsc,y+4,collider))
        image_xscale=1
    } else balancing=0

    //skidding
    if (push=0 && hsp!=0 && braking) {
        if !skidding playsfx(name+"skid")
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

if (kick) {
	kick-=1
	if down && kick<24 {spin=1 crouch=0 kick=0}
	if !spin hsp=(kick/8)*xsc 
	if (jump) kick=0
}

if (kickjump) {
	crouch=1
	if (!jump) kickjump=0
}

if (upper) {
	mcs=0
	//heart=1
	if size=3 hsp=max(2.5,abs(hsp+0.1*(right-left)))*xsc else hsp=max(1,abs(hsp*0.94+0.1*(right-left)))*xsc
	if (upper=32 || vsp>=1) {upper=-1 if (size=2 && energy) fall=4 else fall=9}
	if (size=2) {
		with fire_projectile(x+irandom_range(-16,16),y+irandom_range(-16,16)) {type="notfballexplosion" hspeed=-2*xsc vspeed=2}
		if (upper=-1) {
			playsfx('amyfirekick')
			with (fire_projectile(x+16*xsc,y)) {type="notfballexplosion" hspeed=-4 vspeed=-4}
			with (fire_projectile(x+16*xsc,y)) {type="notfballexplosion" hspeed=-4 vspeed=4}
			with (fire_projectile(x+16*xsc,y)) {type="notfballexplosion" hspeed=4 vspeed=-4}
			with (fire_projectile(x+16*xsc,y)) {type="notfballexplosion" hspeed=4 vspeed=4}
	}
	upper+=1
	}
}

if (dropkick) {
	dropkick+=1
	pikovault=false;
	if !down {dropkick=0}
	if vsp>4 boost=1
	if (size=2) {with fire_projectile(x+irandom_range(-16,16),y+irandom_range(-16,16)) {type="notfballexplosion" hspeed=-1*other.xsc vspeed=-1}}
}

if (droplag) {
	if (droplag>0) droplag-=1
	hsp=0
}

if (afterhang && !upper) {
	pikoball=false;
	pikovault=true;
}

if (pikovault) {
	heart=1
	if vsp>3 pikovault=0
}

if (dash) {
	dash-=1 
	heart=1
	vsp/=1.2
	
	if ((right-left!=dashside && right-left!=0) || (hang && vsp>0)) dash=0 
	hsp=(3+(dash-1)/10)*dashside 
	if (size=2) with fire_projectile(x+random_range(-24,24),y+random_range(-8,8)) {
		type="notfballexplosion" hspeed=-2*xsc vspeed=0
		}	
	}

if (heart) {
	if global.bgscroll mod 6 = 1 with (fire_projectile(x,y+4)) {type="trailheart" depth=owner.depth+1 hspeed=0 vspeed=0}
}

heart=0

if (insta) insta+=1
if (dashtimer) dashtimer-=1
boostvar=inch(boostvar,0.75*boost*!jump*!spin,0.014+(0.002*jump))
if (boost) {
    if (hurt && !super) boost=0
} else boostvar=0
if (super) boost=1
if (firedash) {firedash-=1 boost=1}
hang=max(0,hang-1)
afterhang=max(0,afterhang-1)
if (!collpos(xsc*16,0) || !jump) hang=0



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
jesus=(boost && vsp<4 && !water)

if piko {
    xsc=xsc2
    piko+=1.5
    if piko < 9 && abs(hsp)<3 hsp=max(1*xsc2,hsp/1.1)
    if piko=9 && abs(hsp)<3 {
        hsp=1.3*xsc2
    }
    if piko>21 {
		if piko=25 { //why doesn't this work if it's a proper factor of 1.5
		playsfx("amypiko")
			if (size=2 && energy>=maxe) {
				energy=0
				i=fire_projectile(x+8*xsc,y+6)
				i.type="powah_wave"
				i.owner=id i.orig=id
				i.hspeed=xsc*3+hsp*(xsc=sign(hsp))
				i.speed=median(2,i.speed,5) 
				i.xsc=xsc              
			}
		}
	if piko=24 playsfx(name+"slam")
	}
    if piko>=36 {
		piko=0
    }
}
if !piko && !trip && !twirl
xsc2=xsc

if !twirl
thsp2=hsp

if twirl
{
twirlpre=twirl
hsp=thsp2
xsc=xsc2
twirl+=1
if twirl >= 100
{
twirlpre=0
twirl=0
cantwirl=1
}
}

if hsp=0 && trip
trip=0

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
        || ((spin || kick || skip || dash) && type!=spinyegg && type!=beetle && type!=koopa && !object_is_ancestor(type,koopa) && type!=shell)
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
        
        if (spin || kick || skip || dash) {
            if (type=shell) {if (coll.type!="beetle") {enemydie(coll) exit}}
            else if (type=beetle || object_is_ancestor(type,koopa) || type=koopa) {hsp=0 jump=1 jumpspd=0.5 spin=0 enemystomp(coll) exit}
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
            if (type=koopa || type=beetle || type=rexbig || object_is_ancestor(type,koopa)) {
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
    } else if (!star && !flash) hurtplayer("enemy")
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
    if (shielded) playsfx(name+"shielddamage")
    else playsfx(name+"damage")

    starhit=0
    
jump=1 hurt=1+starhit if (!starhit) if (shielded) {shielded=0} else {if size=3 size=1 else size-=1} hsp=xsc*-2*wf vsp=-3*wf
    
}


//Block hitting

#define hitblocks
if typeblockhit=0{
with (blockcoll){
if (stonebump || owner.size=0 && insted!=1 && !owner.tempkill && cracked=0) {
    if (!goinup) {if (insted!=2) if (owner.twirl=0) owner.vsp=1.5 sound("itemblockbump") tpos=1}
} else { 
     if (!insted) {if (owner.twirl=0) owner.vsp=1.5}
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
	hititembox()
}

#define hitwall
//hit blocks sideways
if (firedash ||((spin || kick) && abs(hsp)>0.5) || upper || (super && fall=10)) {
    global.coll=id
    with (hittable) if (instance_place(x-other.hitside,y,other.id)) {
if global.coll.firedash go=sign(global.coll.vsp) else go=-1
if (global.coll.upper) picked=1
        insted=1
        event_user(0)
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
hsp=0
hyperspeed=0

if twirl
{
twirlpre=0
twirl=0
cantwirl=0
}        


#define landing
braking=0
insted=0
airdash=0
dashanim=0
boosted=0
twirlpre=0
twirl=0
cantwirl=0
onvine=0
upper=0


if fall=8 || fall=9
fall=0

skip=0

if (dropkick) {
    dropkick=-1
	boost=0
	droplag=20
    //player_piping()
    if (abs(hsp)>2) kick=1 
    else if !piped {if (size!=0 && size!=5) screenshake(x,3) rise=xsc risec=-15}
	playsfx(name+"slam")
    if (size=2 || super) {
        screenshake(x,4)
		
       // i=fire_projectile(x+2*hsp,yy+12)
		//i.owner=id
		//i.type=amykaboom
        playsfx(name+'firekick')
        //with (fire_projectile(x,y+8)) {other.type=fballexplosion type=fballexplosion hspeed=-4 vspeed=-4}
        with (fire_projectile(x,y+8)) {other.type=fballexplosion type=fballexplosion hspeed=-4 vspeed=0}
       // with (fire_projectile(x,y+8)) {other.type=fballexplosion type=fballexplosion hspeed=4 vspeed=-4}
        with (fire_projectile(x,y+8)) {other.type=fballexplosion type=fballexplosion hspeed=4 vspeed=0}
    } else instance_create(x,y+8,smoke)
    energy=max(2,energy)
}

if (pikoball) {
	
	var monivaulter;
	monivaulter=instance_place(x,y+4,monitor)
	if (monivaulter) {
		with (monivaulter) event_user(0)
	}

	if (!!size && size!=5) screenshake(x,4-(1*(vsp<3)))
	y-=1
	jump=1
	fall=0
	if size=3 vsp=-6.7 //are you fucking kidding me why is this the perfect jump value
	else vsp=-6
	pikoball = false
	pikovault = true;

	//change jump angle in steep slopes
	vd=point_direction(0,0,hsp,vsp)+point_direction(0,0,1,slobal/2)
	vm=point_distance(0,0,hsp,vsp)
	hsp=lengthdir_x(vm,vd)
	vsp=lengthdir_y(vm,vd)

	with shoot(x-8,y+8,psmoke,-2,-1) {friction=0.1}
	with shoot(x+8,y+8,psmoke, 2,-1) {friction=0.1}
	
	playsfx(name+'vault')
	
} else {
	pikovault = false;
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

alarmmp=60
alarm1=300
sprite="dead"
frame=0
frspd=1
spindash=0
alpha=1

if global.mplay>1 alphadecay=1

if owner.sprite!=sprite {owner.sprite=sprite with owner set_sprite(sprite)}
name=owner.name
p2=owner.p2
owner=owner.id
size=owner.size
xsc=owner.xsc
ysc=owner.ysc
frn=owner.frn
vspeed=-3.5 gravity=0.1-(owner.water*0.015)

//shortsmallform=owner.shortsmallform

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
	if (firedash) {set_sprite("dash") frspd=1 hspeed=xsc*3 fastpipe=1  }
	if (spin||crouch) {
		set_sprite("ball")
		frspd=min(1,0.1+abs(hsp/4))
		if (abs(hsp)>=(maxspd) && !underwater()) {fastpipe=1 playsfx(name+"spin")}
	}
	if (boost) {fastpipe=1}
}
if (type="up") {
set_sprite("fly")
}
if (type="down") {}

if (skidding) {soundstop("sonicskid") skidding=0}
braking=0
insta=0
crouch=0
push=0     
firedash=0
dash=0


#define exitpipe
if (type="door") {}
if (type="side") {}
if (type="up") {}
if (type="down") {}


