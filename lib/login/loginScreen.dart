import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/dialogueUtilies.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/home/homeScreen.dart';
import 'package:todo_list/provider/authUserProvider.dart';
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
                          return 'Please enter email';
                        }
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailController.text);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    Customtextformfield(
                      label: 'Password',
                      controller: passwordController,
                      obscureText: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter password';
                        }
                        if (text.length < 6) {
                          return 'Password should be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
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
        var user = await Firebaseutiles.readUserFromFireStore(
            credential.user?.uid ?? '');

        if (user == null) {
          Dialogueutilies.hideLoading(context);
          Dialogueutilies.showMessage(
              content: 'Failed to retrieve user data',
              context: context,
              title: 'Error',
              posActionName: 'OK');
          return;
        }
        var authprovider =
            Provider.of<Authuserprovider>(context, listen: false);
        authprovider.updateUser(user);
        Dialogueutilies.hideLoading(context);
        Dialogueutilies.showMessage(
            content: 'Login Successful',
            context: context,
            title: 'Success',
            posActionName: 'OK',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(Homescreen.routeName);
            });
        print('Login success');
      } on FirebaseAuthException catch (e) {
        Dialogueutilies.hideLoading(context);
        if (e.code == 'invalid-credential') {
          Dialogueutilies.showMessage(
              content: 'Invalid credentials.',
              context: context,
              title: 'Error',
              posActionName: 'OK');
          print('Invalid credentials.');
        } else if (e.code == 'wrong-password') {
          Dialogueutilies.showMessage(
              content: 'Wrong password provided.',
              context: context,
              title: 'Error',
              posActionName: 'OK');
          print('Wrong password provided.');
        }
      } catch (e) {
        Dialogueutilies.hideLoading(context);
        Dialogueutilies.showMessage(
            content: e.toString(),
            context: context,
            title: 'Error',
            posActionName: 'OK');
        print(e.toString());
      }
    }
  }
}
