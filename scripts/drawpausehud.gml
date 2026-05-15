if (pause) {
    d3d_set_projection_ortho(0,0,400,224,0)
    d3d_transform_stack_push()
    d3d_transform_set_identity()

    rect(0,0,400,224,0,1)
    s=1 if (settings("dequanto")=4) s=1/global.s
    if !sprite_exists(pausespr) pausespr=spr_pausesprblank //fix for time attack resets
    draw_sprite(pausespr,0,-view_xport[view_current]*s,-view_yport[view_current]*s)
    if (global.playback) {
        draw_sprite_stretched(spr_taspause,0,0,0,400,224)
    } else {
        rect(0,0,400,224,0,0.7)
        if (pauseplayer=view_current) {
            if (global.check=="" && !instance_exists(pausefade)) checkcol="${c=$808080}" else if (!instance_exists(pausefade)) checkcol=""
            if (global.lifes<=1 && !instance_exists(pausefade) && global.gamemode=="classic" && !settings("cog inflives") && global.charname[global.option[pauseplayer]]!="kid") retrycol="${c=$808080}" else if (!instance_exists(pausefade)) retrycol=""
            if (pausetex) draw_sprite(pausetex,0,400/2-pausetexw/2,112-pausetexh/2)
            global.halign=1
            global.valign=1
            if (quitask) str=lang("pause quit ask")+"##"+arrow(pausel=0)+lang("pause quit")+arrowleft(pausel=0)+"#"+arrow(pausel=1)+lang("pause back")+arrowleft(pausel=1)
            else if (retryask) str=lang("pause retry ask")+"##"+arrow(pausel=0)+checkcol+lang("pause checkpoint")+"${c=$ffffff}"+arrowleft(pausel=0)+"#"+arrow(pausel=1)+lang("pause start over")+arrowleft(pausel=1)+"#"+arrow(pausel=2)+lang("pause back")+arrowleft(pausel=2)+"##"
            else {
                full=settings("fullscreen")
                zoom=settings("zoom")*!full
                wstr=""
                if (zoom=1 && pausel=3) wstr+=">1x<" else if (zoom=1) wstr+="[1x]" else wstr+=" 1x "
                if (zoom=2 && pausel=3) wstr+=">2x<" else if (zoom=2) wstr+="[2x]" else wstr+=" 2x "
                if (zoom=3 && pausel=3) wstr+=">auto<" else if (zoom=3) wstr+="[auto]" else wstr+=" auto "
                if (full && pausel=3) wstr+=">Full<" else if (full) wstr+="[Full]" else wstr+=" Full "
                v=settings("volbalance")
                vstr=arrow(pausel=5)+"≥ "+string_repeat(".",v*8)+"|"+string_repeat(".",8-v*8)+" "+chr(2)+arrowleft(pausel=5)
                v=settings("musbalance")
                mstr=arrow(pausel=4)+"≤ "+string_repeat(".",v*8)+"|"+string_repeat(".",8-v*8)+" "+chr(1)+arrowleft(pausel=4)

                str=lang("pause")+"##"+
                arrow(pausel=0)+lang("pause resume")+arrowleft(pausel=0)+"#"+
                arrow(pausel=1)+retrycol+lang("pause retry")+"${c=$ffffff}"+arrowleft(pausel=1)+"#"+
                arrow(pausel=2)+lang("pause quit")+arrowleft(pausel=2)+"##"+
                wstr+"##"+
                mstr+"#"+
                vstr+"##"



            }
            if (skindat("left")) {
                d3d_transform_add_scaling(-1,1,1)
                d3d_transform_add_translation(400,0,0)
            }
            draw_skintext(200,112,str)

            global.halign=0
            global.valign=2
            //manage pages (is here so no drawing issues)
            var opagestr;
            if (opagestr) opagestr=pagestr
            pagestr=global.movelist[global.option[pauseplayer],pausepage]
            if (is_real(pagestr)) {pausepage=0 pagestr=global.movelist[global.option[pauseplayer],pausepage]}
            if (is_string(pagestr)) draw_skintext(8,216,pagestr)
            global.valign=0

            draw_skintext(8,12,replacebuttonnames(global.levelname)+"#"+replacebuttonnames(global.leveldescnotags))
            if (global.mplay>1) draw_skintext(8,44,"[P"+string(pauseplayer+1)+"]",playercol(global.input[pauseplayer]))
        }
    }
    d3d_transform_stack_pop()
}
