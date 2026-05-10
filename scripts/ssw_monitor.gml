///ssw_monitor(name)
//This handles sprite switching for the item monitors

if (!inview()) exit

var frox,froy, frx,fry, fr,ffr4,fr88, xsc,ysc,w,h,sheet;
frox=-2 froy=4 frx=0 fry=0 w=1 h=1 xsc=1 ysc=1
sheet=global.monitorsheet[biome]
if (object_index=monamie) fr=3
else fr=global.frame8
if dead fr=2
argument[0]=string(argument[0])

switch (argument[0]) {
    case "mush": {
        frx=0
        fry=0
    break}
    case "fire": {
        frx=0
        fry=1
    break}
    case "feather": {
        frx=0
        fry=2
    break}
    case "star": {
        frx=0
        fry=3
    break}
    case "1up": {
        frx=0
        fry=4
    break}
    case "poison": {
        frx=0
        fry=5
    break}
    case "3up": {
        frx=0
        fry=6
    break}

    case "10coin": {
        frx=1
        fry=0
    break}
    case "shield": {
        frx=1
        fry=1
    break}
    case "superring": {
        frx=1
        fry=2
    break}
    case "mini": { //toilet paper monitor../.
        frx=1
        fry=3
    break}
    case "random": {
        frx=1
        fry=4
    break}
    case "custom": {
        frx=0
        fry=6
    break}

    default:
    case "":
    case "time": {
        frx=1
        fry=5
    break}

}

draw_sprite_part_ext(sheet,1,frx*84+8+fr*21,fry*25+8,w*20,h*24,floor(x+5-8-frox*xsc),floor(y-froy*ysc)+dy,xsc,ysc,$ffffff,1)
if argument[0]="thenewitems" draw_sprite(spr_trollitor,0,floor(x+5-8-frox*xsc),floor(y-froy*ysc)+dy)
