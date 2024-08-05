import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/home/homeScreen.dart';
import 'package:todo_list/login/loginScreen.dart';
import 'package:todo_list/mythemedata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list/provider/authUserProvider.dart';
import 'package:todo_list/provider/listProvider.dart';
import 'package:todo_list/register/registerScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await FirebaseFirestore.instance.enableNetwork();
  runApp(MultiProvider(
providers: [
  ChangeNotifierProvider(create: (context)=>Listprovider()),
  ChangeNotifierProvider(create: (context)=>Authuserprovider()),

],
child: MyApp(),




  )
    
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Loginscreen.routeName,
        routes: {Homescreen.routeName: (context) => Homescreen(),
        Registerscreen.routeName: (context) => Registerscreen(),
                Loginscreen.routeName: (context) => Loginscreen()
        },
        theme: Mythemedata.lightTheme);
  }
}
