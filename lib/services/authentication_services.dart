import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'database_services.dart';

class AuthenticationServices {
  FirebaseServices firebaseServices = FirebaseServices();
  FirebaseAuth auth = FirebaseAuth.instance;

  Future signupFunction(
      String email, String password, String name, BuildContext context) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;
      // User? user=f.user;
      // String userid=user!.uid;
      firebaseServices.userDetailsAdd(name, email, context);
    } on FirebaseAuthException catch (e) {
      print("/////////////error=${e.code}////////////////////");
    }
  }

  Future siginfunction(
      String email, String password, BuildContext context) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      if (auth.currentUser != null) {
        Navigator.pushReplacementNamed(context, "/view");
      }
    } on FirebaseAuthException catch (e) {
      print("/////////error=${e.code}///////");
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            action: SnackBarAction(label: "try again", onPressed: () {}),
            behavior: SnackBarBehavior.floating,
            content: Text("email or password is incorrect")));
      }
    }
  }
}
