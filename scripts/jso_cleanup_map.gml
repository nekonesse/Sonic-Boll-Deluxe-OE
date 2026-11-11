///jso_cleanup_map(map)
{
    /**
    jso_cleanup_map(map): Recursively free up <map>.
    */

    //Loop through all keys
    var i, l, k;
    l = ds_map_size(argument0);
    k = ds_map_find_first(argument0);
    for (i=0; i<l; i+=1) {

        //Look for values that need to be recursed
        switch (jso_map_get_type(argument0, k)) {
            //Maps
            case jso_type_map:
                jso_cleanup_map(jso_map_get(argument0, k));
            break;
            //Lists
            case jso_type_list:
                jso_cleanup_list(jso_map_get(argument0, k));
            break;
        }

        //Find next key
        k = ds_map_find_next(argument0, k);
    }

    //Done, clean up
    ds_map_destroy(argument0);
}
