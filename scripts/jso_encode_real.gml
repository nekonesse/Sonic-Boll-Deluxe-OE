///jso_encode_real(real)
{
    /**
    jso_encode_real(<real>): Return a JSON-encoded version of real value <real>.
    This uses scientific notation with up to 15 significant digits for decimal values.
    For integers, it just uses string().
    This is adapted from the same algorithm used in GMTuple.
    */

    return __jso_gmt_numtostr(argument0);
}
