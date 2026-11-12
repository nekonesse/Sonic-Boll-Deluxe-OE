{

  /**
  tuple(>element_0<, >element_1<, ..., >element_n<): Return an n-tuple
  @author: GameGeisha
  @version: 1.2
  */

  //Position, address table and data
  var pos, addr_table, data;
  pos = 6*argument_count+4;
  addr_table = "";
  data = "";

  //Build the tuple element-by-element
  var i, ca, isstr, datastr;
  for (i=0; i<argument_count; i+=1) {
    //Check the argument's type
    ca = argument[i];
    isstr = is_string(ca);
    if (isstr) { //Save strings as-is
      datastr = ca;
    }
    else { //Save reals in scientific notation, 15 significant digits
      datastr = __jso_gmt_numtostr(ca);
    }
    //Add entry in address table and data
    addr_table += chr(isstr+$30)
    addr_table += string_format(pos, 5, 0);
    pos += string_length(datastr);
    data += datastr;
  }
  
  //Return the tuple, with size header character, address table and data
  return string_format(argument_count, 3, 0)+addr_table+data;
  
}
