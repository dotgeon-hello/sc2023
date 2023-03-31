import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBnKG5J9Ytde7NlOiT_D49p7RekbbPqxcE",
            authDomain: "codename-sc.firebaseapp.com",
            projectId: "codename-sc",
            storageBucket: "codename-sc.appspot.com",
            messagingSenderId: "201877789698",
            appId: "1:201877789698:web:2aa60bee4f397601af1b1b",
            measurementId: "G-4FV2RHD12K"));
  } else {
    await Firebase.initializeApp();
  }
}
