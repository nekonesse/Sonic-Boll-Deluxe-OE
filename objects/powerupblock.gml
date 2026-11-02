#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
off=0
on=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ply=instance_nearest(x,y,player)

//small
if state="0"{

if inverted="0"{
if (ply.size!=0) {
    y=ystart
    on=1
    off=0
} else if (ply.size==0) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.size!=0) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.size==0) {
    y=ystart
    on=1
    off=0
}
}

}

//big
if state="1"{

if inverted="0"{
if (ply.size!=1) {
    y=ystart
    on=1
    off=0
} else if (ply.size==1) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.size!=1) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.size==1) {
    y=ystart
    on=1
    off=0
}
}

}

//fire
if state="2"{

if inverted="0"{
if (ply.size!=2) {
    y=ystart
    on=1
    off=0
} else if (ply.size==2) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.size!=2) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.size==2) {
    y=ystart
    on=1
    off=0
}
}

}

//feather
if state="3"{

if inverted="0"{
if (ply.size!=3) {
    y=ystart
    on=1
    off=0
} else if (ply.size==3) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.size!=3) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.size==3) {
    y=ystart
    on=1
    off=0
}
}

}

//extra
if state="4"{

if inverted="0"{
if (ply.size!=4) {
    y=ystart
    on=1
    off=0
} else if (ply.size==4) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.size!=4) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.size==4) {
    y=ystart
    on=1
    off=0
}
}

}

//mini
if state="5"{

if inverted="0"{
if (ply.size!=5) {
    y=ystart
    on=1
    off=0
} else if (ply.size==5) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.size!=5) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.size==5) {
    y=ystart
    on=1
    off=0
}
}

}

//beet
if state="6"{

if inverted="0"{
if (ply.size!=6) {
    y=ystart
    on=1
    off=0
} else if (ply.size==6) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.size!=6) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.size==6) {
    y=ystart
    on=1
    off=0
}
}

}

//lui
if state="7"{

if inverted="0"{
if (ply.size!=7) {
    y=ystart
    on=1
    off=0
} else if (ply.size==7) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.size!=7) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.size==7) {
    y=ystart
    on=1
    off=0
}
}

}


//star
if state="8"{

if inverted="0"{
if (ply.star!=1) {
    y=ystart
    on=1
    off=0
} else if (ply.star==1) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.star!=1) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.star==1) {
    y=ystart
    on=1
    off=0
}
}

}

//super
if state="9"{

if inverted="0"{
if (ply.super!=1) {
    y=ystart
    on=1
    off=0
} else if (ply.super==1) {
    y=-verybignumber
    on=0
    off=1
}
}

else if inverted="1"{
if (ply.super!=1) {
    y=-verybignumber
    on=0
    off=1
} else if (ply.super==1) {
    y=ystart
    on=1
    off=0
}
}

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
getregion(x)
if state = "0"{
if off{
draw_background_part(global.masterobjects[biome],208,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],208,616,16,16,x,y)
}
}

if state = "1"{
if off{
draw_background_part(global.masterobjects[biome],224,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],224,616,16,16,x,y)
}
}

if state = "2"{
if off{
draw_background_part(global.masterobjects[biome],240,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],240,616,16,16,x,y)
}
}

if state = "3"{
if off{
draw_background_part(global.masterobjects[biome],256,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],256,616,16,16,x,y)
}
}

if state = "4"{
if off{
draw_background_part(global.masterobjects[biome],272,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],272,616,16,16,x,y)
}
}

if state = "5"{
if off{
draw_background_part(global.masterobjects[biome],288,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],288,616,16,16,x,y)
}
}

if state = "6"{
if off{
draw_background_part(global.masterobjects[biome],336,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],336,616,16,16,x,y)
}
}

if state = "7"{
if off{
draw_background_part(global.masterobjects[biome],352,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],352,616,16,16,x,y)
}
}

if state = "8"{
if off{
draw_background_part(global.masterobjects[biome],304,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],304,616,16,16,x,y)
}
}

if state = "9"{
if off{
draw_background_part(global.masterobjects[biome],320,632,16,16,x,ystart)
y=ystart
}
else {
draw_background_part(global.masterobjects[biome],320,616,16,16,x,y)
}
}
