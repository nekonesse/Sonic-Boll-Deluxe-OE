#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
friction=0.1
drop=0
lok=0
fresh=1

mycoll=instance_create(x-8,y-8,kidground)
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (instance_exists(mycoll)) with (mycoll) instance_destroy()
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (drop) {
    mask_index=spr_grindermask
    calcmoving()
    if (!inview()) vspeed=0
    else {
        hspeed=0
            if (collision(0,vspeed+1)) && vspeed>0 {


            s=esign(vspeed,1)
            y+=vspeed
            while (collision(0,0)) {
                y-=s
            }

            vspeed=0

            belt=collision(0,1)
            if belt.object_index=conveyorbelt && !collision(belt.beltspd,0) && !collision(-belt.beltspd,0)
                x=x+belt.beltspd;

        } else vspeed=min(3,vspeed+0.25)
    }
    mask_index=spr_grindermask
    if (mycoll) {mycoll.x=x-8 mycoll.y=y-8}
    if (pitdeath()) instance_destroy()
    life+=1
    if (life>=180 && !flash) flash=180
    if (flash) {flash-=1 if (!flash) instance_destroy()}
}
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (gib100coin(other)){
sound("itembigcoin")
with (instance_create(x,y+4+16*go,bigcoinup)) {type="100coinup" vspeed=-4.5+2*other.go p2=other.owner.p2}
instance_destroy()
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
i=instance_create(x,y,itemdrop)
i.type="100coinup"
i.follow=other.id
i.vspeed=0
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ssw_items("100coin")
