{
    /**
    _jso_decode_real(json, startindex): Extract a real value from JSON string <json> starting at position <startindex>.
    Return a 2-tuple of the extracted real value and the position after the real value.
    */
    var i, len, str;
    i = argument1;
    len = string_length(argument0);
    str = "";

    //Seek to first character: +, -, or 0-9
    var c;
    c = string_char_at(argument0, i);
    if (string_pos(c, "0123456789+-") == 0) {
        do {
            i += 1;
            c = string_char_at(argument0, i);
            if (!_jso_is_whitespace_char(c)) && (string_pos(c, "0123456789+-") == 0) {
                show_error("Cannot parse real value at position " + string(i), true);
            }
        } until (string_pos(c, "0123456789+-") > 0)
    }

    //Determine starting state
    var state;
    switch (c) {
        case "+": case "-":
            state = 0;
        break;
        default:
            state = 1;
        break;
    }
    str += c;
    i += 1;

    //Loop until no more digits found
    var done;
    done = false;
    for (i=i; i<=len && !done; i+=1) {
        c = string_char_at(argument0, i);
        switch (state) {
            //0: Found a sign, looking for a starting number
            case 0:
                switch (c) {
                    case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9":
                        str += c;
                        state = 1;
                    break;
                    default:
                        show_error("Unexpected character at position " + string(i) + ", expecting a digit.", true);
                    break;
                }
            break;
            //1: Found a starting digit, looking for decimal dot, e, E, or more digits
            case 1:
                if (_jso_is_whitespace_char(c)) || (string_pos(c, ":,]}") > 0) {
                    done = true;
                    i -= 1;
                } else {
                    switch (c) {
                        case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9":
                            str += c;
                        break;
                        case ".":
                            str += c;
                            state = 2;
                        break;
                        case "e": case "E":
                            str += c;
                            state = 3;
                        break;
                        default:
                            show_error("Unexpected character at position " + string(i) + ", expecting a dot, e, E or a digit.", true);
                        break;
                    }
                }
            break;
            //2: Found a decimal dot, looking for more digits
            case 2:
                switch (c) {
                    case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9":
                        str += c;
                        state = -2;
                    break;
                    default:
                        show_error("Unexpected character at position " + string(i) + ", expecting a digit.", true);
                    break;
                }
            break;
            //-2: Found a decimal dot and a digit after it, looking for more digits, e, or E
            case -2:
                if (_jso_is_whitespace_char(c)) || (string_pos(c, ":,]}") > 0) {
                    done = true;
                    i -= 1;
                } else {
                    switch (c) {
                        case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9":
                            str += c;
                        break;
                        case "e": case "E":
                            str += c;
                            state = 3;
                        break;
                        default:
                            show_error("Unexpected character at position " + string(i) + ", expecting an e, E or a digit.", true);
                        break;
                    }
                }
            break;
            //3: Found an e/E, looking for +, - or more digits
            case 3:
                switch (c) {
                    case "+": case "-":
                        str += c;
                        state = 4;
                    break;
                    case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9":
                        str += c;
                        state = 5;
                    break;
                    default:
                        show_error("Unexpected character at position " + string(i) + ", expecting a +, - or a digit.", true);
                    break;
                }
            break;
            //4: Found an e/E exponent sign, looking for more digits
            case 4:
                switch (c) {
                    case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9":
                        str += c;
                        state = 5;
                    break;
                    default:
                        show_error("Unexpected character at position " + string(i) + ", expecting a digit.", true);
                    break;
                }
            break;
            //5: Looking for final digits of the exponent
            case 5:
                if (_jso_is_whitespace_char(c)) || (string_pos(c, ":,]}") > 0) {
                    done = true;
                    i -= 1;
                } else {
                    switch (c) {
                        case "0": case "1": case "2": case "3": case "4": case "5": case "6": case "7": case "8": case "9":
                            str += c;
                            state = 5;
                        break;
                        default:
                            show_error("Unexpected character at position " + string(i) + ", expecting a digit.", true);
                        break;
                    }
                }
            break;
        }
    }

    //Am I still expecting more characters?
    if (done) || (state == 1) || (state == -2) || (state == 5) {
        return __jso_gmt_tuple(real(str), i);
    }
    //Error: unexpected ending
    else {
        show_error("Unexpected end of real in JSON string.", true);
    }
}
