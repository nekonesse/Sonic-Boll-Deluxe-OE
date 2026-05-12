#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

toolname[0]="Draw (D)#Shift: move/properties#Ctrl: pick"
toolname[1]="Select (S)#Ctrl+Shift+C/V: copy#using the clipboard"
toolname[2]="Fill (F)#Left click: Flood Fill#Drag to fill rectangle"
toolname[3]="Boundary Tool (E)#Left click: Mark screen as forbidden#Right click: Mark screen as secret#Click again to remove boundary"
toolname[4]="Thumbnail Tool"
toolname[7]="Reference Graphic Tool (R)#Left click: move#Right click: load/unload"
toolname[9]="Spawn Point (W)#Left click: Player Spawn#Right click: Testing Spawn"
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sound("lemonselecttool")
editcursor.tool=tool
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(spr_editorbuttonshadow,0,x,y,1,1,0,c_black,0.5)
draw_sprite(spr_editorbutton,(editcursor.tool=tool)*2,x,y)
draw_sprite_ext(spr_editortools,tool,x+8,y+8,1,1,0,c_black,0.5)
draw_sprite(spr_editortools,tool,x+7,y+7)

if (over) drawtooltip((bbox_left+bbox_right)/2,97,toolname[tool],1)
