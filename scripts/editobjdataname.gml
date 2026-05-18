var type,i,t;

type=argument[1]
i=argument[2]
t=funnytruefalse(i)

if (string(i)="") i="[unset]"

switch (argument[0]) {
    case itembox: {
        if (type=1) {
            if (i="item") return "Contains: Fire Flower"
            if (i="itemfeather") return "Contains: Feather"
            if (i="coins") return "Contains: Multicoins"
            if (i="life") return "Contains: 1-Up"
            if (i="moon") return "Contains: 3-Up"
            if (i="poison") return "Contains: Poison Mushroom"
            if (i="mini") return "Contains: Mini Mushroom"
            if (i="vine") return "Contains: Green Spring"
            if (i="star") return "Contains: Starman"
            if (i="key") return "Contains: Key"
            if (i="shield") return "Contains: Shield"
            if (i="spring") return "Contains: Spring"
            if (i="spreng") return "Contains: Side Spring"
            if (i="bros") return "Contains: Punch Block"
            if (i="shard") return "Contains: Star Shard"
            if (i="pswitch") return "Contains: P Switch"
            if (i="shard") return "Contains: Shard"
            if (i="none") return "Contains: Nothing"
            if (i="itembeetroot") {if !settings("topsecret") return "Contains: Nothing" return "Contains: Beetroot"}
            if (i="itemgreenlui") {if !settings("topsecret") return "Contains: Nothing" return "Contains: Green Lui"}
            return "Contains: Coin"
        }
        if (type=2) {
            if (i="0") return "Variant: Normal"
            if (i="1") return "Variant: Brick"
            if (i="2") return "Variant: On Block"
            if (i="3") return "Variant: Off Block"
            if (i="4") return "Variant: Kaeru Block"
        }
        if (type=3) {if (t) return "Invisible: Yes" return "Invisible: No"}
        if (type=4) return "Bonus Target: "+i
        if (type=0) return "Align: "+string(i)
    }

    case bigitembox: {
        if (type=1) {
            if (i="item") return "Contains: Fire Flower"
            if (i="itemfeather") return "Contains: Feather"
            if (i="coins") return "Contains: Multicoins"
            if (i="life") return "Contains: 1-Up"
            if (i="moon") return "Contains: 3-Up"
            if (i="poison") return "Contains: Poison Mushroom"
            if (i="mini") return "Contains: Mini Mushroom"
            if (i="vine") return "Contains: Green Spring"
            if (i="star") return "Contains: Starman"
            if (i="key") return "Contains: Key"
            if (i="shield") return "Contains: Shield"
            if (i="spring") return "Contains: Spring"
            if (i="spreng") return "Contains: Side Spring"
            if (i="bros") return "Contains: Punch Block"
            if (i="shard") return "Contains: Star Shard"
            if (i="pswitch") return "Contains: P Switch"
            if (i="shard") return "Contains: Shard"
            if (i="none") return "Contains: Nothing"
            if (i="itembeetroot") {if !settings("topsecret") return "Contains: Nothing" return "Contains: Beetroot"}
            if (i="itemgreenlui") {if !settings("topsecret") return "Contains: Nothing" return "Contains: Green Lui"}
            return "Contains: Coin"
        }
        if (type=2) return "Bonus Target: "+i
        if (type=0) return "Align: "+string(i)
    }

    case noteblock: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="item") return "Contains: Fire Flower"
            if (i="itemfeather") return "Contains: Feather"
            if (i="coins") return "Contains: Multicoins"
            if (i="life") return "Contains: 1-Up"
            if (i="moon") return "Contains: 3-Up"
            if (i="poison") return "Contains: Poison Mushroom"
            if (i="mini") return "Contains: Mini Mushroom"
            if (i="vine") return "Contains: Green Spring"
            if (i="star") return "Contains: Starman"
            if (i="key") return "Contains: Key"
            if (i="shield") return "Contains: Shield"
            if (i="spring") return "Contains: Spring"
            if (i="spreng") return "Contains: Side Spring"
            if (i="bros") return "Contains: Punch Block"
            if (i="shard") return "Contains: Star Shard"
            if (i="pswitch") return "Contains: P Switch"
            if (i="shard") return "Contains: Shard"
            if (i="none") return "Contains: Nothing"
            if (i="itembeetroot") {if !settings("topsecret") return "Contains: Nothing" return "Contains: Beetroot"}
            if (i="itemgreenlui") {if !settings("topsecret") return "Contains: Nothing" return "Contains: Green Lui"}
            return "Contains: Coin"
        }
        if (type=2) {if (t) return "Hidden: Yes" return "Hidden: No"}
        if (type=3) {if (t) return "Shift Block" return "Note Block"}
        if (type=4) return "Bonus Target: "+i
    }
    case monitor: {
        if (type=1) {
            if (i="10coin") return "Contains: 10 Coins"
            if (i="mush") return "Contains: Mushroom"
            if (i="fire") return "Contains: Fire Flower"
            if (i="mini") return "Contains: Mini Mushroom"
            if (i="star") return "Contains: Starman"
            if (i="1up") return "Contains: 1-Up"
            if (i="3up") return "Contains: 3-Up"
            if (i="poison") return "Contains: Poison Mushroom"
            if (i="feather") return "Contains: Feather"
            if (i="shield") return "Contains: Shield"
            if (i="superring") return "Contains: Super Ring"
            if (i="time") return "Contains: Time"
        }
        if (type=0) return "Align: "+string(i)
    }
    case downpipe: case sidepipe: case pipeblock: case theothersidepipe: {
        if (type=5) {if (i="0") return "Max Spawns: Unlimited" return "Max Spawns: "+i}
        if (type=4) {
            if (i="[unset]") return "Spawn: Off"
            if (i="goomba") return "Spawn: Goomba"
            if (i="koopa") return "Spawn: Koopa"
            if (i="redkoopa") return "Spawn: Red Koopa"
            if (i="shell") return "Spawn: Shell"
            if (i="beetle") return "Spawn: Beetle"
            if (i="spiny") return "Spawn: Spiny"
            if (i="blooper") return "Spawn: Blooper"
            if (i="podoboo") return "Spawn: Lava Bubble"

            if (i="mushroom") return "Spawn: Mushroom"
            if (i="1up") return "Spawn: 1-Up"
            if (i="3up") return "Spawn: 3-Up"
            if (i="star") return "Spawn: Starman"
            if (i="flower") return "Spawn: Fire Flower"
            if (i="mini") return "Spawn: Mini Mushroom"
            if (i="poison") return "Spawn: Poison Mushroom"
            if (i="spring") return "Spawn: Spring"
            if (i="spreng") return "Spawn: Side Spring"
            if (i="stone") return "Spawn: Stone"
            if (i="feather") return "Spawn: Feather"
            if (i="bobomb") return "Spawn: Bob-omb"
            if (i="litbobomb") return "Spawn: Lit Bob-omb"
            if (i="beetroot") {if !settings("topsecret") return "Spawn: Off" return "Spawn: Beetroot"}
            if (i="greenlui") {if !settings("topsecret") return "Spawn: Off" return "Spawn: Green Lui"}
        }
        if (type=3) {if (t) return "Stream: Yes" return "Stream: No"}
        if (type=2) return "Next Level: "+i
        if (type=1) return "Target: "+i
        return "Name: "+i
    }
    case flagpole: {
        if (type=1) {if (t) return "Type: Signpost" return "Type: Flagpole"}
        return "Next Level: "+i
    }
    case signpost: {
        if (type=1) {return "Type: Signpost"}
        return "Next Level: "+i
    }
    case goalblock: {
        if (type=1) {return "Type: Goalblock"}
        return "Next Level: "+i
    }
    case jetstream: {
        if (type=0) {return "Strength: "+i}
        if (type=1) {
            if (i="0") return "Stream Direction: Right"
            if (i="90") return "Stream Direction: Up"
            if (i="180") return "Stream Direction: Left"
            if (i="270") return "Stream Direction: Down"
        }
        if (type=2) {return "Width: "+i}
        if (type=3) {return "Height: "+i}
        if (type=4) {
            if (i="0") return "Particles: Wind"
            if (i="1") return "Particles: Bubbles"
        }
        if (type=5) {
            if (i="0") return "Invisible: False"
            else
            return "Invisible: True"
        }

    }
    case segafadewarp: {
        if (type=0) {return "ID: "+i}
        if (type=1) {return "Width: "+i}
        if (type=2) {return "Height: "+i}
    }
    case segafadedest: {
        if (type=0) {return "ID: "+i}
    }
    case retainer: {
        if (type=1) return "Hostages: "+i
        return "Next Level: "+i
    }
    case heaven: {
        if (type=1) return "Target: "+i
        return "Name: "+i
    }
    case door: {
        if type=7 {
            var luizdoro;
            luizdoro=unreal(i,0)
            if luizdoro==1 return "Door Type: P-Door"
            if luizdoro==2 return "Door Type: Frog Door"
            else return "Door Type: Regular"
        }
        if (type=6) {
            if (i=="key") return "Accepts: Key"
            if (i=="token") return "Accepts: White Token"
            if (i=="tokenblue") return "Accepts: Blue Token"
            if (i=="tokengreen") return "Accepts: Green Token"
            return "Accepts: Boll Deluxe Android Port" //♥♥♥
        }
        if (type=5) {if (i="1") return "One-Way" return "Two-Way"}
        if (type=4) {if (!string_pos(string(argument[2]),"01")) return "Keys: "+i if (t) return "Locked" return "Unlocked"}
        if (type=3) return "Next Level: "+i
        if (type=2) return "Target: "+i
        if (type=1) return "Name: "+i
        return "Align: "+i
    }
    case warpbox: {
        if (type=6) {
            if (i=="key") return "Accepts: Key"
            if (i=="token") return "Accepts: White Token"
            if (i=="tokenblue") return "Accepts: Blue Token"
            if (i=="tokengreen") return "Accepts: Green Token"
            return "Accepts: Boll Deluxe Android Port"
        }
        if (type=5) {if (!string_pos(string(argument[2]),"01")) return "Keys: "+i if (t) return "Locked" return "Unlocked"}
        if (type=4) {if (i="1") return "Instant" return "Normal Speed"}
        if (type=3) return "Next Level: "+i
        if (type=2) return "Target: "+i
        if (type=1) return "Name: "+i
        return "Align: "+i
    }
    case cardreader:
    case tokencruncher: {
        if (type=2) return "Token Name: "+i
        if (type=1) {
            if (i=="card") return "Accepts: Card"
            if (i=="token") return "Accepts: White Token"
            if (i=="tokenblue") return "Accepts: Blue Token"
            if (i=="tokengreen") return "Accepts: Green Token"
            return "Accepts: Boll Deluxe Android Port"
        }
        return "Cards: "+string(i)
    }
    case anchor: {
        if (type=1) return "Offset: "+i
        if (type=2) {if (i="0") return "Biome: Current" else return "Biome: "+getbiomename(unreal(i,1)-1)}
        return "Asset: "+i
    }
    case axe: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Output Channel: None"
            else
            return "Output Channel: "+i
        }
    }
    case axewall: {
        if (i="1") return "Speed: Slow" if (i="2") return "Speed: Fast" return "Speed: Normal"
    }
    case talkbox: {
        return string_replace_all(i,"\","#\ #")
    }
    case mark: {
        return "Object: "+i
    }
    case textblock: {
        if (type=0) return "Text: "+i
        if (type=1) {if (i="2") return "Align: Right" if (i="1") return "Align: Center" return "Align: Left"}
        if (type=2 && !making_context) return "Blend: ${c=$"+dectohex(unreal(i,0))+"}"+string_repeat(chr(62),8)
        if (type=2) return "Blend: $"+dectohex(unreal(i,0))
    }
    case turing: {
        if (type=0) return "Source..."
        if (type=1) return "Destination..."
    }
    case sprong: {return "Bonus Target: "+i}
    case droptarget: {return "Name: "+i}
    case platform: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="platfall") return "Type: Flimsy"
            if (i="plat3") return "Type: Bowser Platform"
            if (i="platsineh") return "Type: Horizontal"
            if (i="platsinev") return "Type: Vertical"
            if (i="platwrap_up") return "Type: Wrap up"
            if (i="platwrap_down") return "Type: Wrap Down"
            if (i="pulley") return "Type: Pulley Left"
            if (i="pulley_sub") return "Type: Pulley Right"
            if (i="cloudform") return "Type: Cloud"
        }
        if (type=2) {
            if (i="0") return "Length: Long"
            if (i="1") return "Length: Short"
        }
        if (type=3) return "Pulley height: "+i
    }
    case redring: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            return i
        }
    }
    case platdonut: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {if (t) return "Long: Yes" return "Long: No"}
    }
    case fbarblock: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="off") return "Type: Nothing"
            if (i="cookie") return "Type: Waffle"
            return "Type: Normal"
        }
        if (type=2) {if (t) return "Rotation: Clockwise" return "Rotation: Counter"}
        if (type=3) {if (t) return "Block: No" return "Block: Yes"}
        if (type=4) return "Length: "+i
        if (type=5) {if (i) == "0" return "Angle Overwrite: No" else return "Angle Overwrite: "+i}
    }
    case lakitu: {return "Range: "+i+" tiles"}
    case bowserboss: {
        if (type=0) {if (t) return "Fire: Yes" return "Fire: No"}
        if (type=1) {if (t) return "Hammers: Yes" return "Hammers: No"}
        if (type=2) {if (t) return "Music: Yes" return "Music: No"}
    }

    case sonicspike: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Point: Up"
            if (i="1") return "Point: Down"
            if (i="2") return "Point: Left"
            if (i="3") return "Point: Right"
            if (i="4") return "Point: Auto"
        }
    }
    case token: {

        if (type=2) return "Name: "+i
        if (type=1) {
            if (i=="1") return "Type: Blue Token"
            if (i=="2") return "Type: Green Token"
            return "Type: White Token"
        }
        return "Align: "+string(i)
    }

    case goomba:
    case goombrat:
    case beetle:
    case hopkoopa:
    case koopa:
    case redhover:
    case drybones:
    case redkoopa:
    case spiny:
    case piranha:
    case redpiranha:
    case coin:
    case starshard:
    case mushroom:
    case mushmini:
    case keyitem:
    case carditem:
    case flower:
    case starman:
    case mushpoison:
    case shield:
    case vine:
    case redcoin:
    case newtron:
    case crabmeat:
    case rexbig:
    case fishbones:
    case wigglerhead:
    case spikenemy:
    case grinder:
    case orbinautgreen:
    case orbinautblue:
    case orbinautred:
    case orbinautbumper:
    case chopper:
    case muncher:
    case bigmuncher:
    case podoboo: {
        if (type=1) {
            if (string(i) == "1") return "Direction: Right"
            return "Direction: Left"
        }
        return "Align: "+string(i)
    }
    case hammerbro: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Rage: None"
            if (i="1") return "Rage: Normal"
            if (i="2") return "Rage: Full"
        }

    }
    case montymole: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {if (t) return "In ground: Yes" return "In ground: No"}
    }
    case thwomp: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {if (i="0") return "Go Down" else if i="1" return "Go Left" else return "Go Right"}
    }
    case thwimp: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="1") return "Starting Direction: Right"
            else if i="-1" return "Starting Direction: Left"
        }
    }
    case shell: {
        if (type=0) {
            if (i="0") return "Type: Green"
            if (i="1") return "Type: Red"
            if (i="2") return "Type: Beetle"
            if (i="3") return "Type: Spiny"
        }
        if (type=1) {if i="1" return "Disappears Offscreen" return "Persists Offscreen"}
        return "Align: "+string(i)
    }
    case singlecheep: {
        if (i="0") return "Type: Red"
        if (i="1") return "Type: Green"
        if (i="2") return "Type: Flying"
    }

    case checkpoint: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Type: Normal"
            if (i="1") return "Type: No Bonus"
            if (i="2") return "Type: Classic"
        }
        if (type=2) {
            if (i="0") return "Contains: Fire Flower"
            if (i="1") return "Contains: Feather"
            if (i="2") {if !settings("topsecret") return "Contains: Fire Flower" return "Contains: Beetroot"}
            if (i="3") {if !settings("topsecret") return "Contains: Feather" return "Contains: Green Lui"}
        }
    }

    case spike: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Behavior: Always On"
            if (i="1") return "Behavior: Trap"
            if (i="2") return "Behavior: Timer"
            if (i="3") return "Behavior: Timer Alt"
            if (i="4") return "Behavior: On-Off"
            if (i="5") return "Behavior: Off-On"
        }
        if (type=2) {
            if (i="0") return "Point: Right"
            if (i="1") return "Point: Up"
            if (i="2") return "Point: Left"
            if (i="3") return "Point: Down"
            if (i="4") return "Point: Auto"
            if (i="5") return "Point: Star"
        }
    }
    case waterblock: {
        if (type=0) return "Width: "+i
        if (type=1) return "Height: "+i
    }
    case fakesemiplat: {
        if (type=0) {
            return "Align: "+string(i)
        }
        if (type=1) return "Width: "+i
        if (type=2) return "Height: "+i
        if (type=3) {
            var semmy;
            switch (i) {
                case 1: semmy="Yellow" break
                case 2: semmy="Blue" break
                default: semmy="Red" break
            }
            return "Variation: "+semmy
        }
        break;
    }
    case terraintyler:
    case objectstyler:
    case decortyler:
    case tyler: {
        if (type=0) return "offset: "+i
        if (type=1) return "UV: "+i
        if (type=2) {if (t=0) return "Layer: Behind" if (t=1) return "Layer: Middle" return "Layer: Front"}
        if (type=3) {if (i="0") return "Collision: None" if (i="1") return "Collision: Solid" if (i="2") return "Collision: Semisolid" if (i="3") return "Collision: Intangible Spike" if (i="4") return "Collision: Solid Spike"}
        if (type=4) return "Repeat: "+i
        if (type=5) {if (i="0") return "Mirror: No" if (i="1") return "Mirror: Flipped" if (i="2") return "Mirror: Upside" return "Mirror: 180"}
        if (type=6 && !making_context) return "Blend: ${c=$"+dectohex(unreal(i,0))+"}"+string_repeat(chr(62),8)
        if (type=6) return "Blend: $"+dectohex(unreal(i,0))
        if (type=7) {if (i="-1") return "Biome: Current" else return "Biome: "+getbiomename(unreal(i,0))}
    }
    case phaser: {
        if type=1{
            if (i="0") return "Direction: Up"
            if (i="-1") return "Direction: Left"
            if (i="1") return "Direction: Right"
            if (i="2") return "Direction: Down"
        }
        if (type=0) return "Align: "+string(i)
    }
    case brick: {
        if type=1{
            if (i="1") return "Contains Stone"
            if (i="2") return "Is Stone"
            return "Stoneless"
        }
        if type=2{
            if (i="1") return "Cracked"
            return "Undamaged"
        }
        if (type=0) return "Align: "+string(i)
    }
    case bigbrick: {
        if type=1{
            if (i="1") return "Cracked"
            return "Undamaged"
        }
        if (type=0) return "Align: "+string(i)
    }
    case itemlaunch: {
        if (type=0) {
            return "Align: "+string(i)
        }
        if (type=1) {
            if (i="mushroom") return "Type: Mushroom"
            if (i="flower") return "Type: Fire Flower"
            if (i="feather") return "Type: Feather"
            if (i="mini") return "Type: Mini Mushroom"
            if (i="1up") return "Type: 1-Up"
            if (i="3up") return "Type: 3-Up"
            if (i="shield") return "Type: Shield Mushroom"
            if (i="star") return "Type: Starman"
            if (i="poison") return "Type: Poison Mushroom"
            if (i="shard") return "Type: Star Shard"
            if (i="coin") return "Type: Coin"
            if (i="token") return "Type: White Token"
            if (i="tokenblue") return "Type: Blue Token"
            if (i="beetroot") {if !settings("topsecret") return "Type: Fire Flower" return "Type: Beetroot"}
            if (i="greenlui") {if !settings("topsecret") return "Type: Feather" return "Type: Green Lui"}
        }
        if (type=2) {
            if (i="0") return "Physics: On"
            if (i="1") return "Physics: Off"
        }
        if (type=3) {
            if (i="0") return "Launch: No"
            if (i="1") return "Launch: Yes"
        }
    }
    case crystaltap:{
        if (type=0) {
            return "Align: "+string(i)
        }
        if (type=1) {
            if (i="0") return "Not a trigger"
            if (i="1") return "Trigger: Same x"
            if (i="2") return "Trigger: Same y"
        }
    }

    case activate_region:{
        if (type=0) {
            return "Align: "+string(i)
        }
        if (type=1) return "Width: "+string(i)
        if (type=2) return "Height: "+string(i)
    }

    case function: {
        if (type=0) {
            if (i="save") return "Save Block"
            if (i="char") return "Character Swap Block"
            if (i="end") return "Level End Block"
        }
        if (type=1) return "Text: "+i
    }
    case code: {
        if (type=0) {
            return "Code: "+i
        }
        if (type=1) {
            if (i="trig") return "Run Mode: Trigger"
            if (i="loop") return "Run Mode: Loop"
            if (i="auto") return "Run mode: Start"
            if (i="always") return "Run mode: Always"
            if (i="draw") return "Run mode: Draw"
        }
        if (type=2) {
            if (i="0") return "Input Channel: None"
            else
            return "Input Channel: "+i
        }
    }

    case code: {
        if (type=0) {
            return "Align: "+string(i)
        }
        if (type=1) {
            return "Script Name: "+i
        }
        if (type=2) {
            if (i="0") return "Input Channel: None"
            else
            return "Input Channel: "+i
        }
    }

        case ballcannon: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Point: Up"
            if (i="1") return "Point: Down"
            if (i="2") return "Point: Left"
            if (i="3") return "Point: Right"
            if (i="4") return "Point: Up-Left"
            if (i="5") return "Point: Up-Right"
            if (i="6") return "Point: Down-Left"
            if (i="7") return "Point: Down-Right"
        }
        if (type=2) {
            if (i="0") return "Stand: Down"
            if (i="1") return "Stand: Up"
            if (i="2") return "Stand: Left"
            if (i="3") return "Stand: Right"
        }
    }

    case redballcannon: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Point: Up"
            if (i="1") return "Point: Down"
            if (i="2") return "Point: Left"
            if (i="3") return "Point: Right"
            if (i="4") return "Point: Up-Left"
            if (i="5") return "Point: Up-Right"
            if (i="6") return "Point: Down-Left"
            if (i="7") return "Point: Down-Right"
        }
        if (type=2) {
            if (i="0") return "Stand: Down"
            if (i="1") return "Stand: Up"
            if (i="2") return "Stand: Left"
            if (i="3") return "Stand: Right"
        }
    }

    case ballcannonquad: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Direction: Normal"
            if (i="1") return "Direction: Diagonal"
        }
    }

    case redballcannonquad: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Direction: Normal"
            if (i="1") return "Direction: Diagonal"
        }
    }
    case bumper:
    {
    if (type=0) {
    return "Align: "+string(i)
    }
    if (type=1) {
    if (i="0") return "Size: Big"
    if (i="1") return "Size: Small"
    }
    break
    }

    case dirchange:
    {
    if (type=0) {
    return "Angle: "+string(i)
    }
    break
    }

    case conveyorbelt:
    {
    if (type=0) {
    return "Align: "+string(i)
    }
    if (type=1) {
    return "Speed: "+i
    }
    if (type=2) {
            if (i="0") return "Edges: On"
            if (i="1") return "Edges: Off"
        }
    break;
    }

    case terrainspring: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Point: Up"
            if (i="1") return "Point: Down"
            if (i="2") return "Point: Left"
            if (i="3") return "Point: Right"
            if (i="4") return "Point: Up-Left"
            if (i="5") return "Point: Up-Right"
            if (i="6") return "Point: Down-Left"
            if (i="7") return "Point: Down-Right"
        }
    }

    case terrainsprong: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Point: Up"
            if (i="1") return "Point: Down"
            if (i="2") return "Point: Left"
            if (i="3") return "Point: Right"
            if (i="4") return "Point: Up-Left"
            if (i="5") return "Point: Up-Right"
            if (i="6") return "Point: Down-Left"
            if (i="7") return "Point: Down-Right"
        }
    }

    case signalcommunicator: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Input Channel 1: None"
            else
            return "Input Channel 1: "+i
        }
        if (type=2) {
            if (i="0") return "Input Channel 2: None"
            else
            return "Input Channel 2: "+i
        }
        if (type=3) {
            if (i="0") return "Output Channel 1: None"
            else
            return "Output Channel 1: "+i
        }
        if (type=4) {
            if (i="0") return "Output Channel 2: None"
            else
            return "Output Channel 2: "+i
        }
        if (type=5) {
            if (i="0") return "Output Channel 3: None"
            else
            return "Output Channel 3: "+i
        }
        if (type=6) {
            if (i="0") return "Output Channel 4: None"
            else
            return "Output Channel 4: "+i
        }
        if (type=7) {
            if (i="0") return "Logic: OR"
            if (i="1") return "Logic: AND"
            if (i="2") return "Logic: NOR"
            if (i="3") return "Logic: NAND"
            if (i="4") return "Logic: XOR"
            if (i="5") return "Logic: XNOR"
        }
    }

    case channelmaster: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Input Channel Left: None"
            else
            return "Input Channel Left: "+i
        }
        if (type=2) {
            if (i="0") return "Input Channel Right: None"
            else
            return "Input Channel Right: "+i
        }
        if (type=3) {
            if (i="0") return "Input Channel Activate: None"
            else
            return "Input Channel Activate: "+i
        }
    }

    case bopblock: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Output Channel 1: None"
            else
            return "Output Channel 1: "+i
        }
        if (type=2) {
            if (i="0") return "Output Channel 2: None"
            else
            return "Output Channel 2: "+i
        }
        if (type=3) {
            if (i="0") return "Output Channel 3: None"
            else
            return "Output Channel 3: "+i
        }
    }

    case button: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Output Channel: None"
            else
            return "Output Channel: "+i
        }
        if (type=2) {
            if (i="0") return "Filter: Players and Objects"
            if (i="1") return "Filter: Players"
            if (i="2") return "Filter: Objects"
            if (i="3") return "Filter: Enemies"
            if (i="4") return "Filter: All"
        }
        if (type=3) {
            if (i="0") return "Perma-Press: No"
            if (i="1") return "Perma-Press: Yes"
        }
        if (type=4) {
            if (i="0") return "Invisible: No"
            if (i="1") return "Invisible: Yes"
        }
    }

    case onoffscreen: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Input Channel 1: None"
            else
            return "Input Channel 1: "+i
        }
        if (type=2) {
           if (i="0") return "Input Channel 2: None"
            else
            return "Input Channel 2: "+i
        }
        if (type=3) {
            if (i="0") return "Input Channel 2: None"
            else
            return "Input Channel 2: "+i
        }
        if (type=4) {
            if (i="0") return "Input Channel 4: None"
            else
            return "Input Channel 4: "+i
        }
        if (type=5) {
            if (i="0") return "Type: Timer"
            if (i="1") return "Type: Counter"
            if (i="2") return "Type: Lantern"
        }
    }

    case displayscreen: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Input Channel TL: None"
            else
            return "Input Channel TL: "+i
        }
        if (type=2) {
           if (i="0") return "Input Channel TR: None"
            else
            return "Input Channel TR: "+i
        }
        if (type=3) {
            if (i="0") return "Input Channel BL: None"
            else
            return "Input Channel BL: "+i
        }
        if (type=4) {
            if (i="0") return "Input Channel BR: None"
            else
            return "Input Channel BR: "+i
        }
    }

    case variableblock: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Add Channel: None"
            else
            return "Add Channel: "+i
        }
        if (type=2) {
            if (i="0") return "Subtract Channel: None"
            else
            return "Subtract Channel: "+i
        }
        if (type=3) {
            return "Minimum Value: "+i
        }
        if (type=4) {
            return "Maximum Value: "+i
        }
        if (type=5) {
            if (i="0") return "Reset Channel: None"
            else
            return "Reset Channel: "+i
        }
        if (type=6) {
            if (i="0") return "Behavior: Wrapping"
            if (i="1") return "Behavior: Clamping"
            if (i="2") return "Type: Randomization"
        }
    }

    case detector: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Output Channel: None"
            else
            return "Output Channel: "+i
        }
        if (type=2) {
            if (i="0") return "Filter: Players and Objects"
            if (i="1") return "Filter: Players"
            if (i="2") return "Filter: Objects"
            if (i="3") return "Filter: Enemies"
            if (i="4") return "Filter: All"
        }
        if (type=3) return "Height: "+i
        if (type=4) {
            if (i="0") return "Invisible: No"
            if (i="1") return "Invisible: Yes"
        }
        if (type=5) {
            if (i="0") return "Perma-Active: No"
            if (i="1") return "Perma-Active: Yes"
        }
    }

    case timerblock: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Input Channel 1: None"
            else
            return "Input Channel 1: "+i
        }
        if (type=2) {
            if (i="0") return "Output Channel 1: None"
            else
            return "Output Channel 1: "+i
        }
        if (type=3) {
            if (i="0") return "Output Channel 2: None"
            else
            return "Output Channel 2: "+i
        }
        if (type=4) {
            return "Time: "+i
        }
    }

    case ireader: {
        if (type=0) return "Source..."
        if (type=1) {
            return "State Value: "+i
        }
        if (type=2) {
            if (i="0") return "Output Channel: None"
            else
            return "Output Channel: "+i
        }
        if (type=3) {
            if (i="0") return "Output Channel 2: None"
            else
            return "Output Channel 2: "+i
        }
        if (type=4) {
            if (i="0") return "Output Channel 3: None"
            else
            return "Output Channel 3: "+i
        }
        if (type=5) {
            if (i="0") return "Output Channel 4: None"
            else
            return "Output Channel 4: "+i
        }
    }

    case gobble: {
        if (type=0) return "Source..."
        if (type=1) return "2nd Source..."
        if (type=2) {
            if (i="0") return "Equals To"
            if (i="1") return "Greater Than"
            if (i="2") return "Less Than"
        }
        if (type=3) {
            if (i="0") return "Output Channel: None"
            else
            return "Output Channel: "+i
        }
    }

    case spawnerblock: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Object: Static Dummy"
            if (i="1") return "Object: Object Dummy"
            if (i="2") return "Object: Enemy Dummy"
            if (i="3") return "Object: Collider Dummy"
            if (i="4") return "Object: Hazard Dummy"
            if (i="5") return "Object: Cork"
            if (i="6") return "Object: Stone"
        }
        if (type=2) {
            return "Create Code: "+i
        }
        if (type=3) {
            if (i="0") return "Input Channel: None"
            else
            return "Input Channel: "+i
        }
        if (type=4) {
            if (i="0") return "Invisible: No"
            if (i="1") return "Invisible: Yes"
        }
    }

    case enemydummy: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            return "Create Code: "+i
        }
    }

    case greenlui: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="1") return "Jumping" return "Stationary"
        }
    }

    case spriteswitcher: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "All Players"
            if (i="1") return "Nearest Player"
        }
        if (type=2) {
            return "Set Sprite: "+i
        }
        if (type=3) {
            if (i="0") return "Input Channel: None"
            else
            return "Input Channel: "+i
        }
    }

    case bombenemy: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Mode: Walk"
            if (i="1") return "Mode: Sit"
        }
    }

    case beepblockon:
    case beepblockoff: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {return "Blink At: Beat "+string(i)}
    }

    case gate: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Input Channel: None"
            else
            return "Input Channel: "+i
        }
        if (type=2) return "Height: "+i
        if (type=3) return "Speed: "+i
        if (type=4) {
            if (i="0") return "Inverted: No"
            if (i="1") return "Inverted: Yes"
        }
        if (type=5) {
            if (i="0") return "Flipped: No"
            if (i="1") return "Flipped: Yes"
        }
    }

    case sidegate: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Input Channel: None"
            else
            return "Input Channel: "+i
        }
        if (type=2) return "Width: "+i
        if (type=3) return "Speed: "+i
        if (type=4) {
            if (i="0") return "Inverted: No"
            if (i="1") return "Inverted: Yes"
        }
        if (type=5) {
            if (i="0") return "Flipped: No"
            if (i="1") return "Flipped: Yes"
        }
    }

    case signalblock: {
        if (type=0) {
            if (i="0") return "Input Channel: None"
            else
            return "Input Channel: "+i
        }
        if (type=1) {
            if (i="0") return "Inverted: No"
            if (i="1") return "Inverted: Yes"
        }
    }

    case lightbulb: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="ellipse") return "Shape: Ellipse"
            if (i="square") return "Shape: Square"
            if (i="spotlight") return "Shape: Spotlight"
        }
        if (type=2) {return "Width: "+string(i)}
        if (type=3) {return "Height: "+string(i)}
        if (type=4) {
            if (i="0") return "Input Channel: Disabled"
            else
            return "Input Channel: "+i
        }
    }

    case urchin: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Behavior: Horizontal Move"
            if (i="1") return "Behavior: Vertical Move"
            if (i="2") return "Behavior: Horizontal Wave"
            if (i="3") return "Behavior: Vertical Wave"
        }
        if (type=2) {
            if (i="0") return "Flipped: False"
            else
            return "Flipped: True"
        }
    }

    case fireballshooter: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Direction: Right"
            if (i="1") return "Direction: Left"
            if (i="2") return "Direction: Up"
            if (i="3") return "Direction: Down"
        }
        if (type=2) {
            if (i="0") return "Input Channel: None"
            else
            return "Input Channel: "+i
        }
    }

    case swinginghammer: {
        if (type=0) {return "Align: "+string(i)}
        if (type=1) {
            if (i="0") return "Starting Angle: Right"
            if (i="90") return "Starting Angle: Up"
            if (i="180") return "Starting Angle: Left"
            if (i="270") return "Starting Angle: Down"
        }
        if (type=2) {
            if (i="0") return "Clockwise"
            if (i="1") return "Counter-Clockwise"
        }
    } break

    case spikecrusher: {
        if (type=0) {return "Width: "+string(i)}
        if (type=1) {
            if (i="0") return "Length of chain: Infinite"
            else
            return "Length of chain: "+string(i)
        }
        if (type=2) {
            if (i="0") return "Spiked: False"
            else
            return "Spiked: True"
        }
    }

    case crate: {
        if (type=1) {
            if (i="coin") return "Contains: Coin"
            if (i="mushroom") return "Contains: Mushroom"
            if (i="flower") return "Contains: Fire Flower"
            if (i="feather") return "Contains: Feather"
            if (i="1up") return "Contains: 1-Up"
            if (i="3up") return "Contains: 3-Up"
            if (i="poison") return "Contains: Poison Mushroom"
            if (i="mini") return "Contains: Mini Mushroom"
            if (i="star") return "Contains: Starman"
            if (i="shield") return "Contains: Shield Mushroom"
            if (i="spring") return "Contains: Spring"
            if (i="spreng") return "Contains: Side Spring"
            if (i="pswitch") return "Contains: P-Switch"
            if (i="shard") return "Contains: Shard"
            if (i="itembeetroot") if !settings("topsecret") return "Contains: Nothing" return "Contains: Beetroot"
            if (i="itemgreenlui") if !settings("topsecret") return "Contains: Nothing" return "Contains: Green Lui"
            return "Contains: Nothing"
        }
        if (type=2) {if (t) return "Brick: Yes" return "Brick: No"}
        if (type=3) {if (t) return "Invisible: Yes" return "Invisible: No"}
        if (type=4) return "Bonus Target: "+i
        if (type=0) return "Align: "+string(i)
    }

    case pokey: {
        if (type=0) return "Align: "+string(i)
        if (type=1) return "Body Height: "+string(i)
    }

    case chardoor: {
        if (type=0) return "Character: "+string(i)
    }

    case slopebox: {
        if (i="1") return "Type: Right Slope"
        if (i="2") return "Type: Left Smooth Slope"
        if (i="3") return "Type: Right Smooth Slope"
        if (i="4") return "Type: Left Ceiling Slope"
        if (i="5") return "Type: Right Ceiling Slope"
        if (i="6") return "Type: Left Smooth Ceiling Slope"
        if (i="7") return "Type: Right Smooth Ceiling Slope"
        if (i="8") return "Type: Left Semisolid Slope"
        if (i="9") return "Type: Right Semisolid Slope"
        if (i="10") return "Type: Left Smooth Semisolid Slope"
        if (i="11") return "Type: Right Smooth Semisolid Slope"
        return "Type: Left Slope"
    }

    case frogswitch: {
        if (type=0) {
            return "Time: "+string(i)
        }
        if (type=1) {
            if (i="0") return "Overtime effect: Nothing"
            if (i="1") return "Overtime effect: Instant death"
            if (i="2") return "Overtime effect: Drain level timer"
            if (i="3") return "Overtime effect: Revert"
        }

    }
}

if (type=1) {
    if (string(i) == "1") return "Direction: Right"
    return "Direction: Left"
}
return "Align: "+string(i)
