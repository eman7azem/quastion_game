import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(dynamic message, {bool error = false}) {
  Color backgroundColor = Colors.green;

  if(error){
    backgroundColor = Colors.red;
  }

  if (message is String) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else if (message is List) {
    String messageString = message.join(", ");
    Fluttertoast.showToast(
      msg: messageString,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,

    );
  }
}
