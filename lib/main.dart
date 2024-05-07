import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ncoininfos/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    // Replace with actual values
    // ignore: prefer_const_constructors
    options: FirebaseOptions(
      apiKey: "",
      appId: "",
      messagingSenderId: "",
      projectId: "",
    ),
  );
  runApp(const MyApp());
}
