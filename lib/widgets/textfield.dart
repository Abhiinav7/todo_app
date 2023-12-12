import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield extends StatelessWidget {
  TextInputType keyboardType;
  TextEditingController controller;
  String? Function(String?)? validator;
  String hintext;
  bool obscuretext;

  MyTextfield({
    super.key,
    required this.keyboardType,
    required this.controller,
    required this.validator,
    required this.hintext,
    required this.obscuretext,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      obscureText:obscuretext ,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(

          hintText: hintext,
          hintStyle: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
          border: InputBorder.none
            )
    );
  }
}
