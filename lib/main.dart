import 'package:firebase_core/firebase_core.dart';
import 'package:fisrt_app_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCud_H563iv6VsByOK6vJvrAKAP1g3QzPM",
      appId: "1:976374869459:ios:9b26660a1d97bd123ed326",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      projectId: "first-app-flutter-95369",
      // authDomain: "YOUR_AUTH_DOMAIN",
      // databaseURL: "YOUR_DATABASE_URL",
      // storageBucket: "YOUR_STORAGE_BUCKET",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Container(
        color: Colors.blue,
        child: SafeArea(
          child: LoginScreen(),
        ),
      ),
    );
  }
}
