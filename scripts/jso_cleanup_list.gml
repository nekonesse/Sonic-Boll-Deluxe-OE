///jso_cleanup_list(list)
{
    /**
    jso_cleanup_list(list): Recursively free up <list>.
    */

    //Loop through all elements
    var i, l, v;
    l = ds_list_size(argument0);
    for (i=0; i<l; i+=1) {
        //Look for elements that need to be recursed
        switch (jso_list_get_type(argument0, i)) {
            //Maps
            case jso_type_map:
                jso_cleanup_map(jso_list_get(argument0, i));
            break;
            //Lists
            case jso_type_list:
                jso_cleanup_list(jso_list_get(argument0, i));
            break;
        }
    }

    //Done, clean up
    ds_list_destroy(argument0);
}
