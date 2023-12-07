import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        color: Colors.deepPurple,
        height: double.infinity,
        width: double.infinity,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 60),
                width: 450,
                height: 80,
                child: Lottie.asset(
                  "assets/todo.json",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      shadows: [
                        Shadow(
                            color: Colors.deepPurpleAccent,
                            blurRadius: 4,
                            offset: Offset(2, 2))
                      ]),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  description,
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
