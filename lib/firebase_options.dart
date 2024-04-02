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
    apiKey: 'AIzaSyDcFzw8NGsmW11KTCdDFYfnZqzMtRMH6MA',
    appId: '1:565458584973:web:878bdd8e20233ef80ca9c4',
    messagingSenderId: '565458584973',
    projectId: 'soil-mate-1bd0b',
    authDomain: 'soil-mate-1bd0b.firebaseapp.com',
    storageBucket: 'soil-mate-1bd0b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOcypRubFSABySOA5zMZkv96q4vbWVH0g',
    appId: '1:565458584973:android:7e093e0ee59033f10ca9c4',
    messagingSenderId: '565458584973',
    projectId: 'soil-mate-1bd0b',
    storageBucket: 'soil-mate-1bd0b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFrLS0o6_uusf3ut3tOhnad-RJ6PreRZ0',
    appId: '1:565458584973:ios:94c42059ef0c19dd0ca9c4',
    messagingSenderId: '565458584973',
    projectId: 'soil-mate-1bd0b',
    storageBucket: 'soil-mate-1bd0b.appspot.com',
    iosBundleId: 'com.example.soilmateFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFrLS0o6_uusf3ut3tOhnad-RJ6PreRZ0',
    appId: '1:565458584973:ios:9b13ddbdf0aab98a0ca9c4',
    messagingSenderId: '565458584973',
    projectId: 'soil-mate-1bd0b',
    storageBucket: 'soil-mate-1bd0b.appspot.com',
    iosBundleId: 'com.example.soilmateFlutter.RunnerTests',
  );
}