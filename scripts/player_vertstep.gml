//vertical stepping for accurate collision
//player_vertstep()
var check,s,find,mem,yes,yp,savedvsp;

/*if global.lowgrav && !place_meeting(x,y-1,ground) {
    savedvsp = vsp;
    if (vsp<0) vsp*=1.5
    if (vsp>0) vsp*=0.5

    //balance out movement
    if (vsp<-4 && !sprung && fall) {
    vsp-=vsp*0.5
    }
    vsp=min(vsp,2)
    vsp=max(vsp,-5)

}

//yes i made high grav too shh,,,
if global.highgrav && !place_meeting(x,y-1,ground) {
    savedvsp = vsp;
    if (vsp<0) vsp*=0.5
    if (vsp>0) vsp*=1.5

    //balance out movement
    if (vsp<-4 && !sprung && fall) {
    vsp-=vsp*0.5
    }
    vsp=min(vsp,3)
    vsp=max(vsp,-7)
}*/

if pollenated{
    if !down //dont. stop me. noooooooow
        if vsp>1 vsp=1

}
disallow=noone
savedvsp = vsp;
if (antigrav) vsp*=-1

yp=y
y+=vsp

with (invisibox) if (untouched && other.bbox_top <= bbox_bottom && ((other.bbox_top - other.y) + other.yprevious) > bbox_bottom) x=xstart
coll=collision(0,0)
with (invisibox) if (untouched) x=-1000

//Special Collision with pswitch
collp=collision(hsp,vsp)
    if (collp.object_index=pswitch && jump && ((vsp>0 && !antigrav) || (vsp<0 && antigrav))) {
            global.coll=id
            with (collp) event_user(6)
    }
//Monitors here so that they don't fuck up movement.
if (object_is_ancestor(coll.object_index,monitorbase) && jump && ((vsp>0 && !antigrav) || (vsp<0 && antigrav)) && ((coll.hitbehaviour == 1 && fall=0 || fall=5) || (coll.hitbehaviour == 0)) && !hurt) {
    if (!coll.activated) {
        global.coll=id
        with (coll) event_user(6)
        vsp=min(vsp,-2,-vsp)
        
    } else {
        vsp=0
    }
    if (coll.landable)
       com_landing()
    else coll=noone
        
} else if object_is_ancestor(coll.object_index,monitorbase) && coll.shouldfall && (vsp<0 && !antigrav) &&(coll.bbox_bottom<bbox_bottom && !hurt) {
    coll.fall=1
    coll.y-=coll.vspeed
    coll.vspeed=-2
}

    
    
if (coll /*|| y>yground*/) {
    
    if (coll.object_index=pswitch && jump && vsp>0) {
            global.coll=id
            with (coll) event_user(6)
    }
        
    if (vsp<0 && !antigrav) || (vsp>0 && antigrav) {
        
        //bonk
        if (coll.object_index=invisibox && !coll.hit) check=coll
        else {
            oxsc=image_xscale
            if (vertbowser) image_xscale=3/9
            else image_xscale=1/6
            check=collision(0,0)                         
            image_xscale=oxsc
        }
        
        yes=1                  
        
        
        if (!check && x!=view_xview[0]+9 && !(vertbowser && insted)) {
            //corner rounding
            mem=x
            s=hsp
            if (x<mean(coll.bbox_left,coll.bbox_right)) {x-=2 hsp=min(0,hsp)}
            else {x+=2 hsp=max(0,hsp)}
            if (collision(0,0)) {disallow=noone check=coll x=mem hsp=s yes=0}
            else exit
        }   
        playsfx(name+"bonk") bonk=12 if (object_is_ancestor(coll.object_index,hittable)) bonkbrick=1
        
        if (!check) check=coll
        
        checky=y+max(0,check.bbox_bottom+1-bbox_top) 
        
        //hit blocks and stuff
        global.coll=id
        if (check.object_index=lavablock && !is_invincible("fire")) {hurtplayer("lava")} 
        else if (!hurt) 
        if (vertbowser) { //merging did not go well sorry mostre
            s=vsp
            if (object_is_ancestor(check.object_index,hittable)) {
                hitblock(check,id,1,-1 + (2 * antigrav),0)
                with (check) if (object_index!=brick || object_index!=monitor || object_index!=crate) yes=0
            } else yes=0
            with (hittable) {
                smb1destroyer1991=x
                if (object_index=invisibox) {
                    smb1destroyer1991=xstart
                }
                if (instance_place(x,y-s,other.id)) {
                    hitblock(id,other.id,1,-1 + (2 * antigrav),0)
                    with (check) if (object_index!=brick || object_index!=monitor || object_index!=crate) yes=0
                }
            }
            if (vertvspstop || (vertbowser && yes)) vsp=s
        } else if (object_is_ancestor(check.object_index,hittable) && ((!antigrav && y>check.y) || (antigrav && y<check.y) || tempkill)) { //annihilated your entire vertbowser thing to make multi-blockhitting global oopsies :3 -moster
            s=vsp
            hitblock(check,id,0,-1 + (2 * antigrav),0)
            with (hittable) {
                smb1destroyer1991=x
                if (object_index=invisibox) {
                    smb1destroyer1991=xstart
                }
                if (instance_place(x,y-s,other.id)) {
                    hitblock(id,other.id,0,-1 + (2 * antigrav),0)
                }
            }
            if (vertvspstop) vsp=s //this makes the character keep moving up after hitting a brick
            //y=checky
            //exit
        }
        if (!hurt) if (check.object_index=powblock && ((!antigrav && y>check.y) || (antigrav && y<check.y) || tempkill)) {
            with check{
                if !hit{
                    sound("powblockhit")
                    alarm[0]=5
                    other.vsp=1       
                    hit=1
                }
            }
            y=checky
            exit
        }
        coll=instance_place(x,y-1,sonicspike)
        if (coll && (!antigrav && coll.dir==3) || (antigrav && coll.dir==2)) && !is_intangible && !is_invincible("spike") {
            hurtplayer("spike")
        }
    } else {
        //break blocks downwards
        if ((pound>=14 || pound=-1) || (fall=12 && size)) {         
            global.coll=id
            find=0
            with (hittable) if (place_meeting(x,y-(max(4,abs(other.vsp)) * sign(other.vsp)),other.id)) {
                go=1
                with (other) {
                    y=min(y,other.y-(14 - (28 * antigrav)))
                }                
                event_user(0)
                              
                picked=0  
                find=!((object_index==brick && hit) || object_index==crate)
            }
            with (pswitch) if (place_meeting(x,y-(max(4,abs(other.vsp)) * sign(other.vsp)),other.id)||place_meeting(x,yy-(max(1,abs(other.vsp)) * sign(other.vsp)),other.id)) {
                event_user(6)
            } 
            if (pound=-1) {                  
                shoot(x-8,y+4,psmoke,-2,-1)
                shoot(x+8,y+4,psmoke,2,-1)                 
            }
            if (find && (fall=12)) {com_landing() exit}
            if (find && fall!=12) {poundcancel=1 com_landing() exit}            
        }
        if (coll.object_index==noteblock) {
            if (vsp<=0 && !antigrav) || (antigrav && vsp>=0) sound("itemblockbump")
            with (coll) { 
                if object_index=noteblock
                if !shifty && ((other.vsp<=0 && !antigrav) || (other.vsp>=0 && antigrav)){
                    other.jump=1
                    
                    myplayer=other.id
                    go=4
                    other.vsp=-2-(other.akey*3)-(content="vine")*2

                    hit=1
                }
            }
            exit
        }
        if (coll.object_index=crate && ((vsp > 0 && !antigrav) || (vsp < 0 && antigrav))) && !(nocratebounce) {
            vsp=-2-(akey*1.5)
            with(coll) {
                event_user(0);
            }
        }
        if (coll.object_index=pswitch && jump) {
            global.coll=id
            with (coll) event_user(6)
            vsp=min(vsp,-2,-vsp)
        }
        if (spinjump && (size || spinjumpsmall)) {         
            image_xscale=1/6
            find=noone
            with (hittable) if ((object_index==brick && !hit) || object_index==crate) if (place_meeting(x,y-(max(1,abs(other.vsp)) * sign(other.vsp)),other.id)) find=id
            image_xscale=1
            if (!find) with (hittable) if ((object_index==brick && !hit) || object_index==crate) if (place_meeting(x,y-(max(1,abs(other.vsp)) * sign(other.vsp)),other.id)) find=id
            if (find) {            
                if !antigrav y=min(find.bbox_top-14,y)
                else y=max(find.bbox_bottom+14,y)
                vsp=-2.5-ckey*1.5                                                  
                hitblock(find,id,1,1,0)
                exit
            }                      
        }                                     
    }       
    s=sign(vsp)
    y=yp
    repeat ( ceil(abs(vsp))) {
        y+=s                                         
        coll=collision(0,0)
        //nslopcoll=nslopcollision(0,0)
        if (coll /*|| nslopcoll*/) {
            y-=s
            if (vsp>=0 && !antigrav) || (vsp<=0 && antigrav) {com_landing()}
            else {
                if (object_is_ancestor(coll.object_index,moving)) {
                    vsp=min(coll.vsp-1.5,0,vsp)
                    sound("itemblockbump")
                    stopsfx(jumpsnd)
                } else if (coll) if (!hurt && bbox_bottom>coll.bbox_top) {
                    com_piping()
                    if (!pipe) {
                        vsp=1.5
                        sound("itemblockbump")
                        stopsfx(jumpsnd)
                    }
                }
            }
            break
        }
    }    
}

if antigrav vsp*=-1

/*if global.lowgrav || global.highgrav //maybe don't do that.
vsp = savedvsp*/
