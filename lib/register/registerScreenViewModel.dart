import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/dialogueUtilies.dart';
import 'package:todo_list/register/registerNagiator.dart';

class Registerscreenviewmodel extends ChangeNotifier{
   late Registernagiator navigator ;
  //holed data + handle logic
  void register(String email,String password) async {
  navigator.showMyLoading('loading....');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
        );
        // Myuser user = Myuser(
        //     email: emailController.text,
        //     id: credential.user?.uid ?? '',
        //     name: UsernameConteroller.text);
        // var authprovider =
        //     Provider.of<Authuserprovider>(context, listen: false);
        // authprovider.updateUser(user);
        // Firebaseutiles.addUserToFireStore(user);

        navigator.hideMyLoading();
        navigator.showMyMessage('register successfully');
        

        print('succes');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          navigator.hideMyLoading();
        navigator.showMyMessage('The password provided is too weak.');
        

          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
         navigator.hideMyLoading();
        navigator.showMyMessage('The account already exists for that email.');
        
          print('The account already exists for that email.');
        } else if (e.code == 'network') {
         navigator.hideMyLoading();
        navigator.showMyMessage('The account already exists for that email.');
          print('The account already exists for that email.');
        }
      } catch (e) {
       navigator.hideMyLoading();
        navigator.showMyMessage('${e  }');
        print(e); 
      }
  }
}