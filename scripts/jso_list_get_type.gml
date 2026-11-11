///jso_list_get_type(list, index)
{
    /**
    jso_list_get_type(list, index): Retrieve the type of value found at position <index> of <list>.
    */

    //Grab the value
    var v;
    v = ds_list_find_value(argument0, argument1);

    //String; could be string, map or list
    if (is_string(v)) {
        switch (string_char_at(v, 1)) {
            case "s":
                return jso_type_string;
            break;
            case "l":
                return jso_type_list;
            break;
            case "m":
                return jso_type_map;
            break;
            case "b":
                return jso_type_boolean;
            break;
            case "n":
                return jso_type_null;
            break;
            default: show_error("Invalid list content type.", true); break;
        }
    }

    //Real
    else {
        return jso_type_real;
    }
}
