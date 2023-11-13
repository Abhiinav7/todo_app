import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyhomeP extends StatefulWidget {
  const MyhomeP({super.key});

  @override
  State<MyhomeP> createState() => _MyhomePState();
}

class _MyhomePState extends State<MyhomeP> {
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();





  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller:email ,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
              TextField(
                controller:pass ,
                decoration: InputDecoration(
                    border: OutlineInputBorder()
                ),
              ),
              ElevatedButton(onPressed: ()async{
                try{
                  final s=await FirebaseAuth.instance.createUserWithEmailAndPassword(

                      email: email.text, password: pass.text);
                }
               on FirebaseAuthException catch(e){
                  print("/////////////////${e.code}/////////////////");
               }

              }, child: Text("signup"))
            ],
          ),
        ),
      ),
    );
  }
}
