///draw_systext(x,y,str,col,a,spc,cus_spr)
var str,col,alpha,linespc,cus_spr;
var dx,dy;
var l,i,j,c,s;
var line,lw,lh;
var arr,tag,tagstr,cmd;
var dcol,dalp,dsca,dlin;

if (global.sysfont=-1) exit

dx=floor(argument[0])
dy=floor(argument[1])
str=string(argument[2])
col=$ffffff if (argument_count>=4) col=argument[3]
alpha=1 if (argument_count>=5) alpha=argument[4]
linespc=8 if (argument_count>=6) linespc=argument[5]
cus_spr=global.sysfont if (argument_count>=7) cus_spr=argument[6]
l=string_length(str)

s=global.tscale

line=0
lw[999]=0
lh=8*s
//cmd[0,0]=0

if (string(__text_sys_last)!=str) {
    maxx=0
    maxy=0
    //we have to cache all the info about the text if it updates, or else the game lags like crazy
    __text_sys_last = str;
    __text_sys_char_arr = 0;
    __text_sys_char_pos = 0;
    __text_sys_tag_cmds = 0;
    __text_sys_length = 0;
    __text_sys_length_lw = 0;
    __text_sys_length_lh = 0;
    j=1 tag=0
    for (i=1;i<=l;i+=1) {
        ch=string_char_at(str,i)

        //tag system
        if (tag) {
            if (ch="}") {
                tag=0
                //tag commands
                if (string_pos("c=",tagstr)=1) {__text_sys_tag_cmds[j,0]=1 __text_sys_tag_cmds[j,1]=deciphercolor(string_delete(tagstr,1,2))}
                if (string_pos("a=",tagstr)=1) {__text_sys_tag_cmds[j,0]=2 __text_sys_tag_cmds[j,1]=unreal(string_delete(tagstr,1,2))}
                if (string_pos("s=",tagstr)=1) {__text_sys_tag_cmds[j,0]=3 __text_sys_tag_cmds[j,1]=unreal(string_delete(tagstr,1,2))}
                if (string_pos("l=",tagstr)=1) {__text_sys_tag_cmds[j,0]=4 __text_sys_tag_cmds[j,1]=unreal(string_delete(tagstr,1,2))}
                __text_sys_char_arr[j]=13 j+=1 i+=1
                continue
            } else {tagstr+=ch i+=1 continue}
        }
        if (ch="$") if (string_char_at(str,i+1)="{") {tag=1 i+=2 tagstr="" continue}

        c=string_pos(ch,global.fontmap)
        __text_sys_char_arr[j]=c
        __text_sys_char_arr[j, 0]=(c mod 16)*9
        __text_sys_char_arr[j, 1]=(c div 16)*9
        j+=1
        __text_sys_tag_cmds[j,0]=0

        if (c=13) continue
        if (c=35 || c=10) {if (i=l) break lh+=8*s i+=1 line+=1 continue}
        lw[line]+=8*s
        maxx=max(maxx,lw[line])
        __text_sys_length_lw[line] = lw[line];
    }
    maxy=lh
    __text_sys_length_lh = lh;
    __text_sys_length = j-1;
}

if (global.tcalc) exit

l=__text_sys_length
line=0
if (global.halign=1) dx-=floor(__text_sys_length_lw[line]/2)
if (global.halign=2) dx-=__text_sys_length_lw[line]
if (global.valign=1) dy-=floor(__text_sys_length_lh/2)
if (global.valign=2) dy-=__text_sys_length_lh

dcol=col
dalp=alpha
dsca=s
dlin=linespc
for (i=1;i<=l;i+=1) {
    c=__text_sys_char_arr[i]

    if (__text_sys_tag_cmds[i,0]=1) dcol=color_mult(__text_sys_tag_cmds[i,1],col)
    if (__text_sys_tag_cmds[i,0]=2) dalp=alpha*__text_sys_tag_cmds[i,1]
    if (__text_sys_tag_cmds[i,0]=3) dsca=s*__text_sys_tag_cmds[i,1]
    if (__text_sys_tag_cmds[i,0]=4) dlin=__text_sys_tag_cmds[i,1]
    if (c=13) {i+=1 continue}
    if (c=35 || c=10) {dcol=col dalp=alpha dsca=s line+=1 dx=floor(argument[0]) if (global.halign=1) {dx-=floor(__text_sys_length_lw[line]/2)} if (global.halign=2) {dx-=__text_sys_length_lw[line]} dy+=dlin*s i+=1 continue}
    if (c!=32) draw_sprite_part_ext(cus_spr,0,__text_sys_char_arr[i, 0],__text_sys_char_arr[i, 1],9,9,dx,dy+(dlin+1)*s-(dlin+1)*dsca,s,dsca,dcol,dalp)
    dx+=8*s
}
