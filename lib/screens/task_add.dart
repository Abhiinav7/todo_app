import 'package:flutter/material.dart';
import 'package:todo_app/services/database_services.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController description = TextEditingController();
  FirebaseServices services = FirebaseServices();

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
              controller: description,
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
                    if (titlecontroller.text.isNotEmpty &&
                        description.text.isNotEmpty) {
                      services.addTaskToFirebase(
                          titlecontroller.text, description.text);
                      Navigator.pop(context);
                    }
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
