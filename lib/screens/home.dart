import 'package:flutter/material.dart';
import 'package:todo_app/screens/task_add.dart';
class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("ToDo"),
      ),
      body:Container(),
      floatingActionButton: FloatingActionButton.large(
        child: Icon(Icons.add),
          onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(),));
          }),
    );
  }
}
