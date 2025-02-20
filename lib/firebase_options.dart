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
    apiKey: 'AIzaSyCS_Wpby03z_2Fzth7t19e_Kp3kIZVRiwk',
    appId: '1:961574928989:web:70b9df316713b90e9143b4',
    messagingSenderId: '961574928989',
    projectId: 'gym-mate-86c8a',
    authDomain: 'gym-mate-86c8a.firebaseapp.com',
    storageBucket: 'gym-mate-86c8a.appspot.com',
    measurementId: 'G-J4G3R26VE8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBACicHVUcljhaIkMqYLdELNCw8LAmB8mk',
    appId: '1:961574928989:android:bab4c9056edc5cf39143b4',
    messagingSenderId: '961574928989',
    projectId: 'gym-mate-86c8a',
    storageBucket: 'gym-mate-86c8a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnPR8-kntLKduBSiFI-YlWvjkw6xOowqU',
    appId: '1:961574928989:ios:4e940c6d817b025c9143b4',
    messagingSenderId: '961574928989',
    projectId: 'gym-mate-86c8a',
    storageBucket: 'gym-mate-86c8a.appspot.com',
    iosBundleId: 'com.exarth.gymMateAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnPR8-kntLKduBSiFI-YlWvjkw6xOowqU',
    appId: '1:961574928989:ios:4e940c6d817b025c9143b4',
    messagingSenderId: '961574928989',
    projectId: 'gym-mate-86c8a',
    storageBucket: 'gym-mate-86c8a.appspot.com',
    iosBundleId: 'com.exarth.gymMateAdmin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCS_Wpby03z_2Fzth7t19e_Kp3kIZVRiwk',
    appId: '1:961574928989:web:e08302fcf34dcf6f9143b4',
    messagingSenderId: '961574928989',
    projectId: 'gym-mate-86c8a',
    authDomain: 'gym-mate-86c8a.firebaseapp.com',
    storageBucket: 'gym-mate-86c8a.appspot.com',
    measurementId: 'G-ZTFF9RQVZN',
  );
}
