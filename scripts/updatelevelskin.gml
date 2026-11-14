///updatelevelskin()
//updates the level exception for Level not world skins

with globalmanager {
    var worldy,i,exname;
    worldy = global.lskins[1+global.levelskin,0]
    if worldy != global.lbase {
        worldy = moddir + worldy
    }

    exname = global.currentlevel;
    if string_count("¬",global.leveldesc) {
        exname = string_delete(global.leveldesc, 1, (string_pos("¬",global.leveldesc)))
    }

    if (global.lemontest) {
        if (global.lemonlskin != lastlemonlskin) {
            i=0
            repeat (global.biomes) {global.biomesloaded[i]=0 i+=1}

            calcspec()
        }

        if loadspec {
            applyworldskin(global.wskins[1+global.worldskin,0],loadspec) // load default first so you dont get banished to hell
            if (global.lemonlskin != "None") applylevelskin(global.lemonlskin,loadspec)
        }
        lastlemonlskin=global.lemonlskin

    }
    else if (directory_exists(worldy+exname) && global.exception != exname) {
        i=0
        repeat (global.biomes) {global.biomesloaded[i]=0 i+=1}

        calcspec() //Recalculate loadspec, currently loaded biomes don't matter anymore.
        
        if loadspec {
            applyworldskin(global.wskins[1+global.worldskin,0],loadspec) // load default first so you dont get banished to hell
            applylevelskin(worldy+exname,loadspec)
        }
    } else if (!directory_exists(worldy+exname)) {
        if global.exception != "" {
            i=0
            repeat (global.biomes) {global.biomesloaded[i]=0 i+=1}
            
            calcspec() //Recalculate loadspec, currently loaded biomes don't matter anymore.

        }
        global.exception = ""
        global.exceptdir = ""
        if loadspec applyworldskin(global.wskins[1+global.worldskin,0],loadspec)
        updatemusic()
    }

    gamemanager.hudspr=skindat("tex_hud-"+global.gamemode) //reload hud sprite so the game doesnt cry its eyes out when switching mid-level
    gamemanager.hudw=round(sprite_get_width(hudspr)/2)
}
