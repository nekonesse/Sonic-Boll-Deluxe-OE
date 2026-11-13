///lemon_scaleable(container):container / noone
//determines if you're allowed to scale a container by checking every single valid object seperately because idk a better way to do this

var a; a = argument[0]
var obj;

if is_undefined(a) return noone;

if is_real(a.obj) {
    obj=object_get_name(a.obj);
} else {
    obj=a.obj;
}

if (keyboard_check(vk_insert)) return a;

switch(obj) {
    case "groundblock":
    case "hardblock":
    case "waterblock":
    case "ground":
    case "bridgetile":
    case "mushblock":
    case "brick":
    case "bigbrick":
    case "groundsemi":
    case "bighardblock":
    case "lavablock":
    case "barrier":
    case "treeblock":
    case "mushblock2":
    case "itembox":
    case "crate":
    case "groundback":
    case "castleceiling":
    case "cloudtile":
    case "phaser":
    case "spike":
    case "sonicspike":
    case "mushblock3":
    case "bigitembox":
    case "crackedground":
        return a;
    break;   
}

return noone;
