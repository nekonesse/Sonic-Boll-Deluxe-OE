///animation_update
//updates global animation timers

if (skindat("anims")) {
    gframe=(gframe+0.1) mod 4
    global.frame=floor(gframe)
} else {
    gframe=(gframe+0.1) mod 6
    global.frame=max(0,floor(gframe-2))
}
fastframe=(fastframe+0.25) mod 12
fasterframe=(fasterframe+0.5) mod 12
frame8=(frame8+0.125) mod 8
framefire=(framefire+0.25) mod 4
frameitem=frameitem+1/max(1,skindat("itspd"))
boostfrtimer=(boostfrtimer+1) mod 4

global.fastframe2=floor(fastframe/2) mod 2
global.fastframe3=floor(fastframe) mod 3
global.fastframe4=floor(fastframe) mod 4
global.fasterframe4=floor(fasterframe) mod 4
global.frame8=floor(frame8) mod 2
global.frame8flip=((frame8 mod 4)>=2)
global.frame8flipy=(frame8>=4)
global.frame88=floor(frame8)
global.framefire=floor(framefire)
global.dustframe=((frame8 mod 2)=0)
global.boosttrail=8-(frame8*8) mod 8
global.itemframe=floor(frameitem) mod 4

if boostfrtimer=1 global.newaftfr=1 else global.newaftfr=0

global.electric=max(0,global.electric-1)
if (global.electric=0) global.electric=choose(5,10,30)

global.super=floor(frame8 mod 4)
if (global.super=3) global.super=1

//brick tile animation
with (brick) if (tile) {
    if biggie==1 tile_set_region(tile,152+32*(global.frame * !skindat("bricd")),360,32,32)
    else tile_set_region(tile,152+16*(global.frame * !skindat("bricd")),264,16,16)
}
