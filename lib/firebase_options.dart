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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCNzqoVox5gXRz6frOV9c2wsI2LpLtCF-I',
    appId: '1:470678956300:web:2bb58c26df66c6e714c129',
    messagingSenderId: '470678956300',
    projectId: 'linguaotter',
    authDomain: 'linguaotter.firebaseapp.com',
    databaseURL: 'https://linguaotter-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'linguaotter.appspot.com',
    measurementId: 'G-DB3878991C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcs-l8H2WuGGon6PWYqv25DWUEKczWuwI',
    appId: '1:470678956300:android:93d6024bffd0645914c129',
    messagingSenderId: '470678956300',
    projectId: 'linguaotter',
    databaseURL: 'https://linguaotter-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'linguaotter.appspot.com',
  );
}
