///jso_clone_list(list)
{
    /**
    jso_clone_list(list): Return a deep copy of JSOnion-compatible list <list>.
    JSOnion version: 1.1.0
    */

    //Create a new list
    var clone;
    clone = jso_new_list();

    //Copy over content
    var i, size;
    size = ds_list_size(argument0);
    for (i=0; i<size; i+=1) {
        switch (jso_list_get_type(argument0, i)) {
            case jso_type_map:
                jso_list_add_submap(clone, jso_clone_map(jso_list_get(argument0, i)));
            break;
            case jso_type_list:
                jso_list_add_sublist(clone, jso_clone_list(jso_list_get(argument0, i)));
            break;
            default:
                ds_list_add(clone, ds_list_find_value(argument0, i));
            break;
        }
    }

    //Done
    return clone;
}
