#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
gridtex1=sprite_get_texture(tex_grid,0)
gridtex2=sprite_get_texture(tex_grid,1)
deity=objcontainer
selected_array[0]=0
_scaleoutline = noone
global.lemonjustundone=0;

s=-1
s2=-1

unchanged=1

cbuffer[0]=0

flooding=0

region=0

bgslide=0

deityc=0
update=0

width=800
height=700

copyx=0
copyy=0
copyw=0
copyh=0















































































                secrets=""
                if settings("topsecret") {secrets="|Beetroot|Green Lui"}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///finish flooding

if (flooding=2) {
    with (editflood2) {
        if (!editcursor.rightflood) {
            j=hotbar.obj[hotbar.cur]
            i=instance_create(x,y,drawregion.deity)
            i.obj=lemongrab.objlist[j,0]
            i.spr=lemongrab.objlist[j,1]
            i.off=lemongrab.objlist[j,2]
            if (hotbar.picked[hotbar.cur]) for (k=0;k<8;k+=1) i.data[k]=hotbar.data[hotbar.cur,k]
            else for (k=0;k<8;k+=1) i.data[k]=lemongrab.objlist[j,k+101]
            if (lemongrab.objlist[j,5]="align") unpack_align(i)
        }
        instance_destroy()
    }
}

with (deity) if (obj!=other.yes) {x=memx}

UPDATE_THE_DEITIES=1
event_user(7)
flooding=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (view_wview[0]!=width || view_hview[0]!=height) {
    width=view_wview[0]
    height=view_hview[0]

    sureface_free("drawregion")
    sureface_free("drawregion2")
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i,j;

sels=sels+0.1
selcol=merge_color($ff0000,$ffffff,0.5+0.5*sin(sels))
scalecol=merge_color($60d0f0,$a0ffff,0.5*sin(sels))
current_obj=lemongrab.objlist[hotbar.obj[hotbar.cur],0]
if (current_obj=waterblock) {
    if current_layermode!=0 {
        current_layermode=0
        myarray_i=1
        savema=selected_array[0]
        repeat (savema) {
            if moveback {selected_array[myarray_i-1]=selected_array[myarray_i]}
            if (selected_array[myarray_i]==other.id ) {selected=0 event_user(0) selected_array[0]-=1 moveback=1 updatedeities()}
            myarray_i+=1
        }moveback=0
        event_user(7)
    }
    current_layermode=0
} else if (current_obj=groundsemi||
            current_obj=slopel1s||
            current_obj=slopel2s||
            current_obj=sloper1s||
            current_obj=sloper2s||
            current_obj=uslopel1s||
            current_obj=uslopel2s||
            current_obj=usloper1s||
            current_obj=usloper2s) {
    if current_layermode!=2 {
        myarray_i=1
        savema=selected_array[0]
        repeat (savema) {
            if moveback {selected_array[myarray_i-1]=selected_array[myarray_i]}
            if (selected_array[myarray_i]==other.id ) {selected=0 event_user(0) selected_array[0]-=1 moveback=1 updatedeities()}
            myarray_i+=1
        }moveback=0
        event_user(7)
    }
      current_layermode=2

} else if (current_obj=groundback||
            current_obj=slopel1b||
            current_obj=slopel2b||
            current_obj=sloper1b||
            current_obj=sloper2b||
            current_obj=uslopel1b||
            current_obj=uslopel2b||
            current_obj=usloper1b||
            current_obj=usloper2b){

    if current_layermode!=3 {
        myarray_i=1
        savema=selected_array[0]
        repeat (savema) {
            if moveback {selected_array[myarray_i-1]=selected_array[myarray_i]}
            if (selected_array[myarray_i]==other.id ) {selected=0 event_user(0) selected_array[0]-=1 moveback=1 updatedeities()}
            myarray_i+=1
        }moveback=0
        event_user(7)

    }
  current_layermode=3
} else {
    if current_layermode!=1 {
        myarray_i=1
        savema=selected_array[0]
        repeat (savema) {
            if moveback {selected_array[myarray_i-1]=selected_array[myarray_i]}
            if (selected_array[myarray_i]==other.id ) {selected=0 event_user(0) selected_array[0]-=1 moveback=1 updatedeities()}
            myarray_i+=1
        }moveback=0
        event_user(7)
    }
  current_layermode=1
}

curx=floor(((editcursor.x-width/2)/editzoom.level+viewx)/16)
cury=floor(((editcursor.y-height/2)/editzoom.level+viewy)/16)
hidecur=(curx<0 || cury<0 || curx>=lemongrab.w[region] || cury>=lemongrab.h[region] || editcursor.tool=4 || editcursor.tool=7)

clicked=max(0,clicked-1)
highlight=noone

if (flooding) {
    exit
}

//minimap sizing/aspect calculation
/*
mmx=width-208
mmy=height-160+8
mma=lemongrab.h[region]/lemongrab.w[region]
if (mma<144/200) {
    mmw=200
    mmh=200*mma
    mms=200/lemongrab.w[region]
} else {
    mmh=144
    mmw=144/mma
    mms=144/lemongrab.h[region]
}
mml=mmx+100-mmw/2+(viewx-(width/2)/editzoom.level)/(lemongrab.w[region]*16)*mmw
mmt=mmy+72-mmh/2+(viewy-(height/2)/editzoom.level)/(lemongrab.h[region]*16)*mmh
mmr=mml+width/editzoom.level/(lemongrab.w[region]*16)*mmw
mmb=mmt+height/editzoom.level/(lemongrab.h[region]*16)*mmh
mmll=max(mmx+100-mmw/2,mml)
mmtt=max(mmy+72-mmh/2,mmt)

if (within(editcursor.x,editcursor.y,mmx+100-mmw/2,mmy+72-mmh/2,mmw,mmh)) {
    //grab map
    if (editcursor.leftp) grabmap=1
    if (editcursor.left && grabmap) {
        viewx=(editcursor.x-(mmx+100-mmw/2))/mmw*(lemongrab.w[region]*16)
        viewy=(editcursor.y-(mmy+72-mmh/2))/mmh*(lemongrab.h[region]*16)
        UPDATE_THE_DEITIES=1
    } else grabmap=0
} else */{
    grabmap=0
    if (!grab && !resize && !resizew && !resizehorizon && !grabmap) if (within(editcursor.x,editcursor.y,0,90,width,height-90-160)) {
        //mouse inside level area

        if (!editcursor.left && !editcursor.right && !editcursor.middle && (editcursor.shift || editcursor.ctrl)) {
            highlight=instance_place(curx,cury,deity)
            with (highlight) {
                str=""
                j=editobjfind(obj)
                for (i=0;i<lemongrab.objlist[j,3];i+=1) str+=editobjdataname(obj,i,data[i])+"#"
                if (str="") other.highlight=noone
            }
        }

        if (positionpicker) {
            if (editcursor.rightp) {
                positionpicker=false;
                /*UPDATE_THE_DEITIES=1*/
            }
            if (editcursor.leftp) {
                positionpickerinst.data[positionpickerdata]=string(curx-positionpickerinst.x)+","+string(cury-positionpickerinst.y)
                positionpicker=false;
                /*UPDATE_THE_DEITIES=1*/
            }

        } else if (editcursor.leftp && curx=median(curx,-max(1,1/editzoom.level),-1) && cury=median(cury,lemongrab.h[region]-lemongrab.horizon[region],lemongrab.h[region]-lemongrab.horizon[region]+max(1,1/editzoom.level)-1)) {
            unchanged=0
            resizehorizon=1
        } else if (editcursor.leftp && curx=median(curx,-max(1,1/editzoom.level),-1) && cury=median(cury,lemongrab.h[region]-lemongrab.water[region],lemongrab.h[region]-lemongrab.water[region]+max(1,1/editzoom.level)-1)) {
            unchanged=0
            resizew=1
        }  else if (editcursor.leftp && curx=median(curx,lemongrab.w[region],lemongrab.w[region]+max(1,1/editzoom.level)-1) && cury=median(cury,lemongrab.h[region],lemongrab.h[region]+max(1,1/editzoom.level)-1)) {
            unchanged=0
            resize=1
        } else if (editcursor.middlep) {
            grab=1
            grabslide=bgslide
            grabx=viewx
            graby=viewy
            grabcx=editcursor.x
            grabcy=editcursor.y
        } else if (editcursor.tool=7) { //reference
            if (editcursor.rightp) {
                if (global.ref) {
                    sprite_delete(global.ref)
                    global.ref=-1
                } else {
                    f=get_open_filename("Images|*.png;*.jpg;*.gif;*.bmp","")
                    if (file_exists(f)) global.ref=sprite_add(f,1,0,0,0,0)
                }

                event_user(7)
            }
            if (editcursor.leftp) {
                if (!clicked) editsaveundo()
                clicked = 2;
                grabr=1
                grabx=global.refx
                graby=global.refy
                grabcx=editcursor.x
                grabcy=editcursor.y
            }
        } else if (editcursor.rightp && (editcursor.shift || editcursor.tool=1) && (editcursor.tool=0 || editcursor.tool=1)) {
            if (!clicked) editsaveundo()
            clicked = 2;
            with (instance_place(curx,cury,deity)) {
                other.unchanged=0
                str=lemonobjname(obj)+"|-"
                j=editobjfind(obj)
                making_context=1
                for (i=0;i<lemongrab.objlist[j,3];i+=1) str+="|"+editobjdataname(obj,i,data[i])
                making_context=0
                i=show_contextmenu(str,0)-1
                if (i>=0) {
                    data[i]=string_replace_all(editobjmenu(obj,i,data[i]),"|","")
                    if (lemongrab.objlist[j,5+i]="align") unpack_align(id)
                    if obj!=code
                    with (drawregion.deity) if (obj=other.obj && selected) {
                        data[i]=other.data[i]
                        if (lemongrab.objlist[j,5+i]="align") {off2x=other.off2x off2y=other.off2y}
                    } updatedeities()
                    with (other) {/*UPDATE_THE_DEITIES=1*/ event_user(7)}
                }
            }
        } else if (editcursor.tool=0) { //pencil
            if (editcursor.leftp) {
                unchanged=0
                if (!clicked) editsaveundo()
                clicked=2
                drawx=-1
                drawy=-1
                if (editcursor.ctrl) {
                    with (instance_place(curx,cury,watercontainer)) {
                        hotbar.obj[1]=editobjfind(obj)
                        lemonhotbarfamily()
                        sound("systemin")
                    }
                    with (instance_place(curx,cury,backcontainer)) {
                        hotbar.obj[1]=editobjfind(obj)
                        lemonhotbarfamily()
                        sound("systemin")
                    }
                    with (instance_place(curx,cury,semicontainer)) {
                        hotbar.obj[1]=editobjfind(obj)
                        lemonhotbarfamily()
                        sound("systemin")
                    }
                    with (instance_place(curx,cury,deity)) {
                        hotbar.obj[1]=editobjfind(obj)
                        lemonhotbarfamily()
                        sound("systemin")
                    }


                } else if (editcursor.shift) drawing=2
                else drawing=1
            } else if (editcursor.rightp) {
                if (editcursor.ctrl) {

                    //only objcontainer can have data so the other 3 can get out

                    if (!clicked) editsaveundo()
                    clicked=2

                    with (instance_place(curx,cury,deity)) {
                        hotbar.obj[10]=editobjfind(obj)
                        lemonhotbarfamily()
                        sound("systemin")

                        for (k=0;k<8;k+=1) hotbar.data[10,k]=data[k]
                        hotbar.pickeddata=1
                        hotbar.picked[10]=1
                        hotbar.cur=10
                    }

                }
            } else if (editcursor.right) {
                if (!editcursor.shift && !editcursor.ctrl) {
                    unchanged=0
                    if (!clicked) editsaveundo()
                    clicked=2
                    if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=waterblock) {
                        with (instance_place(curx,cury,watercontainer)) {
                            instance_destroy()
                            if !(settings("nolemonsound")) sound("lemonerase")
                            with (other) event_user(7)
                        }
                    } else if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=groundsemi||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel1s||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel2s||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper1s||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper2s||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel1s||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel2s||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper1s||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper2s){
                        with (instance_place(curx,cury,semicontainer)) {
                            instance_destroy()
                            if !(settings("nolemonsound")) sound("lemonerase")
                            with (other) {/*UPDATE_THE_DEITIES=1*/ event_user(7)}
                        }
                    } else if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=groundback||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel1b||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel2b||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper1b||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper2b||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel1b||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel2b||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper1b||
                                lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper2b){
                        with (instance_place(curx,cury,backcontainer)) {
                            instance_destroy()
                            if !(settings("nolemonsound")) sound("lemonerase")
                            with (other) {/*UPDATE_THE_DEITIES=1*/ event_user(7)}
                        }
                    }
                    else with (instance_place(curx,cury,deity)) {
                        instance_destroy()
                        if !(settings("nolemonsound")) sound("lemonerase")
                        with (other)  {/*UPDATE_THE_DEITIES=1*/ event_user(7)}
                    }
                }
            }
        } else if (editcursor.tool=1) { //selection rectangles
            if (editcursor.leftp) {
                unchanged=0
                if (!clicked) editsaveundo()
                clicked = 2;
                clicx=curx
                clicy=cury
                j=0 var seli; seli = 1;
                repeat (selected_array[0]) {
                    if place_meeting(curx,cury,selected_array[seli]) {
                        j=1
                        break;
                    }
                    seli += 1;
                }
                if (j) {
                    grabs=1
                    seli = 1;
                    repeat (selected_array[0]) {
                        with (selected_array[seli]) {
                            grabx = x;
                            graby = y;
                        }
                        seli += 1;
                    }
                } else {
                    selected_array[0]=0
                    /*UPDATE_THE_DEITIES=1*/ event_user(7)
                    selecting=1
                }
            }
        } else if (editcursor.tool=2) { //floodfill
            unchanged=0
            if (!selecting && (editcursor.leftp) && curx=median(0,curx,lemongrab.w[region]-1) && cury=median(0,cury,lemongrab.h[region]-1) && (editcursor.right || editcanflood(lemongrab.objlist[hotbar.obj[hotbar.cur],0]))) {
                if (!clicked) editsaveundo()
                clicked=2
                //editcursor.rightflood=editcursor.right
                clicx=curx
                clicy=cury
                selecting=2
            }
        } else if (editcursor.tool=3) { //cambitmap
            unchanged=0
            pos=(floor(curx/25) mod 24)+floor(cury/14)*24
            if (pos=median(0,pos,576)) {
                if (editcursor.leftp) {editsaveundo() lemongrab.cambitmap[region,pos div 8]=lemongrab.cambitmap[region,pos div 8] ^ (1<<(7-(pos mod 8))) lemongrab.cambitmap2[region,pos div 8]=lemongrab.cambitmap2[region,pos div 8] & ~(1<<(7-(pos mod 8))) event_user(7)}
                if (editcursor.rightp) {editsaveundo() lemongrab.cambitmap2[region,pos div 8]=lemongrab.cambitmap2[region,pos div 8] ^ (1<<(7-(pos mod 8))) lemongrab.cambitmap[region,pos div 8]=lemongrab.cambitmap[region,pos div 8] & ~(1<<(7-(pos mod 8))) event_user(7)}
            }
        } else if (editcursor.tool=4) { //thumb
            unchanged=0
            if (editcursor.left) {
                if (!clicked) editsaveundo() clicked=2
                lemongrab.thumbregion=region
                lemongrab.thumbx=median(0,curx-7,lemongrab.w[region]-14)
                lemongrab.thumby=median(0,cury-5,lemongrab.h[region]-10)
            }
        } else if (editcursor.tool=9) { //spawn
            unchanged=0
            if (editcursor.left) {
                if (!clicked) editsaveundo()
                clicked = 2;
                var greenhillzone; greenhillzone=0 //              i       change spawning to allow multiple regions too
                memx=lemongrab.spawnx
                memy=lemongrab.spawny
                memr=lemongrab.spawnr
                lemongrab.spawnx=median(0,curx,lemongrab.w[region]-1)
                lemongrab.spawny=median(0,cury,lemongrab.h[region]-1)
                lemongrab.spawnr=region
                if region>0 repeat (8) {lemongrab.spawnx+=lemongrab.w[greenhillzone]+25 greenhillzone+=1 if (greenhillzone == region) break;}
                if (lemongrab.spawnx!=memx || lemongrab.spawny!=memy || lemongrab.spawnr!=memr) event_user(7)
            }
            else if (editcursor.right) {
                if (!clicked) editsaveundo()
                clicked = 2;
                var greenhillzone; greenhillzone=0 //theoretically i could change spawning to allow multiple regions too but. idk maybe later
                memx=lemongrab.tspawnx
                memy=lemongrab.tspawny
                memr=lemongrab.tspawnr
                lemongrab.tspawnx=median(0,curx,lemongrab.w[region]-1)
                lemongrab.tspawny=median(0,cury,lemongrab.h[region]-1)
                lemongrab.tspawnr=region
                if region>0 repeat (8) {lemongrab.tspawnx+=lemongrab.w[greenhillzone]+25 greenhillzone+=1 if (greenhillzone == region) break;}
                if (lemongrab.tspawnx!=memx || lemongrab.tspawny!=memy || lemongrab.tspawnr!=memr) event_user(7)
            }
        } else if (editcursor.tool=10) { //scale tool
            if (!_scaling) {
                if current_layermode=0 _scaleoutline = instance_place(curx,cury,watercontainer)
                if current_layermode=1 _scaleoutline = instance_place(curx,cury,deity)
                if current_layermode=2 _scaleoutline = instance_place(curx,cury,semicontainer)
                if current_layermode=3 _scaleoutline = instance_place(curx,cury,backcontainer)

                _scaleoutline = lemon_scaleable(_scaleoutline)

                if (editcursor.leftp && _scaleoutline && (curx == (_scaleoutline.x - 1 + ((_scaleoutline.scalex) * _scaleoutline._xsc)) && cury == (_scaleoutline.y - 1 + ((_scaleoutline.scaley) * _scaleoutline._ysc)))) {
                    if (!clicked) editsaveundo()
                    clicked = 2;
                    _scaling = 1;
                    unchanged = 0;
                }
            }
        }
    }
}

if (_scaling) {  //Please.

    if (!editcursor.left || editcursor.tool != 10 || !_scaleoutline || !instance_exists(_scaleoutline)) {
        _scaling = 0;
        if (_scaleoutline && instance_exists(_scaleoutline)) with (_scaleoutline) {
            replace_below = 1;
            updatedeities();
        }
        event_user(7)
    } else {
        _scaleoutline.scalex = min(max(1, min((curx - (_scaleoutline.x - 1)) div _scaleoutline._xsc, (lemongrab.w[region] - _scaleoutline.x) div _scaleoutline._xsc)),65535)
        _scaleoutline.scaley = min(max(1, min((cury - (_scaleoutline.y - 1)) div _scaleoutline._ysc, (lemongrab.h[region] - _scaleoutline.y) div _scaleoutline._ysc)),65535)
    }

} else if (editcursor.tool != 10) {
    _scaleoutline = noone;
}

if (drawing) {
    //drawing objects
    if (!editcursor.left) {drawing=0 /*UPDATE_THE_DEITIES=1*/ event_user(7)}
    else if ((curx!=drawx || cury!=drawy) && curx=median(0,curx,lemongrab.w[region]-1) && cury=median(0,cury,lemongrab.h[region]-1)) {
         if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=waterblock) {
            //water painting
            grabj=instance_place(curx,cury,watercontainer)
            if (!grabj && lemonhappy() && drawing=1) {
                i=instance_create(curx,cury,lemongrab.waters[region])
                i.region=region
                i.obj=lemongrab.objlist[hotbar.obj[hotbar.cur],0]
                with i updatedeities()
                myarray_i=1
                savema=selected_array[0]
                repeat (savema) {
                    with (selected_array[myarray_i]) {selected=0 event_user(0)}
                    myarray_i+=1
                    selected_array[0]-=1
                }

                selected_array[0]=0
                /*with (watercontainer) if (selected) {selected=0 event_user(0)}
                with (deity) if (selected) {selected=0 event_user(0)}
                with (semicontainer) if (selected) {selected=0 event_user(0)}
                with (backcontainer) if (selected) {selected=0 event_user(0)}*/
                //UPDATE_THE_DEITIES=1 event_user(7)
            } else if (drawing=1) grabj=noone
        } else if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=groundsemi||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel1s||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel2s||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper1s||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper2s||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel1s||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel2s||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper1s||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper2s){
            //semi painting
            grabj=instance_place(curx,cury,semicontainer)
            if (!grabj && lemonhappy() && drawing=1) {
                i=instance_create(curx,cury,lemongrab.semis[region])
                with i updatedeities()
                i.region=region
                i.obj=lemongrab.objlist[hotbar.obj[hotbar.cur],0]
                i.spr=lemongrab.objlist[hotbar.obj[hotbar.cur],1]
                lemongrasschecker(i);
                myarray_i=1
                savema=selected_array[0]
                repeat (savema) {
                    with (selected_array[myarray_i]) {selected=0 event_user(0)}
                    myarray_i+=1
                    selected_array[0]-=1
                }
                /*
                with (watercontainer) if (selected) {selected=0 event_user(0)}
                with (deity) if (selected) {selected=0 event_user(0)}
                with (semicontainer) if (selected) {selected=0 event_user(0)}
                with (backcontainer) if (selected) {selected=0 event_user(0)}*/
                /*UPDATE_THE_DEITIES=1*/ event_user(7)
            } else if (drawing=1) grabj=noone
        } else if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=groundback||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel1b||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel2b||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper1b||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper2b||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel1b||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel2b||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper1b||
            lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper2b){
            //back-ground painting
            grabj=instance_place(curx,cury,backcontainer)
            if (!grabj && lemonhappy() && drawing=1) {
                i=instance_create(curx,cury,lemongrab.backs[region])
                with i updatedeities()
                i.region=region
                i.obj=lemongrab.objlist[hotbar.obj[hotbar.cur],0]
                i.spr=lemongrab.objlist[hotbar.obj[hotbar.cur],1]
                myarray_i=1
                savema=selected_array[0]
                repeat (savema) {
                    with (selected_array[myarray_i]) {selected=0 event_user(0)}
                    myarray_i+=1
                    selected_array[0]-=1
                }

                /*with (watercontainer) if (selected) {selected=0 event_user(0)}
                with (deity) if (selected) {selected=0 event_user(0)}
                with (semicontainer) if (selected) {selected=0 event_user(0)}
                with (backcontainer) if (selected) {selected=0 event_user(0)}*/
                /*UPDATE_THE_DEITIES=1*/ event_user(7)
            } else if (drawing=1) grabj=noone
        } else {
            grabj=instance_place(curx,cury,deity)
            if (!grabj && lemonhappy() && drawing=1) {
                j=hotbar.obj[hotbar.cur]
                i=instance_create(curx,cury,deity)
                i.obj=lemongrab.objlist[j,0]
                i.spr=lemongrab.objlist[j,1]
                i.off=lemongrab.objlist[j,2]
                lemongrasschecker(i);
                if (hotbar.picked[hotbar.cur]) for (k=0;k<12;k+=1) i.data[k]=hotbar.data[hotbar.cur,k]
                else for (k=0;k<12;k+=1) i.data[k]=lemongrab.objlist[j,k+101]
                if (lemongrab.objlist[j,5]="align") unpack_align(i)
                with i updatedeities()
                myarray_i=1
                savema=selected_array[0]
                repeat (savema) {
                    with (selected_array[myarray_i]) {selected=0 event_user(0)}
                    myarray_i+=1
                    selected_array[0]-=1
                }

                /*
                with (watercontainer) if (selected) {selected=0 event_user(0)}
                with (deity) if (selected) {selected=0 event_user(0)}
                with (semicontainer) if (selected) {selected=0 event_user(0)}
                with (backcontainer) if (selected) {selected=0 event_user(0)}*/

                /*UPDATE_THE_DEITIES=1*/ event_user(7)
            } else if (drawing=1) grabj=noone
        }
        drawx=curx
        drawy=cury
        //single click cancel
        if (drawing=2) {
            drawing=0
            /*UPDATE_THE_DEITIES=1*/ event_user(7)
        }
    }
}
if (grabj) {
    //grab the object
    if (curx!=drawx || cury!=drawy) {
        yes=1
        with (grabj) {
            y-=99
            if (instance_place(other.curx,other.cury,other.deity)) other.yes=0
            y+=99
        }
        if (yes) {
            grabj.x=median(0,curx,lemongrab.w[region]-1)
            grabj.y=median(0,cury,lemongrab.h[region]-1)
        }
        drawx=curx
        drawy=cury
        //UPDATE_THE_DEITIES=1
    }
    if (!editcursor.left) { /*UPDATE_THE_DEITIES=1*/ event_user(7) with grabj updatedeities() /*grabj=noone*/}
}
if (grab) {
    //grab the view
    memx=viewx
    memy=viewy
    viewx=grabx+(grabcx-editcursor.x)/editzoom.level
    viewy=graby+(grabcy-editcursor.y)/editzoom.level
    if (viewx!=memx || viewy!=memy) {
        dont_update_eities=1;
        event_user(7)
    }
    if (!editcursor.middle) grab=0
    bgslide=grabslide+(grabcx-editcursor.x)/2
}
if (grabr) {
    //grab the reference
    memx=global.refx
    memy=global.refy
    global.refx=round(grabx-(grabcx-editcursor.x)/editzoom.level)
    global.refy=round(graby-(grabcy-editcursor.y)/editzoom.level)
    if (!editcursor.left) grabr=0
    if (global.refx!=memx || global.refy!=memy) event_user(7)
}
if (resize) {
    //grab the region
    memx=lemongrab.w[region]
    memy=lemongrab.h[region]
    lemongrab.w[region]=median(25,curx,600*3)
    lemongrab.h[region]=median(14,cury,336*3)
    lemongrab.water[region]=min(lemongrab.water[region],lemongrab.h[region])
    lemongrab.horizon[region]=min(lemongrab.horizon[region],lemongrab.h[region])
    if (lemongrab.w[region]!=memx || lemongrab.h[region]!=memy) event_user(7)
    if (!editcursor.left) {
        resize=0
        with (objcontainer) event_user(0)
        with (semicontainer) event_user(0)
        with (backcontainer) event_user(0)
        with (watercontainer) event_user(0)

        if (region == lemongrab.spawnr) {
            sx = lemongrab.spawnx
            loope=0 repeat (8) {if (lemongrab.spawnr==loope) break; sx-=25 + lemongrab.w[loope] loope+=1}

            if (sx > lemongrab.w[region] - 1) sx = lemongrab.w[region] - 1
            if (lemongrab.spawny > lemongrab.h[region] - 1) lemongrab.spawny = lemongrab.h[region] - 1

            loope=0 repeat (8) {if (lemongrab.spawnr==loope) break; sx+=25 + lemongrab.w[loope] loope+=1}
            lemongrab.spawnx = sx
        }

        if (region == lemongrab.tspawnr) { //how it feels to be an identical code chunk with 6 variables different
            sx = lemongrab.tspawnx
            loope=0 repeat (8) {if (lemongrab.tspawnr==loope) break; sx-=25 + lemongrab.w[loope] loope+=1}

            if (sx > lemongrab.w[region] - 1) sx = lemongrab.w[region] - 1
            if (lemongrab.tspawny > lemongrab.h[region] - 1) lemongrab.tspawny = lemongrab.h[region] - 1

            loope=0 repeat (8) {if (lemongrab.tspawnr==loope) break; sx+=25 + lemongrab.w[loope] loope+=1}
            lemongrab.tspawnx = sx
        }

        event_user(7)
    }
}
if (resizew) {
    //grab the water
    memy=lemongrab.water[region]
    lemongrab.water[region]=median(0,lemongrab.h[region]-cury,lemongrab.h[region])
    if (lemongrab.water[region]!=memy) event_user(7)
    if (!editcursor.left) {
        resizew=0
        event_user(7)
    }
}
if (resizehorizon) {
    //grab the horizon
    memy=lemongrab.horizon[region]
    lemongrab.horizon[region]=median(0,lemongrab.h[region]-cury,lemongrab.h[region])
    if (lemongrab.horizon[region]!=memy) event_user(7)
    if (!editcursor.left) {
        resizehorizon=0
        event_user(7)
    }
}
if (selecting) {
    curx=max(0,curx)
    cury=max(0,cury)

    if (curx<clicx) {selx=curx selw=clicx-curx+1} else {selx=clicx selw=curx-clicx+1}
    if (cury<clicy) {sely=cury selh=clicy-cury+1} else {sely=clicy selh=cury-clicy+1}

    selw=min(selw+selx,lemongrab.w[region])-selx
    selh=min(selh+sely,lemongrab.h[region])-sely

    if (selecting=1) {
        if (selecting=1) {
            if (!editcursor.left) {
                if current_layermode=0  with (watercontainer) {
                    if (selected) with other{
                        myarray_i=1
                        savema=selected_array[0]
                        repeat (savema) {
                            if moveback {selected_array[myarray_i-1]=selected_array[myarray_i]}
                            else if (selected_array[myarray_i]==other.id ) {selected=0 event_user(0) selected_array[0]-=1 moveback=1}
                            myarray_i+=1
                        }moveback=0
                    }
                    with (drawregion) other.selected=(splace_meeting(selx,sely,other.id,selw,selh))
                    if (selected) {
                        other.selected_array[0]+=1 other.selected_array[other.selected_array[0]]=id updatedeities()
                    }
                }
                if current_layermode=1  with (deity) {
                    if (selected) with other{
                        myarray_i=1
                        savema=selected_array[0]
                        repeat (savema) {
                            if moveback {selected_array[myarray_i-1]=selected_array[myarray_i]}
                            else if (selected_array[myarray_i]==other.id ) {selected=0 event_user(0) selected_array[0]-=1 moveback=1}
                            myarray_i+=1
                        }moveback=0
                    }
                    with (drawregion) other.selected=(splace_meeting(selx,sely,other.id,selw,selh))
                    if (selected) {
                        other.selected_array[0]+=1 other.selected_array[other.selected_array[0]]=id updatedeities()
                    } else{


                    }
                }
                if current_layermode=2 with (semicontainer) {
                    if (selected) with other{
                        myarray_i=1
                        savema=selected_array[0]
                        repeat (savema) {
                            if (selected_array[myarray_i]==other.id ) {selected=0 event_user(0) selected_array[0]-=1 break;}
                            myarray_i+=1
                        }
                    }
                    with (drawregion) other.selected=(splace_meeting(selx,sely,other.id,selw,selh))
                    if (selected) {
                        other.selected_array[0]+=1 other.selected_array[other.selected_array[0]]=id updatedeities()
                    }
                }
                if current_layermode=3 with (backcontainer) {
                    if (selected) with other{
                        myarray_i=1
                        savema=selected_array[0]
                        repeat (savema) {
                            if (selected_array[myarray_i]==other.id ) {selected=0 event_user(0) selected_array[0]-=1 break;}
                            myarray_i+=1
                        }
                    }
                    with (drawregion) other.selected=(splace_meeting(selx,sely,other.id,selw,selh))
                    if (selected) {
                        other.selected_array[0]+=1 other.selected_array[other.selected_array[0]]=id updatedeities()
                    }
                }
                /*UPDATE_THE_DEITIES=1*/
                selecting=0
            }
        }
    }
    if (selecting=2) {
        if (!editcursor.left) {
            if (selw=1 && selh=1) {//flood fill
                with (deity) memx=x
                var yes;
                switch(current_layermode) {
                    case 0:
                        yes = place_meeting(x,y,lemongrab.waters[region])
                    break;
                    case 1:
                        yes = place_meeting(x,y,deity)
                    break;
                    case 2:
                        yes = place_meeting(x,y,lemongrab.semis[region])
                    break;
                    case 3:
                        yes = place_meeting(x,y,lemongrab.backs[region])
                    break;

                }
                if (!yes) {
                    if (lemonhappy()) {
                        flooding=1
                        instance_create(curx,cury,editflood)
                    }
                }
            } else {//fill rectangle
                j=hotbar.obj[hotbar.cur]
                var u,v;
                u=selx;
                repeat (selw) {
                    v=sely
                    repeat (selh) if (lemonhappy()) {
                        if (lemongrab.objlist[j,0]=groundsemi||
                        lemongrab.objlist[j,0]=slopel1s||
                        lemongrab.objlist[j,0]=slopel2s||
                        lemongrab.objlist[j,0]=sloper1s||
                        lemongrab.objlist[j,0]=sloper2s||
                        lemongrab.objlist[j,0]=uslopel1s||
                        lemongrab.objlist[j,0]=uslopel2s||
                        lemongrab.objlist[j,0]=usloper1s||
                        lemongrab.objlist[j,0]=usloper2s){
                            yes=instance_place(u,v,semicontainer)
                            if (!yes){
                                i=instance_create(u,v,lemongrab.semis[region])
                                i.region=region
                                i.obj=lemongrab.objlist[hotbar.obj[hotbar.cur],0]
                                i.spr=lemongrab.objlist[j,1]
                                if v==sely lemongrasschecker(i);
                                else i.frame=1
                            }

                        } else if (lemongrab.objlist[j,0]=groundback||
                        lemongrab.objlist[j,0]=slopel1b||
                        lemongrab.objlist[j,0]=slopel2b||
                        lemongrab.objlist[j,0]=sloper1b||
                        lemongrab.objlist[j,0]=sloper2b||
                        lemongrab.objlist[j,0]=uslopel1b||
                        lemongrab.objlist[j,0]=uslopel2b||
                        lemongrab.objlist[j,0]=usloper1b||
                        lemongrab.objlist[j,0]=usloper2b){
                        //back-ground painting
                            yes=instance_place(u,v,backcontainer)
                            if (!yes){
                                i=instance_create(u,v,lemongrab.backs[region])
                                i.region=region
                                i.obj=lemongrab.objlist[hotbar.obj[hotbar.cur],0]
                                i.spr=lemongrab.objlist[j,1]
                            }

                        } else if (lemongrab.objlist[j,0]=waterblock){
                        //water painting
                            yes=instance_place(u,v,watercontainer)
                            if (!yes){
                                i=instance_create(u,v,lemongrab.waters[region])
                                i.region=region
                                i.obj=lemongrab.objlist[j,0]
                                i.spr=lemongrab.objlist[j,1]
                            }

                        } else {
                            yes=instance_place(u,v,deity)
                            if (!yes) {
                                i=instance_create(u,v,deity)
                                i.obj=lemongrab.objlist[j,0]
                                i.spr=lemongrab.objlist[j,1]
                                i.off=lemongrab.objlist[j,2]
                                if (i.obj == groundblock) {
                                    if (v==sely) {
                                        lemongrasschecker(i);
                                    } else i.frame = 1;
                                }
                                if (hotbar.picked[hotbar.cur]) for (k=0;k<12;k+=1) i.data[k]=hotbar.data[hotbar.cur,k]
                                else for (k=0;k<12;k+=1) i.data[k]=lemongrab.objlist[j,k+101]
                                if (lemongrab.objlist[j,5]="align") unpack_align(i)
                            }
                        }
                        v+=1
                        if (i && instance_exists(i)) with (i) updatedeities()
                    }
                    u+=1;
                }
                /*UPDATE_THE_DEITIES=1*/
                event_user(7)
            }
            selecting=0
        }
    }
    if (editcursor.tool!=selecting) selecting=0
}
if (grabs) {//grab selection
    if current_layermode=0 with (watercontainer) if (selected) {
        x=(other.curx-other.clicx)+grabx
        y=(other.cury-other.clicy)+graby
    }
    if current_layermode=1 with (deity) if (selected) {
        x=(other.curx-other.clicx)+grabx
        y=(other.cury-other.clicy)+graby
    }
    if current_layermode=2 with (semicontainer) if (selected) {
        x=(other.curx-other.clicx)+grabx
        y=(other.cury-other.clicy)+graby
    }
    if current_layermode=3 with (backcontainer) if (selected) {
        x=(other.curx-other.clicx)+grabx
        y=(other.cury-other.clicy)+graby
    }
    if (!editcursor.left) {
        grabs=0
    }
    /*UPDATE_THE_DEITIES=1*/ event_user(7)
}

if (editcursor.escape) {
    myarray_i=1
    repeat (selected_array[0]) {
        with (selected_array[myarray_i]) {selected=0 event_user(0)}
        myarray_i+=1
    }
}

curx=median(0,curx,lemongrab.w[region]-1)
cury=median(0,cury,lemongrab.h[region]-1)

    /*
i=instance_number(deity) + instance_number(watercontainer) + instance_number(semicontainer) + instance_number(backcontainer)
if (i!=deityc || update) {
    deityc=i
    update=0
    event_user(7)
}
    */

if (positionpicker) {
    if (curx!=grabx || cury!=graby) {
        grabx=curx graby=cury
        event_user(7)
    }
}


if (usersevened) {event_user(8) usersevened=false}
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sureface_free("drawregion")
sureface_free("drawregion2")

if (!global.lemontest) {
    if (global.ref!=-1) sprite_delete(global.ref)
    global.ref=-1
    global.refx=0
    global.refy=0
}
#define Other_17
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//make sure the surface is updated in draw event. Also im going to fuckign kill someone this had the entire fucking updating surface code and it just keeps being fucking spammed multiple times per frame this is the entire reason Lemon fucking sucked this entire time  - -S-
usersevened=1
#define Other_18
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var j,i,v1,v2,b,xx,yy;

count[region]=instance_number(objcontainer)+instance_number(semicontainer)+instance_number(backcontainer)+instance_number(watercontainer)

s=sureface("drawregion",width,height)
if (s=-1) exit

sw=round(224*(width/height))
s2=sureface("drawregion2",sw,224)
if (s2=-1) exit

if (!sureface_set_target("drawregion2")) exit
draw_clear_alpha(0,1)

bgname=lemongrab.typebg[region]+lemongrab.typetime[region]+"sky"
if !skindat("bg_"+bgname) bgname=lemongrab.typebg[region]+"sky"
maxslot=skindat("ms_"+bgname)

for (i=0;i<=maxslot;i+=1) {
    spr=skindat("tex_"+bgname+string(i))
    if (spr) if (!skindat("fg_"+bgname+string(i)) && !skindat("3d_"+bgname+string(i))) {
        bw=skindat("texw_"+bgname+string(i))
        bh=skindat("texh_"+bgname+string(i))
        vx=floor(-modulo(bgslide*skindat("px_"+bgname+string(i)),0,bw))
        p=0
        t=skindat("voffset")
        bm=skindat("bm_"+bgname+string(i))
        if (bm=1) draw_set_blend_mode(bm_add)
        if (bm=2) draw_set_blend_mode(bm_subtract)
        repeat (ceil(sw/bw)+1) {draw_sprite(spr,0,vx+p,232-bh-t) p+=bw}
        if (bm) draw_set_blend_mode(0)
    }
}


rect(0,0,width/2,height/2,0,0.6)
draw_set_blend_mode(bm_add)
rect(0,0,width/2,height/2,0,1)
draw_set_blend_mode(0)
surface_reset_target()

if (!sureface_set_target("drawregion")) exit
draw_clear_alpha(0,1)
draw_surface_stretched(s2,0,0,width,height)
d3d_transform_add_translation((width/2)/editzoom.level-viewx,(height/2)/editzoom.level-viewy,0)
d3d_transform_add_scaling(editzoom.level,editzoom.level,1)
rect(-16,-16,lemongrab.w[region]*16+32,lemongrab.h[region]*16+32,0,0.5)
rect(lemongrab.w[region]*16,lemongrab.h[region]*16,max(16,16/editzoom.level),max(16,16/editzoom.level),$ffffff,1)
//water square
rect(-max(16,16/editzoom.level),(lemongrab.h[region]-lemongrab.water[region])*16,max(16,16/editzoom.level),max(16,16/editzoom.level),$ff8000,1)
//horizon square
rect(-max(16,16/editzoom.level),(lemongrab.h[region]-lemongrab.horizon[region])*16,max(16,16/editzoom.level),max(16,16/editzoom.level),$00CCDE,1)

rect(0,(lemongrab.h[region]-lemongrab.water[region])*16,lemongrab.w[region]*16,lemongrab.water[region]*16,$ff8000,0.5)
if (global.ref!=-1) draw_sprite_ext(global.ref,0,global.refx,global.refy,1,1,0,$ffffff,0.5)

var isback,issemi;

if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=groundback||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel1b||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel2b||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper1b||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper2b||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel1b||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel2b||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper1b||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper2b){
    isback=true
}

if (lemongrab.objlist[hotbar.obj[hotbar.cur],0]=groundsemi||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel1s||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=slopel2s||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper1s||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=sloper2s||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel1s||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=uslopel2s||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper1s||
lemongrab.objlist[hotbar.obj[hotbar.cur],0]=usloper2s){
    issemi=true
}

if (isback) {
    draw_set_alpha(0.25)
} else if (issemi) {
    draw_set_alpha(0.525)
}

if global.greenmode draw_set_color($80ff80)
if (gridtoggle.on) {
    texture_set_repeat(1)
    draw_primitive_begin_texture(pr_trianglestrip,gridtex1)
    draw_vertex_texture(-0.5,-0.5,0,0)
    draw_vertex_texture(lemongrab.w[region]*16-0.5,-0.5,lemongrab.w[region]/2,0)
    draw_vertex_texture(-0.5,lemongrab.h[region]*16-0.5,0,lemongrab.h[region]/2)
    draw_vertex_texture(lemongrab.w[region]*16-0.5,lemongrab.h[region]*16-0.5,lemongrab.w[region]/2,lemongrab.h[region]/2)
    draw_primitive_end()
}// else rect(0,0,lemongrab.w[region]*16,lemongrab.h[region]*16,$c0c0c0,0.375)
texture_set_repeat(1)
draw_primitive_begin_texture(pr_trianglestrip,gridtex2)
draw_vertex_texture(-0.5,-0.5,0,0)
draw_vertex_texture(lemongrab.w[region]*16-0.5,-0.5,lemongrab.w[region]/50,0)
draw_vertex_texture(-0.5,lemongrab.h[region]*16-0.5,0,lemongrab.h[region]/28)
draw_vertex_texture(lemongrab.w[region]*16-0.5,lemongrab.h[region]*16-0.5,lemongrab.w[region]/50,lemongrab.h[region]/28)
draw_primitive_end()

draw_set_color($1ffffff)

texture_set_interpolation(editzoom.level<1)

//done earlier because bback makes  a lot  more shit transparent than top does

if (isback) {
    draw_set_alpha(1);
} else {
    draw_set_alpha(0.25);
}

with (backcontainer) {
    if (drawregion.UPDATE_THE_DEITIES && !drawregion.dont_update_eities)
    updatedeities()

    draw_sprite_ext(spr,frame,x*16,y*16,scalex,scaley,0,c_white,draw_get_alpha())
}

if (isback) {
    draw_set_alpha(0.25)
} else if (issemi) {
    draw_set_alpha(1);
} else {
    draw_set_alpha(0.525);
}

with (semicontainer) {
    if (drawregion.UPDATE_THE_DEITIES && !drawregion.dont_update_eities)
    updatedeities()

    draw_sprite_ext(spr,frame,x*16,y*16,scalex,scaley,0,c_white,draw_get_alpha())
    update=0
}

if (issemi) || (isback) {
    draw_set_alpha(0.25)
} else {
    draw_set_alpha(1);
}

//with (deity)

// draw deity inlined

var d,canupdate;
canupdate = (drawregion.UPDATE_THE_DEITIES && !drawregion.dont_update_eities)
with (deity) {

    if (canupdate)
    updatedeities()

    draw_sprite_ext(spr,frame,x*16+off+off2x,y*16+off+off2y,scalex,scaley,0,c_white,draw_get_alpha())

    switch(obj) {
        case (tyler):
        case (objectstyler):
        case (terraintyler):
        case (decortyler): {
            for (i=0;i<ur;i+=1) for (j=0;j<vr;j+=1) {
                if (flip=0) draw_background_part_ext(sheet,l,t,w,h,u+i*w,v+j*h,1,1,col,0.5)
                if (flip=1) draw_background_part_ext(sheet,l,t,w,h,u+(i+1)*w,v+j*h,-1,1,col,0.5)
                if (flip=2) draw_background_part_ext(sheet,l,t,w,h,u+i*w,v+(j+1)*h,1,-1,col,0.5)
                if (flip=3) draw_background_part_ext(sheet,l,t,w,h,u+(i+1)*w,v+(j+1)*h,-1,-1,col,0.5)
            }
        } break

        case (itemlaunch): {
            draw_sprite(spr_itemspawner,11,(x*16)+8,(y*16)+8) break;
        }

        case (spawncancel): if (point) {
            draw_set_color($ff)
            draw_arrow(x*16,y*16+8,point.x*16+16,point.y*16+8,8)
            draw_set_color($ffffff)
        } break

        case (textblock): {
            global.halign=align
            draw_skintext(x*16,y*16,data[0],col)
            global.halign=0
        } break

        case (pipeblock):
        case (sidepipe):
        case (downpipe):
        case (theothersidepipe):
        case (door):
        case (warpbox): {
            if (point) {
                draw_set_color($ff)
                draw_arrow(x*16+8,y*16+8,point.x*16+8,point.y*16+8,8)
                draw_set_color($ffffff)
            }
            if (point2) {
                draw_set_color($ff00)
                draw_arrow(x*16+8,y*16+8,point2.x*16+8,point2.y*16+8,8)
                draw_set_color($ffffff)
            }
        } break

        case (axe): if (point) {
            draw_set_color($ff)
            draw_arrow(x*16+8,y*16+8,point.x*16+8,point.y*16+8,8)
            draw_set_color($ffffff)
        } break

        case (activate_region): {
            rect(x*16+off+off2x,y*16+off+off2y,real(data[1])*16,real(data[2])*16,c_navy,0.5) //Not finding out if every object gets "col" Lol
        } break

        case (fbarblock): {
            if (fire) {
                if (clock) {for (i=0;i<6+6*long;i+=1) draw_sprite(spr_firebar,0,x*16+8+6*i,y*16+8-6*i)}
                else {for (i=0;i<6+6*long;i+=1) draw_sprite(spr_firebar,0,x*16+8-6*i,y*16+8-6*i)}
            }
        } break
        case (platform): {
            if (sub) {
                draw_circle(x*16+8,(y-height)*16+16,8,1)
                draw_circle(sub.x*16-8,(y-height)*16+16,8,1)
                draw_line(x*16,(y-height)*16+16,x*16,y*16)
                draw_line(sub.x*16,(y-height)*16+16,sub.x*16,sub.y*16)
                draw_line(x*16+8,(y-height)*16+8,sub.x*16-8,(y-height)*16+8)
            }
        } break
        case (axewall): if (point) {
            draw_set_color($ff)
            d=point_direction(x,y,point.x,point.y)
            draw_arrow(x*16+8,y*16+8,x*16+8+lengthdir_x(32,d),y*16+8+lengthdir_y(32,d),8)
            draw_set_color($ffffff)
        } break
        case (mark): case (anchor): {draw_omitext(x*16,y*16+4,data[0])}
        break
        case (retainer): {
            if (data[0]="") draw_sprite_part(skindat("tex_princess0"),0,8,8,112,112,x*16-32,y*16-88+skindat("prin"))
        } break
        case (ireader): {
            draw_sprite(spr_ireader,1,srcx*16,srcy*16)
            draw_set_color($ff) if (selected) draw_set_color($ffffff)
            draw_arrow(x*16+8,y*16+8,srcx*16+8,srcy*16+8,8)
            draw_set_color($ffffff)
        } break

        case (obj=gobble): {
            draw_sprite(spr_ireader,1,srcx*16,srcy*16)
            draw_sprite(spr_ireader,1,srcx2*16,srcy2*16)
            draw_set_color($ff) if (selected) draw_set_color($ffffff)
            draw_arrow(x*16+8,y*16+8,srcx*16+8,srcy*16+8,8)
            draw_arrow(x*16+8,y*16+8,srcx2*16+8,srcy2*16+8,8)
            draw_set_color($ffffff)
        } break

        case (fakesemiplat): {
            rect(x*16,y*16,real(data[1])*16,real(data[2])*16,col,0.5)
        } break

        case (lightbulb): {
            rect((x*16)-((real(data[2])*16)/2)+8,(y*16)-((real(data[3])*16)/2)+8,real(data[2])*16,real(data[3])*16,$00c3f4,0.5)
        } break

        case (detector): {
            rect(x*16+5,y*16,6,real(data[3])*8,col,0.5)
        } break

        case (gate): {
            rect(x*16+5,y*16,6,real(data[2])*16,col,0.5)
        } break

        case (sidegate): {
            rect(x*16,y*16+5,real(data[2])*16,6,col,0.5)
            draw_sprite(spr_sidegate,0,(x*16)+(real(data[2])-1)*16,y*16)
        } break

        case (bigitembox): {
            bigboxoffset=16
        }
        case (itembox): {
            switch data[1] {
                case "item": {
                    draw_sprite_ext(spr_flower,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "itemfeather": {
                    draw_sprite_ext(spr_feather,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "itembeetroot": {
                    draw_sprite_ext(spr_beetroot,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "itemgreenlui": {
                    draw_sprite_ext(spr_greenlui,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "mini": {
                    draw_sprite_ext(spr_mushsmall,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+4,1,1,0,c_white,0.5)
                } break
                case "coins": {
                    draw_sprite_ext(spr_coin,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "life": {
                    draw_sprite_ext(spr_1up,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "moon": {
                    draw_sprite_ext(spr_3moon,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "poison": {
                    draw_sprite_ext(spr_poison,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "vine": {
                    draw_sprite_ext(spr_sprong,0,x*16+off+off2x+bigboxoffset,y*16+off+off2y,1,1,0,c_white,0.5)
                } break
                case "star": {
                    draw_sprite_ext(spr_starman,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "key": {
                    draw_sprite_ext(spr_key,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "shield": {
                    draw_sprite_ext(spr_shield,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "spring": {
                    draw_sprite_ext(spr_spring,0,x*16+off+off2x+bigboxoffset,y*16+off+off2y,1,1,0,c_white,0.5)
                } break
                case "spreng": {
                    draw_sprite_ext(spr_spreng,0,x*16+off+off2x+bigboxoffset,y*16+off+off2y,1,1,0,c_white,0.5)
                } break
                case "pswitch": {
                    draw_sprite_ext(spr_switch,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
                case "shard": {
                    draw_sprite_ext(spr_shard,0,x*16+off+off2x+8+bigboxoffset,y*16+off+off2y+8,1,1,0,c_white,0.5)
                } break
            }
        } break

    }
    update=0
}

with (watercontainer) {
    if (drawregion.UPDATE_THE_DEITIES && !drawregion.dont_update_eities)
    updatedeities()

    draw_sprite_ext(spr_editorwater,0,x*16,y*16,scalex,scaley,0,c_white,draw_get_alpha())
}

UPDATE_THE_DEITIES=0

draw_set_alpha(1)

//end draw deity

//spawner...
if (region=lemongrab.spawnr) {
    var sx, greenhillzone; sx=lemongrab.spawnx greenhillzone=0
    if region>0 repeat (8) {sx-=lemongrab.w[greenhillzone]+25 greenhillzone+=1 if (greenhillzone == region) break;}
    draw_sprite(spr_spawner,0,sx*16,lemongrab.spawny*16)
}

if (region=lemongrab.tspawnr) {
    var sx, greenhillzone; sx=lemongrab.tspawnx greenhillzone=0
    if region>0 repeat (8) {sx-=lemongrab.w[greenhillzone]+25 greenhillzone+=1 if (greenhillzone == region) break;}
    draw_sprite(spr_spawner,1,sx*16,lemongrab.tspawny*16)
}

if (positionpicker) {
    draw_arrow(positionpickerinst.x*16+8,positionpickerinst.y*16+8,curx*16+8,cury*16+8,8)
    draw_sprite(spr_ireader,1,curx*16,cury*16)
}

texture_set_interpolation(0)

j=0
for (i=0;i<72;i+=1) {
    v1=lemongrab.cambitmap[region,i]
    v2=lemongrab.cambitmap2[region,i]
    v3=lemongrab.cambitmap3[region,i]
    b=128
    repeat (8) {
        if (j mod 24<lemongrab.w[region]/25 && j div 24<lemongrab.h[region]/14) {
            if (v1 & b) {
                xx=(j mod 24)*25*16
                yy=(j div 24)*14*16
                rect(xx,yy,min(xx+400,lemongrab.w[region]*16)-xx,min(yy+224,lemongrab.h[region]*16)-yy,$ff,0.5)
            }
            if (v2 & b) {
                xx=(j mod 24)*25*16
                yy=(j div 24)*14*16
                rect(xx,yy,min(xx+400,lemongrab.w[region]*16)-xx,min(yy+224,lemongrab.h[region]*16)-yy,$ff0000,0.5)
            }
            if (v3 & b) {
                xx=(j mod 24)*25*16
                yy=(j div 24)*14*16
                rect(xx,yy,min(xx+400,lemongrab.w[region]*16)-xx,min(yy+224,lemongrab.h[region]*16)-yy,$ff0000,0.5)
            }
            b=b>>1
        }
        j+=1
    }
}



dont_update_eities=0;

d3d_transform_set_identity()

draw_set_blend_mode(bm_add)
rect(0,0,width,height,0,1)
draw_set_blend_mode(0)
surface_reset_target()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var ofx,ofy;

d3d_transform_set_identity()
if (!sureface_exists("drawregion") || !sureface_exists("drawregion2") || global.lemonjustundone) {__emergency = 1; usersevened=1 UPDATE_THE_DEITIES=1 global.lemonjustundone=0}
if (usersevened && __emergency) {event_user(8) usersevened=false __emergency = 0;}
rect(0,0,width,height,0,1)
draw_set_blend_mode_ext(bm_one,bm_one)
draw_surface(s,0,0)
draw_set_blend_mode(0)
rect(0,0,width,90,$ffffff,0.25)
rect(0,height-160,width,160,$ffffff,0.25)

ofx=(width/2)/editzoom.level-viewx
ofy=(height/2)/editzoom.level-viewy

d3d_transform_add_translation(ofx,ofy,0)
d3d_transform_add_scaling(editzoom.level,editzoom.level,1)
if (!hidecur) rect(curx*16,cury*16,16,16,$ff00,0.5)
if (editcursor.tool=4 && region=lemongrab.thumbregion) {
    draw_sprite(spr_level,0,lemongrab.thumbx*16,lemongrab.thumby*16)
    rect(lemongrab.thumbx*16,lemongrab.thumby*16,224,160,selcol,0.5)
}
if (!grab && !grabj && !grabf && !hidecur && !positionpicker) if ((editcursor.tool=0 && !editcursor.shift) || (editcursor.tool=2 && editcanflood(lemongrab.objlist[hotbar.obj[hotbar.cur],0]))) {
    off=lemongrab.objlist[hotbar.obj[hotbar.cur],2]
    draw_sprite_ext(lemongrab.objlist[hotbar.obj[hotbar.cur],1],0,curx*16+off,cury*16+off,1,1,0,selcol,0.5)
}
if (selecting) rect(selx*16,sely*16,selw*16,selh*16,selcol,0.5)
if ((selecting == 2 || scaling) && !dragsound) {
    if !(settings("nolemonsound")) sound("lemonbucketdrag",1)
    dragsound=1
} else if (selecting != 2 && !scaling) {
    if !(settings("nolemonsound")) soundstop("lemonbucketdrag")
    dragsound=0
}
i=1 var _s;
repeat (selected_array[0]) { _s = selected_array[i]
    rect((_s.x * 16) - 2, (_s.y * 16) - 2, ((_s.scalex * 16) * _s._xsc) + 4, ((_s.scaley * 16) * _s._ysc) + 4, selcol, 0.5)
    i+=1
}
/*
with (watercontainer) if (selected) rect(x*16-2,y*16-2,20,20,other.selcol,0.5)
with (deity) if (selected) rect(x*16-2,y*16-2,20,20,other.selcol,0.5)
with (semicontainer) if (selected) rect(x*16-2,y*16-2,20,20,other.selcol,0.5)
with (backcontainer) if (selected) rect(x*16-2,y*16-2,20,20,other.selcol,0.5)*/

if (_scaleoutline)
    with (_scaleoutline) {
        rect((x * 16) - 2, (y * 16) - 2, ((scalex * 16) * _xsc) + 2, ((scaley * 16) * _ysc) + 2, other.scalecol, 1, 1)
        draw_sprite(spr_lemonscale, other._scaling, ((x + (scalex * _xsc)) * 16), ((y + (scaley * _ysc)) * 16))
    }

if (editcursor.tool=1 && editcursor.ctrl && !editcursor.shift) && (copy_layer == current_layermode) if (copyw>0 || copyh>0) rect(curx*16,cury*16,copyw*16,copyh*16,selcol,0.5)
d3d_transform_set_identity()

//minimap
/* currently removed
rect(mmx,mmy,200,144,0,1)
rect(mmx+100-mmw/2,mmy+72-mmh/2,mmw,mmh,$ffffff,0.5)
d3d_transform_add_translation(0.5,0.5,0)
d3d_transform_add_scaling(mms,mms,1)
d3d_transform_add_translation(mmx+100-mmw/2,mmy+72-mmh/2,0)
with (objcontainer) draw_sprite_ext(mask_index,0,x,y,image_xscale,image_yscale,0,0,1)
d3d_transform_set_identity()
rect(mmll,mmtt,min(mmr,mmx+100+mmw/2)-mmll,min(mmb,mmy+72+mmh/2)-mmtt,$ffffff,0.5)     */
#define KeyPress_27
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
editexit()
