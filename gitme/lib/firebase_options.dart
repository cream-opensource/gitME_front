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
    apiKey: 'AIzaSyCneDMcBchVW__iWFYYsY6PkuTibtDXA6E',
    appId: '1:92996881519:web:a9af06055599e74222519a',
    messagingSenderId: '92996881519',
    projectId: 'gitme-6767c',
    authDomain: 'gitme-6767c.firebaseapp.com',
    storageBucket: 'gitme-6767c.appspot.com',
    measurementId: 'G-SY4FKWP21L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAj-i4x94PFy8HX3hH72uI2xvkc7jDoJI',
    appId: '1:92996881519:android:2350260a6319c25322519a',
    messagingSenderId: '92996881519',
    projectId: 'gitme-6767c',
    storageBucket: 'gitme-6767c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYGUEGhqVfZ9za4vvAH97RqP0_2R6tedA',
    appId: '1:92996881519:ios:13c67a21836f31c222519a',
    messagingSenderId: '92996881519',
    projectId: 'gitme-6767c',
    storageBucket: 'gitme-6767c.appspot.com',
    iosBundleId: 'com.example.gitme',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYGUEGhqVfZ9za4vvAH97RqP0_2R6tedA',
    appId: '1:92996881519:ios:bf3434e6ae426acd22519a',
    messagingSenderId: '92996881519',
    projectId: 'gitme-6767c',
    storageBucket: 'gitme-6767c.appspot.com',
    iosBundleId: 'com.example.gitme.RunnerTests',
  );
}
