#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
vspeed=-3
gravity=0.15
lok=1
fresh=1
red=0
alarm[1]=30
getregion(x)
bounces=0
c=1
type="None"
owner=noone
vanillapower=1
drawcode=""
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lok=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (type="coinup" && coinfalloff) {
    image_xscale=image_yscale
    image_yscale+=0.1
}

if (type="coinup" && dissapear) {
    dissapear-=1
    if dissapear=1 instance_destroy()
}
if (type="ringup" && coinfalloff) {
    image_xscale=image_yscale
    image_yscale+=0.1
}

if (type="ringup" && dissapear) {
    dissapear-=1
    if dissapear<=5 instance_destroy()
}

if (c) {
    if (follow!=0) {
        if (follow=-1) {
            if (!place_meeting(x,y,collider)) follow=0
        } else {
            friction=0.1
            gravity=0
            motion_add(point_direction(x,y,follow.x+(follow.hsp),follow.y+(follow.vsp)),0.2)
            speed=min(6,speed)
            if (point_distance(x,y,follow.x,follow.y)>150 || follow.hurt) {follow=-1 friction=0 gravity=0.15}
        }
    } else {
        if (collision(hspeed,0)) hspeed*=-1

        coll=collision(0,vspeed+esign(vspeed,1))
        if (coll &&!coinfalloff) {
            if (coll.object_index=lavablock) {instance_create(x,y,smoke) sound("enemykick") instance_destroy()}
            else if (vspeed<0) vspeed=abs(vspeed)
            else if (y<coll.y) {
                if ((abs(vspeed)<3 || type="star") && type!="ringup") {event_user(0)}
                else {
                    if (type="coinup" || type="token" || type="tokenblue") sound("itemcoinping")
                    vspeed=-abs(vspeed*0.5)
                    if (type="ringup") {vspeed=-4+(bounces/2) bounces+=1}
                }
            }
        }
        if (pitdeath()) {
            if (heavened) {
                x=heavened.target.x+(x-gamemanager.righthand[p2]+112)
                y=heavened.target.y-16
                heavened=0
            } else instance_destroy()
        }

        vspeed=min(5,vspeed)
        if (!inview()) {x-=hspeed y-=vspeed}
    }
}
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.name="kid" && (type="coinup" || type="ringup")) with (other) hurtplayer("item")
else if (vspeed>0 || follow) {
    visible=0
    typecoll=type
    if typecoll="coinup" typecoll="coin" else if typecoll="ringup" typecoll="ring"

    if (typecoll=="token") {type=0 gibtoken(other.id) instance_destroy()} //honestly foolhardy game switching a string to a number just for collecting tokens but we'll see how it plays out
    else if (typecoll=="tokenblue") {type=1 gibtoken(other.id) instance_destroy()}
    else if (give_item(other.id,typecoll)) {if (typecoll="coin"||typecoll="ring") instance_create(x,y,glitter) instance_destroy()} //the types were the same as the charm item names anyway so i got rid of the huge useless list -moster
    visible=1
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//y=(y div 16)*16+9
if !vanillaitem {if owner!=noone {with owner {dropid=id droptype=other.type charm_run("itemdrop")}}} //prevent conflict between charms with different versions of the same powerup by looking for the owner of the itemdrop before everyone else
if !vanillaitem && yep==0 {with player {if !other.yep {dropped=id droptype=other.type charm_run("itemdrop")}}} //now check every player. if it still doesnt get destroyed then the instance_destroy() at the bottom will
if (type="coinup") with (instance_create(x,y,coin)) {sound("itemcoinping") drop=1 p2=other.p2 biome=other.biome depth=0 if (other.dissapear) life=max(0,180-other.dissapear)}
else if (type="10coinup") with (instance_create(x,y,tencoin)) {sound("itemcoinping") drop=1 p2=other.p2 biome=other.biome depth=0 if (other.dissapear) life=max(0,180-other.dissapear)}
else if (type="30coinup") with (instance_create(x,y,thirtycoin)) {sound("itemcoinping") drop=1 p2=other.p2 biome=other.biome depth=0 if (other.dissapear) life=max(0,180-other.dissapear)}
else if (type="50coinup") with (instance_create(x,y,fiftycoin)) {sound("itemcoinping") drop=1 p2=other.p2 biome=other.biome depth=0 if (other.dissapear) life=max(0,180-other.dissapear)}
else if (type="100coinup") with (instance_create(x,y,hundredcoin)) {sound("itemcoinping") drop=1 p2=other.p2 biome=other.biome depth=0 if (other.dissapear) life=max(0,180-other.dissapear)}
else if (type="ringup") {vspeed=-2}
else if (type="mushroom") with (instance_create(x,y,mushroom)) {vspeed=0 alarm[0]=-1 drop=1 p2=other.p2 depth=0}
else if (type="star") with (instance_create(x,y,starman)) {hspeed=sign(other.hspeed) fuel=other.fuel c=2 alarm[0]=-1 depth=0 drop=1 p2=other.p2}
else if (type="bfeather") with (instance_create(x,y,feather)) {vspeed=0 alarm[0]=-1 drop=1 p2=other.p2 depth=0}
else if (type="btroot") with (instance_create(x,y,beetroot)) {vspeed=0 alarm[0]=-1 drop=1 p2=other.p2 depth=0}
else if (type="glui") with (instance_create(x,y,greenlui)) {vspeed=0 alarm[0]=-1 drop=1 p2=other.p2 depth=0}
else if (type="mini") with (instance_create(x,y,mushmini)) {vspeed=0 alarm[0]=-1 drop=1 p2=other.p2 depth=0}
else if (type="fflower") with (instance_create(x,y,flower)) {vspeed=0 alarm[0]=-1 c=1 drop=1 p2=other.p2 depth=0}
else if (type="token") with (instance_create(x,y,token)) {vspeed=0 xstart=myspawnx ystart=myspawny depth=0}
else if (type="tokenblue") with (instance_create(x,y,token)) {vspeed=0 type=1 xstart=myspawnx ystart=myspawny depth=0} //set xstart and ystart so item launcher can be destroyed
else {vspeed=0 hspeed=0}
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if vanillapower==1 ssw_items(type)
else string_execute(drawcode)
