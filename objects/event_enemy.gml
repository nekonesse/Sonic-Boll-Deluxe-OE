#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
channelid = 0
getregion(x)
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
outputid=unreal(outputid,0);
outputid2=unreal(outputid2,0);
outputid3=unreal(outputid3,0);
outputid4=unreal(outputid4,0);

p=string_pos(",",src)
srcx=unreal(string_copy(src,1,p-1),0)*16
srcy=unreal(string_delete(src,1,p),0)*16

checkenemy = instance_place(x+srcx,y+srcy,enemy);
if !(checkenemy) {
    checkenemy = instance_place(x+srcx,y+srcy,bowserboss);
}


if (checkenemy) {
    checkenemy.parent_event = id;
}
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if outputid != 0 global.channel[outputid] += 1
if outputid2 != 0 global.channel[outputid2] += 1
if outputid3 != 0 global.channel[outputid3] += 1
if outputid4 != 0 global.channel[outputid4] += 1
activateTechnicals();
