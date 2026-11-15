#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
water=0
k=0

getregion(x)

spr=global.effectssheet[biome]
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
k=!k
if (k) && !(nopart) {
    i=noone;
    var obj;
    obj=streamwind;
    if (parttype==1) obj=streambubble;
    switch (dir){
        case 0:
            i=instance_create(x,y+4+myrand(sprite_height-8),obj)
            i.fr=1
            i.region=region

        break;
        case 90:
            i=instance_create(x+4+myrand(sprite_width-8),y+sprite_height,obj)
            i.region=region
        break;
        case 180:
            i=instance_create(x+sprite_width,y+4+myrand(sprite_height-8),obj)
            i.fr=1
            i.region=region
        break;
        case 270:
            i=instance_create(x+4+myrand(sprite_width-8),y,obj)
            i.region=region
        break;
    }
    if (i!=noone) {
        i.speed=(3.5+myrand(4))+strength
        i.direction=dir+myrand(16)-8
    }
}
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!other.piped) {
    if (dir=0) {
        if (other.name="kid") other.hyperspeed+=max(0,0.5*(1-(other.x-x)/sprite_width))
        else other.hsp+=max(0,strength*(1-(other.x-x)/sprite_width))
    }
    if (dir=90) {
        if (other.jump) {other.fall=1}
        other.vsp-=max(0,strength*(other.y-y)/sprite_height)
    }
    if (dir=180) {
        if (other.name="kid") other.hyperspeed-=max(0,0.5*(other.x-x)/sprite_width)
        else other.hsp-=max(0,strength*(other.x-x)/sprite_width)
    }
    if (dir=270) {
        other.vsp+=max(0,strength*(1-(other.y-y)/sprite_height))
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (natural) exit;

strength=unreal(strength,-1)/4
dir=unreal(dir,0)
image_xscale=unreal(w,-1)
image_yscale=unreal(h,-1)
nopart=unreal(nopart,0)
parttype=unreal(parttype,0)
