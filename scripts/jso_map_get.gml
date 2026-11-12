///jso_map_get(map, key)
{
    /**
    jso_map_get(map, key): Retrieve the value stored in <map> with the key value <key>, with the correct type.
    */

    //Grab the value
    var v;
    v = ds_map_find_value(argument0, argument1);

    //String; could be string, map or list
    if (is_string(v)) {
        switch (string_char_at(v, 1)) {
            case "s":
                return string_delete(v, 1, 1);
            break;
            case "l": case "m":
                return real(string_delete(v, 1, 1));
            break;
            case "b":
                if (v == "btrue") {
                    return true;
                }
                else if (v == "bfalse") {
                    return false;
                }
                else {
                    show_error("Invalid boolean value.", true);
                }
            break;
            case "n":
                if (v == "nnull") {
                    return jso_value_of_null;
                }
                else {
                    show_error("Invalid null value.", true);
                }
            break;
            default: show_error("Invalid map contents.", true); break;
        }
    }

    //Real; return real value as-is
    else {
        return v;
    }
}
