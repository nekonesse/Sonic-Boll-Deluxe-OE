{

  /**
  __gmt_numtostr(num): Return string representation of <num>. Decimal numbers expressed as scientific notation
  with double precision (i.e. 15 digits)
  @author: GameGeisha
  @version: 1.2 (edited)
  */
  if (frac(argument0) == 0) {
    return string(argument0);
  }

    var mantissa, exponent;
    exponent = floor(log10(abs(argument0)));
    mantissa = string_format(argument0/power(10,exponent), 15, 14);
    var i, ca;
    i = string_length(mantissa);
    do {
      ca = string_char_at(mantissa, i);
      i -= 1;
    } until (ca != "0")
    if (ca != ".") {
        mantissa = string_copy(mantissa, 1, i+1);
    }
    else {
        mantissa = string_copy(mantissa, 1, i);
    }
    if (exponent != 0) {
      return mantissa + "e" + string(exponent);
    }
    else {
      return mantissa;
    }

}
