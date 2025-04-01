import 'package:firebase_core/firebase_core.dart';
import 'package:fisrt_app_flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
// import 'firebase_options.dart';'

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
