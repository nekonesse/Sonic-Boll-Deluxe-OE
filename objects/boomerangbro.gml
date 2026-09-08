#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

jc=x mod 224
hc=x mod 48
hasboomerang=1
sprite="boomerangbro"
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !inview() {exit}
if (trap) {
    x=(x*4+trap.x)/5
    y=(y*4+trap.y)/5
    flipc-=1
    if (!flipc) {xsc*=-1 flipc=24}
    x-=hspeed
    y-=vspeed
} else if (active) {
    nearest=nearestplayer()
    if abs(nearest.x-x)<120 target=nearest
    if (retreat) {
        cc=0
        x-=sign(x-xstart)*0.25
        if (abs(x-xstart)<32) retreat=0
    } else {
        cc+=1
        if (cc>2560 && x>nearest.x) x+=sign(nearest.x-x)*0.5
        else x+=0.25*sign(gamemanager.act-64)
        if (abs(x-xstart)>128) retreat=1
    }
    hc+=1 if (hc=48) {hc=0
        xsc=esign(x-nearest.x,1)
        if (gonnathrow) {with (instance_create(x,y-10,boomerang)) {xsc=other.xsc owner=other.id} hasboomerang=0}
        gonnathrow=rchoose(0,1,1)
        if !hasboomerang gonnathrow=0
        if (jumping) sprite="boomerangbrojump"
        else sprite="boomerangbro"
        if (gonnathrow) sprtime=8
    }

    jc+=1 if (jc=224) {jc=0 if (!jump) {
        if ((nearest.y>y+64 || rchoose(0,1)) && y+64<region.ky) {coll=collpos(0,16,1) if (coll) if (coll.object_index=brick || coll.object_index=phaser || coll.object_index=itembox) {vspeed=-3 jumping=40 jump=1 sprite="boomerangbrojump"}}
        else {coll=collpos(0,-48,1) if (coll) if (coll.object_index=brick || coll.object_index=phaser || coll.object_index=itembox) {vspeed=-6 jumping=30 jump=1 sprite="boomerangbrojump"}}
    }}

    if (sprtime) {sprtime-=1 if (!sprtime) sprite="boomerangbroaim"}
    if (jump) vspeed=min(4,vspeed+0.25)
    if (jumping) {jumping-=1 if (!jumping && !gonnathrow) sprite="boomerangbro"}
    else {
        yground=easyground()
        if (y>=yground-8-4*(vspeed=0)) {y=yground-8 vspeed=0 jump=0}
        else {retreat=!retreat x=xprevious jump=1}
    }

    if (collision(0,0) && !jumping) {retreat=!retreat x=xprevious}
} else cc=0
xstart=x
