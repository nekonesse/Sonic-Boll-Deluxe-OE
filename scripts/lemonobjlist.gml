//listobj(object,centered,sprite,iconsubimage,parent)
//    listdoc("Name","Usage")
//    listargs("argnames")
//    listdata("argdefaults")

length=0
m=ds_map_create()
d=ds_map_create()

listobj(lemon_tile     ,0,spr_ground       ,0,lemon_tile)
    listdoc("Tile","")
    listargs("type","mode"     ,"layer","dest","name","entrypoint","create path"   ,"pathids")
    listdata("start","1"       ,"0"    ,"0"   ,""    ,""          ,"0"             ,"-1" )
                    //0 is level
                    //1 is deco
                    //2 is warp
listobj(groundblock     ,0,spr_ground       ,0,groundblock)
    listdoc("Ground","")

listobj(crackedblock     ,0,spr_crackedground       ,177,groundblock)
    listdoc("Cracked Ground","")


listobj(groundsemi      ,0,spr_semi         ,1,groundsemi)
    listdoc("Semi Ground","Can be stood on.")

listobj(groundback     ,0,spr_bground         ,152,groundsemi)
    listdoc("Back Ground","Can't be stood on.")

listobj(hardblock       ,0,spr_hardblock    ,2,groundblock)
    listdoc("Hard Block","")

listobj(bighardblock       ,0,spr_bighardblock    ,136,groundblock)
    listdoc("Big Hard Block","Twice the size, mainly for decoration.")

listobj(castleceiling   ,0,spr_castleceiling,3,groundblock)
    listdoc("Accent Block","Makes your graphics go the extra mile, change aspect a lot when changing biomes.")

listobj(coral           ,0,spr_coral        ,4,coral)
    listdoc("Coral","HOW DID YOU GET HERE?!?!?!")

listobj(treeblock       ,0,spr_treeblock    ,5,groundblock)
    listdoc("Tree","Trees will tile down until they hit the bottom of the region.")

listobj(mushblock       ,0,spr_mushblock    ,6,groundblock)
    listdoc("Mushroom Tree","Mushroom Trees will tile down until the bottom of the region.")

listobj(bridgetile      ,0,spr_bridgetile   ,7,bridgetile)
    listdoc("Bridge","Bridges can be jumped through and will also stop pipes from tiling.")

listobj(bridge          ,0,spr_bridge       ,8,bridgetile)
    listdoc("Castle Bridge","")

listobj(brick           ,0,spr_brick        ,9,brick)
    listdoc("Bricks","Bricks will also stop pipes from tiling.")
    listargs("align",  "stoned" ,"crackedstart")
    listdata("0"     , "0"      ,"0"      )

listobj(bigbrick        ,0,spr_bigbrick        ,184,brick)
    listdoc("Big Bricks","Big Bricks are tougher than regular bricks, and cannot be stoned. Good for them?")
    listargs("align", "crackedstart")
    listdata("0"    , "0")

listobj(itembox         ,0,spr_box          ,10,itembox)
    listdoc("Item Box","Item Boxes can be invisible or look like bricks, and the bonus target is for green springs contained inside.")
    listargs("align","content","bricked","invisible","target")
    listdata("0",""       ,"0"      ,"0"        ,""      )

listobj(bigitembox         ,0,spr_bigbox          ,141,itembox)
    listdoc("Long Item Box","Thrice the size, acts like a regular box but spits out 2 coins on the side.")
    listargs("align","content","target")
    listdata("0",""     ,""      )

listobj(slopel1         ,0,spr_slopel1      ,11,slopel1)
    listdoc("Slope","Somethin' buggin ya?")

listobj(sloper1         ,0,spr_sloper1      ,12,slopel1)
    listdoc("Slope","Somethin' buggin ya?")

listobj(slopel2         ,0,spr_slopel2      ,13,slopel1)
    listdoc("Slope","Somethin' buggin ya?")

listobj(sloper2         ,0,spr_sloper2      ,14,slopel1)
    listdoc("Slope","Somethin' buggin ya?")

listobj(usloper1         ,0,spr_usloper1      ,221,slopel1)
    listdoc("Slope","Somethin' buggin ya?")

listobj(uslopel1         ,0,spr_uslopel1      ,222,slopel1)
    listdoc("Slope","Somethin' buggin ya?")

listobj(usloper2         ,0,spr_usloper2      ,223,slopel1)
    listdoc("Slope","Somethin' buggin ya?")

listobj(uslopel2         ,0,spr_uslopel2      ,224,slopel1)
    listdoc("Slope","Somethin' buggin ya?")

listobj(slopel1s         ,0,spr_slopel1s      ,93,slopel1s)
    listdoc("Semiground Slope","Somethin' buggin ya?")

listobj(sloper1s         ,0,spr_sloper1s      ,94,slopel1s)
    listdoc("Semiground Slope","Somethin' buggin ya?")

listobj(slopel2s         ,0,spr_slopel2s      ,95,slopel1s)
    listdoc("Semiground Slope","Somethin' buggin ya?")

listobj(sloper2s         ,0,spr_sloper2s      ,96,slopel1s)
    listdoc("Semiground Slope","Somethin' buggin ya?")

listobj(usloper1s         ,0,spr_usloper1s      ,225,slopel1s)
    listdoc("Semiground Slope","Somethin' buggin ya?")

listobj(uslopel1s         ,0,spr_uslopel1s      ,226,slopel1s)
    listdoc("Semiground Slope","Somethin' buggin ya?")

listobj(usloper2s         ,0,spr_usloper2s      ,227,slopel1s)
    listdoc("Semiground Slope","Somethin' buggin ya?")

listobj(uslopel2s         ,0,spr_uslopel2s      ,228,slopel1s)
    listdoc("Semiground Slope","Somethin' buggin ya?")

listobj(sloper2b         ,0,spr_sloper2b      ,229,slopel1b)
    listdoc("Background Slope","")

listobj(slopel2b         ,0,spr_slopel2b      ,230,slopel1b)
    listdoc("Background Slope","")

listobj(sloper1b         ,0,spr_sloper1b      ,231,slopel1b)
    listdoc("Background Slope","")

listobj(slopel1b         ,0,spr_slopel1b      ,232,slopel1b)
    listdoc("Background Slope","")

listobj(usloper1b         ,0,spr_usloper1b      ,233,slopel1b)
    listdoc("Background Slope","")

listobj(uslopel1b         ,0,spr_uslopel1b      ,234,slopel1b)
    listdoc("Background Slope","")

listobj(usloper2b         ,0,spr_usloper2b      ,235,slopel1b)
    listdoc("Background Slope","")

listobj(uslopel2b         ,0,spr_uslopel2b      ,236,slopel1b)
    listdoc("Background Slope","")

listobj(phaser          ,0,spr_phaser       ,15,groundsemi)
    listdoc("Phaser","Jump through or one-way walls.")
    listargs("align", "dir")
    listdata("0"  ,"0")

listobj(barrier         ,0,spr_barrier      ,16,barrier)
    listdoc("Barrier","Barriers are invisible and can't be climbed, and they also stop pipes from tiling.")


listobj(ground     ,0,spr_16       ,216,barrier)
    listdoc("Collision","Invisible ground for use in levels.")

listobj(slopebox   ,0,spr_slopebox ,241,barrier)
listdoc("Slope Box","Invisible sloped ground for use in levels.")
listargs("type")
listdata("0")

listobj(waterblock      ,0,spr_water        ,17,waterblock)
    listdoc("Water","Water will tile down to create waterfalls.")
    listargs("w","h")
    listdata("1","1")

listobj(lavablock       ,0,spr_lava         ,18,waterblock)
    listdoc("Lava","Lava does not flow, but it creates decorative lava falls.")

listobj(waterfall      ,0,spr_waterfall       ,178,waterblock)
    listdoc("Waterfall","Will tile down to create more waterfalls.")


listobj(lavafall      ,0,spr_lavafall       ,179,waterblock)
    listdoc("Lavafall","Will tile down to create more lavafalls.")

listobj(onswitch        ,0,spr_onswitch     ,19,onswitch)
    listdoc("Switch Block","")

listobj(onblock         ,0,spr_onblock      ,20,onswitch)
    listdoc("Red Switching Block","")

listobj(offblock        ,0,spr_offblock     ,21,onswitch)
    listdoc("Blue Switching Block","")

listobj(skullblock      ,0,spr_skullblock   ,22,onswitch)
    listdoc("Skull Block","If you die, they become intangible.")

listobj(skullbloff      ,0,spr_skullbloff   ,23,onswitch)
    listdoc("No Skull Block","If you die, they become solid.")

listobj(talkbox         ,0,spr_talkbox      ,24,anchor)
    listdoc("Text Box","Use \ to separate pages and hashtag for newlines.")
    listargs("text")
    listdata("Hi!" )

listobj(anchor          ,1,spr_anchor       ,25,anchor)
    listdoc("Asset Anchor","Check the lemon section in the game manual for detailed instructions.")
    listargs("name"    ,"offset", "bim")
    listdata("mushroom","0,0","0")

listobj(tyler           ,0,spr_tyler        ,26,anchor)
    listdoc("Tyler","This guy named Tyler can place any Tiles sheet graphic anywhere.")
    listargs("off","tile"     ,"layer","coll","rep","mirror","blend"   ,"bim")
    listdata("0,0","46,30,2,2","0"    ,"0"   ,"1x1","0"     ,"16777215","-1" )

listobj(terraintyler           ,0,spr_terraintyler        ,164,anchor)
    listdoc("Terrain Tyler","This other guy named Tyler can place any Terrain sheet graphic anywhere")
    listargs("off","tile"     ,"layer","coll","rep","mirror","blend"   ,"bim")
    listdata("0,0","46,30,2,2","0"    ,"0"   ,"1x1","0"     ,"16777215","-1" )

listobj(objectstyler           ,0,spr_objectstyler        ,165,anchor)
    listdoc("Objects Tyler","This other guy named Tyler can place any Objects sheet graphic anywhere")
    listargs("off","tile"     ,"layer","coll","rep","mirror","blend"   ,"bim")
    listdata("0,0","46,30,2,2","0"    ,"0"   ,"1x1","0"     ,"16777215","-1" )

listobj(decortyler           ,0,spr_decortyler        ,204,anchor)
    listdoc("Decor Tyler","This other guy named Tyler can place any Decor sheet graphic anywhere.")
    listargs("off","tile"     ,"layer","coll","rep","mirror","blend"   ,"bim")
    listdata("0,0","0,0,2,2","0"    ,"0"   ,"1x1","0"     ,"16777215","-1" )

listobj(mark            ,1,spr_mark         ,27,mark)
    listdoc("Object Anchor","")
    listargs("type")
    listdata("")

listobj(textblock       ,0,spr_textblock    ,28,anchor)
    listdoc("Text Block","")
    listargs("str","alignment","color")
    listdata("","0","16777215")

listobj(pipeblock       ,0,spr_pipeblock    ,29,pipeblock)
    listdoc("Pipe","You can place a down pipe on top of this one to create a continuous pipe wall.")
    listargs("name","target","nextlevel","jet","content","maxitem")
    listdata(""    ,""      ,""         ,"0"  ,""       ,"4"      )

listobj(downpipe        ,0,spr_pipeblock2   ,30,pipeblock)
    listdoc("Pipe","You can place a regular pipe under this one to create a continuous pipe wall.")
    listargs("name","target","nextlevel","jet","content","maxitem")
    listdata(""    ,""      ,""         ,"0"  ,""       ,"4"      )

listobj(sidepipe        ,0,spr_sidepipe     ,32,pipeblock)
    listdoc("Pipe","These pipes will connect to nearby vertical pipes.")
    listargs("name","target","nextlevel","jet","content","maxitem")
    listdata(""    ,""      ,""         ,"0"  ,""       ,"4"      )

listobj(theothersidepipe,0,spr_othersidepipe,31,pipeblock)
    listdoc("Pipe","These pipes will connect to nearby vertical pipes.")
    listargs("name","target","nextlevel","jet","content","maxitem")
    listdata(""    ,""      ,""         ,"0"  ,""       ,"4"      )

listobj(door            ,0,spr_door         ,33,pipeblock)
    listdoc("Warp Door","")
    listargs("align", "name","target","nextlevel","key","oneway","locktype","is_pdoor")
    listdata("0,0"  ,""     ,""      ,""         ,"0"  ,"0"     ,"key"     ,"0")

listobj(heaven          ,0,spr_heaven       ,34,heaven)
    listdoc("Coin Heaven Marker","Marks a coin heaven entrance, use the target field to specify the exit drop target.")
    listargs("name","target")
    listdata(""    ,""      )

listobj(droptarget      ,0,spr_drop         ,35,heaven)
    listdoc("Drop In Marker","For when you just don't want a pipe sticking out of the ceiling.")
    listargs("name")
    listdata(""    )

listobj(platform        ,0,spr_platform     ,36,platform)
    listdoc("Platform","")
    listargs("align","type"     ,"length","pulleyheight")
    listdata("0"    ,"platsinev","0"    ,"6"           )

listobj(platdonut       ,0,spr_donut        ,37,platform)
    listdoc("Donut Platform","These will fall after a short period of stading on them. They also have a long variant.")
    listargs("align", "long")
    listdata("0"    ,"0")

listobj(platboat        ,0,spr_boat     ,240,platform)
    listdoc("Boat","Starts moving when a player stands on it. Stops at walls, will ignore grates")
    listargs("align")
    listdata("0")

listobj(spring          ,0,spr_spring       ,38,spring)
    listdoc("Spring","")

listobj(spreng          ,0,spr_spreng       ,39,spring)
    listdoc("Side Spring","Place two for the ultimate Sonic 2 action!")

listobj(sprong          ,0,spr_sprong       ,40,spring)
    listdoc("Green Spring","Green Springs can also warp you to different levels.")
    listargs("target")
    listdata(""      )

listobj(axe             ,0,spr_axe          ,41,axe)
    listdoc("Axe","Axes will destroy the closest bridge and all nearby Axe Barriers, and also defeat the nearest boss.")
    listargs("align","channelid")
    listdata("0","0")

listobj(axewall         ,0,spr_axewall      ,42,axe)
    listdoc("Axe Barrier","Axe Barriers will disappear when the closest axe to them is collected.")
    listargs("type")
    listdata("0"   )

listobj(cork            ,1,spr_cork         ,43,cork)
    listdoc("Cork","Cork blocks float in water and can be pushed or grabbed.")
    listargs("align")
    listdata("0"    )

listobj(stone           ,0,spr_stone        ,44,cork)
    listdoc("Stone","Stone blocks fall with gravity, and are a bit heavy.")
    listargs("align")
    listdata("0"    )

listobj(checkpoint      ,0,spr_checkpoint   ,45,checkpoint)
    listdoc("Checkpoint","Checkpoints will provide a Special Ring that activates red coins, or a Special Stage.")
    listargs("align","func","powerup")
    listdata("0"    ,"0"   ,"0")

listobj(flagpole        ,0,spr_flagpole     ,46,flagpole)
    listdoc("Flagpole","Flagpoles have an option for the filename of the next level to load.")
    listargs("nextlevel")
    listdata(""         )

listobj(signpost     ,0,spr_signpost     ,47,flagpole)
    listdoc("Signpost","Signposts, just like flagpoles, have an option for the filename of the next level to load.")
    listargs("nextlevel")
    listdata(""         )

listobj(retainer        ,0,spr_retainer     ,48,flagpole)
    listdoc("Mushroom Retainer","Retainers with an empty target level will act as Princess retainers.")
    listargs("nextlevel","hostages")
    listdata(""         ,"1"       )

listobj(itemlaunch     ,1,spr_itemspawner  ,49,itemlaunch)
    listdoc("Item Launcher","Shoots an item when touched.")
    listargs("align","spawn"   )
    listdata("0"    ,"mushroom")

listobj(coin            ,1,spr_coin         ,50,coin)
    listdoc("Coin","")
    listargs("align")
    listdata("0"    )

listobj(itemring            ,1,spr_ring        ,154,coin)
    listdoc("Ring","These come from Sonic's world. They're a bit too powerful.")
    listargs("align")
    listdata("0"    )

listobj(redring            ,1,spr_redring        ,155,coin)
    listdoc("Red Ring","")
    listargs("align","redringid")
    listdata("0"  ,"1"  )

listobj(mushroom        ,1,spr_mushroom     ,81,mushroom)
    listdoc("Mushroom","")
    listargs("align")
    listdata("0"    )

listobj(lifemush        ,1,spr_1up          ,87,mushroom)
    listdoc("1up Mushroom","")
    listargs("align")
    listdata("0"    )

    //#88 - Dotter (Deprecated)
    //#89 - Undotter (Deprecated)

listobj(lifemoon,1,spr_3moon,242,mushroom)
    listdoc("3up Moon","")
    listargs("align")
    listdata("0"    )

listobj(flower          ,1,spr_flower       ,82,mushroom)
    listdoc("Fire Flower","")
    listargs("align")
    listdata("0"    )

listobj(mushpoison      ,1,spr_poison       ,83,mushroom)
    listdoc("Poison Mushroom")
    listargs("align")
    listdata("0"    )

listobj(starman         ,1,spr_starman      ,84,mushroom)
    listdoc("Starman")
    listargs("align")
    listdata("0"    )

listobj(keyitem         ,1,spr_key          ,85,keyitem)
    listdoc("Key")
    listargs("align")
    listdata("0"    )

listobj(crystaltap      ,1,spr_crystaltap   ,90,crystaltap)
    listdoc("Crystal Tap")
    listargs("align", "trigger")
    listdata("0"    , "0")

listobj(starshard       ,1,spr_shard        ,91,starshard)
    listdoc("Boll Shard")
    listargs("align")
    listdata("0"    )

listobj(redcoin         ,1,spr_redcoin      ,51,coin)
    listdoc("Red Coins","")
    listargs("align")
    listdata("0"    )

listobj(jumprefresh     ,1,spr_jumprefresh  ,52,jumprefresh)
    listdoc("Jump Refresh","Refuels the characters' air moves")

listobj(token           ,1,spr_token        ,53,token)
    listdoc("Token","Tokens stay with you for longer than keys or cards can.")
    listargs("align", "persistence","name")
    listdata("0,0", "0", "")

listobj(shield          ,1,spr_shield       ,86,mushroom)
    listdoc("Shield","")
    listargs("align")
    listdata("0,0")

listobj(goomba          ,1,spr_goomba       ,54,goomba)
    listdoc("Goomba","")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(beetle          ,1,spr_beetle       ,55,beetle)
    listdoc("Beetle","Its shell is pretty sturdy.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(hopkoopa        ,1,spr_para         ,56,hopkoopa)
    listdoc("Paratroopa","They use their wings to hop around.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(koopa           ,1,spr_koopa        ,57,koopa)
    listdoc("Koopa","")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(redhover        ,1,spr_parab        ,58,hopkoopa)
    listdoc("Red Paratroopa","They use their wings to actually fly.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(redkoopa        ,1,spr_koopab       ,59,koopa)
    listdoc("Red Koopa","")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(lakitu          ,1,spr_lakitu       ,60,spiny)
    listdoc("Lakitu","Lakitus respawn when killed.")

listobj(spiny           ,1,spr_spiny        ,61,spiny)
    listdoc("Spiny","Will hurt you when stepped on.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(hammerbro       ,1,spr_hammerbro    ,62,hammerbro)
    listdoc("Hammer Bro","Possibly the most lethal enemy in Bowser's old army.")
    listargs("align","ragemode")
    listdata("0"    ,"1")



listobj(piranha         ,1,spr_piranha      ,63,piranha)
    listdoc("Piranha","Did you know? Piranhas can grow from ceilings too!")
    listargs("align")
    listdata("-8"    )

listobj(redpiranha      ,1,spr_redpiranha   ,64,piranha)
    listdoc("Purple Piranha","Purple Piranhas are less shy.")
    listargs("align")
    listdata("-8"    )

listobj(shell           ,1,spr_shell        ,66,shell)
    listdoc("Shell","Some Koopa must've forgotten their shell...")
    listargs("stype", "mario_bro_source_code")
    listdata("0"    , "0")

listobj(goombrat        ,1,spr_brat         ,67,goomba)
    listdoc("Goombrat","These cousins to goombas are a bit more careful with where they walk.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(podoboo         ,1,spr_podoboo      ,68,podoboo)
    listdoc("Lava Bubble","Lava Bubbles will jump as high as you place them.")
    listargs("align")
    listdata("0"    )

listobj(bulletbill      ,1,spr_bulletbill   ,69,bulletbill)
    listdoc("Bullet Bill","The one and only!")

listobj(cannon          ,0,spr_cannon       ,70,cannon)
    listdoc("Bill Blaster","The multiple and only!")

listobj(cheepspawner    ,0,spr_cheepzone    ,71,cheepspawner)
    listdoc("Cheep Spawner","Cheep Spawners will continuously create swimming cheeps, and also create flying cheeps when placed out of water. Use a spawner stopper to limit their effect area.")

listobj(singlecheep     ,1,spr_cheeps       ,97,singlecheep)
    listdoc("Cheep Cheep","")
    listargs("type")
    listdata("0"   )

listobj(blooper         ,1,spr_blooper      ,65,singlecheep)
    listdoc("Blooper","Contrary to popular belief, squids can actually fly.")

listobj(bulletspawner   ,0,spr_bulletzone   ,72,cheepspawner)
    listdoc("Bullet Spawner","")

listobj(spawncancel     ,0,spr_spawncancel  ,73,cheepspawner)
    listdoc("Spawner Cutoff Marker","These things will stop spawner objects from continuing indefinitely when placed to their right. Watch for indication arrows!")

listobj(fbarblock       ,0,spr_fbarblock    ,74,fbarblock)
    listdoc("Firebar","This invention of King Bowser can rotate in various ways and adjust its length. Or become a waffle.")
    listargs("align","type"  ,"clockwise","noblock","length","angle")
    listdata("0","normal","0"        ,"0"      ,"6"     ,"0")

listobj(spike           ,0,spr_spikes       ,75,spike)
    listdoc("Intangible Spike","Isn't solid. Spikes have a trap mode to detect players walking on top of them.")
    listargs("align","trap","flip")
    listdata("0"    ,"0"   ,"4"   )

listobj(sonicspike         ,0,spr_sonicspike      ,176,spike)
    listdoc("Solid Spikes","Very solid. Spikes have a trap mode to detect players walking on top of them.")
    listargs("align","flip")
    listdata("0"    ,"4"   )

listobj(delfruit        ,1,spr_delfruit     ,76,delfruit)
    listdoc("Delicious Fruit","Is it a cherry? Is it an apple?")

listobj(bowserboss      ,0,spr_bowser       ,77,bowserboss)
    listdoc("Boss","")
    listargs("canfire","hammers","music")
    listdata("1"      ,"0"      ,"1"    )

listobj(turing          ,0,spr_turing       ,78,turing)
    listdoc("Turing Block","Depracted, use Signal Communicators instead.")
    listargs("src","dst")
    listdata("0,0","0,0")

listobj(function        ,0,spr_function     ,79,function)
    listdoc("Function Block")
    listargs("type","text")
    listdata("char",""    )

listobj(code            ,0,spr_code         ,80,code)
    listdoc("Code Block","Read the Technical Document for info.")
    listargs("text","run","channelid")
    listdata(""    ,"trig","0")

listobj(goalblock        ,0,spr_goalblock     ,98,flagpole)
    listdoc("Goal Block","Ends the stage. How exciting!")
    listargs("nextlevel")
    listdata(""         )

listobj(x1F0             ,0,spr_1F0           ,99,x1F0)
    listdoc("Sprite Block","Does not allow things that aren't the player to move through it.")

listobj(grateblock         ,0,spr_noplayer   ,100,x1F0)
    listdoc("Grate","Does not allow players to move through it.")

listobj(cardreader            ,0,spr_cardreader         ,101,carditem)
    listdoc("Card Reader","We only read cards here, sir.")
    listargs("cardamount")
    listdata("0"   ,"card")

listobj(carditem              ,1,spr_card          ,102,carditem)
    listdoc("Card")
    listargs("align")
    listdata("0"    )

listobj(tokencruncher            ,0,spr_cardreader         ,101,token)
    listdoc("Token Cruncher","After reports of faulty card readers asking for tokens, we have decided to simply re-sell them as token crunchers.")
    listargs("cardamount", "locktype", "name")
    listdata("0"   ,"token", "")

listobj(feather              ,1,spr_feather          ,103,mushroom)
    listdoc("Feather")
    listargs("align")
    listdata("0"    )

listobj(monitor              ,1,spr_monitor          ,104,itembox)
    listdoc("Monitor","Break it to get the item displayed, great for bouncing around!")
    listargs("align","contents")
    listdata("0","10coin")

//105= drybones, moved further down for family to display nicer

listobj(drybones             ,1,spr_drybones          ,105, koopa)
    listdoc("Dry Bones","[UNFINISHED] Spooky scary skeletons, send shivers down your spine!")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(vine            ,1,spr_vine        ,106,itembox)
    listdoc("Vine","[UNFINISHED] Climb with ease.")
    listargs("align")
    listdata("0"    )

listobj(fence           ,0,spr_fence       ,107,itembox)
    listdoc("Fence","[UNFINISHED] Climb with ease. Comes in all sizes!")

listobj(crabmeat          ,1,spr_crabmeat       ,108,crabmeat)
    listdoc("Crabmeat","Shoots two projectiles when the player gets near.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(newtron       ,1,spr_newtron       ,109,crabmeat)
    listdoc("Newtron","They're like ninjas... waiting the perfect moment in the dark to attack you!")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(rexbig       ,1,spr_rex       ,110,rexbig)
    listdoc("Rex","This dino takes a few more hits to take off, but it runs all over the place!")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(montymole   ,1,spr_mole       ,111,montymole)
    listdoc("Monty Mole","Can burrow into the ground, once they pop out they start to chase you.")
    listargs("align","type")
    listdata("0"    ,"0")

listobj(thwomp   ,1,spr_thwomp      ,112,thwomp)
    listdoc("Thwomp","Although they can be anywhere...you gotta admit they look better in Bowser's castles.")
    listargs("align","sidethwomp")
    listdata("0"    ,"0")

listobj(thwimp   ,1,spr_thwimp      ,212,thwomp)
    listdoc("Thwimp","Jumps back and fourth in an arc.")
    listargs("align","startdir")
    listdata("0"    ,"1")

listobj(firebro       ,1,spr_firebro    ,189,hammerbro)
    listdoc("Fire Bro","")
    listargs("align")
    listdata("0"    )
listobj(boomerangbro       ,1,spr_boomerangbro    ,113,hammerbro)
    listdoc("Boomerang Bro","")
    listargs("align")
    listdata("0"    )

listobj(yelkoopa           ,1,spr_koopac        ,114,koopa)
    listdoc("Yellow Koopa","This happy-go-lucky Koopa hops with joy everywhere around! It is a bit reckless, however.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(blukoopa           ,1,spr_koopad        ,115,koopa)
    listdoc("Blue Koopa","Look at those sick shades! Be careful though, they might try to charge a shell at you if you're looking at them too closely. Or maybe the glasses.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(bombshellkoopa             ,1,spr_bombshellkoopa          ,125,koopa)
    listdoc("Bombshell koopa","They don't like being stepped on, it makes them explode with anger!")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(yelhover        ,1,spr_parac        ,116,hopkoopa)
    listdoc("Yellow Paratroopa","Float horizontally in a wave pattern.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(bluhover        ,1,spr_parad        ,117,hopkoopa)
    listdoc("Blue Paratroopa","Float verticaly in a line pattern, Dashes at you in the air!")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(urchin       ,1,spr_urchin     ,118,singlecheep)
    listdoc("Urchin","Although its natural habitat is the sea, it can apparently live anywhere...?")
    listargs("align","type","flip")
    listdata("0"    ,"0","0")

listobj(paragoomba          ,1,spr_paragoomba       ,120,goomba)
    listdoc("Paragoomba","")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(paragoombrat          ,1,spr_paragoombrat      ,121,goomba)
    listdoc("Paragoombrat","Faster than Paragoombas.")
    listargs("align","sdir")
    listdata("0"    ,"0")

listobj(pswitch        ,1,spr_switch       ,122,itembox)
    listdoc("P-Switch","It's not a mark object anymore!")
    listargs("align")
    listdata("0"    )

listobj(punchblock        ,1,spr_bump       ,123,itembox)
    listdoc("Punch Block","")
    listargs("align")
    listdata("0"    )

listobj(firepiranha         ,1,spr_firepiranha      ,198,piranha)
    listdoc("Fire Piranha","Will spew fire at the closest player.")
    listargs("align")
    listdata("-8"    )

listobj(noteblock        ,1,spr_noteblock       ,124,itembox)
    listdoc("Note Block","Bouncy, and can contain items. They're a bit broken though, but our construction workers are here to fix them...(in some years???)")
    listargs("align","content","hidden","shifty","target")
    listdata("0"    ,"","0","0","")

listobj(freemover        ,1,spr_platform       ,148,platform)
    listdoc("Free Moving Platform","[Proof of Concept] Can use direction movers to change angle of movement. Very unfinished, and with zero polish to boot. Use with caution.")
    listargs("align")
    listdata("0"    )

listobj(dirchange        ,1,spr_dirchange       ,149,platform)
    listdoc("Direction Changer","This ain't no Track-a-flop. Use with a Free Moving Platform.")
    listargs("dir")
    listdata("0"    )

listobj(pblock        ,1,spr_pblock      ,126,onswitch)
    listdoc("P-Block","Dissapear once you hit a P-Switch.")
    listargs("align")
    listdata("0"    )

listobj(pblockoff       ,1,spr_pblockoff      ,127,onswitch)
    listdoc("P-Block Off","Appear once you hit a P-Switch.")
    listargs("align")
    listdata("0"    )

listobj(bullseyebill      ,1,spr_bullseyebill   ,128,bulletbill)
    listdoc("Bull's-Eye Bill","The Seeker. Like a regular bullet bill, but it will follow you.")

listobj(fishbones      ,1,spr_fishboner   ,129,singlecheep)
    listdoc("Fish Bone","[BROKEN] Charges at you on sight.")
    listargs("align")
    listdata("0"   )

listobj(redcannon      ,0,spr_redcannon   ,130,cannon)
listdoc("Bull's-Eye Blaster","")

listobj(bullseyespawner   ,0,spr_bullseyezone   ,131,cheepspawner)
listdoc("Bull's-Eye Spawner","")

listobj(ballcannon             ,0,spr_plcannon         ,132,cannon)
    listdoc("Cannon","Can shoot Cannonballs in 8 directions.")
    listargs("align","dir","standdir")
    listdata("0","0","0")

listobj(redballcannon             ,0,spr_plredcannon         ,133,cannon)
    listdoc("Fast Cannon","Can shoot Cannonballs in 8 directions... but faster.")
    listargs("align","dir","standdir")
    listdata("0","0","0")

listobj(nslopl             ,0,spr_nslopl       ,133,nslopl)
    listdoc("Slope","yup.")
    listargs("")
    listdata("")

    listobj(nslopr             ,0,spr_nslopr       ,133,nslopl)
    listdoc("Slope","yup.")
    listargs("")
    listdata("")
    listobj(nslopl2             ,0,spr_nslopl2       ,133,nslopl)
    listdoc("Slope","yup.")
    listargs("")
    listdata("")
    listobj(nslopr2             ,0,spr_nslopr2       ,133,nslopl)
    listdoc("Slope","yup.")
    listargs("")
    listdata("")
listobj(nsloplu             ,0,spr_nsloplu       ,133,nslopl)
    listdoc("Slope","yup.")
    listargs("")
    listdata("")

    listobj(nslopru             ,0,spr_nslopru       ,133,nslopl)
    listdoc("Slope","yup.")
    listargs("")
    listdata("")
    listobj(nslopl2u             ,0,spr_nslopl2u       ,133,nslopl)
    listdoc("Slope","yup.")
    listargs("")
    listdata("")
    listobj(nslopr2u             ,0,spr_nslopr2u       ,133,nslopl)
    listdoc("Slope","yup.")
    listargs("")
    listdata("")

listobj(onspike       ,0,spr_onspike      ,134,onswitch)
    listdoc("Switching Spike","Switches from spike to solid when hitting an On/Off switch.")

listobj(offspike        ,0,spr_offspike    ,135,onswitch)
    listdoc("Solid Switching Spike","Switches from solid to spike when hitting an On/Off switch.")

listobj(fakesemiplat             ,0,spr_semiplat      ,137,groundsemi)
    listdoc("Semisolids","Comes in all sizes!")
    listargs("align","width","height","color")
    listdata("0","1","1","0")

listobj(mushblock2       ,0,spr_mushblock2    ,138,groundblock)
    listdoc("Mushroom Tree 2","If it's so good, why doesn't it have a sequel? Same function, different look")
listobj(mushblock3       ,0,spr_mushblock3    ,139,groundblock)
    listdoc("Mushroom Tree 3","Same function, different look")

listobj(wigglerhead             ,1,spr_semiplat      ,139,wigglerhead)
    listdoc("Wiggler","[BROKEN] Caution: The wiggly worm will get angry if stepped on.")
    listargs("align")
    listdata("0")

listobj(spikenemy             ,1,spr_spikenemy      ,140,spikenemy)
    listdoc("Spike","[UNFINISHED] Will spit out spikeballs.")
    listargs("align")
    listdata("0")

listobj(ballcannonquad             ,0,spr_plquadcannon         ,142,cannon)
listdoc("Quad Cannon","Like a cannon, but alternates between angles with each shot.")
listargs("align","dir")
listdata("0","0")

listobj(redballcannonquad             ,0,spr_plredquadcannon         ,143,cannon)
listdoc("Fast Quad Cannon","Like a faster cannon, but alternates between angles with each shot.")
listargs("align","dir")
listdata("0","0")

listobj(powblock             ,0,spr_powblock         ,144,powblock)
listdoc("POW Block","Takes up to 3 hits, each one being an entire screen nuke.")
listargs("align","type")
listdata("0","0")

listobj(banzaibill      ,0,spr_banzaibill   ,145,bulletbill)
listdoc("Banzai Bill","[UNFINISHED] THE BIG ONE!! Can interact with or even break some blocks.")

listobj(bumper             ,0,spr_bumper         ,147,bumper)
listdoc("Bumper","")
listargs("align","type")
listdata("0","0")

listobj(conveyorbelt             ,0,spr_conveyor        ,150,conveyorbelt)
listdoc("Conveyor Belt","It can move various objects, and even yourself!")
listargs("align","beltspd","edgetile")
listdata("0","2","0")

listobj(terrainspring             ,0,spr_terrainspring         ,151,spring)
    listdoc("Terrain Spring","Works like a regular spring, except its stuck in the ground")
    listargs("align","dir")
    listdata("0","0")

listobj(terrainsprong             ,0,spr_terrainsprong         ,195,spring)
    listdoc("Green Terrain Spring","Works like a regular spring, except its stuck in the ground")
    listargs("align","dir")
    listdata("0","0")

listobj(pokey             ,1,spr_pokey         ,214,pokey)
    listdoc("Pokey","A stack of spikey balls that can be adjusted in length.#Going for the head will make it lose all its balance!")
    listargs("align","height")
    listdata("0","3")

listobj(banzailauncher     ,0,spr_banzailauncher         ,153,cannon)
listdoc("Banzai Bill Launcher","")

listobj(boo       ,1,spr_boo       ,119,bulletbill)
    listdoc("Boo","Now you see it, now you don't! Boos are shy, and only follow you if you're not looking at them.")
    listargs("align")
    listdata("0"    )

listobj(warpbox       ,1,spr_warpbox   ,185,pipeblock)
    listdoc("Warpbox","Useful for secrets, level transitions, or quick transportation between areas.")
    listargs("align","name","target","nextlevel","instant","key","locktype")
    listdata("0,0"  ,""    ,""      ,""         ,"0"      ,"0"  ,"key")

listobj(pollenflower            ,0,spr_polflower       ,183,spring)
    listdoc("Pollen Flower","Works like a terrain spring. But makes you fall slower.")
    listargs("align")
    listdata("0")

//Button Family

listobj(button             ,0,spr_button         ,156,button)
listdoc("Button","Stepping on this will activate a signal.")
listargs("align","channelid","filter","perma","invis")
listdata("0","0","0","0","0")

listobj(detector             ,0,spr_detector       ,158,button)
listdoc("Detector","Passing through this will activate a signal.")
listargs("align","channelid","filter","height","invis","perma")
listdata("0","0","0","4","0","1")

listobj(gate             ,0,spr_gate       ,182,button)
listdoc("Gate","Opened with a signal.")
listargs("align","channelid","height","speedam","inverted","flipped")
listdata("0","0","2","4","0","0")

listobj(sidegate             ,0,spr_hitbox       ,196,button)
listdoc("Sideways Gate","Opened with a signal.")
listargs("align","channelid","width","speedam","inverted","flipped")
listdata("0","0","2","4","0","0")

listobj(signalblock          ,0,spr_signalblock     ,186,button)
listdoc("Signal Block","Turns hollow with a signal, else it's solid.")
listargs("channelid","inverted")
listdata("0","0")

//Signal Communicator Family

listobj(signalcommunicator             ,0,spr_signalcommunicator        ,159,signalcommunicator)
listdoc("Signal Communicator","Hitting this can activate multiple signals, can act like a logic gate. Read the Technical Document for info.")
listargs("align","channelid","channelid2","channelid3","channelid4","channelid5","channelid6","logic")
listdata("0","0","0","0","0","0","0","0")

listobj(onoffscreen             ,0,spr_onoffscreen       ,157,signalcommunicator)
listdoc("On/Off Screen","Activating this will cause a countdown, or other stuff. Read the Technical Document for info.")
listargs("align","channelid","channelid2","channelid3","channelid4","type")
listdata("0","0","0","0","0","0")

listobj(displayscreen        ,0,spr_displayscreen       ,205,signalcommunicator)
listdoc("Segmented Display","A Screen with 4 different inputs that control each corner display.")
listargs("align","channelid","channelid2","channelid3","channelid4")
listdata("0","0","0","0","0")

listobj(timerblock             ,0,spr_timerblock      ,160,signalcommunicator)
listdoc("Timer Block","Activates a configurable timer and gives an output if the timer stops. Read the Technical Document for info.")
listargs("align","channelid","channelid2","channelid3","settime")
listdata("0","0","0","0","60")

listobj(variableblock             ,0,spr_variableblock     ,207,signalcommunicator)
listdoc("Variable Block","Bumping or activating this block will increase or decrease its value. Very configurable.")
listargs("align","channelid","channelid2","minvalue","maxvalue","channelid3","mode")
listdata("0","0","0","0","99","0","0")

listobj(channelmaster             ,0,spr_channelmaster     ,209,signalcommunicator)
listdoc("Channel Master","Swap channels with remote inputs, will activate a different ouput channel with a 3rd input.")
listargs("align","channelid","channelid2","channelid3")
listdata("0","0","0","0")

listobj(bopblock             ,0,spr_bopblock        ,210,signalcommunicator)
listdoc("Bop Block","Will activate a signal for a single frame.")
listargs("align","channelid","channelid2","channelid3")
listdata("0","0","0","0")

listobj(ireader          ,0,spr_ireader       ,161,signalcommunicator)
listdoc("I-Reader","Reads a signal from an external source. Read the Technical Document for info.")
listargs("src","value","channelid","channelid2","channelid3","channelid4")
listdata("0,0","0","0","0","0","0")

listobj(gobble          ,0,spr_gobble       ,206,signalcommunicator)
listdoc("Gobble","Compares two signals from external sources.")
listargs("src","src2","type","channelid")
listdata("0,0","0,0","0","0")

//End

listobj(spawnerblock          ,0,spr_spawnerblock      ,163,spawnerblock)
listdoc("Spawner","Spawns any object with a signal. Read the Technical Document for info.")
listargs("align","object","ccode","channelid","invis")
listdata("0","0","","0","0")

listobj(enemydummy          ,1,spr_enemydummy      ,211,enemydummy)
listdoc("Samba","When you just feel like sitting around and doing nothing.#Can execute creation code.")
listargs("align","ccode")
listdata("0","")

/*listobj(spriteswitcher          ,0,spr_spriteswitcher     ,166,signalcommunicator)
listdoc("Sprite Switcher","Visually changes the player's sprite. Read the Technical Document for info.")
listargs("align","nearest","setspr","channelid")
listdata("0","0","","0")*/

listobj(cloudtile         ,0,spr_cloudtile     ,166,groundsemi)
listdoc("Cloud Tile","Acts like a single tile semisolid.")

listobj(orbinautgreen          ,0,spr_orbinautgreen     ,167,orbinautgreen)
listdoc("Orbinaut","")
listargs("align","sdir")
listdata("0"    ,"0")

listobj(orbinautblue         ,0,spr_orbinautblue     ,168,orbinautgreen)
listdoc("Throwing Orbinaut","")
listargs("align","sdir")
listdata("0"    ,"0")

listobj(orbinautred         ,0,spr_orbinautred     ,169,orbinautgreen)
listdoc("Fire Orbinaut","")
listargs("align","sdir")
listdata("0"    ,"0")

listobj(orbinautbumper        ,0,spr_orbinautbumper     ,170,orbinautgreen)
listdoc("Bumper Orbinaut","")
listargs("align","sdir")
listdata("0"    ,"0")

listobj(grinder        ,0,spr_grinder     ,171,spike)
listdoc("Grinder","Static Hazard, allows you to spinjump off.")
listargs("align")
listdata("0")

listobj(bombenemy        ,0,spr_bomb     ,172,crabmeat)
listdoc("Bomb","Big nuisance, explodes into several bullets when a player is near.")
listargs("align","mode")
listdata("0","0")

listobj(chopper        ,0,spr_chopper     ,174,podoboo)
listdoc("Chopper","Choppers will jump as high as you place them, and jump constantly.")
listargs("align")
listdata("0")

listobj(dashpanel        ,0,spr_dashpanel     ,175,dashpanel)
listdoc("Dash Panel","Makes players go max speed instantly.")

listobj(muncher        ,0,spr_muncher     ,92,spike)
listdoc("Muncher","Similar to a solid spike, can be killed by POWs.")
listargs("align")
listdata("0")

listobj(bigmuncher        ,0,spr_bigmuncher     ,180,spike)
listdoc("Big Muncher","[BROKEN] Same as a muncher, But even Bigger.")
listargs("align")
listdata("0")

listobj(mushmini        ,1,spr_mushsmall     ,187,mushroom) //lol
listdoc("Mini Mushroom","size 2 and size 3 fans when size 5 walks in")
listargs("align")
listdata("0"    )

listobj(swinginghammer        ,0,spr_swinginghammerfull     ,188,spike)
listdoc("Swinging Hammer","Will release from its chain when near, swinging and breaking blocks on its way.")
listargs("align","startingrot","reversed")
listdata("0","0","0")

listobj(crate           ,0,spr_crate        ,192,brick)
    listdoc("Crate","Easier to break than bricks, can hold items.")
    listargs("align","content")
    listdata("0","")

listobj(beepblockon         ,0,spr_beepblockon      ,190,beepblockon)
    listdoc("Red Beeping Block","")
    listargs("align","start_beep")
    listdata("0","5")

listobj(beepblockoff        ,0,spr_beepblockoff    ,191,beepblockon)
    listdoc("Blue Beeping Block","")
    listargs("align","start_beep")
    listdata("0","5")

listobj(lightbulb        ,0,spr_lightbulb    ,194,lightbulb)
    listdoc("Light Bulb","An invisible source of light in dark areas, can adjust shape and size.")
    listargs("align","shape","width","height","channelid")
    listdata("0","ellipse","5","5","0")

listobj(bobomb      ,1,spr_bobomb     ,173,bobomb)
listdoc("Bob-Omb","Ignites when stomped on, will break blocks around its radius when it explodes.")
listargs("align","sdir")
listdata("0"    ,"0")

listobj(litbobomb      ,1,spr_litbobomb     ,197,bobomb)
listdoc("Lit Bob-Omb","Will break blocks around its radius when it explodes.")
listargs("align","sdir")
listdata("0"    ,"0")

listobj(fireballshooter        ,0,spr_fireballshooter     ,199,fbarblock)
listdoc("Fireball Shooter","Shoots Fireballs, can optionally fire with an Input Signal.")
listargs("align","dir","channelid")
listdata("0","0","0")

listobj(spikecrusher        ,0,spr_spikecrusher     ,200,spike)
listdoc("Crusher","Constantly drops downwards, and its name doesn't really lie.")
listargs("width","ylimit","spiked")
listdata("4","0","1")

listobj(jetstream         ,0,spr_wind      ,201,barrier)
    listdoc("Jet Stream","Applies force to players and enemies within the stream area.")
    listargs("strength","dir","w","h","parttype","nopart")
    listdata("2","0","1","1","0","0")

listobj(segafadewarp         ,0,spr_fadeenter      ,202,pipeblock)
    listdoc("Screen Warp Entrance","Touching this object will warp the player to a destination with the same ID.")
    listargs("wid","w","h")
    listdata("0","1","1")

listobj(segafadedest         ,0,spr_fadeexit      ,203,pipeblock)
    listdoc("Screen Warp Destination","Destination for Screen Warp Entrance.")
    listargs("wid")
    listdata("0")

listobj(gearplatform         ,1,spr_gearplatform      ,213,platform)
    listdoc("Gear Platform","Players fall off the platform when it's stood on.")
    listargs("align")
    listdata("0")

listobj(chardoor            ,0,spr_chardoor         ,215,pipeblock)
    listdoc("Character Door","Allows the player to swap the character they're using.")
    listargs("name")
    listdata("sonic")


listobj(activate_region     ,0,spr_activateregion   ,217,barrier)
    listdoc("Activation Area","Activate all objects inside them while a player is near. May cause lag if too large.")
    listargs("align","width","height")
    listdata("0","1","1")

listobj(hillzone          ,0,spr_191hill       ,218,hillzone)
    listdoc("Hill Zone","don't use these in new levels they probably barely work")


listobj(fencezone          ,0,spr_191fence       ,219,hillzone)
    listdoc("Fence Zone","don't use these in new levels they probably barely work")

listobj(scriptblock, 0,spr_scriptblock         ,220,code)
    listdoc("Script Block","Read the Technical Document for info.")
    listargs("align","scriptname","channelid")
    listdata("0","","0")

listobj(trigger_spawn, 0,spr_trigger_spawn         ,216,trigger_spawn)
    listdoc("Trigger Spawn Entity","Spawns a defined object at this entity's position with the desired alignment.")
    listargs("align","obj","objalign","constant","channelid")
    listdata("0","goomba","8,8","0","0")

listobj(logic_relay, 0,spr_logic_relay         ,216,trigger_spawn)
    listdoc("Logic Relay Entity","Relays 1 signal up to 4 output channels")
    listargs("channelid","outputid","outputid2","outputid3","outputid4")
    listdata("0","0","0","0","0")

listobj(event_auto, 0,spr_event_auto         ,216,trigger_spawn)
    listdoc("Event Auto Entity","Outputs up to 4 channels when the level starts")
    listargs("outputid","outputid2","outputid3","outputid4")
    listdata("0","0","0","0")

listobj(event_input, 0,spr_event_input         ,216,trigger_spawn)
    listdoc("Event Input Entity","Outputs to a channel when the specificed player input button is pressed")
    listargs("checkfor","outputid","index","onpress")
    listdata("akey", "0", "0", "0")

listobj(bluecoin         ,1,spr_bluecoin      ,237,coin)
    listdoc("Blue Coins","Blue coins only appear when affected by a P-Switch")
    listargs("align")
    listdata("0"    )

listobj(beetroot          ,1,spr_beetroot     ,238,beetroot)
    listdoc("Beetroot","mario forces cutscene 14 'it's been forever since i've seen you!'")
    listargs("align")
    listdata("0"    )

listobj(greenlui          ,1,spr_greenlui     ,239,beetroot)
    listdoc("Green Jumping Lui","mario forces cutscene 14 'it's been forever since i've seen you!'")
    listargs("align", "jumping")
    listdata("0"    , "0")

listobj(pig          ,0,spr_pig     ,243,pig)
    listdoc("The pig from angry birds","Bye Bye Broom")
    listargs("align")
    listdata("0,0"  )

n=ds_map_create()
k=ds_map_find_first(m)
repeat (ds_map_size(m)) {
    ds_map_add(n,object_get_name(k),k+1)
    k=ds_map_find_next(m,k)
}




global.lemonnames=m
global.lemondescs=d
global.lemonobjs=n
