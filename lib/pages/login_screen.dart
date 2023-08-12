import 'package:chat_tharwat/pages/chat_screen.dart';
import 'package:chat_tharwat/pages/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text_field.dart';
import '../core/widgets/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height / 6,
                    ),
                    const Image(image: AssetImage("assets/images/scholar.png")),
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
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                        onchanged: (data) {
                          email = data;
                        },
                        hintText: "Email",
                        hintTextColor: Colors.white,
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "please enter email";
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                        validator: (data) {
                          if (data!.isEmpty) {
                            return "please enter password";
                          }
                        },
                        onchanged: (data) {
                          password = data;
                        },
                        hintText: "Password",
                        hintTextColor: Colors.white),
                    SizedBox(
                      height: screenSize.height / 35,
                    ),
                    CustomButton(
                      buttonText: 'Login',
                      textColor: Colors.blueGrey,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            isLoading = true;
                            setState(() {});
                            UserCredential credential = await loginUser();
                            print(credential.user!.email);
                            showSnackBar(context, "You Login Successfully");
                            Navigator.pushNamed(context, ChatScreen.routeName);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              showSnackBar(
                                  context, "No user found for that email.");
                            } else if (ex.code == 'wrong-password') {
                              showSnackBar(context,
                                  "Wrong password provided for that user.");
                            }
                          } catch (ex) {
                            showSnackBar(context, "Error Occurred");
                          }
                          isLoading = false;
                          setState(() {});
                        } else {}
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?",
                            style: TextStyle(color: Colors.white)),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text(
                            ' Register',
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

  Future<UserCredential> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    return credential;
  }
}
