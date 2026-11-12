{

  if (__jso_gmt_size(__jso_gmt_tuple("Waahoo", "Negg", 0)) != 3) {
    show_message("Bad size for 3-tuple");
  }
  if (__jso_gmt_size(__jso_gmt_tuple()) != 0) {
    show_message("Bad size for null tuple");
  }
  if (__jso_gmt_size(__jso_gmt_tuple(7)) != 1) {
    show_message("Bad size for 1-tuple");
  }
  if (__jso_gmt_size(__jso_gmt_tuple(1,2,3,4,5,6,7,8,9,10)) != 10) {
    show_message("Bad size for 10-tuple");
  }

}
