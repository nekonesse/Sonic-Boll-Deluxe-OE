#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
frame=0
timer=0
activated=0
shouldfall=0
hitbehaviour=0
landable=1
timerdeathtype=0
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (activated) { // triggered
   frame += 0.1
   // 3 / 2 is because there's 3 eye sprites and they should display at 2x speed
   // relative to the regular frog switch activate
   if (frame >= (2 + (3 / 2))) {
      frame -= (3 / 2) - 0.1
   }
}
#define Other_16
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
gamemanager.frog_escape = 1
gamemanager.frog_escape_timer = unreal(timer, 60) * 60
gamemanager.frog_escape_timer_effect = unreal(timerdeathtype,0)

gamemanager.frog_secret = egg()

if (gamemanager.frog_secret)
   sound('frogswitch2')
else sound('frogswitch')

mus_play("escape",1)
instance_create(x,y-40,smoke)
activated=1

other.vsp=0

with (konblock) alarm[0]=1
with (koffblock) {alarm[0]=1 owner=global.coll}
gamemanager.kaerublockstate=!gamemanager.kaerublockstate

with (door) if (is_frogdoor) {frogged=1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var fr;
fr = frame
if (fr >= 2)
   fr = 2
draw_background_part(global.masterobjects[biome], 16 + (32 * ceil(fr)), 600, 32, 48, x-8, y-32)
if (frame > 2)
   draw_background_part(global.masterobjects[biome], 112, 600 + (16 * floor((frame - 2) * 2)), 32, 16, x-8, y-32)
