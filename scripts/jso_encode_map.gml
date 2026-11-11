///jso_encode_map(map)
{
    /**
    jso_encode_map(map): Return a JSON-encoded version of map <map>.
    */

    //Go through every key-value pair
    var i, l, k, s;
    s = "";
    l = ds_map_size(argument0);
    k = ds_map_find_first(argument0);
    for (i=0; i<l; i+=1) {
        //Prefix , if there is preceding item
        if (i > 0) {
            s += ",";
        }
        //Find the key and encode it
        if (is_real(k)) {
            s += jso_encode_real(k);
        } else {
            s += jso_encode_string(k);
        }
        //Add the : separator
        s += ":";
        //Select correct encoding for each value, then recursively encode each
        switch (jso_map_get_type(argument0, k)) {
            case jso_type_real:
                s += jso_encode_real(jso_map_get(argument0, k));
            break;
            case jso_type_string:
                s += jso_encode_string(jso_map_get(argument0, k));
            break;
            case jso_type_map:
                s += jso_encode_map(jso_map_get(argument0, k));
            break;
            case jso_type_list:
                s += jso_encode_list(jso_map_get(argument0, k));
            break;
            case jso_type_boolean:
                s += jso_encode_boolean(jso_map_get(argument0, k));
            break;
            case jso_type_null:
                s += jso_encode_null();
            break;
        }
        //Get next key
        k = ds_map_find_next(argument0, k);
    }

    //Done, add braces
    return "{" + s + "}";
}
