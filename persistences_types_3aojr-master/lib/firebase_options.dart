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
    apiKey: 'AIzaSyALLC2-PUTzPRBNVJhDYOqVQvDZZ1TLOh0',
    appId: '1:24344401666:web:d41baba1828fdac96e141b',
    messagingSenderId: '24344401666',
    projectId: 'aojr-mobilepersistence-f9a8e',
    authDomain: 'aojr-mobilepersistence-f9a8e.firebaseapp.com',
    storageBucket: 'aojr-mobilepersistence-f9a8e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbM-z3E_ZtArKpcWRkK_CuJ5LRYU3dVCI',
    appId: '1:24344401666:android:47f636b1041c07606e141b',
    messagingSenderId: '24344401666',
    projectId: 'aojr-mobilepersistence-f9a8e',
    storageBucket: 'aojr-mobilepersistence-f9a8e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy9cVdYaxxdfNRwEyTwFGJbwj432YlK9A',
    appId: '1:24344401666:ios:abef5c266554c5b16e141b',
    messagingSenderId: '24344401666',
    projectId: 'aojr-mobilepersistence-f9a8e',
    storageBucket: 'aojr-mobilepersistence-f9a8e.appspot.com',
    iosBundleId: 'com.example.persistencesTypes3aojr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAy9cVdYaxxdfNRwEyTwFGJbwj432YlK9A',
    appId: '1:24344401666:ios:e47150c7f9a70dcc6e141b',
    messagingSenderId: '24344401666',
    projectId: 'aojr-mobilepersistence-f9a8e',
    storageBucket: 'aojr-mobilepersistence-f9a8e.appspot.com',
    iosBundleId: 'com.example.persistencesTypes3aojr.RunnerTests',
  );
}