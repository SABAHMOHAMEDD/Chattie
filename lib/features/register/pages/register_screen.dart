import 'package:chat_tharwat/features/login/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/constance/constants.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/show_snack_bar.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = "RegisterScreen";

  String? email;
  String? name;

  String? password;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          isLoading = false;

          showSnackBar(context, "You Registered Successfully");
          Navigator.pushReplacementNamed(
            context,
            LoginScreen.routeName,
          );
        } else if (state is RegisterFailureState) {
          isLoading = false;

          showSnackBar(context, state.errorMessage.toString());
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return Scaffold(
            backgroundColor: KPrimaryColor,
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
                        Image(
                          image: AssetImage(KLogo),
                          height: 100,
                          width: 100,
                        ),
                        const Text(
                          " AlHarethi Chat",
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                              cubit.registerUser(email, password, name);
                            } else {}
                          },
                          buttonText: 'Register',
                          textColor: KPrimaryColor,
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
                                style: TextStyle(color: KSecondryColor),
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
