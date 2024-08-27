import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/dialogueUtilies.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/home/homeScreen.dart';
import 'package:todo_list/model/myUser.dart';
import 'package:todo_list/provider/authUserProvider.dart';
import 'package:todo_list/register/customTextFormField.dart';
import 'package:todo_list/register/registerNagiator.dart';
import 'package:todo_list/register/registerScreenViewModel.dart';

class Registerscreen extends StatefulWidget  {
  static const String routeName = 'register Screen';

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen>implements Registernagiator {
  TextEditingController UsernameConteroller =
      TextEditingController(text: 'amira');

  TextEditingController emailController =
      TextEditingController(text: 'jana.aismaiel@gmail.com');

  TextEditingController passwordController =
      TextEditingController(text: 'dhjhbvcjhkcj');

  TextEditingController confirmPassword =  
      TextEditingController(text: 'dhjhbvcjhkcj');

  var formKey = GlobalKey<FormState>();

  Registerscreenviewmodel viewModel =Registerscreenviewmodel();

  @override
  void initState(){
    super.initState();
    viewModel.navigator=this;
  }

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
      viewModel.register(emailController.text, passwordController.text);
     
    }
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    Dialogueutilies.hideLoading(context);
  }

  @override
  void showMyLoading(String message) {
    // TODO: implement showMyLoading
  Dialogueutilies.showLoading(context,message);
  }

  @override
  void showMyMessage(String message) {
    // TODO: implement showMyMessage
    Dialogueutilies.showMessage(context: context, content: message,posActionName: 'Ok');
   
  }
}
