///ssw_weffects(name)
//This handles sprite switching for the world skin visual effects

var frx,fry,xsc,ysc,w,h,frox,froy;
frox=0 froy=0 frx=0 fry=0 w=1 h=1 xsc=1 ysc=1

switch (argument[0]) {
    case "poof": {frx=8+25*frame fry=8 w=24 h=24 frox=12 froy=12 break}
    case "glitter": {frx=8+25*frame fry=33 w=24 h=24 frox=12 froy=12 break}
    case "kick": {frx=8+25*frame fry=58 w=24 h=24 frox=12 froy=12 break}
    case "firework": {frx=8+25*floor(frame) fry=83 w=24 h=24 frox=12 froy=12 break}
    case "walkdust": {frx=208+25*frame fry=8 w=24 h=24 frox=12 froy=12 break}
    case "badnikpoof": {frx=208+25*frame fry=33 w=24 h=24 frox=12 froy=12 break}

    case "score": {frx=8+25*(value-5*(value>4)+(value==11)-(value==13)) fry=108+25*((value>4)+(value>=11)+(value>=12)+(value>=13)) w=24 h=24 frox=12 froy=12 if (skindat("left")) xsc=-1 break}
    case "redscore": {frx=8+25*(redvalue-1) fry=258 w=24 h=24 frox=12 froy=-12 break}

    case "waterin": {frx=8+25*floor(frame) fry=158 w=24 h=24 frox=12 froy=12 xsc=side break}
    case "waterout": {frx=8+25*floor(frame) fry=183 w=24 h=24 frox=12 froy=12 break}
    case "lavain": {frx=8+25*floor(frame) fry=208 w=24 h=24 frox=12 froy=12 xsc=side break}
    case "lavaout": {frx=8+25*floor(frame) fry=233 w=24 h=24 frox=12 froy=12 break}
    case "rottensmoke": {frx=158+25*frame fry=233 w=24 h=24 frox=12 froy=12 break}
}

draw_sprite_part_ext(global.effectssheet[biome],0,frx,fry,w,h,floor(x-frox*xsc),floor(y-froy*ysc)+dy,xsc,ysc,$ffffff,1)
