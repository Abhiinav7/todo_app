import 'package:flutter/material.dart';
class MyAppbar extends StatelessWidget implements PreferredSizeWidget{
  bool isCenter;
  double elevation;
  Color bgcolor;
  Widget title;
  List<Widget>? actions;

   MyAppbar({
     super.key,
     required this.isCenter,
     required this.elevation,
     required this.bgcolor,
     required this.title,
     required this.actions
   });
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenter,
      elevation: elevation,
      backgroundColor: bgcolor,
      automaticallyImplyLeading: false,
      title: title,
      actions:actions,

    );
  }


}
