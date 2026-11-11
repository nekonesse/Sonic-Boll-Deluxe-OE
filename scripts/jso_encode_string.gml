///jso_encode_string(str)
{
    /**
    jso_encode_string(str): Return a JSON-encoded version of string <str>.
    */

    //Iteratively reconstruct the string
    var i, l, s, c;
    s = "";
    l = string_length(argument0);
    for (i=1; i<=l; i+=1) {
        //Replace escape characters
        c = string_char_at(argument0, i);
        switch (ord(c)) {
            case 34: case 92: case 47: //Double quotes, backslashes and slashes
                s += "\" + c;
            break;
            case 8: //Backspace
                s += "\b";
            break;
            case 12: //Form feed
                s += "\f";
            break;
            case 10: //New line
                s += "\n";
            break;
            case 13: //Carriage return
                s += "\r";
            break;
            case 9: //Horizontal tab
                s += "\t";
            break;
            default: //Not an escape character
                s += c;
            break;
        }
    }

    //Add quotes
    return '"' + s + '"';
}
