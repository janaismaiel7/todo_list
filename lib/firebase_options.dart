// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAfKa8nkQNa7hgKUdVRBaGmncziPrWO_dU',
    appId: '1:887513628309:web:fb8a733543298d7ebe259c',
    messagingSenderId: '887513628309',
    projectId: 'to-do-list-a2ec2',
    authDomain: 'to-do-list-a2ec2.firebaseapp.com',
    storageBucket: 'to-do-list-a2ec2.appspot.com',
    measurementId: 'G-1L9C6T5KEB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQPetYeoStXXB9SwdglbPpiWC7ZL9Jj0c',
    appId: '1:887513628309:android:a9ae440e6d99426cbe259c',
    messagingSenderId: '887513628309',
    projectId: 'to-do-list-a2ec2',
    storageBucket: 'to-do-list-a2ec2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDV93cdpOu8LuSmuDlsAUpZWkBx1hAe_0A',
    appId: '1:887513628309:ios:d5343a18321eb227be259c',
    messagingSenderId: '887513628309',
    projectId: 'to-do-list-a2ec2',
    storageBucket: 'to-do-list-a2ec2.appspot.com',
    iosBundleId: 'com.example.todoList',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDV93cdpOu8LuSmuDlsAUpZWkBx1hAe_0A',
    appId: '1:887513628309:ios:d5343a18321eb227be259c',
    messagingSenderId: '887513628309',
    projectId: 'to-do-list-a2ec2',
    storageBucket: 'to-do-list-a2ec2.appspot.com',
    iosBundleId: 'com.example.todoList',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAfKa8nkQNa7hgKUdVRBaGmncziPrWO_dU',
    appId: '1:887513628309:web:0b337071d64d222dbe259c',
    messagingSenderId: '887513628309',
    projectId: 'to-do-list-a2ec2',
    authDomain: 'to-do-list-a2ec2.firebaseapp.com',
    storageBucket: 'to-do-list-a2ec2.appspot.com',
    measurementId: 'G-15XY3KSE3H',
  );
}
