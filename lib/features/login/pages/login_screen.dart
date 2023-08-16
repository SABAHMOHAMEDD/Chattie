import 'package:chat_tharwat/features/login/cubit/login_cubit.dart';
import 'package:chat_tharwat/features/register/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/show_snack_bar.dart';
import '../../home/pages/home_screen.dart';
import '../cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "LoginScreen";

  String? email;

  String? password;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          isLoading = false;

          showSnackBar(context, "You Login Successfully");
          Navigator.pushReplacementNamed(
            context,
            HomeScreen.routeName,
          );

          print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
          print(email);
          print(r"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
        } else if (state is LoginFailureState) {
          isLoading = false;

          showSnackBar(context, state.errorMessage.toString());
        }
      },
      builder: (context, state) {
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
                          height: screenSize.height / 9,
                        ),
                        const Image(
                            image: AssetImage("assets/images/scholar.png")),
                        const Text(
                          "AlHarethi Chat",
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                            obscureText: true,
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
                              BlocProvider.of<LoginCubit>(context)
                                  .loginUser(email, password);
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
                                style:
                                    TextStyle(color: Colors.blueGrey.shade100),
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
      },
    );
  }
}
