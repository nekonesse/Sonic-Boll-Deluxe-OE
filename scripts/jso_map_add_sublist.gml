///jso_map_add_sublist(map, key, sublist)
{
    /**
    jso_map_add_sublist(map, key, sublist): Add the key-value pair <key>:<sublist> to <map>, where <sublist> is a list.
    */
    ds_map_add(argument0, argument1, "l" + string(argument2));
}
