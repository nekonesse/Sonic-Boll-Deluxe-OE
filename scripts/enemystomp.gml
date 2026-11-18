var k;

k=argument[0].object_index

with (global.coll) {
    coll=argument[0]
    unfresh=coll.unfresh
    vsp=-3-akey*1.5
    canstopjump=akey
    if (!unfresh) enemyc+=1
    if (!global.enemblood || argument[0].object_index=koopa || object_is_ancestor(argument[0].object_index,koopa) || argument[0].object_index=beetle) sound("enemystomp") else sound("systemhit")

}

with (argument[0]) {
    if(!global.enemblood || object_index=koopa || object_is_ancestor(object_index,koopa) || object_index=beetle || object_index=drybones) {
        switch (object_index) {
            case goomba:     case goomba:        {if !brat with (instance_create(x,y,goombasmash)){hspeed*=s biome=other.biome} else {with (instance_create(x,y,goombratsmash)){hspeed*=s biome=other.biome}} break}
            //case bulletbill: {instance_create(x,y,smoke) break}
            case bulletbill:    {with (instance_create(x,y,genericdead)) {hspeed*=-s type="bulletdead" vspeed=0} break}
            case cheepfly:   {instance_create(x,y,smoke) break}
            case hammerbro:  {with (instance_create(x,y,genericdead)) {xsc=other.xsc type="hammerbrodead" biome=other.biome timetodie=120} break}
            case lakitu:     {with (instance_create(x,y,genericdead)) {xsc=other.xsc type="lakitudead" timetodie=120} break}
            case blooper:    {with (instance_create(x,y,genericdead)) {hspeed=0      type="blooperdead"} break}
            case piranha:    {with (instance_create(x,y,genericdead))    {depth=other.depth if (other.red) type="redpiranhadie" else type="piranhadie" nomove=1 timetodie=30} break}
            case redpiranha: {with (instance_create(x,y,genericdead))    {depth=other.depth type="redpiranhadie" nomove=1 timetodie=30} break}
            case koopa:      {with (instance_create(x,y,shell   )) {phase=global.coll if (powner) powner.items+=1 powner=other.powner           } break}
            case redkoopa:   {with (instance_create(x,y,shell   )) {phase=global.coll if (powner) powner.items+=1 powner=other.powner type="red"} break}
            case yelkoopa:   {with (instance_create(x,y,shell   )) {phase=global.coll if (powner) powner.items+=1 powner=other.powner type="yel"} break}
            case blukoopa:   {with (instance_create(x,y,shell   )) {phase=global.coll if (powner) powner.items+=1 powner=other.powner type="blu"} break}
            case bombshellkoopa:      {instance_create(x,y,bombshell) break}
            case beetle:     {with (instance_create(x,y,shell   )) {phase=global.coll if (powner) powner.items+=1 powner=other.powner type="beetle"} break}
            case hopkoopa:   {with (instance_create(x,y,   koopa)) {phase=global.coll if (powner) powner.items+=1 powner=other.powner hspeed=esign(other.x-x,1)*0.5} break}
            case redhover:   {with (instance_create(x,y,redkoopa)) {phase=global.coll if (powner) powner.items+=1 powner=other.powner hspeed=esign(other.x-x,1)*0.5} break}
            case yelhover:   {with (instance_create(x,y,yelkoopa)) {phase=global.coll if (powner) powner.items+=1 powner=other.powner hspeed=esign(other.x-x,1)*0.75} break}
            case bluhover:   {with (instance_create(x,y,blukoopa)) {phase=global.coll if (powner) powner.items+=1 powner=other.powner hspeed=esign(other.x-x,1)*0.75} break}
            case drybones:   {with (instance_create(x,y,drydead)) {xsc=other.xsc if other.vspeed!=0 {drop=1 vspeed=other.vspeed} powner=other.powner} break}
            case rexsmall:   {with (instance_create(x,y,goombasmash)) {xsc=other.xsc hspeed*=s sprite="rexsmash" biome=other.biome } break}
            case rexbig:     {with (instance_create(x,y,rexsmall)) {xsc=other.xsc biome=other.biome } break}
            case montymole: {with (instance_create(x,y,genericdead))    {hspeed*=s  type="montydead" vspeed=-2 biome=other.biome}  break}
            case spikenemy: {with (instance_create(x,y,genericdead))    {hspeed*=s  type=other.type+"spikedead" vspeed=-2 biome=other.biome}  break}

            case crabmeat: {instance_create(x,y,badniksmoke) break}
            case newtron: {instance_create(x,y,badniksmoke) break}
            case orbinautgreen: {instance_create(x,y,badniksmoke) break}
            case orbinautblue: {instance_create(x,y,badniksmoke) break}
            case orbinautred: {instance_create(x,y,badniksmoke) break}
            case orbinautbumper: {instance_create(x,y,badniksmoke) break}
            case bombenemy: {instance_create(x,y,badniksmoke) break}
            case chopper: {instance_create(x,y,badniksmoke) break}
            case cannonball:   {instance_create(x,y,smoke) break}
            case redcannonball:   {instance_create(x,y,smoke) break}
            case banzaibill:   {with(instance_create(x-32,y-32,deadbanzai)){xsc=other.xsc hspeed=other.hspeed vspeed=other.vspeed} break;}

            case paragoomba: {with (instance_create(x,y,   goomba)) {phase=global.coll if (powner) powner.items+=1 powner=other.powner hspeed=esign(other.x-x,1)*0.5 if other.brat {brat=1 sprite="goombrat"} } break}
            case bobomb:      {with (instance_create(x,y,litbobomb)) {xsc=other.xsc phase=global.coll if (powner) powner.items+=1 powner=other.powner} break}

            //damage on touch enemies (damages player objects)

            case wigglerhead: { if kek with self {anger=1 with p1 anger=1 with p2 anger=1 with p3 anger=1 with p4 anger=1} break}
            case wigglerbod: { if kek with self { with owner {anger=1} } break}
            case boo: break;
            case thwomp: {  if kek {with other hurtplayer("enemydamage") did_you_think_killing_me_would_kill_me=1} else  instance_create(x,y,smoke) break }
            case urchin: {instance_create(x,y,smoke)} break;



            case enemydummy: {if (customstomp) {cstomp=instance_create(x,y,real(customstomp))} else instance_create(x,y,smoke) break}
                }
    } else {
        with (instance_create(x,y+4,deadkid)) {del=1 a=1 name="kid"}
    }

    with(parent_event) event_user(1);

    if (object_index=lakitu) {respawned=1 y=-verybignumber alarm[0]=960}
    else if !did_you_think_killing_me_would_kill_me {//scoring
        with player {
            if (argument_count=2)
                doscore_p(scoresequence(argument[1]))
            else doscore_p()
        }
        instance_destroy()
        y=-verybignumber
    }
}

//multistomping similar enemies
with (global.coll) {
    oxsc=image_xscale
    image_xscale=1.5
    coll=instance_place(x,y+8,k)
    image_xscale=oxsc
    if (coll) {seqcount=max(2,seqcount) enemystomp(coll)}
}
