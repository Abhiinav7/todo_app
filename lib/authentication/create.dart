import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthCreate extends StatefulWidget {
  const AuthCreate({super.key});

  @override
  State<AuthCreate> createState() => _AuthCreateState();
}

class _AuthCreateState extends State<AuthCreate> {
  void validate() {
    final validate = _formkey.currentState!.validate();
    // FocusScope.of(context).unfocus();
    if (validate) {
      _formkey.currentState!.save();
      Signup(_pass, email1.text, _name);
    }
  }

  Signup(String password, String email,String name) async {
    if (isLogin) {
      try {
        final ref = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        print("///////////login succes//////////");
      }
      on FirebaseAuthException catch (e) {
        print("/////////error=${e}///////");
      }
    }
    else {
      try {
        final f = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email, password: password);
        print("///////////account created///////////");
        // String userId = f.user!.uid;
        // cl.doc(userId)
        //     .set({"username": name, "email": email});
      } on FirebaseAuthException catch (e) {
        print("/////////////error=${e.code}////////////////////");
      }
    }
  }

  CollectionReference cl = FirebaseFirestore.instance.collection("user");
  var _name = '';
  var _pass = '';
  TextEditingController email1 = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool isLogin = false;
  bool isNot = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo "),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      isLogin
                          ? Container()
                          : TextFormField(
                              key: ValueKey("name"),
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Field cannot be empty";
                                } else if (value.toString().length <= 4) {
                                  return "must contain 5 characters";
                                }

                                return null;
                              },
                              onSaved: (newValue) => _name = newValue!,
                              decoration: InputDecoration(
                                  hintText: "enter name",
                                  hintStyle: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 18),
                                  filled: true,
                                  fillColor: Colors.purple,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide())),
                            ),
                      isNot? TextFormField(
                        key: ValueKey("name"),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Field cannot be empty";
                          } else if (value.toString().length <= 4) {
                            return "must contain 5 characters";
                          }

                          return null;
                        },
                        onSaved: (newValue) => _name = newValue!,
                        decoration: InputDecoration(
                            hintText: "enter name",
                            hintStyle: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 18),
                            filled: true,
                            fillColor: Colors.purple,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide())),
                      ):Container(),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email1,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Field cannot be empty";
                          } else if (!value.toString().contains("@")) {
                            return "invalid email";
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "enter email",
                            hintStyle: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 18),
                            filled: true,
                            fillColor: Colors.purple,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide())),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        key: ValueKey("password"),
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return "Field is empty";
                          } else if (value.toString().length <= 5) {
                            return "weak password";
                          }
                          return null;
                        },
                        onSaved: (newValue) => _pass = newValue!,
                        decoration: InputDecoration(
                            hintText: "enter password",
                            hintStyle: GoogleFonts.roboto(
                                color: Colors.white, fontSize: 18),
                            filled: true,
                            fillColor: Colors.purple,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide())),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        width: 180,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            validate();
                            // if (_formkey.currentState!.validate()) {
                            //   _formkey.currentState!.save();
                            //   Signup(email1.text, _name, _pass);
                            // }
                            //  Signup(_pass, email1.text,_name);
                          },
                          child: isLogin
                              ? Text(
                                  "Sign in",
                                  style: TextStyle(fontSize: 20),
                                )
                              : Text(
                                  "Sign up",
                                  style: TextStyle(fontSize: 20),
                                ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isLogin = true;
                          });
                        },
                        child: isLogin
                            ? GestureDetector(
                            onTap: (){
                             setState(() {
                               isNot=true;

                             });
                            },
                            child:isNot? Text("Already have an account"): Text("Dont have an account"))
                            : GestureDetector(child: Text("Already have an account")),
                      )
                    ],
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
