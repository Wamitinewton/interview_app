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
    apiKey: 'AIzaSyBV59TIynkSukOu9D-d34L1Y8LbIw4ZiCs',
    appId: '1:528423788099:web:dd64d5ff2c433cc9c93ef6',
    messagingSenderId: '528423788099',
    projectId: 'flutter-fcm-1b28b',
    authDomain: 'flutter-fcm-1b28b.firebaseapp.com',
    storageBucket: 'flutter-fcm-1b28b.appspot.com',
    measurementId: 'G-M6N361V36W',
  );

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: "AIzaSyDSjL7-NqizRuTIYU2zqUpMCddVEgyiBp0",
      appId: "1:862069428665:android:f80bd34595170d566b6668",
      messagingSenderId: "862069428665",
      projectId: "interviewapp-f6657",
      storageBucket: "interviewapp-f6657.appspot.com");

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4QupXSa3DfTReyikpvvyHE_2B_C82Qy8',
    appId: '1:528423788099:ios:64ea09bdfa223bc3c93ef6',
    messagingSenderId: '528423788099',
    projectId: 'flutter-fcm-1b28b',
    storageBucket: 'flutter-fcm-1b28b.appspot.com',
    iosBundleId: 'com.example.healthAndDoctorAppointment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD4QupXSa3DfTReyikpvvyHE_2B_C82Qy8',
    appId: '1:528423788099:ios:9289c29abb1ac926c93ef6',
    messagingSenderId: '528423788099',
    projectId: 'flutter-fcm-1b28b',
    storageBucket: 'flutter-fcm-1b28b.appspot.com',
    iosBundleId: 'com.example.healthAndDoctorAppointment.RunnerTests',
  );
}
