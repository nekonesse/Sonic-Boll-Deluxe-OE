if (global.debug) {
    updateeverything+=1
    if (updateeverything == 15) {
        if updateeverything {
            with (all) {
                if (object_index != lightbulb) {if keyboard_check(ord("J")) show_message(object_get_name(object_index)+lf+string(object_index)) visible=1}
                else visible=0
            }
        }
        updateeverything = 0
    }
    if (keyboard_check_pressed(ord("0"))) global.epic_speed_mode = !global.epic_speed_mode
    if (keyboard_check_pressed(vk_add)) with (player) size+=1
    if (keyboard_check_pressed(vk_subtract)) with (player) size=max(0,size-1)
}

frames+=1
if (frames>=15) {
    global.pfps=mean(global.pfps,((frames*1000000)/max(1,external_call(global.dll_deltaTime))))
    graph[graphi]=round(global.pfps)
    graphi=(graphi+1) mod 400
    frames=0
}

if ((global.tasing || (global.lemontest && settings("lemontasing"))) || global.debug) {
    global.spd=median(5,global.spd+5*((mouse_wheel_up() + keyboard_check_pressed(vk_pageup))-(mouse_wheel_down() + keyboard_check_pressed(vk_pagedown))),60+140*global.debug)
}

if (!fadekill) {
    room_speed=global.spd
    errorstate=error_occurred
    if (error_occurred) {error_occurred=0 crashloghandler() if (!string_pos("non-existing surface",error_last) || global.gamemaker) error(error_last)}
}
