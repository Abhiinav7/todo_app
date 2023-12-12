import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../services/database_services.dart';
import '../widgets/animatedTexts.dart';
import '../widgets/appbar.dart';
import 'discriptionView.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    getUserId();
    super.initState();
  }

  getUserId() async {
    final user = await FirebaseAuth.instance.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("user");
  FirebaseServices services = FirebaseServices();
  String uid = " ";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async{
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      return true;
    },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: MyAppbar(
          actions: [
            IconButton(
                onPressed: () async {
                  await services.signOut();
                  if (FirebaseAuth.instance.currentUser == null) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                icon: Icon(Icons.logout_outlined))
          ],
          isCenter: true,
          elevation: 0,
          bgcolor: Colors.transparent,
          title: AnimeText(
            text: 'ToDo',
          ),
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
              Navigator.pushNamed(context, "/task");
            }),
        body: Stack(children: [
          Lottie.asset(
            "assets/bg.json",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder(
              stream:
                  collectionReference.doc(uid).collection("mytasks").orderBy("time",descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
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
                            services.delete(data, uid);
                          } else {
                            services.delete(data, uid);
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
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        child: Text(
                                      data["title"],
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      DateFormat.yMd().format(time),
                                      style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      DateFormat.jm().format(time),
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
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
        ]),
      ),
    );
  }
}
