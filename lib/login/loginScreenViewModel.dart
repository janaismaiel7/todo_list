import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/dialogueUtilies.dart';
import 'package:todo_list/login/loginNavigator.dart';

class Loginscreenviewmodel extends ChangeNotifier{

  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var formkey =GlobalKey<FormState> ();
  late Loginnavigator navigator;
//data+ handle logic
void login() async {
  if(formkey.currentState==true){
  navigator.showMyLoading('waiting....');
  try{        final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
             email: emailController.text, password: passwordController.text);
        
        navigator.hideMyLoading();
    
        print('Login success');
      } 
      on FirebaseAuthException catch (e) {

        if (e.code == 'invalid-credential') {
           navigator.hideMyLoading();
        navigator.showMyMessage('Invalid credentials.');
          print('Invalid credentials.');
        } else if (e.code == 'wrong-password') {
             navigator.hideMyLoading();
        navigator.showMyMessage('Wrong password provided.');
          print('Wrong password provided.');
        }
      } catch (e) {
       navigator.hideMyLoading();
        navigator.showMyMessage(e.toString());
        print(e.toString());
      }
    }}
}