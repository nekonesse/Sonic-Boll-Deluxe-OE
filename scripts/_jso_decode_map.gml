{
    /**
    _jso_decode_map(json, startindex): Extract a map from JSON string <json> starting at position <startindex>.
    Return a 2-tuple of the extracted map handle and the position after the ending }.
    */
    var i, len, map;
    i = argument1;
    len = string_length(argument0);
    map = jso_new_map();

    //Seek to first {
    var c;
    c = string_char_at(argument0, i);
    if (c != "{") {
        do {
            i += 1;
            c = string_char_at(argument0, i);
            if (!_jso_is_whitespace_char(c)) && (c != "{") {
                show_error("Cannot parse map at position " + string(i), true);
            }
        } until (c == "{")
    }
    i += 1;

    //Read until end of JSON or ending }
    var found_end, state, found, current_key;
    found_end = false;
    state = 0;
    for (i=i; i<=len && !found_end; i+=1) {
        c = string_char_at(argument0, i);
        switch (state) {
            //0: Looking for a key or closing }
            case 0:
                switch (c) {
                    case "}":
                        found_end = true;
                    break;
                    case '"':
                        found = _jso_decode_string(argument0, i);
                        current_key = __jso_gmt_elem(found, 0);
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 1;
                    break;
                    case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9": case "+": case "-":
                        found = _jso_decode_real(argument0, i);
                        current_key = __jso_gmt_elem(found, 0);
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
            //1: Looking for the : separator
            case 1:
                switch (c) {
                    case ":":
                        state = 2;
                    break;
                    default:
                        if (!_jso_is_whitespace_char(c)) {
                            show_error("Unexpected character at position " + string(i) + ".", true);
                        }
                    break;
                }
            break;
            //2: Looking for a value
            case 2:
                switch (c) {
                    case "[":
                        found = _jso_decode_list(argument0, i);
                        jso_map_add_sublist(map, current_key, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 3;
                    break;
                    case "{":
                        found = _jso_decode_map(argument0, i);
                        jso_map_add_submap(map, current_key, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 3;
                    break;
                    case '"':
                        found = _jso_decode_string(argument0, i);
                        jso_map_add_string(map, current_key, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 3;
                    break;
                    case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9": case "+": case "-":
                        found = _jso_decode_real(argument0, i);
                        jso_map_add_real(map, current_key, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 3;
                    break;
                    case "t": case "f":
                        found = _jso_decode_boolean(argument0, i);
                        jso_map_add_boolean(map, current_key, __jso_gmt_elem(found, 0));
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 3;
                    break;
                    case "n":
                        found = _jso_decode_null(argument0, i);
                        jso_map_add_null(map, current_key);
                        i = __jso_gmt_elem(found, 1)-1;
                        state = 3;
                    break;
                    default:
                        if (!_jso_is_whitespace_char(c)) {
                            show_error("Unexpected character at position " + string(i) + ".", true);
                        }
                    break;
                }
            break;
            //3: Done looking for an entry, want comma or }
            case 3:
                switch (c) {
                    case "}":
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

    //Return extracted map with ending position if the ending } is found
    if (found_end) {
        return __jso_gmt_tuple(map, i);
    }
    //Ended too early, throw error
    else {
        show_error("Unexpected end of map in JSON string.", true);
    }
}
