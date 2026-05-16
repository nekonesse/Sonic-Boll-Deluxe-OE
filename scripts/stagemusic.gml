///stagemusic(instance, restart, includestar)
//plays stage music for instance"s current position
var includestar;
includestar=true if (argument_count>=3) includestar=argument[2]

with (bowserboss) if (musiclock && !dead) {
    if (skindat("bossmusic")) {
        switch (btype) {
        case 2:
            if global.founddowsermusic {
                mus_play("finaldoss",1)
                break
            }
        case 1:
            mus_play("finalboss",1)
            break
        default:
            mus_play("boss",1)
            break
        } exit
    }
}
    
var song,supermusic;

getregion(argument[0].x)
song=region.typemus

if (string_count("$finale",global.leveldesc) && song == "Castle") song = "finale"

if (skindat("allmusic")) song="all"

skindat("musmem","")

if (global.gamemode="tutorial") song="tuto"

if (star && includestar) song="starman"

supermusic=0
with (player) if (super && playsupermusic) supermusic=1 

if (global.ptime) {song="pswitch"}

with (gamemanager) {
    alarm[7]=1    
    if (!drowning && !supermusic && !frog_escape) {
        if ((song!=global.music) || (song=="pswitch" && argument[1])) {
            global.music=song
            global.musicmem=song                                    
            if (song!="") {                 
                if (song="tuto") mus_play("_options",1)
                else mus_play(song,1)
            } else mus_stop()
        }
    }           
}
