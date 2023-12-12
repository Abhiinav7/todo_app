import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("user");

  userDetailsAdd(String name, String email, BuildContext context) async {
    String userId = auth.currentUser!.uid;
    if (userId != null) {
      collectionReference.doc(userId).set({"username": name, "email": email});
      Navigator.pushReplacementNamed(context, "/view");
      return Fluttertoast.showToast(
          msg: "Account create succesfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM_LEFT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple.shade700,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  delete(var doc, String uid) async {
    try {
      //await FirebaseFirestore.instance.collection("tasks").doc(uid).collection("mytasks").doc(time.toString()).delete();
      await collectionReference
          .doc(uid)
          .collection("mytasks")
          .doc(doc["time"])
          .delete();
    } catch (e) {
      print("erroor//////////////////////////////${e}");
    }
  }

  addTaskToFirebase(String title, String description) async {
    try {
      final user = await auth.currentUser!;
      //final user=await FirebaseAuth.instance.currentUser;
      String userId = user.uid;
      var time = DateTime.now();
      await collectionReference
          .doc(userId)
          .collection("mytasks")
          .doc(time.toString())
          .set({
        "title": title,
        "description": description,
        "time": time.toString(),
        "timestamp": time
      });

      Fluttertoast.showToast(
          msg: "task saved",
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 15.0);
    } catch (error) {
      print("//////////////////error=${error}//////////////////////");
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    print("//////////////////////Logged out///////////////////////////");
  }
}
