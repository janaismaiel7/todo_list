import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/dialogueUtilies.dart';
import 'package:todo_list/home/homeScreen.dart';
import 'package:todo_list/register/customTextFormField.dart';

class Registerscreen extends StatelessWidget {
  static const String routeName = 'register Screen';
  TextEditingController UsernameConteroller =
      TextEditingController(text: 'amira');
  TextEditingController emailController =
      TextEditingController(text: 'jana.aismaiel@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'dhjhbvcjhkcj');
  TextEditingController confirmPassword =
      TextEditingController(text: 'dhjhbvcjhkcj');
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            color: Appcolors.backgrountLightColor,
            child: Image.asset(
              'assets/images/background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'create account',
              style: TextStyle(color: Appcolors.whiteColor),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    Customtextformfield(
                      label: 'User Name',
                      controller: UsernameConteroller,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter User Name';
                        }
                      },
                    ),
                    Customtextformfield(
                      label: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter email';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
                        return null;
                      },
                    ),
                    Customtextformfield(
                      label: 'Password',
                      controller: passwordController,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter Password';
                        }
                        if (text.length < 6) {
                          return 'Password should be at least 6 chars';
                        }
                        return null;
                      },
                    ),
                    Customtextformfield(
                      label: 'Confrim Password',
                      controller: confirmPassword,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter Confirm Password';
                        }
                        if (text != passwordController.text) {
                          return 'Confirm Password does not match password';
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Appcolors.primaryColor)),
                          onPressed: () {
                            register(context);
                          },
                          child: Text(
                            'Create Account',
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                    )
                  ],
                ),
              )),
        )
      ],
    );
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      Dialogueutilies.showLoading(context, 'Loading');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Dialogueutilies.hideLoading(context);
        Dialogueutilies.showMessage(
            context: context,
            content: 'Register Successfull',
            title: 'Sucesss',
            posActionName: 'ok',
            posAction: () {
              Navigator.of(context).pushNamed(Homescreen.routeName);
            });

        print('succes');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Dialogueutilies.hideLoading(context);
          Dialogueutilies.showMessage(
              context: context,
              content: 'The password provided is too weak.',
              title: 'Error',
              posActionName: 'ok');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Dialogueutilies.hideLoading(context);
          Dialogueutilies.showMessage(
              context: context,
              content: 'The account already exists for that email.',
              title: 'error',
              posActionName: 'ok');
          print('The account already exists for that email.');
        } else if (e.code == 'network') {
          Dialogueutilies.hideLoading(context);
          Dialogueutilies.showMessage(
              context: context,
              content: 'The account already exists for that email.',
              title: 'error',
              posActionName: 'ok');
          print('The account already exists for that email.');
        }
      } catch (e) {
        Dialogueutilies.hideLoading(context);
        Dialogueutilies.showMessage(
            context: context,
            content: e.toString(),
            title: 'Error',
            posActionName: 'ok');
        print(e);
      }
    }
  }
}
