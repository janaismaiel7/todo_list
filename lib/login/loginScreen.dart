import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/appColors.dart';
import 'package:todo_list/dialogueUtilies.dart';
import 'package:todo_list/firebaseUtiles.dart';
import 'package:todo_list/home/homeScreen.dart';
import 'package:todo_list/login/loginNavigator.dart';
import 'package:todo_list/login/loginScreenViewModel.dart';
import 'package:todo_list/provider/authUserProvider.dart';
import 'package:todo_list/register/customTextFormField.dart';
import 'package:todo_list/register/registerScreen.dart';

typedef MyValidator = String? Function(String?);

class Loginscreen extends StatefulWidget {
  static const String routeName = 'Login Screen';

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> implements Loginnavigator {
 
  var formKey = GlobalKey<FormState>();

  Loginscreenviewmodel viewModel =Loginscreenviewmodel();
  void initState(){
    super.initState();
    viewModel.navigator= this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
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
                key: viewModel.formkey,
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
                        controller: viewModel.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter email';
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(viewModel.emailController.text);
                          if (!emailValid) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      Customtextformfield(
                        label: 'Password',
                        controller: viewModel.passwordController,
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
                                backgroundColor: WidgetStateProperty.all(
                                    Appcolors.primaryColor)),
                            onPressed: () {
                              viewModel.login();
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
      ),
    );
  }

  @override
  void hideMyLoading() {
    // TODO: implement hideMyLoading
    Dialogueutilies.hideLoading(context);
  }
  
  @override
  void showMyLoading(String message) {
    // TODO: implement showMyLoading
   Dialogueutilies.showLoading(context, message);
  }
  
  @override
  void showMyMessage(String messsage) {
    // TODO: implement showMyMessage
     Dialogueutilies.showMessage(context: context, content: messsage);
  }
  }
  
 
