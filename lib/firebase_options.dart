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
    apiKey: 'AIzaSyDWCqmLm5zA572Bre_5EmC87n65asIc8VE',
    appId: '1:431560517476:web:cb0d05b1dd5c6a8ed3fc71',
    messagingSenderId: '431560517476',
    projectId: 'pillow-99baf',
    authDomain: 'pillow-99baf.firebaseapp.com',
    storageBucket: 'pillow-99baf.firebasestorage.app',
    measurementId: 'G-27GC7TB816',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMMfXcHIPaWKQvy7ACffYEmzeNNL0nDTw',
    appId: '1:431560517476:android:340deffbb20027a8d3fc71',
    messagingSenderId: '431560517476',
    projectId: 'pillow-99baf',
    storageBucket: 'pillow-99baf.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmsod2jawMtE--LHN0VOjNmyHvhVBvpro',
    appId: '1:431560517476:ios:93bc7582eb12f460d3fc71',
    messagingSenderId: '431560517476',
    projectId: 'pillow-99baf',
    storageBucket: 'pillow-99baf.firebasestorage.app',
    iosBundleId: 'com.example.pillow',
  );
}
