import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/home/homeScreen.dart';
import 'package:todo_list/login/loginScreen.dart';

class Lightsplashscreen extends StatefulWidget {
  static const String routeName = 'splashScreen';

  @override
  State<Lightsplashscreen> createState() => _LightsplashscreenState();
}

class _LightsplashscreenState extends State<Lightsplashscreen> {
  late Image splashImage;

  @override
  void initState() {
    super.initState();
   
  
 Future.delayed(Duration(seconds: 3), () {
    Navigator.of(context).pushReplacementNamed(Homescreen.routeName);

   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: double.infinity,
        height:double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/splash.png'))
        ),
      )
      
    );
  }
}
