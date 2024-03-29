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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRFojC6dTEDuOcKFmeHPku9P_4bhqDb-o',
    appId: '1:777810629251:android:d386dcda27466743f381b6',
    messagingSenderId: '777810629251',
    projectId: 'sky-trade-ca6e1',
    databaseURL: 'https://sky-trade-ca6e1-default-rtdb.firebaseio.com',
    storageBucket: 'sky-trade-ca6e1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABB3dt5Kcq0JL7TbsiaEf_szOVPkNLFGI',
    appId: '1:777810629251:ios:2a1b60b05b1fdb2af381b6',
    messagingSenderId: '777810629251',
    projectId: 'sky-trade-ca6e1',
    databaseURL: 'https://sky-trade-ca6e1-default-rtdb.firebaseio.com',
    storageBucket: 'sky-trade-ca6e1.appspot.com',
    iosBundleId: 'com.example.tenawoBeslkwo',
  );
}
