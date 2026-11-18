var kek,k;
if argument[0].intangible_timer exit
k=argument[0].object_index
kek=(object_index=player)

with (global.coll) {
    coll=argument[0]
    unfresh=coll.unfresh
    if (!unfresh) enemyc+=1
    if (name="ashura" && bounce) {bounce=0 fall=0 vsp=-6+3*!akey canstopjump=akey}
    if (kek && jump && !(name="robo" && vsp>5)) {if (spinjump) vsp=-3-akey*1.5 else vsp=min(vsp,-2,-vsp)}
}

with (argument[0]) {
    if (!global.enemblood || object_index=drybones) {
        switch (object_index) {
            case goombrat:      {instance_create(x,y,smoke) break}
            case goomba:        {instance_create(x,y,smoke) break}

            case redkoopa:
            case redhover:      {instance_create(x,y,smoke) break}
            case koopa:
            case hopkoopa:      {instance_create(x,y,smoke) break}
            case bombshellkoopa: {instance_create(x,y,BOM) break}

            case spiny:
            case spinyegg:      {instance_create(x,y,smoke) break}
            case shell:         {instance_create(x,y,smoke) break}
            case beetle:        {instance_create(x,y,smoke) break}

            case blooper:       {instance_create(x,y,smoke) break}
            case cheepred:      {instance_create(x,y,smoke) break}
            case cheepwhite:    {instance_create(x,y,smoke) break}

            case hammerbro:     {instance_create(x,y,smoke) break}
            case cheepfly:      {instance_create(x,y,smoke) break}
            case lakitu:        {instance_create(x,y,smoke) break}
            case piranha:       {instance_create(x,y,smoke) break}
            case redpiranha:    {instance_create(x,y,smoke) break}
            case bulletbill:    {instance_create(x,y,smoke) break}
            case drybones:      {if global.coll.is_drykiller instance_create(x,y,smoke) else with (instance_create(x,y,drydead)) {xsc=other.xsc if other.vspeed!=0 {drop=1 vspeed=other.vspeed} powner=other.powner} break}
            case montymole:     {instance_create(x,y,smoke) break}
            case rexbig:        {instance_create(x,y,smoke) break}
            case rexsmall:      {instance_create(x,y,smoke) break}
            case spikenemy:     {instance_create(x,y,smoke) break}
            case banzaibill:   {with(instance_create(x,y,bigBOM)) {sound("bigenemyexplode")} break}

            //badniks
            case crabmeat: {instance_create(x,y,badniksmoke) break}
            case newtron: {instance_create(x,y,badniksmoke) break}
            case orbinautgreen: {instance_create(x,y,badniksmoke) break}
            case orbinautblue: {instance_create(x,y,badniksmoke) break}
            case orbinautred: {instance_create(x,y,badniksmoke) break}
            case orbinautbumper: {instance_create(x,y,badniksmoke) break}
            case bombenemy: {instance_create(x,y,badniksmoke) break}
            case chopper: {instance_create(x,y,badniksmoke) break}

            case bobomb:      {with (instance_create(x,y,litbobomb)) {phase=global.coll if (powner) powner.items+=1 powner=other.powner} break}
            //damage on touch enemies (damages player objects)

            case boo: break;
            case thwomp: {  if kek {with other hurtplayer("enemydamage") did_you_think_killing_me_would_kill_me=1} else  instance_create(x,y,smoke) break }
            case urchin: {instance_create(x,y,smoke)} break;


            case enemydummy: {if (customexplode) {cexplode=instance_create(x,y,real(customexplode))} else instance_create(x,y,smoke) break}

            default: {instance_create(x,y,smoke) break}
        }
        i.owner=id
        sound("enemykill")
    } else {
        with (instance_create(x,y+4,deadkid)) {del=1 a=1 name="kid"}
        sound("systemhit")
    }

    with(parent_event) event_user(1);

    if (object_index=lakitu) {respawned=1 y=-verybignumber alarm[0]=960} else if !did_you_think_killing_me_would_kill_me {//scoring
        with player {
            if (argument_count=2)
                doscore_p(scoresequence(argument[1]))
            else doscore_p()
        }
        instance_destroy()
    }
}

//multistomping similar enemies
if (kek && k!=pswitch) with (global.coll) {
    oxsc=image_xscale
    image_xscale*=1.5
    coll=instance_place(x,y+8,k)
    image_xscale=oxsc
    if (coll) {seqcount=max(2,seqcount) enemyexplode(coll)}
}
