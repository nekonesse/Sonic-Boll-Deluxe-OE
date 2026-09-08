///collision(x,y, force semisolid ground)
//finds a collision with the current mask

var o,yp,repeatthisass,returnnobody;


if (teleport>8) return noone
if (posed) with (finalwall) if (object_index=finalwall) y-=verybignumber
if (disallow) {disallow.y-=verybignumber}
with (pswitch) {p=y if (carry) y-=verybignumber}
if (object_index=player) {
    with (phaser) {
        if (nslop=0){
            if (dir=2) {if (other.vsp>0 || other.bbox_top<y-1+other.vsp) y-=verybignumber}
            else if (dir=0) {if (other.vsp<0 || other.bbox_bottom>y+1+other.vsp) y-=verybignumber}
            else {
                if (dir) {if (other.hsp>0 || other.bbox_left<x+15+other.hsp) y-=verybignumber}
                else {if (other.hsp<0 || other.bbox_right>x+1+other.hsp) y-=verybignumber}
            }
        } else {
            if (s=1)
            if (other.vsp<0||other.bbox_bottom>bbox_bottom)
            {


                y-=verybignumber
            } else if ((l=1 && other.bbox_right>x)||(l=0 && other.bbox_left<x)) && other.bbox_bottom>bbox_bottom y-=verybignumber

        }
    }
    with (movingphaser) {
        ycollcheckstart=y //The y in which I started the coll check, changed the variable just in case it's what's wrong
        if (dir=2) {if (other.vsp>0 || other.bbox_top<y-1+other.vsp) y-=verybignumber}
        else if (dir=0) {if (other.vsp<0 || other.bbox_bottom>y+1+other.vsp) && (!argument[2]) y-=verybignumber}
        else {
            if (dir) {if (other.hsp>0 || other.bbox_left<x+15+other.hsp) y-=verybignumber}
            else {if (other.hsp<0 || other.bbox_right>x+1+other.hsp) y-=verybignumber}
        }
    }

} else {
    if (object_index=bowserboss) with (moving) y-=verybignumber
    with (phaser) {
        if (nslop=0){
            if (dir=2) {if (other.vspeed>0 || other.bbox_top<y-1+other.vspeed) y-=verybignumber}
            else if (dir=0) {if (other.vspeed<0 || other.bbox_bottom>y+1+other.vspeed) && (!argument[2]) y-=verybignumber}
            else {
                if (dir) {if (other.hspeed>0 || other.bbox_left<x+15+other.hspeed) y-=verybignumber}
                else {if (other.hspeed<0 || other.bbox_right>x+1+other.hspeed) y-=verybignumber}
            }
        } else {
            if (s=1)
            if (other.vspeed<0||other.bbox_bottom-2>bbox_bottom)//-2 is here to counteract the possibility of the enemy being slightly sunk into the ground, possibly caused by how the enemy works in general.
            {


                y-=verybignumber
            } else if ((l=1 && other.bbox_right>x)||(l=0 && other.bbox_left<x)) && other.bbox_bottom>bbox_bottom y-=verybignumber

        }
    }
}
yp=y
y=-verybignumber


count=0
o=instance_place(x+argument[0],yp+argument[1],collider)
if object_index=player && o=noone
o=instance_place(x+argument[0],yp+argument[1],grateblock)
if object_index=player && o=noone && (felljesus || felljesus_cruelty)
o=instance_place(x+argument[0],yp+argument[1],lavablock)
if object_index!=player && o=noone
o=instance_place(x+argument[0],yp+argument[1],x1F0)

y=yp
if (object_index=player)
if (object_is_ancestor(o.object_index,moving)&& mustabovemoving)
{
    if o.object_index=movingphaser{
        if o.dir=0 && !jump y+=o.vspeed //possibly fixes phasers dragging you up and down if you jump through them??
        with (o) {y=ycollcheckstart}
    }
    else
    y+=o.vsp
    returnnobody=1 //should fix phasers just randomly being sent to hell never to return???
}

with (phaser) y=ystart
if (object_index=player)
with (movingphaser) y=ycollcheckstart
with (pswitch) y=p
if (disallow) disallow.y+=verybignumber
if (posed) with (finalwall) if (object_index=finalwall) y+=verybignumber
if (object_index=bowserboss) with (moving) y+=verybignumber
if (panic && object_index=bowserboss) if o.object_index=lavablock  return noone

if returnnobody return noone

if (!o && (object_index=player||object_index=charmdeath)) {
    if (name="kid") o=instance_place(x+argument[0],y+argument[1],kidground)
    if (!o && (jesus || jeezus || jesus_mercy)) {
        o=instance_place(x+argument[0],y+argument[1],waterblock)
        if (!o) {
            if (y>region.water-12-argument[1] ) {
                walter.y=region.water-12-argument[1]
                if splashtimer == 0 {
                    water_splash(-1)
                    splashtimer = 120
                }
                return walter
            } else splashtimer=max(splashtimer-1,0)
        }else if (o) {
                if splashtimer == 0 {
                    water_splash(-1)
                    splashtimer = 120
                }
            return(o)
        }
    }
}

return o
