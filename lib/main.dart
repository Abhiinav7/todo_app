import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/screens/loginpage.dart';
import 'package:todo_app/screens/signup.dart';
import 'package:todo_app/screens/task_add.dart';
import 'package:todo_app/screens/view.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My ToDo',
      theme: ThemeData(
       primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,
      ),
      //home: const SignupPage(),
      routes: {
        "/login":(context) =>LoginPage(),
        "/create":(context) =>SignupPage(),
        "/view":(context) =>MyHome(),
        "/task":(context) =>TaskPage(),



      },
      initialRoute:FirebaseAuth.instance.currentUser != null? "/view" :"/login",
    );
  }
}

