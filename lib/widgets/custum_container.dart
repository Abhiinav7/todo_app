import 'package:flutter/material.dart';
class MyContainer extends StatelessWidget {

  Widget child;
   MyContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(left: 10),
      height: 62,
     child: child,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(8),
       border: Border.all(color: Colors.white,width: 2),

     ),
    );
  }
}
