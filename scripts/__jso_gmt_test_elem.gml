{

  if (__jso_gmt_elem(__jso_gmt_tuple("Qblock", "kll"), 0) != "Qblock") {
    show_message("Element retrieval failed for simple string. #Should be:Qblock#Actual:" + __jso_gmt_elem(__jso_gmt_tuple("Qblock"), 0));
  }
  if (__jso_gmt_elem(__jso_gmt_tuple(9, "Q", -7), 0) != 9) {
    show_message("Element retrieval failed for simple number. #Should be 9#Actual:" + string(__jso_gmt_elem(__jso_gmt_tuple(9, "Q", 7), 0)));
  }
  if (__jso_gmt_elem(__jso_gmt_tuple("Qblock", "", "Negg"), 1) != "") {
    show_message("Element retrieval failed for empty string#Should be empty string#Actual:"+string(__jso_gmt_elem(__jso_gmt_tuple("Qblock", "", "Negg"), 0)));
  }

  if (__jso_gmt_elem(__jso_gmt_elem(__jso_gmt_tuple("Not this", __jso_gmt_tuple(0, 1, 2, 3), "Waahoo"), 1), 3) != 3) {
    show_message("Element retrieval failed in nested tuple. #Should be 3#Actual:" + string(__jso_gmt_elem(__jso_gmt_elem(__jso_gmt_tuple("Not this", __jso_gmt_tuple(0, 1, 2, 3), "Waahoo"), 1), 3)));
  }

}
