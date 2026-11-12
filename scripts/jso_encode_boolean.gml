///jso_encode_boolean(bool)
{
    /**
    jso_encode_boolean(bool): Return a JSON-encoded version of the boolean value <bool>.
    */
    if (argument0) {
        return "true";
    } else {
        return "false";
    }
}
