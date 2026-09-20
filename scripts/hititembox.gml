//Ran by charm the same way it does vine_climbing
with (blockcoll){

    if (!insted) {
    owner.vsp=1.5
    }
    if (!wait || owner.tempbrick) {
        if (object_index!=turing) sound("itemblockbump")
        wait=13
        if (!hit) {
            if (content="coins"){ picked=owner.is_coinexplosive || other.is_coinexplosive}
            x=xstart
            if (object_index=invisibox) {
                with (player) if (instance_place(x,y,other.id)) y+=other.bbox_bottom-bbox_top
            }
            untouched=0
            if (respawning) alarm[2]=400
            upwardthrust()
            if (object_index=goalblock) {
                hsp=0
                event_user(4)
            } else if (object_index=turing) {
                if (mode=0) turingblock()
            } else if (content!="bros") {
                if (object_index=talkbox) {
                    if (string_pos("sfx",text)) {
                        sound(string_delete(text,1,4))
                    } else {
                        if (!open) {
                            with (talkbox) open=0
                            open=1
                            cur=0
                            sound("itemmessage")
                        } else {
                            if (trans) cur+=1
                            if (cur+1>=pages) open=0
                            else {sf=0 trans=1}
                        }
                    }
                } else if (content="coins") {
                    if (picked) {
                        with (instance_position(x+8,y+8+16*go,brick)) {insted=1 owner=other.owner event_user(0)}
                        if (go=1) if (instance_position(x+8,y+24,collider)) {
                            go=-1
                            with (instance_position(x+8,y-8,brick)) {insted=1 owner=other.owner event_user(0)}
                        }
                        i=cc
                        if (done || picked=2) i=1
                        cc-=i
                        picked=0
                        repeat (i) with (instance_create(x+8+offset,y+8+16*go,itemdrop)) {
                            hspeed=myrand(2)-1
                            vspeed=(2+myrand(2))*other.go
                            drop=0
                            type="coinup"
                        }
                    } else {
                        with (instance_create(x+8+offset,y+8+16*go,coinup)) {sound("itemcoin") vspeed=-1.5+2*other.go p2=other.owner.p2}
                            if (object_index == bigitembox) {
                            with (instance_create(x+8,y+8+16*go,coinup)) {sound("itemcoin") vspeed=-1.5+2*other.go p2=other.owner.p2}
                            with (instance_create(x+8+(offset*2),y+8+16*go,coinup)) {sound("itemcoin") vspeed=-1.5+2*other.go p2=other.owner.p2}
                            repeat (3) give_item(owner,"coinblock")
                            } else {
                            give_item(owner,"coinblock")
                            }
                        cc-=1
                    }
                    if (done || cc=0) {
                        owner.blockc+=1
                        hit=1
                    }
                    if (alarm[1]=-1) alarm[1]=256
                    tpos=0
                } else {
                    owner.blockc+=1
                    hit=1
                    if (object_index == bigitembox) {
                    with (instance_create(x+8,y+8+16*go,coinup)) {sound("itemcoin") vspeed=-1.5+2*other.go p2=other.owner.p2}
                    with (instance_create(x+8+(offset*2),y+8+16*go,coinup)) {sound("itemcoin") vspeed=-1.5+2*other.go p2=other.owner.p2}
                    repeat (2) give_item(owner,"coinblock")
                    }
                    sound("itemappear")
                    mush=!owner.size
                    if owner.skipmush mush=0
                    if !mush mush=owner.size==5
                    alarm[0]=18
                }
            }
            tpos=1
            spendblock()
        }
    }

}
