import 'package:chat_tharwat/core/cache_helper.dart';
import 'package:chat_tharwat/features/login/pages/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/show_snack_bar.dart';
import '../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  String? name;

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
                      height: screenSize.height / 9,
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
                    Column(
                      children: [
                        CustomTextFormField(
                          hintText: "Name",
                          hintTextColor: Colors.white,
                          onchanged: (data) {
                            name = data;
                          },
                          validator: (data) {
                            if (data!.isEmpty) {
                              return "please enter name";
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                          obscureText: true,
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
                    SizedBox(
                      height: screenSize.height / 35,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            isLoading = true;
                            setState(() {});
                            registerUser();
                            showSnackBar(
                                context, "You Registered Successfully");
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.routeName,
                            );
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

  void registerUser() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((value) {
      UserCreate(name: name!, email: email!, uId: value.user!.uid);
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
    });
  }

  void UserCreate({
    required String name,
    required String email,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toJson())
        .then((value) {})
        .catchError((error) {
      print(error.toString());
    });
  }
}
