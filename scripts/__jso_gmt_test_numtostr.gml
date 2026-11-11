{

  var tolerance;
  tolerance = 1/10000000000;

  if (real(__jso_gmt_numtostr(9)) != 9) {
    show_message("Scientific notation conversion failed for 1-digit integer! Result: " + __jso_gmt_numtostr(9));
  }
  if (real(__jso_gmt_numtostr(500)) != 500) {
    show_message("Scientific notation conversion failed for 3-digit integer! Result: " + __jso_gmt_numtostr(500));
  }
  if (abs(real(__jso_gmt_numtostr(pi))-pi) > tolerance) {
    show_message("Scientific notation conversion failed for pi! Result: " + __jso_gmt_numtostr(pi));
  }
  if (abs(real(__jso_gmt_numtostr(104729.903455))-104729.903455) > tolerance) {
    show_message("Scientific notation conversion failed for large decimal number! Result: " + __jso_gmt_numtostr(104729.903455));
  }
  if (abs(real(__jso_gmt_numtostr(-pi))+pi) > tolerance) {
    show_message("Scientific notation conversion failed for -pi! Result: " + __jso_gmt_numtostr(-pi));
  }
  if (abs(real(__jso_gmt_numtostr(1/pi))-1/pi) > tolerance) {
    show_message("Scientific notation conversion failed for 1/pi! Result: " + __jso_gmt_numtostr(1/pi));
  }

}
