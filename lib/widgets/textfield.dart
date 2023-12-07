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
      obscureText:obscuretext ,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          hintText: hintext,
          hintStyle: GoogleFonts.roboto(color: Colors.white, fontSize: 18),
          border: InputBorder.none
          // enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(8),
          //     borderSide: BorderSide(color: Colors.white, width: 2)),
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(10),
          //     borderSide: BorderSide(color: Colors.white, width: 2)),
            )
    );
  }
}
