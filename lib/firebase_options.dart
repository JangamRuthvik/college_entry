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
    apiKey: 'AIzaSyAf9V490xONl98Wscbii-ywgMqEg3dkBlY',
    appId: '1:472314911811:web:9d945b3a92c659510a88f6',
    messagingSenderId: '472314911811',
    projectId: 'outpaist',
    authDomain: 'outpaist.firebaseapp.com',
    storageBucket: 'outpaist.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA3v_moptSiMZ6Cv1y8FjxmYocwER02XHw',
    appId: '1:472314911811:android:8bf02c994f5fdc790a88f6',
    messagingSenderId: '472314911811',
    projectId: 'outpaist',
    storageBucket: 'outpaist.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBc5FMJ05vP8aPF1Gf9tNBGtSYqRUaGDsc',
    appId: '1:472314911811:ios:001b065d504dbb2e0a88f6',
    messagingSenderId: '472314911811',
    projectId: 'outpaist',
    storageBucket: 'outpaist.appspot.com',
    iosClientId: '472314911811-n2p0piec8ulou5c02hrv50l4m18aqill.apps.googleusercontent.com',
    iosBundleId: 'com.example.collegeEntry',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBc5FMJ05vP8aPF1Gf9tNBGtSYqRUaGDsc',
    appId: '1:472314911811:ios:b682b86baa47a68a0a88f6',
    messagingSenderId: '472314911811',
    projectId: 'outpaist',
    storageBucket: 'outpaist.appspot.com',
    iosClientId: '472314911811-7uua66ocj7qp9ifj4e601ruk8tqcj0p8.apps.googleusercontent.com',
    iosBundleId: 'com.example.collegeEntry.RunnerTests',
  );
}
