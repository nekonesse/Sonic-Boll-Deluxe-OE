///drawskinnablehud()
//draws new model hudlet based hud
//scope: gamemanager

var t,p,spr,col,col2,n,n,s,ps,key,fsiner,maintain_ring,biome;

p=players[view_current]
getregion(p.x)

d3d_transform_stack_push()
d3d_transform_add_translation(hoffx,hoffy,0)

draw_sprite_ext(hudspr,0,200-hudw,0,1,1,0,c_white,hud_alpha[view_current])


spr=p.sheets[global.reroutedsizes[p.p2,p.size]]
if global.singlesheet[slot] spr=p.sheets[0]

emblem_sheetx=p.emblem_sheetx
emblem_sheety=p.emblem_sheety

nametag_sheetx=p.nametag_sheetx
nametag_sheety=p.nametag_sheety

energyhor_sheetx=p.energyhor_sheetx
energyhor_sheety=p.energyhor_sheety

energyvert_sheetx=p.energyvert_sheetx
energyvert_sheety=p.energyvert_sheety

//if p.dontdrawhudler=1 exit

if !(global.nohud) && !(p.dontdrawhudler) {

    if p.usepalette scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[p.p2*100],global.pal_1[p.p2]+1,global.pal_2[p.p2]+1,global.pal_3[p.p2]+1,global.pal_4[p.p2]+1,p.size,hud_alpha[view_current],p.totpal+1)
    //emblem
    draw_sprite_part_ext(spr,0,emblem_sheetx,emblem_sheety,18,18,14,199,1,1,c_white,hud_alpha[view_current]) //grin emoji
    //name tag
    draw_sprite_part_ext(spr,0,nametag_sheetx,nametag_sheety,65,9,32,200+((settings("cog inflives") && global.gamemode!="timeattack" && global.gamemode!="battle" && p.name != "kid")*4),1,1,c_white,hud_alpha[view_current])
    shader_reset();

    var py;
    py = clamp(gamemanager.frog_escape, 0, 16)
    if (gamemanager.frog_escape && gamemanager.frog_escape_timer == 0 && gamemanager.frog_escape_timer_effect == 2) // scroll timer back in for drain
    py = 16-clamp(gamemanager.frog_escape - (32+16), 0, 16)


    if global.gamemode!="timeattack" {
        col=$ffffff
        if (global.inf_time || global.wanna) {
            draw_skintext(336,8,chr(17)+"-:--",col,hud_alpha[view_current])
        } else {
            if (gamemanager.time<=skindat("hurrytime") && global.frame8) col=$ff
            if (skindat("mariotime"))
                t=floor(players[view_current].tick/22.5)
            else
                t=floor(players[view_current].tick/60)

            t_offset = ((t div 60) >= 10) + ((t div 60) >= 100) //listen if you can get 1000 minutes of time i dont wanna hear nothing about it being offcentered
            draw_skintext(336-(t_offset*8),8 - py,chr(17)+string(t div 60)+":"+format(t mod 60,2),col,hud_alpha[view_current])
        }
    } else {
        global.inf_time=1
        t=floor(players[view_current].tick/60)
        t2=floor(players[view_current].tick*1.66666667)
        global.halign=1


        var timestring, l, u;;
        l = global.lskins[global.levelskin+1,0]
        if (l == global.lbase) l = ""

        timestring=chr(17)+string(t div 60)+"'"+format(t mod 60,2)+"''"+format(t2 mod 100,2)
        //redstring="  "+chr(19+settings("ta_win_" + global.levelfname + l))
        placement=3 u=3
        tas="" if global.tasing tas="tas_"
        repeat 3 {if ta_set("ta_time_"+tas+string(u-1)+global.currentlevel+l) > players[view_current].tick placement-=1 u-=1}

        draw_skintext(200,8 - py,timestring,c_white,hud_alpha[view_current])

        global.halign=0

        if medshake medshake-=0.5

        if (placement == prevplacement + 1) && (placement < 4) {
            medshake=choose(4,4.5)
            if (placement < 3) sound("itemwarpboxexit",0,1.175)
            else if (placement == 3) sound("smallbumper")
        }
        u=round(medshake)
        draw_sprite(spr_ta_rank,min(placement,3),200+(5*8)+irandom_range(-u,u),6+irandom_range(-u,u))

        prevplacement=placement

    }

    /*if (global.gamemode="battle") {
        drawhudlet("stages",stageleft)
        drawhudlet("frags",p.frags)
    }*/
    if ((global.gamemode="classic" || /*just incase*/ global.gamemode="tutorial") && (!settings("cog inflives") || p.name="kid")) draw_skintext(40,208,chr(42)+drawlivestring(),c_white,hud_alpha[view_current])
    if (global.gamemode="battle") draw_skintext(40,208,chr(127)+string(p.frags),c_white,hud_alpha[view_current]) //figuring it out now its later
    if (global.gamemode="timeattack") draw_skintext(40,208,chr(18)+chr(42)+string(settings("ta_death")),c_white,hud_alpha[view_current])

    //i hope newly joined moster dies for this stupid hasty quickfix -current moster


    draw_skintext(248 + ((global.gamemode=="timeattack") * 64),8,formatdark(global.scor[view_current],9),$ffffff,hud_alpha[view_current])
    draw_skintext(16,8,chr(36)+chr(42)+format(global.coins[view_current],2),$ffffff,hud_alpha[view_current])
    maintain_ring=0
    if global.rings[view_current]=0
        with itemdrop if type="ringup" && p2=view_current {maintain_ring=1}
    if global.rings[view_current]==0
        col2=$ffffff
        if global.frame8 col2=$ff
    if ringxoffset!=-44 && global.rings[view_current]=0 && !maintain_ring{
        ringxoffset-=1
        col2=$ff
    }else if ringxoffset!=16 && (global.rings[view_current]>0 || maintain_ring) {
        ringxoffset+=1
        col2=$ffffff
    }
    if global.rings[view_current]!=0
        col2=$ffffff

    draw_skintext(ringxoffset,24,chr(16)+chr(42)+formatdark(global.rings[view_current],3),col2,hud_alpha[view_current])

    // min is -44 max is 16
    // so in total it's 60
    // the vertical bar wants to offset by 24, so... 
    // it's y position is offset by (((ringxoffset+44)/60)*24)



    if global.gamemode!="timeattack" {
    //Red Rings
        for (i=1;i<6;i+=1) {
            if ringexists[i] {
                draw_skintext(328+(i*8),24-py,chr(19+settings("rr" + string(i) + global.levelfname + pack)),c_white,hud_alpha[view_current])
            } else {
                draw_skintext(328+(i*8),24-py,chr(19),$A8A8A8,hud_alpha[view_current])
            }
        }
    }

    //Tokens
    if (gamemanager.tokens > 0 && tokenxoffset!=0) {
        tokenxoffset-=1
        tocol=c_white
    } else if (gamemanager.tokens == 0 && tokenxoffset!=64) {
        tokenxoffset+=1
        tocol=$A0A0A0
    }

    if (global.tokens > 0 && blokenxoffset!=0) {
        blokenxoffset-=1
        blocol=c_white
    } else if (global.tokens == 0 && blokenxoffset!=64) {
        blokenxoffset+=1
        blocol=$A0A0A0
    }
    draw_skintext(336+(tokenxoffset),24 + ((global.gamemode!="timeattack") * 16),chr(128)+chr(42)+formatdark(gamemanager.tokens,3),tocol,hud_alpha[view_current])
    draw_skintext(336+(blokenxoffset),32 + ((global.gamemode!="timeattack") * 16),chr(129)+chr(42)+formatdark(global.tokens,3),blocol,hud_alpha[view_current])

    if (gamemanager.frog_escape) {
       var timothy, timmin, timsec, timcol, timstr, unfixable;
       timcol = c_white
       timothy = gamemanager.frog_escape_timer div 60
       timmin = timothy div 60
       timsec = timothy mod 60
       unfixable = string(timsec)
       if (string_length(unfixable) < 2)
          unfixable = "0"+unfixable

       timstr = string(timmin) + ":" + unfixable

       if (timothy <= 10) timcol = c_red else if (timothy <= 30) timcol = c_yellow

       ni=1
       nx=184
       //ny=32
       ny=(clamp(gamemanager.frog_escape,0,16+32) * 2) - (16 + 32)

       draw_sprite_part_ext(global.effectssheet[biome],0,8,349,16,16,nx-16,ny,1,1,c_white,hud_alpha[view_current])
       repeat (string_length(timstr)) {
              draw_sprite_part_ext(global.effectssheet[biome],0,8 + ((ord(string_char_at(timstr,ni)) - 48) * 8),333,8,16,nx,ny,1,1,timcol,hud_alpha[view_current])
              ni+=1 nx+=8
       }
    }

    //drawhudlet("world",roomname)

    //enerugi bar
    if (p.maxe>=1) {

            if (p.bartype) for (i=0;i<p.maxe;i+=1) draw_sprite_part_ext(spr,0,(energyhor_sheetx+34)+9*median(0,i+1-p.energy,1),energyhor_sheety,8,8,16+8*i,192,1,1,c_white,hud_alpha[view_current])
            else           for (i=0;i<p.maxe;i+=2) draw_sprite_part_ext(spr,0,energyhor_sheetx+17*median(0,i+1-p.energy,1),energyhor_sheety,16,8,16+8*i,192,1,1,c_white,hud_alpha[view_current])

            if (p.bartype) for (i=0;i<p.maxe;i+=1) draw_sprite_part_ext(spr,0,energyvert_sheetx,(energyvert_sheety+34)+9*median(0,1-(p.maxe-i-p.energy),1),8,8,16,8+8*i+16+(((ringxoffset+44)/60)*24),1,1,c_white,hud_alpha[view_current])
            else           for (i=0;i<p.maxe;i+=2) draw_sprite_part_ext(spr,0,energyvert_sheetx,energyvert_sheety+17*median(0,1-(p.maxe-i-p.energy),1),8,16,16,8*i+16+(((ringxoffset+44)/60)*24),1,1,c_white,hud_alpha[view_current])

    }

    temp=hud_alpha[view_current]
    if !retry_alpha[view_current] hud_alpha[view_current]=1

    //reset
    if (instance_exists(p)) if (p.reset) {
        global.halign=1
        global.valign=1

        global.tscale=3
        draw_systext(200-1,88-1,"GAME OVER",0,hud_alpha[view_current])
        draw_systext(200-1,88+1,"GAME OVER",0,hud_alpha[view_current])
        draw_systext(200+1,88-1,"GAME OVER",0,hud_alpha[view_current])
        draw_systext(200+1,88+1,"GAME OVER",0,hud_alpha[view_current])
        draw_systext(200,88  ,"GAME OVER",c_white,hud_alpha[view_current])
        global.tscale=1

        s="------------------------------"
        draw_systext(200-1,108-1,s,0,hud_alpha[view_current])
        draw_systext(200-1,108+1,s,0,hud_alpha[view_current])
        draw_systext(200+1,108-1,s,0,hud_alpha[view_current])
        draw_systext(200+1,108+1,s,0,hud_alpha[view_current])
        draw_systext(200,108  ,s,c_white,hud_alpha[view_current])

        if (global.mplay=1) {
            if (global.input[view_current]<JOY) key=keyname(global.key[11,max(0,global.input[view_current])])
            else key=string_upper(player.joymap[11])
            s="PRESS "+qt+key+qt+" TO TRY AGAIN"
            draw_systext(200-1,120-1,s,0,hud_alpha[view_current])
            draw_systext(200-1,120+1,s,0,hud_alpha[view_current])
            draw_systext(200+1,120-1,s,0,hud_alpha[view_current])
            draw_systext(200+1,120+1,s,0,hud_alpha[view_current])
            draw_systext(200,120  ,s,c_white,hud_alpha[view_current])
        } else {
            s="WAIT TO TRY AGAIN"
            draw_systext(200-1,120-1,s,0,hud_alpha[view_current])
            draw_systext(200-1,120+1,s,0,hud_alpha[view_current])
            draw_systext(200+1,120-1,s,0,hud_alpha[view_current])
            draw_systext(200+1,120+1,s,0,hud_alpha[view_current])
            draw_systext(200,120  ,s,c_white,hud_alpha[view_current])
        }

        global.halign=0
        global.valign=0
    }
}

hud_alpha[view_current]=temp

d3d_transform_stack_pop()

with p if star with other{
    d3d_set_fog(true, c_white, 0, 1)
    if p.usepalette scr_applyPaletteSegmentedAlpha(global.shaderPaletteSwapAlpha,global.palettesprites[p.p2*100],global.pal_1[p.p2]+1,global.pal_2[p.p2]+1,global.pal_3[p.p2]+1,global.pal_4[p.p2]+1,p.size,((-(cos((p.tick / 6)))) * 0.6) * hud_alpha[view_current],p.totpal+1) //Krabby Patty Secret Formula Do Not Remove
    //emblem
    draw_sprite_part_ext(spr,0,78,10,18,18,14,199,1,1, c_white, ((-(cos((p.tick / 6)))) * 0.6) * hud_alpha[view_current])
    //name tag
    draw_sprite_part_ext(spr, 0, 10,10,65,9,32,200+(settings("cog inflives")*4),1,1, c_white, ((-(cos((p.tick / 6)))) * 0.6) * hud_alpha[view_current])
    shader_reset();
    d3d_set_fog(false, c_black, 0, 0)
    if p.tick mod 8{
        i=instance_create(16+random_range(0,80),196+random_range(0,20),playerstars)
        i.setview=view_current
        i.myp=p.p2
    }
}
