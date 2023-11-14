import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  addTaskToFirebase() async {
    try{
      FirebaseAuth auth = FirebaseAuth.instance;
      final user = await auth.currentUser!;
      //final user=await FirebaseAuth.instance.currentUser;
      String userId = user.uid;
      var time = DateTime.now();
      await FirebaseFirestore.instance
          .collection("tasks")
          .doc(userId)
          .collection("mytasks")
          .doc(time.toString())
          .set({
        "title": titlecontroller.text,
        "description": textEditingController.text,
        "time": time.toString(),
        "timestamp":time
      });
      Fluttertoast.showToast(msg: "task saved");
    }
    catch(error){
      print("//////////////////error=${error}//////////////////////");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Task"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: Colors.purple, fontSize: 17),
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "What to do !",
                hintStyle: TextStyle(color: Colors.purple, fontSize: 17),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    addTaskToFirebase();
                  },
                  child: Text(
                    "Add task",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
