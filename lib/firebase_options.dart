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
    apiKey: 'AIzaSyB8GFYcfeBtbONy94KeTSC4VABpp9vj7VY',
    appId: '1:172562951861:web:677c9f454cef074e18d8fc',
    messagingSenderId: '172562951861',
    projectId: 'intelli-traffic',
    authDomain: 'intelli-traffic.firebaseapp.com',
    storageBucket: 'intelli-traffic.appspot.com',
    measurementId: 'G-QPY0NVF7LM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANJLdCwTLewjVW_8GxPWxx-X9wXTkaY-Q',
    appId: '1:172562951861:android:083581183e02287f18d8fc',
    messagingSenderId: '172562951861',
    projectId: 'intelli-traffic',
    storageBucket: 'intelli-traffic.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQgvMxZXajolWtvcH2XAKguMIOVTvLFGM',
    appId: '1:172562951861:ios:51569afd6fc4fdb118d8fc',
    messagingSenderId: '172562951861',
    projectId: 'intelli-traffic',
    storageBucket: 'intelli-traffic.appspot.com',
    iosBundleId: 'com.example.intelTraffic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQgvMxZXajolWtvcH2XAKguMIOVTvLFGM',
    appId: '1:172562951861:ios:51569afd6fc4fdb118d8fc',
    messagingSenderId: '172562951861',
    projectId: 'intelli-traffic',
    storageBucket: 'intelli-traffic.appspot.com',
    iosBundleId: 'com.example.intelTraffic',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8GFYcfeBtbONy94KeTSC4VABpp9vj7VY',
    appId: '1:172562951861:web:d43259605b85c50a18d8fc',
    messagingSenderId: '172562951861',
    projectId: 'intelli-traffic',
    authDomain: 'intelli-traffic.firebaseapp.com',
    storageBucket: 'intelli-traffic.appspot.com',
    measurementId: 'G-JQ3T8QK9HW',
  );
}