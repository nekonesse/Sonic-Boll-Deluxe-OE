///ssw_item(name)
//This handles sprite switching for the items of the game

if (!inview()) exit

var frox,froy, frx,fry, fr,ffr4,fr88, xsc,ysc,w,h,sheet;

fr=global.frame
ifr=global.itemframe
ffr4=global.fastframe4
fffr4=global.fasterframe4
fr88=global.frame88

frox=0 froy=0 frx=0 fry=0 w=1 h=1 xsc=1 ysc=1
sheet=global.itemsheet[biome]
switch (argument[0]) {
    case "coin": { frox=8 froy=8 frx=4+ifr fry=0 break}
    case "ring": {frox=8 froy=8 frx=4+ifr fry=4 break}
    case "ringup": {frox=8 froy=8 frx=4+ifr fry=4 break}
    case "redring": {frox=8 froy=8 frx=4+ifr fry=5 break}
    case "clearring": {frox=8 froy=8 frx=4+ifr fry=6 break}
    case "redcoin": {frox=8 froy=8 frx=4+ifr fry=2 break}
    case "bluecoin": {frox=8 froy=8 frx=4+ifr fry=3 break}
    case "coinup": {frox=8 froy=8 frx=4+ffr4 fry=1 if (red) fry=2 break}
    case "coindrop": {frox=8 froy=8 frx=4+(fr88 mod 4) fry=1 break}
    case "jumprefresh": {frx=6+spent fry=10 frox=8 froy=8 break}
    case "key": {frx=fr fry=8 frox=8 froy=8 break}
    case "keyfollow": {frx=0 fry=8 frox=8 froy=9-round(abs(cos(posbob))*bob) break}
    case "card": {frx=4+fr fry=8 frox=8 froy=9 break}
    case "cardforshow": {frx=4 fry=8 frox=8 froy=8 xsc=0.5 ysc=0.5 break}
    case "cardfollow": {frx=4+fr fry=8 frox=8 froy=9 break}
    //fuck off! case "dotter": {frx=6 fry=12 frox=8 froy=8 break}
    //fuck on! case "undotter": {frx=7 fry=12 frox=8 froy=8 break}
    case "mushroom": {if (hspeed>=0 && skindat("itemflip")) xsc=-1 frx=fr fry=0 frox=8 froy=8 break}
    case "lifemush": {if (hspeed>=0 && skindat("itemflip")) xsc=-1 frx=fr fry=3 frox=8 froy=8 break}
    case "star":     {if (hspeed>=0 && skindat("itemflip")) xsc=-1 frx=ifr fry=4 frox=8 froy=8 break}
    case "fflower":  {frx=ifr fry=1 frox=8 froy=8 break}
    case "bfeather":  {frx=featherfr fry=2 frox=8 froy=8 break}
    case "shard":    {frx=fr88 fry=9 frox=8 froy=8 if (flip) xsc=-1 break}
    case "mini": {frx=fr fry=6 frox=8 froy=8 break}
    case "token":    {frx=ifr fry=10+type frox=8 froy=8 break}
    case "tokenforshow":    {frx=0 fry=10+type frox=8 froy=8 xsc=0.5 ysc=0.5 break}
    case "shield":    {frx=ifr fry=5 frox=8 froy=8 break} //frx+=4??
    case "mushpoison": {if (hspeed>=0 && skindat("itemflip")) xsc=-1 frx=fr fry=7 frox=8 froy=8 break}
    case "glui":      {sheet=global.topsheetcret[biome] frx=ifr fry=1 frox=8 froy=8 break}
    case "btroot":    {sheet=global.topsheetcret[biome] frx=ifr fry=0 frox=8 froy=8 if (object_index == projectile) {xsc=0.88 ysc=0.88} break}
    case "3moon":     {sheet=global.topsheetcret[biome] frx=ifr fry=2 frox=8 froy=8 break}
    case "mushrotten":     {sheet=global.topsheetcret[biome] frx=4+ifr fry=0 frox=8 froy=8 break}
    case "10coin": {sheet=global.topsheetcret[biome] frx=ifr*2 fry=3 w=2 h=2 frox=16 froy=16 break}
    case "10coinup": {sheet=global.topsheetcret[biome] frx=fffr4*2 fry=3 w=2 h=2 frox=16 froy=16 break}
    case "30coin": {sheet=global.topsheetcret[biome] frx=ifr*2 fry=5 w=2 h=2 frox=16 froy=16 break}
    case "30coinup": {sheet=global.topsheetcret[biome] frx=fffr4*2 fry=5 w=2 h=2 frox=16 froy=16 break}
    case "50coin": {sheet=global.topsheetcret[biome] frx=ifr*2 fry=7 w=2 h=2 frox=16 froy=16 break}
    case "50coinup": {sheet=global.topsheetcret[biome] frx=fffr4*2 fry=7 w=2 h=2 frox=16 froy=16 break}
    case "100coin": {sheet=global.topsheetcret[biome] frx=ifr*2 fry=9 w=2 h=2 frox=16 froy=16 break}
    case "100coinup": {sheet=global.topsheetcret[biome] frx=fffr4*2 fry=9 w=2 h=2 frox=16 froy=16 break}
}

draw_sprite_part_ext(sheet,1,frx*16+8,fry*16+8,w*16,h*16,floor(x-frox*xsc),floor(y-froy*ysc)+dy,xsc,ysc,$ffffff,1)
