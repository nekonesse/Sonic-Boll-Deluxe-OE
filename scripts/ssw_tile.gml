///ssw_tile(name)
//This handles sprite switching for the items that are on the master sheet

if (!inview()) exit

var frox,froy, frx,fry, fr,ffr4,fr8,fr88, xsc,ysc,w,h, plat;

fr=global.frame
ffr4=global.fastframe4
fr8=global.frame8
fr88=global.frame88

frox=0 froy=0 frx=0 fry=0 w=1 h=1 xsc=1 ysc=1 plat=0 alpha=1
switch (argument[0]) {
    case "brick": {if (anim) frx=9+fr else frx=9+frame fry=16  if (hit) {frx=15-goinup fry=15} break}
    case "bricd": {frx=9+frame fry=16 if biggie {frx=9+(frame*2) fry=22} break}
    case "box": {
        if (content="bros") {frx=2 fry=23 break}
        if (hit) frx=15-goinup
        else frx=9+fr
        fry=15
    break}
    case "bigbox": {
        w=3
        if (hit) {frx=5 fry=16-goinup}
        else {frx=2 fry=15+fr}
        //fry=15
    break}

    case "cracked": if !biggie {frx=14 fry=16 break} else {frx=17 fry=22 w=2 h=2 break}
    ///////////////////MOVE TO OBJECTS.PNG
    case "sonicspike": {
        if (dir=0) {frx=15 fry=1+floor(frame)}
        if (dir=1) {frx=12+floor(frame) fry=0}
        if (dir=2) {frx=11 fry=1+floor(frame)}
        if (dir=3) {frx=12+floor(frame) fry=4}
        if (dir=4) {frx=12+floor(frame) fry=1}
    break}

    //case "cork": {frx=17 fry=20 frox=8 froy=8 break}
    //case "stone": {frx=17 fry=19 frox=8 froy=8 break}
    case "onblock": {frx=15 fry=12+blue break}
    case "offblock": {frx=16 fry=12+blue break}

    case "konblock": {frx=15 fry=14 break}
    case "koffblock": {frx=16 fry=14 break}

    case "onspike": {frx=17+fr fry=12+blue break}
    case "offspike": {frx=21 fry=12+blue break}
    case "onswitch": {frx=14 fry=13-gamemanager.onblockstate break}

    case "pblock": {frx=17 fry=17 frox=8 froy=8 break}
    case "pblockoff": {frx=18 fry=17 frox=8 froy=8 break}

    case "platform": {frx=19.5 fry=0 w=3 frox=24 break}
    case "shortplat": {frx=20 fry=2 w=2 frox=24 break}

    case "donut": {frx=17+frame fry=18 break}
    case "donutlong": {frx=20+frame*2 fry=18 w=2 break}

    case "bridge": {frx=10 fry=12 break}
    case "bridgeparticle": {frx=9+xpart fry=13 w=0.25 frox=0 froy=0 break}
    case "chain": {frx=11 fry=12 h=2 froy=16 break}
    case "chainleft": {frx=9 fry=12 h=2 froy=16 break}
    case "axewall": {frx=12 fry=12 break}

    case "flag": {frx=26+fr*2 fry=0 w=2 h=1.5 break}
    case "door": {
        w=2
        h=2
        frox=8
        froy=16
        if funnytruefalse(is_pdoor) || is_frogdoor {
            if (is_frogdoor) {
                fry=22
                if !frogged && !frame {frx=19}
                else frx=21+floor(frame)*2
            }
            else {
                if !switched && !frame frx=9
                else frx=11+floor(frame)*2
                fry=10
            }
        } else if !(oneway || (target="" && nextlevel="")) {
            frx=11+floor(frame)*2
            if (key && frame=0)
            frx=9
            fry=8
        } else {
            frx=17.5+floor(frame)*2
            fry=10
        }
    break}
    case "chardoor": {
        frx=17.5+floor(frame)*2

        fry=8
        w=2
        h=2
        frox=8
        froy=16
    break}
    case "cardreaderup": {frx=19.5 fry=6.5 w=2 h=2 frox=16 froy=16 break}
    case "cardreaderdown": {frx=32.5 fry=6.5 w=2 h=2 frox=16 froy=16 break}

    case "talkbox": {frx=17+frame fry=15 break}
    case "goalblock": {frx=29+frame fry=3 break}
    case "finishstar": {frx=29+global.fastframe4 fry=2 break}

    case "hardblock": {frx=0 fry=20 break}//used exclusively for hidden shiftblocks btw
    case "noteblock": {frx=9+fr  fry=18+isred break}
    case "shiftblock": {if go frx=14 else if hit||content="" frx=15 else frx=9+fr fry=20 break}

    case "warpbox": {frx=18-key+frame fry=20 frox=8 froy=8 if oncooldown alpha=0.5  break}

}

if plat=0 draw_background_part_ext(global.master[biome],frx*16+8,fry*16+8,w*16,h*16,floor(x-frox*xsc)+notex,floor(y-froy*ysc)+notey+dy,xsc,ysc,$ffffff,alpha)
if (plat!=0) draw_background_part_ext(global.master[biome],(frx+2)*16+8,fry*16+8,16,16,floor(x-frox*xsc+plat*16*xsc),floor(y-froy*ysc)+dy,xsc,ysc,$ffffff,1)
