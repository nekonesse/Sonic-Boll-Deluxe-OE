///replacecharacter(id,slot,"all",dir) //load entire skin
///replacecharacter(id,slot,"less",dir) //load only roster
///replacecharacter(id,slot,"more",dir) //load roster remainder
//apply character skin
var slot,ss,i,j,k,l,index,what,dir,str,p,splits,nukeprevious,NUKEEMALL,laniel,sheetname,funmode;

index=argument[0]
slot=argument[1]
what=argument[2]
dir=argument[3]
charmusdir=argument[3] //Hey all, -S- here,. this extra variable may be unnecessary, but sadly I don't know if it's good to use dir as a non local variable, if it is, then great, tell me and I'll change it so that this thing is unnecesary again. (Years later i still dont have a response.)


shared=global.cache+"character\_shared\"
allyourbase=global.pbase+global.charname[index]+"\"
if global.charmod[char] allyourbase=moddir+"character\"+global.charname[index]+"\" 

if (dir == allyourbase) nukeprevious = 1 //My precious Leak Nuke.

name=global.charname[index]

ss=string(slot)

if (what="less" || what="all") {
    sheetname=name
    funmode=playerskindat(slot,name+" sheetname")
    if is_string(funmode) sheetname=funmode
    
    playerskinstr(slot,"name"+ss,playerskinstr(slot,name+" name"))
    playerskindat(slot,"noicon"+ss,(replacesheet(slot,name+"icon",dir+name+"-icon.png",0,0,1)=-1))
    playerskindat(slot,"iconspd"+ss,1/median(1,unreal(playerskindat(slot,name+" icon speed"),8),255))
    playerskindat(slot,"iconloop"+ss,funnytruefalse(playerskindat(slot,name+" icon loop")))
    playerskindat(slot,"iconloopback"+ss,unreal(playerskindat(slot,name+" icon loop back"),0))
    if (dir != allyourbase) replacesfx(slot,name+"select",allyourbase+"sfx\"+name+"select.wav",1)
    replacesfx(slot,name+"select",dir+"sfx\"+name+"select.wav",nukeprevious)
    //The following is text translated from ancient engravings found in a dig site:
    //The palette and emblem are to be loaded in less, as they are to be used in the roster.
    replacesheet(slot,name+"emblem",dir+sheetname+"-emblem.png",0,0,1)
    playerskindat(slot,"offersprays"+ss,funnytruefalse(playerskindat(slot,name+" use paletting")))
    playerskindat(slot,"maxsizes"+ss,max(unreal(playerskindat(slot,name+" max sizes"),0),7))
    playerskindat(slot,"totpal"+ss,max(unreal(playerskindat(slot,name+" total palettes"),0),0))
    if (playerskindat(slot,"totpal"+ss) == 0)
        playerskindat(slot,"totpal"+ss,13)
    
    replacepalette(slot,sheetname,dir)
    
    playerskindat(slot,"defaultpal1"+ss,min(unreal(playerskindat(slot,name+" defaultspray 1"),0),playerskindat(slot,"totpal"+ss)))
    playerskindat(slot,"defaultpal2"+ss,min(unreal(playerskindat(slot,name+" defaultspray 2"),0),playerskindat(slot,"totpal"+ss)))
    playerskindat(slot,"defaultpal3"+ss,min(unreal(playerskindat(slot,name+" defaultspray 3"),0),playerskindat(slot,"totpal"+ss)))
    playerskindat(slot,"defaultpal4"+ss,min(unreal(playerskindat(slot,name+" defaultspray 4"),0),playerskindat(slot,"totpal"+ss)))
    playerskindat(slot,"reroutepal2"+ss,median(0,unreal(playerskindat(slot,name+" reroutespray 2"),0),1))
    playerskindat(slot,"reroutepal3"+ss,median(0,unreal(playerskindat(slot,name+" reroutespray 3"),0),2))
    playerskindat(slot,"reroutepal4"+ss,median(0,unreal(playerskindat(slot,name+" reroutespray 4"),0),3))
    playerskindat(slot,"rostersize"+ss,median(-1,unreal(playerskindat(slot,name+" roster size"),-1),playerskindat(slot,"maxsizes"+ss)))
    if (playerskindat(slot,"rostersize"+ss) == -1)
        playerskindat(slot,"rostersize"+ss,1)
}

if (what="more" || what="all") { 
    NUKEEMALL=0
    repeat (32000) {
        global.animdat[slot,NUKEEMALL]=0
        global.boxwidth[slot,NUKEEMALL]=0
        global.boxheight[slot,NUKEEMALL]=0
        global.skincenterx[slot,NUKEEMALL]=0
        global.skincentery[slot,NUKEEMALL]=0
        global.reroutedsizes[slot,NUKEEMALL]=0
        global.spritelist[slot,NUKEEMALL]=0
        global.spritelistsplitpointsname[slot,NUKEEMALL]=0
        global.spritelistsplitpoints[slot,NUKEEMALL]=0
        global.splitsize[slot,NUKEEMALL]=0
        global.singlesheetsplitwidth[slot,NUKEEMALL]=0
        global.animname[slot,NUKEEMALL]=0
        global.reroutedanims[slot,NUKEEMALL]=0
        global.animationstartX[slot,NUKEEMALL]=0
        global.animationstartY[slot,NUKEEMALL]=0
        global.spritelistpadding[slot,NUKEEMALL]=0
        NUKEEMALL+=1
    }
    singlesheet=funnytruefalse(playerskindat(slot,name+" single sheet"))
    global.singlesheet[slot]=singlesheet
    
    sheetname=name
    funmode=playerskindat(slot,name+" sheetname")
    if is_string(funmode) sheetname=funmode
    
    
    if singlesheet {
        replacesheet(slot,name+"0",dir+sheetname+".png",0,0,1) //it was all a trick all along.
    }else replacesheet(slot,name+"0",dir+sheetname+"-basic.png",0,0,1)
    replacesheet(slot,name+"1",dir+sheetname+"-big.png",0,0,1)
    replacesheet(slot,name+"2",dir+sheetname+"-fire.png",0,0,1)
    replacesheet(slot,name+"3",dir+sheetname+"-feather.png",0,0,1)
    replacesheet(slot,name+"4",dir+sheetname+"-extra.png",0,0,1)
    replacesheet(slot,name+"5",dir+sheetname+"-mini.png",0,0,1)
    replacesheet(slot,name+"6",dir+sheetname+"-beet.png",0,0,1) //eternal torture walks in "well whats up sonic boll fans"
    replacesheet(slot,name+"7",dir+sheetname+"-lui.png",0,0,1)
    
    //replacesheet(slot,name+"6",dir+name+"-items.png",0,0,1)
    //You can only reroute to something of a smaller ""value"". It works the same as getting hurt, basically.
    global.reroutedsizes[slot,0]=0
    switch (string(playerskindat(slot,name+" size reroute big"))){
        case "basic": global.reroutedsizes[slot,1]=0 break;
        default: global.reroutedsizes[slot,1]=1 break;
    }
    switch (string(playerskindat(slot,name+" size reroute fire"))){
        case "basic": global.reroutedsizes[slot,2]=0 break;
        case "big": global.reroutedsizes[slot,2]=1 break;
        default: global.reroutedsizes[slot,2]=2 break;
    }
    switch (string(playerskindat(slot,name+" size reroute feather"))){
        case "basic": global.reroutedsizes[slot,3]=0 break;
        case "big": global.reroutedsizes[slot,3]=1 break;
        default: global.reroutedsizes[slot,3]=3 break;
    }
    switch (string(playerskindat(slot,name+" size reroute extra"))){
        case "basic": global.reroutedsizes[slot,4]=0 break;
        case "big": global.reroutedsizes[slot,4]=1 break;
        default: global.reroutedsizes[slot,4]=4 break;
    }
    //Mini already has use mini, so die.
    global.reroutedsizes[slot,5]=5    
    
    switch (string(playerskindat(slot,name+" size reroute beet"))){
        case "basic": global.reroutedsizes[slot,6]=0 break;
        case "big": global.reroutedsizes[slot,6]=1 break;
        case "fire": global.reroutedsizes[slot,6]=2 break;
        case "feather": global.reroutedsizes[slot,6]=3 break;
        default: global.reroutedsizes[slot,6]=6 break;
    }
    switch (string(playerskindat(slot,name+" size reroute lui"))){
        case "basic": global.reroutedsizes[slot,7]=0 break;
        case "big": global.reroutedsizes[slot,7]=1 break;
        case "fire": global.reroutedsizes[slot,7]=2 break;
        case "feather": global.reroutedsizes[slot,7]=3 break;
        default: global.reroutedsizes[slot,7]=7 break;
    }
    
    var johnrepetition, amounte;
    johnrepetition=playerskindat(slot,"maxsizes"+ss)-7
    amounte=8
    
    if johnrepetition {
        repeat (johnrepetition) {
            global.reroutedsizes[slot,amounte]=amounte
            amounte+=1
        }
    }
    
    
    if (file_exists(dir+"princess.png")) replacesheet(slot,"princess",dir+"princess.png",241,354,1)
    else if (file_exists(allyourbase+"princess.png")) replacesheet(slot,"princess",allyourbase+"princess.png",241,354,1)
    else replacesheet(slot,"princess",shared+"princess.png",241,354,1)
    
    if (file_exists(dir+"superparticles.png")) replacesheet(slot,"superparticles",dir+"superparticles.png",217,117,1)
    else if (file_exists(allyourbase+"superparticles.png")) replacesheet(slot,"superparticles",allyourbase+"superparticles.png",217,117,1)
    else replacesheet(slot,"superparticles",shared+"superparticles.png",217,117,1)
    
    if (file_exists(dir+sheetname+"-shields.png")) replacesheet(slot,name+"shields",dir+sheetname+"-shields.png",217,217,1) 
    else if (file_exists(dir+"shields.png")) replacesheet(slot,name+"shields",dir+"shields.png",217,217,1) 
    else if (file_exists(allyourbase+name+"-shields.png")) replacesheet(slot,name+"shields",allyourbase+name+"-shields.png",217,217,1) 
    else if (file_exists(allyourbase+"shields.png")) replacesheet(slot,name+"shields",allyourbase+"shields.png",217,217,1) 
    else replacesheet(slot,name+"shields",shared+"shields.png",217,217,1)
    
    
    
    if (file_exists(dir+"boll.png")) playerskindat(slot,"bolltex"+ss,replacesheet(slot,"boll",dir+"boll.png",0,0,0))    
    
    playerskindat(slot,"3ddeath"+ss,funnytruefalse(playerskindat(slot,name+" 3d death")))
    playerskindat(slot,"minisheet"+ss,funnytruefalse(playerskindat(slot,name+" mini sheet")))
    playerskindat(slot,"glideanim"+ss,funnytruefalse(playerskindat(slot,name+" glide animation")))
    playerskindat(slot,"pitchdash"+ss,funnytruefalse(playerskindat(slot,name+" pitch spindash")))
    playerskindat(slot,"jumpball"+ss,funnytruefalse(playerskindat(slot,name+" jump ball animation")))
    playerskindat(slot,"kidsplat"+ss,funnytruefalse(playerskindat(slot,name+" blood splat")))
    playerskindat(slot,"bowlag"+ss,funnytruefalse(playerskindat(slot,name+" bow lag")))
    playerskindat(slot,"useypos"+ss,funnytruefalse(playerskindat(slot,name+" use ypos")))
    playerskindat(slot,"tempwait"+ss,funnytruefalse(playerskindat(slot,name+" temporary wait")))

    
    
    global.spritelist[slot,index]=global.defaultspritelist[index]
    
    customspritelist= string(playerskindat(slot,name+" custom sprite list"))
    if (customspritelist!="0"&&customspritelist!="") {
        global.spritelist[slot,index]=customspritelist
    }
    
    
    splitternames=string(playerskindat(slot,name+" sheet splits"))
    
    splits=string_count(",",splitternames)+1
    if splitternames="0" splits=0
    
    i=0
    repeat(splits){
        j=string_pos(",",splitternames)
        if j==0 j=string_length(splitternames)+1
        global.spritelistsplitpointsname[slot,i]=string_copy(splitternames,0,j-1)
        
        splitternames=string_copy(splitternames,j+1,(string_length(splitternames)-j))
        i+=1
    }
    
    global.spritelistsplits[slot]=splits
    
    splitville=string(playerskindat(slot,name+" sheet split size"))
    
    i=0
    repeat(splits){
        j=string_pos(",",splitville)
        if j==0 j=string_length(splitville)+1
        global.splitsize[slot,i]=unreal(string_copy(splitville,0,j-1),-1)
        if global.splitsize[slot,i]<=0 global.splitsize[slot,i]=((global.splitsize[slot,i-1]-8)*(i+1)+8)
        splitville=string_copy(splitville,j+1,(string_length(splitville)-j))
        i+=1
    }
    ///////*Single Sheet stuff.
    if global.singlesheet[slot]{
        singlesheetsplitville=string(playerskindat(slot,name+" singlesheet split width"))
        singlesheetsplits=string_count(",",singlesheetsplitville)+1
        i=0
        repeat(singlesheetsplits){
            j=string_pos(",",singlesheetsplitville)
            if j==0 j=string_length(singlesheetsplitville)+1
            global.singlesheetsplitwidth[slot,i]=unreal(string_copy(singlesheetsplitville,0,j-1),-1)-8
            singlesheetsplitville=string_copy(singlesheetsplitville,j+1,(string_length(singlesheetsplitville)-j))
            i+=1
        }
        
        singlesheetsplitville=string(playerskindat(slot,name+" singlesheet split height"))
        singlesheetsplits=string_count(",",singlesheetsplitville)+1
        i=0
        repeat(singlesheetsplits){
            j=string_pos(",",singlesheetsplitville)
            if j==0 j=string_length(singlesheetsplitville)+1
            global.singlesheetsplitheight[slot,i]=unreal(string_copy(singlesheetsplitville,0,j-1),-1)
            singlesheetsplitville=string_copy(singlesheetsplitville,j+1,(string_length(singlesheetsplitville)-j))
            i+=1
        }
    }
    
    
    playerskindat(slot,"bollcoltop"+ss,deciphercolor(playerskinstr(slot,name+" boll top")))
    playerskindat(slot,"bollcolmid"+ss,deciphercolor(playerskinstr(slot,name+" boll mid")))
    playerskindat(slot,"bollcolbot"+ss,deciphercolor(playerskinstr(slot,name+" boll bot")))
    
    playerskindat(slot,"firelen"+ss,median(0,unreal(playerskindat(slot,name+" fire duration")),255))
    playerskindat(slot,"viclen"+ss,median(0,unreal(playerskindat(slot,name+" victory duration")),9999))
    playerskindat(slot,"vicfr"+ss,median(1,unreal(playerskindat(slot,name+" victory frame")),9999))
    playerskindat(slot,"poleoffx"+ss,median(0,unreal(playerskindat(slot,name+" pole center offset")),9999))
    playerskindat(slot,"maxwait"+ss,median(0,unreal(playerskindat(slot,name+" time until wait")),9999))
    playerskindat(slot,"squish"+ss,median(0,unreal(playerskindat(slot,name+" pipe squish")),9999))
    playerskindat(slot,"moth"+ss,median(0,unreal(playerskindat(slot,name+" marker offset"),24),9999))
    if (string(playerskindat(slot,"moth"+ss)) == "0") playerskindat(slot,"moth"+ss, 24)
    playerskindat(slot,"shortsmallform"+ss,median(0,unreal(playerskindat(slot,name+" short small form")),1))
    
    playerskindat(slot,"offshield"+ss,median(-9999,unreal(playerskindat(slot,name+" shield offset")),9999))
    playerskindat(slot,"spdshield"+ss,median(0,unreal(playerskindat(slot,name+" shield speed")),9999))
    playerskindat(slot,"smlshield"+ss,median(-9999,unreal(playerskindat(slot,name+" small shield offset")),9999))
    playerskindat(slot,"skin_offsety"+ss,median(1,unreal(playerskindat(slot,name+" skin offset"),128),9999))
    if string(playerskindat(slot,name+" skin offset"))="0" playerskindat(slot,"skin_offsety"+ss, 128)
    
    if (string(playerskindat(slot,name+" afterimage blend"))="0") playerskindat(slot,"afterimageblend"+ss,$ffffff)
    else playerskindat(slot,"afterimageblend"+ss,deciphercolor(playerskinstr(slot,name+" afterimage blend")))
    
    playerskindat(slot,"carryx"+ss,median(-32,unreal(playerskindat(slot,name+" carry offset x")),32))
    playerskindat(slot,"carryy"+ss,median(-32,unreal(playerskindat(slot,name+" carry offset y")),32))
    
    laniel = "lang"
    if (is_string(playerskindat(slot,"lang "+name+" winspecial"))) laniel += " "+name //Assume that skins with for example, [lang sonic], are pack skins
    
    playerskinstr(slot,"wspecial"+ss,playerskinstr(slot,laniel+" winspecial"))
    playerskinstr(slot,"aspecial"+ss,playerskinstr(slot,laniel+" allspecial"))
    playerskinstr(slot,"princess"+ss,playerskinstr(slot,laniel+" princess"))
    playerskinstr(slot,"savetext1"+ss,playerskinstr(slot,laniel+" savetext1"))
    playerskinstr(slot,"savetext2"+ss,playerskinstr(slot,laniel+" savetext2"))
    playerskinstr(slot,"savetext3"+ss,playerskinstr(slot,laniel+" savetext3"))
    playerskinstr(slot,"savetext4"+ss,playerskinstr(slot,laniel+" savetext4"))
    playerskinstr(slot,"savetext5"+ss,playerskinstr(slot,laniel+" savetext5"))
    playerskinstr(slot,"savetext6"+ss,playerskinstr(slot,laniel+" savetext6"))   
              
    
    if (dir != allyourbase) {
        charmusdir = allyourbase
        if (name="kid") replacecharmusic("reset",slot,1)
        replacecharmusic("princess",slot,1)  
        replacecharmusic("super",slot,1)
        replacecharmusic("starman",slot,1)
        charmusdir = dir
    }
    if (name="kid") replacecharmusic("reset",slot,nukeprevious)
    replacecharmusic("princess",slot,nukeprevious)  
    replacecharmusic("super",slot,nukeprevious)
    replacecharmusic("starman",slot,nukeprevious)
    
    if (dir != allyourbase) {
        playerskindat(slot,"growsfx"+ss,replacesfx(slot,name+"grow",allyourbase+"sfx\"+name+"grow.wav",1))
        playerskindat(slot,"growsfx2"+ss,replacesfx(slot,name+"grow2",allyourbase+"sfx\"+name+"grow2.wav",1))
        playerskindat(slot,"growsfx3"+ss,replacesfx(slot,name+"grow3",allyourbase+"sfx\"+name+"grow3.wav",1))
    }
    playerskindat(slot,"growsfx"+ss,replacesfx(slot,name+"grow",dir+"sfx\"+name+"grow.wav",nukeprevious))
    playerskindat(slot,"growsfx2"+ss,replacesfx(slot,name+"grow2",dir+"sfx\"+name+"grow2.wav",nukeprevious))
    playerskindat(slot,"growsfx3"+ss,replacesfx(slot,name+"grow3",dir+"sfx\"+name+"grow3.wav",nukeprevious))

    adiwah(slot,name,global.spritelist[slot,index])
    
    //Transform split name into split numbers.
    j=0 
    repeat (splits){
        i=0
        repeat (global.animdat[slot,0]) {
           
            if (string(global.animdat[slot,16+128*i])==global.spritelistsplitpointsname[slot,j]) {global.spritelistsplitpoints[slot,j]=i }
            i+=1
        }
        j+=1
    }
        //Quick setup to Reroute an animation to another <--- The really hard part! (Part 1)
    //We do this to avoid comparing strings every time when we change an anim. We set it up so that the game already knows what animation to use with no comparing.
    i=0
    checkerlist=global.defaultspritelist[index]
    //We must make an array containing a conversion from sid(default) to sid(custom)
    repeat (string_count(",",global.defaultspritelist[index])+1){ //this does kinda suck and probably fucks up loading time though. Very mid.
        //Get the Default Animation's name
        checkpos=string_pos(",",checkerlist)
        if checkpos==0 checkpos=string_length(checkerlist)+1

        global.animname[slot,i]=string_copy(checkerlist,0,checkpos-1)

        checkerlist=string_copy(checkerlist,checkpos+1,(string_length(checkerlist)-checkpos))

        //Grab the animation we are rerouting to.
        replacer=string(playerskindat(slot,name+" reroute"+" "+global.animname[slot,i]))
        if replacer=="0"
            replacer=global.animname[slot,i]

        j=0
        repeat (global.animdat[slot,0]) { //now, we scour our custom sprite list to find the id petraining to our rerouted animation.
            if (string(global.animdat[slot,16+128*j])==replacer) {global.reroutedanims[slot,i]=j break;}
            j+=1
        }
        i+=1
    }


    global.animationstartX[slot,0]=0
    global.animationstartY[slot,0]=0
    global.spritelistpadding[slot,0]=0
    global.totalpadding[slot]=0

    i=0
    k=0 //spritelistsplitpoints index.
    repeat (global.animdat[slot,0]) {
        //We're gonna be using this loop to our advantage to set up everything for concatenate! <--- The really hard part! (Part 2)
        //as we move forward, we must set animationstartX and animationstartY to what we want.
        if i!=0{ //The first animation will always be on the top left. ALWAYS.
            
            
           
            global.animationstartX[slot,i]=global.animationstartX[slot,i-1]
            global.animationstartY[slot,i]=global.animationstartY[slot,i-1]
            global.spritelistpadding[slot,i]=global.spritelistpadding[slot,i-1]
            if (global.spritelistsplits[slot]>k)
                if i>global.spritelistsplitpoints[slot,k]{
                    global.animationstartY[slot,i]=-1
                    global.spritelistpadding[slot,i]=global.splitsize[slot,k]-8
                    global.totalpadding[slot]+=global.spritelistpadding[slot,i]
                    k+=1
                    
                } 
                
            
            if funnytruefalse(playerskindat(slot,name+" connect"+" "+string(global.animdat[slot,16+128*i]))){
                global.animationstartX[slot,i]+=max(1,global.animdat[slot,16+128*(i-1)+1],global.animdat[slot,16+128*(i-1)+2],global.animdat[slot,16+128*(i-1)+3],global.animdat[slot,16+128*(i-1)+4],global.animdat[slot,16+128*(i-1)+5])
                
            }else{
                global.animationstartX[slot,i]=0
                global.animationstartY[slot,i]+=1
            }
           
            //If you ever get problems with the concatenate/split setup, then uncomment the thing below. It'll tell you on runtime bascially everything about an animation.
            //show_message(string(global.animdat[slot,16+128*i])+" X:"+ string(global.animationstartX[slot,i]) +" Y:" +string(global.animationstartY[slot,i])+" Padding:" +string(global.spritelistpadding[slot,i]))
        }
        i+=1
    }

    str="select,damage,shielddamage,ringdamage,die,jump,win,step,bonk,super,"+global.soundlist[index]
    do {
        p=string_pos(",",str)
        if (p=0) p=string_length(str)+1
        sfx=string_copy(str,1,p-1)
        if (dir != allyourbase) replacesfx(slot,name+sfx,allyourbase+"sfx\"+name+sfx+".wav",1)
        replacesfx(slot,name+sfx,dir+"sfx\"+name+sfx+".wav",nukeprevious)
        str=string_delete(str,1,p)
    } until (str="")
}
