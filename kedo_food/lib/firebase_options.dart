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
    apiKey: 'AIzaSyBFXqo6Vc2qCLbNJ8RkTGzz0DCifEhlTz0',
    appId: '1:852431000005:web:b213ab03ed99d5a0a4fbac',
    messagingSenderId: '852431000005',
    projectId: 'flutter-kedo-food',
    authDomain: 'flutter-kedo-food.firebaseapp.com',
    databaseURL: 'https://flutter-kedo-food-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-kedo-food.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_tiySQlatKMwZe1bffGHRIlPQ007TJy4',
    appId: '1:852431000005:android:71c9a839b6fe0d15a4fbac',
    messagingSenderId: '852431000005',
    projectId: 'flutter-kedo-food',
    databaseURL: 'https://flutter-kedo-food-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-kedo-food.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCng_0UsR0PjHhts15pL0eYQ9jEhq2wyVs',
    appId: '1:852431000005:ios:8874c5f14e73f346a4fbac',
    messagingSenderId: '852431000005',
    projectId: 'flutter-kedo-food',
    databaseURL: 'https://flutter-kedo-food-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-kedo-food.appspot.com',
    iosClientId: '852431000005-27q9l5qlgas6ddn6d49rd24q7rbbg65m.apps.googleusercontent.com',
    iosBundleId: 'com.example.kedoFood',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCng_0UsR0PjHhts15pL0eYQ9jEhq2wyVs',
    appId: '1:852431000005:ios:8874c5f14e73f346a4fbac',
    messagingSenderId: '852431000005',
    projectId: 'flutter-kedo-food',
    databaseURL: 'https://flutter-kedo-food-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-kedo-food.appspot.com',
    iosClientId: '852431000005-27q9l5qlgas6ddn6d49rd24q7rbbg65m.apps.googleusercontent.com',
    iosBundleId: 'com.example.kedoFood',
  );
}