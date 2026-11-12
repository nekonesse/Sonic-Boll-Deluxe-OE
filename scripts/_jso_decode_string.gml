{
    /**
    _jso_decode_string(json, startindex): Extract a string from JSON string <json> starting at position <startindex>.
    Return a 2-tuple of the extracted string and the position after the ending double quote.
    */
    var i, len, str;
    i = argument1;
    len = string_length(argument0);
    str = "";

    //Seek to first double quote
    var c;
    c = string_char_at(argument0, i);
    if (c != '"') {
        do {
            i += 1;
            c = string_char_at(argument0, i);
        } until (c == '"')
    }
    i += 1;

    //Read until end of JSON or ending double quote
    var found_end, escape_mode;
    found_end = false;
    escape_mode = false;
    for (i=i; i<=len && !found_end; i+=1) {
        c = string_char_at(argument0, i);
        //Escape mode
        if (escape_mode) {
            switch (c) {
                case '"': case "\": case "/":
                    str += c;
                    escape_mode = false;
                break;
                case "b":
                    str += chr(8);
                    escape_mode = false;
                break;
                case "f":
                    str += chr(12);
                    escape_mode = false;
                break;
                case "n":
                    str += chr(10);
                    escape_mode = false;
                break;
                case "r":
                    str += chr(13);
                    escape_mode = false;
                break;
                case "t":
                    str += chr(9);
                    escape_mode = false;
                break;
                case "u":
                    var u;
                    if (len-i < 5) {
                        show_error("Invalid escape character at position " + string(i) + ".", true);
                    } else {
                        str += chr(_jso_hex_to_decimal(string_copy(argument0, i+1, 4)));
                        escape_mode = false;
                        i += 4;
                    }
                break;
                default:
                    show_error("Invalid escape character at position " + string(i) + ".", true);
                break;
            }
        }
        //Regular mode
        else {
            switch (c) {
                case '"': found_end = true; break;
                case "\": escape_mode = true; break;
                default: str += c; break;
            }
        }
    }

    //Return extracted string with ending position if the ending double quote is found
    if (found_end) {
        return __jso_gmt_tuple(str, i);
    }
    //Ended too early, throw error
    else {
        show_error("Unexpected end of string in JSON string.", true);
    }
}
