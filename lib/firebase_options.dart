// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyA_g2yuP7wd_WeM2pEn2pRhuJoM_H04dxI',
    appId: '1:921010982650:web:272714b468882988e0c343',
    messagingSenderId: '921010982650',
    projectId: 'medici-2bdb5',
    authDomain: 'medici-2bdb5.firebaseapp.com',
    storageBucket: 'medici-2bdb5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDRXxbd4wYcXXz5nM9_bA-NvgCn0XwBwA',
    appId: '1:921010982650:android:4229dea3e3f108b6e0c343',
    messagingSenderId: '921010982650',
    projectId: 'medici-2bdb5',
    storageBucket: 'medici-2bdb5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuPl-xQ8VuoCeN-8wgUnla48SRRZdKgO0',
    appId: '1:921010982650:ios:cb9e9bdb7a7c48c4e0c343',
    messagingSenderId: '921010982650',
    projectId: 'medici-2bdb5',
    storageBucket: 'medici-2bdb5.appspot.com',
    iosBundleId: 'com.example.medici',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCuPl-xQ8VuoCeN-8wgUnla48SRRZdKgO0',
    appId: '1:921010982650:ios:29a83aa5f2f58020e0c343',
    messagingSenderId: '921010982650',
    projectId: 'medici-2bdb5',
    storageBucket: 'medici-2bdb5.appspot.com',
    iosBundleId: 'com.example.medici.RunnerTests',
  );
}
