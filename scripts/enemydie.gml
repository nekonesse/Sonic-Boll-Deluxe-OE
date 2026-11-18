var s;
if argument[0].intangible_timer exit
if !argument[0] {show_message("thing tried to kill object 0") exit}
with (global.coll) {
    coll=argument[0]
    unfresh=coll.unfresh
    if (!unfresh) enemyc+=1
    if (argument_count>=2) {if (!argument[2]) if(!global.enemblood) kicksound(argument[1]) else sound("systemhit")}
    else {if (!global.enemblood) kicksound(seqcount) else sound("systemhit")}
}

with (argument[0]) {
    s=esign(x-(global.coll).x,1)

    if(!global.enemblood || object_index=drybones) {
        switch (object_index) {
            case goomba:        {if !brat with (instance_create(x,y,goombadead)){hspeed*=s biome=other.biome} else {with (instance_create(x,y,goombratdead)){hspeed*=s biome=other.biome}} break}
            case redkoopa:      {with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="redshell"} break}
            case redhover:      {with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="redshell"} break}
            case koopa:         {with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="shell" } break}
            case bombshellkoopa:{with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="bombshell"} break}
            case hopkoopa:      {with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="shell"} break}
            case yelkoopa:
            case yelhover:      {with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="yelshell"} break}
            case blukoopa:      {with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="blushell"} break}
            case bluhover:      {with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="blushell"} break}
            case bombshellkoopa:{with (instance_create(x,y,koopadead))      {hspeed*=s biome=other.biome type="bombshell"} break}

            case spiny:
            case spinyegg:      {with (instance_create(x,y,koopadead))      {hspeed*=s type="spinyshell"} break}
            case shell:         {with (instance_create(x,y,koopadead))      {hspeed*=s type=other.type+"shell" biome=other.biome} break}
            case beetle:        {with (instance_create(x,y,koopadead))      {hspeed*=s type="beetleshell"   biome=other.biome} break}

            case cheepred:      {with (instance_create(x,y,fishdead))       {hspeed*=s type="cheepdead"     } break}
            case cheepwhite:    {with (instance_create(x,y,fishdead))       {hspeed*=s type="greencheepdead"} break}

            case blooper:       {with (instance_create(x,y,genericdead))    {hspeed*=s type="blooperdead"   } break}
            case hammerbro:     {with (instance_create(x,y,genericdead))    {hspeed=s  type="hammerbrodead" vspeed=-2 biome=other.biome timetodie=120}  break}
            case cheepfly:      {with (instance_create(x,y,genericdead))    {hspeed*=s type="cheepflydead" timetodie=120} break}
            case lakitu:        {with (instance_create(x,y,genericdead))    {type="lakitudead"} break}
            case piranha:       {with (instance_create(x,y,genericdead))    {depth=other.depth if (other.red) type="redpiranhadie" else type="piranhadie" nomove=1 timetodie=30 ysc=other.ysc} break}
            case redpiranha:    {with (instance_create(x,y,genericdead))    {depth=other.depth type="redpiranhadie" nomove=1 timetodie=30 ysc=other.ysc} break}
            case thwomp:        {with (instance_create(x,y,deadthwomp))     {depth=other.depth xsc=other.xsc biome=other.biome frame=0 eid=3} sound("enemykick") break}
            case drybones:      {with (instance_create(x,y,drydead))        {xsc=other.xsc if other.vspeed!=0 {drop=1 vspeed=other.vspeed} powner=other.powner} break}

            case rexbig:        {with (instance_create(x,y,genericdead))    {hspeed=s  type="rexdead" vspeed=-2 biome=other.biome}  break}
            case rexsmall:      {with (instance_create(x,y,genericdead))    {hspeed=s  type="rexsmalldead" vspeed=-2 biome=other.biome}  break}
            case montymole:     {with (instance_create(x,y,genericdead))    {hspeed*=s  type="montydead" vspeed=-2 biome=other.biome}  break}
            case spikenemy:     {with (instance_create(x,y,genericdead))    {hspeed*=s  type=other.type+"spikedead" vspeed=-2 biome=other.biome}  break}
            case bulletbill:    {with (instance_create(x,y,genericdead))    {hspeed*=-s type="bulletdead"  vspeed=0} break}
            case banzaibill:   {with(instance_create(x,y,bigBOM)) {sound("enemybigexplode")} break}

            //badniks
            case crabmeat: {instance_create(x,y,badniksmoke) break}
            case newtron: {instance_create(x,y,badniksmoke) break}
            case orbinautgreen: {instance_create(x,y,badniksmoke) break}
            case orbinautblue: {instance_create(x,y,badniksmoke) break}
            case orbinautred: {instance_create(x,y,badniksmoke) break}
            case orbinautbumper: {instance_create(x,y,badniksmoke) break}
            case bombenemy: {instance_create(x,y,badniksmoke) break}
            case chopper: {instance_create(x,y,badniksmoke) break}

            //damage on touch enemies (damages player objects)
            case boo: break;
            case fishbones:    {with (instance_create(x,y,genericdead))    {hspeed=s  type="fishbonesdead" vspeed=-2 biome=other.biome} sound("enemybones") break}
            //case thwomp: {  if kek {with other hurtplayer("enemydamage") did_you_think_killing_me_would_kill_me=1} else {instance_create(x,y,smoke) did_you_think_killing_me_would_kill_me=0} break }
            case urchin: {instance_create(x,y,smoke)} break;

            case enemydummy: {if (customdie) {cdie=instance_create(x,y,real(customdie))} else instance_create(x,y,smoke) break}
            default:    {instance_create(x,y,smoke) break}
         }
    } else {
        with (instance_create(x,y+4,deadkid)) {del=1 a=1 name="kid"}
    }

    with(parent_event) event_user(1);

    if (object_index==lakitu) {respawned=1 y=-verybignumber alarm[0]=960} else if !did_you_think_killing_me_would_kill_me {//scoring
        with player {
            if (argument_count=2)
                doscore_p(scoresequence(argument[1]))
            else doscore_p()
        }
        instance_destroy()
    }
}
