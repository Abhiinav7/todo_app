import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/task_add.dart';

import 'discriptionView.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  //var time = DateTime.now();

  delete(var doc) async {
    //await FirebaseFirestore.instance.collection("tasks").doc(uid).collection("mytasks").doc(time.toString()).delete();
    await FirebaseFirestore.instance
        .collection("tasks")
        .doc(uid)
        .collection("mytasks")
        .doc(doc["time"])
        .delete();
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  String uid = "";

  getUserId() async {
    final user = await FirebaseAuth.instance.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo"),
        actions: [
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
          }, icon: Icon(Icons.logout),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(21), top: Radius.circular(21))),
          child: Icon(
            Icons.add,
            size: 25,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskPage(),
                ));
          }),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("tasks")
              .doc(uid)
              .collection("mytasks")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final doc = snapshot.data!.docs;
              return ListView.builder(
                itemCount: doc.length,
                itemBuilder: (context, index) {
                  final data = doc[index];
                  var time = (data["timestamp"] as Timestamp).toDate();
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        delete(data);
                      }
                    },
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DescriptionView(
                                  title: data["title"],
                                  description: data["description"]),
                            ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(15),
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.teal.shade500,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                    child: Text(
                                  data["title"],
                                  style: GoogleFonts.roboto(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ))
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                    child: Text(
                                  DateFormat.yMd().format(time),
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                                SizedBox(
                                  height: 12,
                                ),
                                Container(
                                    child: Text(
                                  DateFormat.jm().format(time),
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    background: Container(
                      color: Colors.transparent,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
