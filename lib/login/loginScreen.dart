import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/dialogueUtilies.dart';
import 'package:todo_list/home/homeScreen.dart';
import 'package:todo_list/register/customTextFormField.dart';
import 'package:todo_list/register/registerScreen.dart';

typedef MyValidator = String? Function(String?);

class Loginscreen extends StatelessWidget {
  static const String routeName = 'Login Screen';

  TextEditingController emailController =
      TextEditingController(text: 'jana.aismaiel@gmail.com');

  TextEditingController passwordController =
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
              'Login',
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Welcome Back',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  Appcolors.primaryColor)),
                          onPressed: () {
                            login(context);
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context).textTheme.titleLarge,
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Registerscreen.routeName);
                        },
                        child: Text(
                          'or create Account',
                          style: TextStyle(color: Appcolors.primaryColor),
                        ))
                  ],
                ),
              )),
        )
      ],
    );
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      try {
        Dialogueutilies.showLoading(context, 'loading');
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        Dialogueutilies.hideLoading(context);
        Dialogueutilies.showMessage(content: 'Login Successful',context: context,title: 'Sucesss',posActionName: 'ok');
          Navigator.of(context).pushNamed(Homescreen.routeName);
        print('login success');

        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
            Dialogueutilies.hideLoading(context);
        Dialogueutilies.showMessage(content: 'No user found for that email.',context: context,title: 'Error',posActionName: 'ok');
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
            Dialogueutilies.hideLoading(context);
        Dialogueutilies.showMessage(content: 'Wrong password provided for that user.',context: context,title: 'Error',posActionName: 'ok');
          print('Wrong password provided for that user.');
        }
      } catch (e) {
          Dialogueutilies.hideLoading(context);
        Dialogueutilies.showMessage(content: e.toString(),context: context,title: 'Error',posActionName: 'ok');
        print(e.toString());
      }
    }
  }
}
