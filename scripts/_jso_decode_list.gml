{
    /**
    _jso_decode_list(json, startindex): Extract a list from JSON string <json> starting at position <startindex>.
    Return a 2-tuple of the extracted list handle and the position after the ending ].
    */
    var i, len, list;
    i = argument1;
    len = string_length(argument0);
    list = jso_new_list();

    //Seek to first [
    var c;
    c = string_char_at(argument0, i);
    if (c != "[") {
        do {
            i += 1;
            c = string_char_at(argument0, i);
            if (!_jso_is_whitespace_char(c)) && (c != "[") {
                show_error("Cannot parse list at position " + string(i), true);
            }
        } until (c == "[")
    }
    i += 1;

    //Read until end of JSON or ending ]
    var found_end, state, found;
    found_end = false;
    state = 0;
    for (i=i; i<=len && !found_end; i+=1) {
        c = string_char_at(argument0, i);
        switch (state) {
            //0: Looking for an item
            case 0:
                switch (c) {
                    case "]":
                        found_end = true;
                    break;
                    case "[":
                        found = _jso_decode_list(argument0, i);
                        jso_list_add_sublist(list, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 1;
                    break;
                    case "{":
                        found = _jso_decode_map(argument0, i);
                        jso_list_add_submap(list, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 1;
                    break;
                    case '"':
                        found = _jso_decode_string(argument0, i);
                        jso_list_add_string(list, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 1;
                    break;
                    case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9": case "+": case "-":
                        found = _jso_decode_real(argument0, i);
                        jso_list_add_real(list, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 1;
                    break;
                    case "t": case "f":
                        found = _jso_decode_boolean(argument0, i);
                        jso_list_add_boolean(list, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 1;
                    break;
                    case "n":
                        found = _jso_decode_null(argument0, i);
                        jso_list_add_null(list);
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 1;
                    break;
                    default:
                        if (!_jso_is_whitespace_char(c)) {
                            show_error("Unexpected character at position " + string(i) + ".", true);
                        }
                    break;
                }
            break;
            //1: Done looking for an item, want comma or ]
            case 1:
                switch (c) {
                    case "]":
                        found_end = true;
                    break;
                    case ",":
                        state = 0;
                    break;
                    default:
                        if (!_jso_is_whitespace_char(c)) {
                            show_error("Unexpected character at position " + string(i) + ".", true);
                        }
                    break;
                }
            break;
        }
    }

    //Return extracted list with ending position if the ending ] is found
    if (found_end) {
        return __jso_gmt_tuple(list, i);
    }
    //Ended too early, throw error
    else {
        show_error("Unexpected end of list in JSON string.", true);
    }
}
