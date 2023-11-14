import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  String title, description;

  DescriptionView({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Description"),
      ),
      body: Container(
        color: Colors.purple,
        height: double.infinity,
        width: double.infinity,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 10, left: 7, right: 7, bottom: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.purple,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 5),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
              ),
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.purple,
              ),
              Container(
                margin: EdgeInsets.all(12),
                child: Text(
                  "~${description}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
