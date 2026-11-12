{
    /**
    _jso_decode_boolean(json, startindex): Extract a boolean from JSON string <json> starting at position <startindex>.
    Return a 2-tuple of the extracted boolean and the position after the last e.
    */
    var i, len, str;
    i = argument1;
    len = string_length(argument0);

    //Seek to first t or f that can be found
    var c;
    c = string_char_at(argument0, i);
    if (c != "t") && (c != "f") {
        do {
            i += 1;
            c = string_char_at(argument0, i);
            if (!_jso_is_whitespace_char(c)) && (c != "t") && (c != "f") {
                show_error("Cannot parse boolean value at position " + string(i), true);
            }
        } until (c == "t") || (c == "f")
    }

    //Look for true if t is found
    if (c == "t") && (string_copy(argument0, i, 4) == "true") {
        return __jso_gmt_tuple(true, i+4);
    }
    //Look for false if f is found
    else if (c == "f") && (string_copy(argument0, i, 5) == "false") {
        return __jso_gmt_tuple(false, i+5);
    }
    //Error: unexpected ending
    else {
        show_error("Unexpected end of boolean in JSON string.", true);
    }
}
