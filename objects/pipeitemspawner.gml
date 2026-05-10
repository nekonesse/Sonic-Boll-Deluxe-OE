#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0]=120
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!collision(x+sign(hsp)*16,y+sign(vsp)*16) && !place_meeting(x+sign(hsp)*16,y+sign(vsp)*16,content)) {
    items+=1
    if (items=maxitem) instance_destroy()
    with (instance_create(x,y,pipeitem)) {
        hspeed=other.hsp
        vspeed=other.vsp
        powner=other.id
        content=other.content
        enem=other.enem
        object=other.object
        sprite=other.sprite
        enemy2=other.enemy2
        if (enem) xsc=esign(-hspeed,esign(x-nearestplayer().x,1)) else xsc=esign(-hspeed,esign(nearestplayer().x-x,-1))
        if (content=spring || content=spreng) {x-=8 y-=8}
    }
}
alarm[0]=120
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (!inview()) alarm[0]=120
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch content {
    case "goomba": content=goomba sprite="goomba" enem=1 break
    case "koopa": content=koopa sprite="koopa" enem=1 break
    case "redkoopa": content=redkoopa sprite="redkoopa" enem=1 break
    case "paratroopa": content=hopkoopa sprite="paratroopa" enem=1 break
    case "shell": content=shell sprite="shell" enem=1 break
    case "beetle": content=beetle sprite="beetle" enem=1 break
    case "spiny": content=spiny sprite="spiny" enem=1 break
    case "blooper": content=blooper sprite="blooper" enem=1 break
    case "bobomb": content=bobomb sprite="bob-omb" enem=1 enemy2=1 break
    case "litbobomb": content=litbobomb sprite="bob-ombfuse" enem=1 enemy2=1 break
    case "podoboo": instance_create(x,y+4,podoboo) instance_destroy() break
    case "chopper": instance_create(x,y+4,chopper) instance_destroy() break
    case "mushroom": content=mushroom sprite="mushroom" break
    case "1up": content=lifemush sprite="lifemush" break
    case "3up": content=lifemoon sprite="3moon" break
    case "star": content=starman sprite="star" break
    case "flower": content=flower sprite="fflower" break
    case "mini": content=mushmini sprite="mini" break
    case "feather": content=feather sprite="bfeather" break
    case "beetroot": content=beetroot sprite="btroot" break
    case "greenlui": content=greenlui sprite="glui" break
    case "poison": content=mushpoison sprite="mushpoison" break
    case "spring": content=spring sprite="spring" object=1 break
    case "spreng": content=spreng sprite="spreng" object=1 break
    case "stone": content=stone sprite="stone" object=1 break
    case "cork": content=cork sprite="cork" object=1 break
}

maxitem=unreal(maxitem,4)
