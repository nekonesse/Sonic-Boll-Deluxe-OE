#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
mytile=-1
getregion(x)
content="mushroom"
stonebump=0
stoned=""
cracked=0
biggie=0
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (mytile) tile_delete(mytile)
mytile=-1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if (biggie && (image_xscale!=2 || image_yscale!=2)) {image_xscale=2 image_yscale=2}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (lock && mytile) tile_set_position(mytile,x,y+dy)
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(x+8,y+8,smoke)
s=(nearestplayer().xsc)
if (content="mushroom") with (instance_create(x+8,y+8,mushroom)) {c=1 vspeed=-4 hspeed=1.5*other.s alarm[0]=-1}
if (content="1up") with (instance_create(x+8,y+8,lifemush))      {c=1 vspeed=-4 hspeed=1.5*other.s alarm[0]=-1}
if (content="3up") with (instance_create(x+8,y+8,lifemoon))      {c=1 vspeed=-4 hspeed=1.5*other.s alarm[0]=-1}
if (content="flower") with (instance_create(x+8,y+8,flower))     {c=1 vspeed=-4 hspeed=1.5*other.s}
if (content="feather") with (instance_create(x+8,y+8,feather))   {c=1 hspeed=0 vspeed=-4 alarm[0]=1}
if (content="mini") with (instance_create(x+8,y+8,mushmini))     {c=1 vspeed=-4 hspeed=1.5*other.s alarm[0]=-1}
if (content="poison") with (instance_create(x+8,y+8,mushpoison)) {c=1 vspeed=-4 hspeed=1.5*other.s alarm[0]=-1}
if (content="star") with (instance_create(x+8,y+8,starman))      {c=1 vspeed=-4 hspeed=1.5*other.s alarm[0]=-1}
if (content="shard") with (instance_create(x+8,y+8,starshard))   {vspeed=-3.5}
if (content="shield") with (instance_create(x+8,y+8,shield))   {vspeed=-3.5}
if (content="coin") with (instance_create(x+8,y+8,itemdrop))     {type="coinup" vspeed=-4 hspeed=2*s}
if (content="spring") with (instance_create(x,y,spring))   {vspeed=-3.5}
if (content="spreng") with (instance_create(x,y,spreng))   {vspeed=-3.5}
if (content="pswitch") with (instance_create(x,y,pswitch))   {vspeed=-3.5}
if (content="beetroot") with (instance_create(x+8,y+8,beetroot)) {c=1 vspeed=-4 hspeed=1.5*other.s alarm[0]=-1}
if (content="greenlui") with (instance_create(x+8,y+8,greenlui)) {c=1 vspeed=-4 hspeed=1.5*other.s alarm[0]=-1}
if (content != "" && content != "coin" && content != "coins") sound("itemappear")

i=instance_create(x+4,y+12,part) with(i){type=3 hspeed=-1 vspeed=-1+2*go}
i=instance_create(x+12,y+12,part) with(i){type=3 hspeed=1 vspeed=-1+2*go}
i=instance_create(x+4,y+4,part) with(i){type=3 hspeed=-1 vspeed=-3+2*go}
i=instance_create(x+12,y+4,part) with(i){type=3 hspeed=1 vspeed=-3+2*go}

sound("itemcratebreak")

instance_destroy();
#define Other_13
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (mytile) tile_delete(mytile)
mytile=tile_dyn(global.master[biome],152,280,16,16,x,y,2)
