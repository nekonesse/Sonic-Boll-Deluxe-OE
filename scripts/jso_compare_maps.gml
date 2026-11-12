///jso_compare_maps(map1, map2)
{
    /**
    jso_compare_maps(map1, map2): Return whether the contents of JSOnion-compatible maps <map1> and <map2> are the same.
    */

    //If they aren't the same size, they can't be the same
    var size;
    size = ds_map_size(argument0);
    if (size != ds_map_size(argument1)) {
        return false;
    }

    //Compare contents pairwise
    var i, k, type, a, b;
    k = ds_map_find_first(argument0);
    for (i=0; i<size; i+=1) {
        //Check that key exists on both sides
        if (!ds_map_exists(argument1, k)) {
            return false;
        }
        //Check type
        type = jso_map_get_type(argument0, k);
        if (jso_map_get_type(argument1, k) != type) {
            return false;
        }
        //Check content
        a = jso_map_get(argument0, k);
        b = jso_map_get(argument1, k);
        switch (type) {
            case jso_type_map:
                if (!jso_compare_maps(a, b)) {
                    return false;
                }
            break;
            case jso_type_list:
                if (!jso_compare_lists(a, b)) {
                    return false;
                }
            break;
            default:
                if (a != b) {
                    return false;
                }
            break;
        }
        //Advance to next key
        k = ds_map_find_next(argument0, k);
    }

    //No mismatches, return true
    return true;
}
