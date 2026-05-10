///draw_omitext(x,y,str,col,a,taggable,uselower,cus_spr)
var str,dx,dy,l,i,j,c,s,lw,lh,line,col,alpha,arr,tag,tagstr,cmd,dcol,dalp,dsca,taggable,uselower,cus_spr;

dx=floor(argument[0])
dy=floor(argument[1])
str=string(argument[2])
col=$ffffff if (argument_count>=4) col=argument[3]
alpha=1 if (argument_count>=5) alpha=argument[4]
taggable=1 if (argument_count>=6) taggable=argument[5]
uselower=0 if (argument_count>=7) uselower=argument[6]
cus_spr=spr_omifont if (argument_count>=8) cus_spr=argument[7]

if !uselower //legacy
str=string_upper(string(argument[2]))

l=string_length(str)

maxx=0
maxy=0
s=global.tscale

line=0
lw[999]=0
lh=8*s
cmd[0,0]=0

j=1 tag=0
for (i=1;i<=l;i+=1) {
    ch=string_char_at(str,i)

    //tag system
    if (taggable) {
        if (tag) {
            if (ch="}") {
                tag=0
                //tag commands
                if (string_pos("c=",tagstr)=1) {cmd[j,0]=1 cmd[j,1]=deciphercolor(string_delete(tagstr,1,2))}
                if (string_pos("a=",tagstr)=1) {cmd[j,0]=2 cmd[j,1]=unreal(string_delete(tagstr,1,2))}
                //if (string_pos("s=",tagstr)=1) {cmd[j,0]=3 cmd[j,1]=unreal(string_delete(tagstr,1,2))}
                arr[j]=13 j+=1 i+=1
                continue
            } else {tagstr+=ch i+=1 continue}
        }
        if (ch="$") if (string_char_at(str,i+1)="{") {tag=1 i+=2 tagstr="" continue} else if (string_char_at(str,i+1)="|") {cmd[j,0]=1 cmd[j,1]=col i+=2 arr[j]=13 j+=1 continue}
    }

    c=string_pos(ch,global.omimap) //have to use a map because the old system like choked and died the moment it was above 127
    if (ch == chr(10)) c=10
    arr[j]=c j+=1 cmd[j,0]=0

    if (c=13) continue
    if (taggable) && (c=35 || c=10) {if (i=l) break lh+=6*s i+=1 line+=1 continue}
    lw[line]+=4*s
    maxx=max(maxx,lw[line])
}
maxy=lh

if (global.tcalc) exit

l=j-1
line=0
if (global.halign=1) dx-=floor(lw[line]/2)
if (global.halign=2) dx-=lw[line]
if (global.valign=1) dy-=floor(lh/2)
if (global.valign=2) dy-=lh

dcol=col
dalp=alpha
dsca=s
for (i=1;i<=l;i+=1) {
    c=arr[i]
    if (cmd[i,0]=1) dcol=color_mult(cmd[i,1],col)
    if (cmd[i,0]=2) dalp=alpha*cmd[i,1]
    if (cmd[i,0]=3) dsca=s*cmd[i,1]
    if (c=13) {i+=1 continue}
    if (taggable) && (c=35 || c=10) {dy+=6*dsca line+=1 dx=floor(argument[0]) if (global.halign=1) dx-=floor(lw[line]/2) if (global.halign=2) dx-=lw[line] i+=1 continue}
    if (c!=32) draw_sprite_part_ext(cus_spr,0,((c-32) mod 16)*5,((c-32) div 16)*7,5,7,dx-1,dy-1+6*dsca-6*dsca,dsca,dsca,dcol,dalp)
    dx+=4*dsca
}
