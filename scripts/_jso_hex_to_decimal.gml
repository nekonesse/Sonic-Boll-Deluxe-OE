{
    /**
    _jso_hex_to_decimal(hex_string): Return the decimal value of the hex number represented by <hex_string>
    */
    var hex_string, hex_digits;
    hex_string = string_lower(argument0);
    hex_digits = "0123456789abcdef";

    //Convert digit-by-digit
    var i, len, digit_value, num;
    len = string_length(hex_string);
    num = 0;
    for (i=1; i<=len; i+=1) {
        digit_value = string_pos(string_char_at(hex_string, i), hex_digits)-1;
        if (digit_value >= 0) {
            num *= 16;
            num += digit_value;
        }
        //Unknown character
        else {
            show_error("Invalid hex number: " + argument0, true);
        }
    }
    return num;
}
