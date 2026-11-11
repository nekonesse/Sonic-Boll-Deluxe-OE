{
up=   0
down= 0
left= 0
right=0
akey= 0
bkey= 0
ckey= 0
skey= 0
xkey=0
ykey=0
zkey=0

if cpu_myleader.flash flash=cpu_myleader.flash
size=cpu_myleader.size
super=cpu_myleader.super
if cpu_myleader.shielded shielded=cpu_myleader.shielded
cpu_myleader=cpu_myleader

//respawn
if (global.mplay<2 && cpu_deadstore!=dead && alarm[7]=-1) {alarm[7]=120}
cpu_deadstore=dead


    //if my player is standing on blockq and I'm directly below it, find a way to get to my player, preferably without hitting the block.

if !auto &&  (global.joynum>(global.input[p2]))||global.input[p2]<2 input_get(global.input[p2])
if (left||right||down||up||akey||bkey||ckey||skey||xkey||ykey||zkey)
{
    player_controlled=1
    backtocputimer=0
}
if !player_controlled { 
    akey=0 
    bkey=0 
    ckey=0 
    skey=0
    left=0 
    xkey=0 
    ykey=0 
    zkey=0
    backtocputimer=0
} else { 
    backtocputimer+=1 
    if backtocputimer>480 {
        player_controlled=0 
        backtocputimer=0
    } 
}

if player_controlled exit

if !instance_exists(cpu_myleader) exit



//the actual bot itself

akey=0
if cpu_myleader.x>x+(16*!jump) right=1
if cpu_myleader.x<x-(16*!jump) left=1

if cpu_myleader.y<(y-32) && cpu_myleader.jump=0 akey=1
//if cpu_myleader.y<(y-12)&&cpu_myleader.jump akey=1
if cpu_myleader.down down=1
if cpu_myleader.spindash&&abs(hsp)<0.5&&!jump{xsc=cpu_myleader.xsc spindash=cpu_myleader.xsc}
if cpu_myleader.abut && !jump {jumpwait=abs(cpu_myleader.x-x)/max(abs(cpu_myleader.hsp),1)  }

if !jump {
    if jumpwait {
        jumpwait-=1 
        if jumpwait<=1 akey=1
    }
}

if vsp>0 canstopjump=0
if jump && (cpu_myleader.vsp+cpu_myleader.y) <(y+16)&&canstopjump &&vsp<-1 {
    akey=1 
    cpu_akeystuck=0
}



////Some pathfinding to avoid bots getting stuck in stupid ways
if push!=0 && !instance_place(x+8*xsc,y-32,collider) akey=1
if !jump
if collision_line(x,y,cpu_myleader.x,cpu_myleader.y,collider,0,1){
    //Determine where the thing is.
    
    if abs(cpu_myleader.x-x)<32 && !push{ //Unlikely that there's something between us horizontally, let's check vertically.
    
    
    } else{//Ah shit there's something here, even worse, jumping wont fix our issues.
        if collision_line(x,bbox_bottom,cpu_myleader.x,cpu_myleader.bbox_bottom,collider,0,1){
        //It's not a tube... (From here characters would likely react differently)
        
        } else{ //Oh it's just a tube lmao (Found a small tunnel, characters will react differently.)
            down=1
            akey=1
        }
    }
}


//Character Specific shit



//Back to general stuff
if akey cpu_akeystuck+=1
else cpu_akeystuck=0

if cpu_akeystuck>5 {
    akey=0
    cpu_akeystuck=0
}

if !inview() && !dead {
    x=cpu_myleader.x
    y=cpu_myleader.y
}

}
