#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redringid="1"
pack = global.lskins[global.levelskin+1,0]
if (pack == global.lbase) pack = ""
if spentblock() instance_destroy()
#define Collision_player
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
switch redringid{
case "1": myid=1 break;
case "2": myid=2 break;
case "3": myid=3 break;
case "4": myid=4 break;
case "5": myid=5 break;
default: myid=1 break;
}

instance_create(x,y,glitter)
sound("itemredring")

if !global.lemontest {
    if (settings("rr" + redringid + global.levelfname + pack)) {
        stats("clear rings collected",stats("clear rings collected")+1) //"grey rings collected" epic fail
    } else {
        settings("rr" + redringid + global.levelfname + pack,1)
        stats("red rings collected",stats("red rings collected")+1)

        if (stats("red rings collected") >= 20) {
            unlockchar("retromario");
        }
    }
} else if (global.lemontest) {
    stats("red rings tested",stats("red rings tested")+1)
}

global.scor[other.p2]+=1500
global.coins[other.p2]+=10

spendblock()
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !settings("rr" + redringid + global.levelfname + pack) || global.lemontest
    ssw_items("redring")
else
    ssw_items("clearring")
