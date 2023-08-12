import 'package:chat_tharwat/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/show_snack_bar.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: Colors.white,
          ),
          inAsyncCall: isLoading,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height / 6,
                    ),
                    Image(image: AssetImage("assets/images/scholar.png")),
                    const Text(
                      "Scholar Chat",
                      style: TextStyle(
                          fontFamily: "Schyler",
                          color: Colors.white,
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: screenSize.height / 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hintText: "Email",
                            hintTextColor: Colors.white,
                            onchanged: (data) {
                              email = data;
                            },
                            validator: (data) {
                              if (data!.isEmpty) {
                                return "please enter email";
                              }
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            validator: (data) {
                              if (data!.isEmpty) {
                                return "please enter password";
                              }
                            },
                            hintText: "Password",
                            hintTextColor: Colors.white,
                            onchanged: (data) {
                              password = data;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height / 35,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            isLoading = true;
                            setState(() {});
                            UserCredential credential = await registerUser();
                            print(credential.user!.email);
                            showSnackBar(
                                context, "You Registered Successfully");
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'weak-password') {
                              showSnackBar(context,
                                  "The password provided is too weak.");
                            } else if (ex.code == 'email-already-in-use') {
                              showSnackBar(context,
                                  "The account already exists for that email.");
                            }
                          } catch (ex) {
                            showSnackBar(context, "Error Occurred");
                          }
                          isLoading = false;
                          setState(() {});
                        } else {}
                      },
                      buttonText: 'Register',
                      textColor: Colors.blueGrey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?",
                            style: TextStyle(color: Colors.white)),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, LoginScreen.routeName);
                          },
                          child: Text(
                            ' Login',
                            style: TextStyle(color: Colors.blueGrey.shade100),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<UserCredential> registerUser() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return credential;
  }
}
