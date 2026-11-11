{

  /**
  elem(tuple_source, n): Return the <n>th element of <tuple_source>
  @author: GameGeisha
  @version: 1.2
  */

  //Capture arguments
  var t, n, size;
  t = argument0;
  n = argument1;
  size = __jso_gmt_size(t);

  //Search for the bounding positions for the <n>th element in the address table
  var start, afterend, isstr;
  isstr = ord(string_char_at(t, 4+6*n))-$30;
  start = real(string_copy(t, 5+6*n, 5));
  if (n < size-1) {
    afterend = real(string_copy(t, 11+6*n, 5));
  } else {
    afterend = string_length(t)+1;
  }

  //Return the <n>th element with the correct type
  if (isstr) {
    return string_copy(t, start, afterend-start);
  }
  else {
    return real(string_copy(t, start, afterend-start));
  }

}
