{
    /**
    _jso_lookup_kernel(jso_ds, jso_type, task_type, ds_args_list): Kernel of the check and lookup functions.
    - jso_ds: The JSOnion-compatible data structure handle.
    - jso_type: The type of the JSOnion-compatible (jso_type_list or jso_type_map)
    - task_type: 0=check, 1=lookup, 2=lookup type
    - ds_args_list: ds_list of arguments passed in.

    PLEASE DO NOT CALL DIRECTLY --- use regular jso_*() functions.
    */

    var i, k, data, type, type_string, task_type, keys_size, ds_args_list;
    data = argument0;
    type = argument1;
    if (type == jso_type_map) {
        type_string = "map";
    } else {
        type_string = "list";
    }
    task_type = argument2;
    ds_args_list = argument3;
    keys_size = ds_list_size(ds_args_list);

    //Iteratively go through arguments in ds_args_list
    for (i=0; i<keys_size; i+=1) {
        k = ds_list_find_value(argument3, i);
        switch (type) {
            //Check for existence of the key in the current map
            case jso_type_map:
                if (!ds_map_exists(data, k)) {
                    switch (task_type) {
                        case 0:
                            return false;
                        break;
                        default:
                            show_error("Cannot find value in " + type_string + " lookup.", true);
                        break;
                    }
                }
                type = jso_map_get_type(data, k);
                data = jso_map_get(data, k);
            break;
            //Check for existence of the index in the current list
            case jso_type_list:
                if (is_string(k)) {
                    switch (task_type) {
                        case 0:
                            return false;
                        break;
                        default:
                            show_error("Cannot use string indices for nested lists in " + type_string + " lookup.", true);
                        break;
                    }
                }
                if (k >= ds_list_size(data)) {
                    switch (task_type) {
                        case 0:
                            return false;
                        break;
                        default:
                            show_error("Index overflow for nested lists in " + type_string + " lookup.", true);
                        break;
                    }
                }
                type = jso_list_get_type(data, k);
                data = jso_list_get(data, k);
            break;
            //Trying to go through a leaf; don't attempt to look further
            default:
                switch (task_type) {
                    case 0:
                        return false;
                    break;
                    default:
                        show_error("Recursive overflow in " + type_string + " lookup.", true);
                    break;
                }
            break;
        }
    }
    
    //Can find something, return the value requested by the task
    switch (task_type) {
        case 0:
            return true;
        break;
        case 1:
            return data;
        break;
        case 2:
            return type;
        break;
    }
}
