///jso_compare_lists(list1, list2)
{
    /**
    jso_compare_lists(list1, list2): Return whether the contents of JSOnion-compatible lists <list1> and <list2> are the same.
    */

    //If they aren't the same size, they can't be the same
    var size;
    size = ds_list_size(argument0);
    if (size != ds_list_size(argument1)) {
        return false;
    }

    //Compare contents pairwise
    var i, type, a, b;
    for (i=0; i<size; i+=1) {
        //Check type
        type = jso_list_get_type(argument0, i);
        if (jso_list_get_type(argument1, i) != type) {
            return false;
        }
        //Check content
        a = jso_list_get(argument0, i);
        b = jso_list_get(argument1, i);
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
    }

    //No mismatches, return true
    return true;
}
