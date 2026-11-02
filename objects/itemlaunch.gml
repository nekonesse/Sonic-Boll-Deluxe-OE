#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
spawn=""
getregion(x)
if spentblock() instance_destroy()
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var s;

s=esign(x-(other.x),1)
if (spawn="mushroom") with (instance_create(x,other.bbox_top-8,mushroom)) {c=1 drop=other.drop vspeed=-4 hspeed=s alarm[0]=-1 if (drop) hsp=4*s else hsp=3*s}
if (spawn="1up") with (instance_create(x,other.bbox_top-8,lifemush))      {c=1 drop=other.drop vspeed=-4 hspeed=s alarm[0]=-1 if (drop) hsp=4*s else hsp=3*s}
if (spawn="3up") with (instance_create(x,other.bbox_top-8,lifemoon))      {c=1 drop=other.drop vspeed=-4 hspeed=s alarm[0]=-1 if (drop) hsp=4*s else hsp=3*s}
if (spawn="flower") with (instance_create(x,other.bbox_top-8,flower))     {c=1 drop=other.drop vspeed=-4                                hsp=4*s             }
if (spawn="feather") with (instance_create(x,other.bbox_top-8,feather))   {c=1 drop=other.drop vspeed=-4                                hsp=4*s             }
if (spawn="mini") with (instance_create(x,other.bbox_top-8,mushmini)) {c=1 drop=other.drop vspeed=-4 hspeed=s alarm[0]=-1 if (drop) hsp=4*s else hsp=3*s}
if (spawn="poison") with (instance_create(x,other.bbox_top-8,mushpoison)) {c=1 drop=other.drop vspeed=-4 hspeed=s alarm[0]=-1 if (drop) hsp=4*s else hsp=3*s}
if (spawn="rotten") with (instance_create(x,other.bbox_top-8,mushrotten)) {c=1 drop=other.drop vspeed=-5 hspeed=s alarm[0]=-1 if (drop) hsp=2*s else hsp=1.25*s}
if (spawn="demon") with (instance_create(x,other.bbox_top-8,greendemon)) {c=1 drop=other.drop vspeed=-4.25 gravity=0.15 hspeed=s if (drop) hsp=4.75*s else hsp=4.25*s}
if (spawn="star") with (instance_create(x,other.bbox_top-8,starman))      {c=1 drop=other.drop vspeed=-4 hspeed=s alarm[0]=-1 if (drop) hsp=4*s else hsp=3*s}
if (spawn="shard") with (instance_create(x,other.bbox_top-8,starshard))   {vspeed=-3.5}
if (spawn="shield") with (instance_create(x,other.bbox_top-8,shield))   {vspeed=-3.5}
if (spawn="coin") with (instance_create(x,other.bbox_top-8,itemdrop))     {type="coinup" vspeed=-4 hspeed=2*s}
if (spawn="token") with (instance_create(x,other.bbox_top-8,itemdrop))     {type="token" myspawnx=other.xstart myspawny=other.ystart vspeed=-4 hspeed=2*s}
if (spawn="tokenblue") with (instance_create(x,other.bbox_top-8,itemdrop))     {type="tokenblue" myspawnx=other.xstart myspawny=other.ystart vspeed=-4 hspeed=2*s}
if (spawn="itembeetroot") with (instance_create(x,other.bbox_top-8,beetroot))     {c=1 drop=other.drop vspeed=-4                                hsp=4*s             }
if (spawn="itemgreenlui") with (instance_create(x,other.bbox_top-8,greenlui))     {c=1 drop=other.drop vspeed=-4                             hsp=4*s             }
sound("itemappear")
instance_destroy()
