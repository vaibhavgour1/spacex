
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makeb/utility/color.dart';


class Utility {

  static showToast({required String msg}) async {
    msg.isEmpty
        ? ""
        : Fluttertoast.showToast(
        msg: msg, textColor: Colors.white, backgroundColor: colorPrimary, gravity: ToastGravity.BOTTOM,fontSize:14);
  }


}
