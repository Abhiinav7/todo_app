import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../services/authentication_services.dart';
import '../widgets/animatedTexts.dart';
import '../widgets/appbar.dart';
import '../widgets/custum_container.dart';
import '../widgets/shimmerEffect.dart';
import '../widgets/textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController name = TextEditingController();
  AuthenticationServices services = AuthenticationServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MyAppbar(
        actions: [],
        isCenter: true,
        elevation: 0,
        bgcolor: Colors.transparent,
        title: AnimeText(
          text: 'ToDo',
        ),
      ),
      body: Stack(
        children: [
          Lottie.asset(
            "assets/bg.json",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 260,
                      ),
                      MyContainer(
                        child: MyTextfield(
                          keyboardType: TextInputType.name,
                          controller: name,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Field cannot be empty";
                            } else if (value.toString().length <= 4) {
                              return "must contain 5 characters";
                            }

                            return null;
                          },
                          hintext: 'Enter Name',
                          obscuretext: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyContainer(
                        child: MyTextfield(
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "Field cannot be empty";
                            } else if (!value.toString().contains("@")) {
                              return "invalid email";
                            } else {
                              return null;
                            }
                          },
                          hintext: 'Enter Email',
                          obscuretext: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyContainer(
                        child: MyTextfield(
                            obscuretext: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: pass,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Field cannot be empty";
                              } else if (value.toString().length <= 5) {
                                return "weak password";
                              }
                              return null;
                            },
                            hintext: "Enter Password"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 95),
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey[300])),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                services.signupFunction(
                                    email.text, pass.text, name.text, context);
                              }
                            },
                            child: Text(
                              "Sign up",
                              style: GoogleFonts.taiHeritagePro(
                                  fontSize: 24,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w900),
                            )),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                      ShimmerEffects(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          child: Text(
                            "Already have an account!",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
