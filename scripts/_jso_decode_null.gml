{
    /**
    _jso_decode_null(json, startindex): Extract a null from JSON string <json> starting at position <startindex>.
    Return a 2-tuple of the extracted null and the position after the last l.
    */
    var i, len, str;
    i = argument1;
    len = string_length(argument0);

    //Seek to first n that can be found
    var c;
    c = string_char_at(argument0, i);
    if (c != "n") {
        do {
            i += 1;
            c = string_char_at(argument0, i);
            if (!_jso_is_whitespace_char(c)) && (c != "n") {
                show_error("Cannot parse null value at position " + string(i), true);
            }
        } until (c == "n")
    }

    //Look for null if n is found
    if (c == "n") && (string_copy(argument0, i, 4) == "null") {
        return __jso_gmt_tuple(jso_value_of_null, i+4);
    }
    //Error: unexpected ending
    else {
        show_error("Unexpected end of null in JSON string.", true);
    }
}
