///initskin()
//initialize skin control structures

with (globalmanager) {
    skinmap=ds_map_create()

    playerskinmap[0]=ds_map_create()
    playerskinmap[1]=ds_map_create()
    playerskinmap[2]=ds_map_create()
    playerskinmap[3]=ds_map_create()
    playerskinmap[4]=ds_map_create()
    playerskinmap[5]=ds_map_create()
    playerskinmap[6]=ds_map_create()
    playerskinmap[7]=ds_map_create()
    playerskinmap[8]=ds_map_create()
    playerskinmap[9]=ds_map_create()
    playerskinmap[10]=ds_map_create()
    playerskinmap[11]=ds_map_create()

    skindir=global.workdir+"SBDX_skins\"
    moddir=global.workdir+"SBDX_mods\"

    directory_create(skindir)
    directory_create(moddir)

    global.worldskin=0
    global.worldskin2=0
    global.musicskin=0
    global.levelskin=0

    global.characters=0

    global.asset[0,0]=0

    i=0
    global.biome[i]="Ground" i+=1
    global.biome[i]="Underground" i+=1
    global.biome[i]="Underwater" i+=1
    global.biome[i]="Castle" i+=1
    global.biome[i]="Bonus" i+=1
    global.biome[i]="Sky" i+=1
    global.biome[i]="Beach" i+=1
    global.biome[i]="Forest" i+=1
    global.biome[i]="Desert" i+=1
    global.biome[i]="GhostHouse" i+=1
    global.biome[i]="Airship" i+=1
    global.biome[i]="Volcano" i+=1
    global.biome[i]="Snow" i+=1
    global.biome[i]="Autumn" i+=1
    global.biome[i]="Factory" i+=1
    global.biome[i]="Clockwork" i+=1
    global.biome[i]="Abstract" i+=1
    global.biome[i]="Tutorial" i+=1
    global.biome[i]="Warp" i+=1
    global.biomes=i
    global.biome[69]="Default"

    for (i=0;i<global.biomes;i+=1) {
        global.master[i]=background_create_color(1,1,0)
        global.masterterrain[i]=background_create_color(1,1,0)
        global.masterobjects[i]=background_create_color(1,1,0)
        global.masterdecor[i]=background_create_color(1,1,0)
        for (j=0;j<96;j+=1) global.effectsprite[i,j]=-1
    }
    list=
        "goomba,goombasmash,goombadead,paragoomba,"+
        "goombrat,goombratsmash,goombratdead,paragoombrat,"+
        "paratroopa,koopa,"+
        "shell,shellwake,shellspin,shelldead,"+
        "redparatroopa,redkoopa,"+
        "redshell,redshellwake,redshellspin,redshelldead,"+
        "yelparatroopa,yelkoopa,"+
        "yelshell,yelshellwake,yelshellspin,yelshelldead,"+
        "bluparatroopa,blukoopa,blushellwinged,"+
        "blushell,blushellwake,blushellspin,blushelldead,"+
        "drybones,drybonesdead,dryres,boo,booscared,stretchappear,stretch,stretchhide,"+
        "bombshellkoopa,bombshell,bombshelldead,bob-omb,bob-omblit,bob-ombfuse,"+
        "beetle,beetleshell,beetleshellwake,beetleshellspin,beetleshelldead,busterbeetle,busterbeetlecarry,busterbeetlethrow,busterbeetledead,parabeetle,parabeetledead,greenparabeetle,greenparabeetledead,"+
        "spinyegg,spiny,spinyshell,spinyshellwake,spinyshellspin,spinyshelldead,spinyball,spinyballdead,pokey,pokeybody,"+
        "spike,spikeballthrow,spikedead,oldspike,oldspikeballthrow,oldspikedead,"+
        "snowspike,snowspikeballthrow,snowspikedead,firespike,firespikeballthrow,firespikedead,"+
        "lakitu,lakituaim,lakitudead,lakitucloud,angrysun,angrysundescend,moon,moondescend,"+
        "hammerbro,hammerbrojump,hammerbroaim,hammerbrodead,firebro,firebrojump,firebroaim,firebrodead,boomerangbro,boomerangbrojump,boomerangbroaim,boomerangbrodead,"+
        "rex,rexsmall,rexsmash,rexdead,rexsmalldead,"+
        "montydigup,montydig,hole,montypop,montymole,montydead,rockywrenchcap,rockywrenchappear,rockywrench,rockywrenchhide,rockywrenchdead,"+
        "wigglerhead,wigglerbod,wigglerheaddead,wigglerboddead,wigglerheadangery,wigglerbodangery,wigglerheadangerydead,wigglerbodangerydead,firesnake,firesnakedead,"+
        "piranha,piranhadie,redpiranha,redpiranhadie,"+
        "firepiranhaup,firepiranhaupshoot,firepiranhadown,firepiranhadownshoot,firepiranhamiddle,firepiranhamiddleshoot,ptooie,ptooieblow,nipper,nipperjump,nipperdead,"+
        "cheep,cheepdead,greencheep,greencheepdead,cheepfly,cheepflydead,spikecheep,spikecheepdead,bossbass,bossbassate,bossbassdead,"+
        "blooper,blooperdead,blooperkid,fishbones,fishbonesattack,fishbonesdead,urchin,lavalotus,lavalotusshoot,"+
        "bullet,bulletdead,bullseyebullet,bullseyebulletdead,flamechomp,flamechompignite,flamechompdead,chainchomp,chainchompdead,"+
        "lavabubble,lavabubbledown,thwomp,thwompangry,thwompdown,thwompangryside,thwompside,bthwomp,bthwompangry,bthwompdown,bthwompangryside,bthwompside,thwimp,hotfoot,hotfootwalk,"+
        "crabmeat,crabmeatshoot,newtrontrans,newtronshoot,newtrongo,chopper,greenorbinaut,blueorbinaut,redorbinaut,bumperorbinaut,"+
        "bombstand,bombwalk,bombignite,buzzbombfly,buzzbombhover,"+
        "samba,"

    global.enemysprites=string_count(",",list)
    for (i=0;i<global.enemysprites;i+=1) {
        p=string_pos(",",list)
        global.enemysprite[i,0]=string_copy(list,1,p-1)
        list=string_delete(list,1,p)
    }

    listBoss=
        "fakebowser,fakebowserfire,fakebowserpanic,"+
        "bowser,bowserfire,bowserpanic,"+
        "dowser,dowserfire,dowserpanic,"+
        "boomboom,boomboomhit,boomboomsit,"

    global.enemybosssprites=string_count(",",listBoss)
    for (i=0;i<global.enemybosssprites;i+=1) {
        p=string_pos(",",listBoss)
        global.enemybosssprite[i,0]=string_copy(listBoss,1,p-1)
        list=string_delete(listBoss,1,p)
    }

    indexskins()

    skinstr("bundlename","")
    skinstr("bundledesc","")
    skindat("settings starting lives",5)
    skindat("maxspecial",1)
}
