///jso_clone_map(map)
{
    /**
    jso_clone_map(map): Return a deep copy of JSOnion-compatible map <map>.
    JSOnion version: 1.1.0
    */

    //Create a new map
    var clone;
    clone = jso_new_map();

    //Copy over content
    var k, size;
    k = ds_map_find_first(argument0);
    size = ds_map_size(argument0);
    repeat (size) {
        switch (jso_map_get_type(argument0, k)) {
            case jso_type_map:
                jso_map_add_submap(clone, k, jso_clone_map(jso_map_get(argument0, k)));
            break;
            case jso_type_list:
                jso_map_add_sublist(clone, k, jso_clone_list(jso_map_get(argument0, k)));
            break;
            default:
                ds_map_add(clone, k, ds_map_find_value(argument0, k));
            break;
        }
        k = ds_map_find_next(argument0, k);
    }

    //Done
    return clone;
}
