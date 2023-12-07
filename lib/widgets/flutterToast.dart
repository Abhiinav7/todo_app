import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastWidget extends StatelessWidget {
  String msg;
  Color bgcolor;
  double fontSize;
  Color textcolor;

  ToastWidget({
    required this.fontSize,
    required this.bgcolor,
    required this.textcolor,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgcolor,
      textColor: textcolor,
      fontSize: fontSize,
    );

    return Container();
  }
}
