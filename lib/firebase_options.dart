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
    apiKey: 'AIzaSyAkWOd5gjltpjA9sSsYjgwoMGkd6ETHV1I',
    appId: '1:687536711646:web:36d3734586edb60439df4f',
    messagingSenderId: '687536711646',
    projectId: 'fir-riverpod-5ac6f',
    authDomain: 'fir-riverpod-5ac6f.firebaseapp.com',
    storageBucket: 'fir-riverpod-5ac6f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDt-TD3PRJRV7-P4RhUlnKszrwet8ltZ7k',
    appId: '1:687536711646:android:442fdc3a8eca5d8e39df4f',
    messagingSenderId: '687536711646',
    projectId: 'fir-riverpod-5ac6f',
    storageBucket: 'fir-riverpod-5ac6f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcBiT9AhLVJwkUNsTk4SlDHEztjDjcyAQ',
    appId: '1:687536711646:ios:78f13d21c0dab8e839df4f',
    messagingSenderId: '687536711646',
    projectId: 'fir-riverpod-5ac6f',
    storageBucket: 'fir-riverpod-5ac6f.appspot.com',
    iosClientId: '687536711646-93j366cdhgh7o7scrjh6othb2j34kjsl.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseRiverpod',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDcBiT9AhLVJwkUNsTk4SlDHEztjDjcyAQ',
    appId: '1:687536711646:ios:78f13d21c0dab8e839df4f',
    messagingSenderId: '687536711646',
    projectId: 'fir-riverpod-5ac6f',
    storageBucket: 'fir-riverpod-5ac6f.appspot.com',
    iosClientId: '687536711646-93j366cdhgh7o7scrjh6othb2j34kjsl.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseRiverpod',
  );
}
