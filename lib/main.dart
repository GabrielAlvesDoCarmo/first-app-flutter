import 'package:firebase_core/firebase_core.dart';
import 'package:fisrt_app_flutter/screens/login_screen.dart';
import 'package:fisrt_app_flutter/utils/constants/constants.dart';
import 'package:flutter/material.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(const MyApp());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: Constants.apiKey,
      appId: Constants.appId,
      messagingSenderId: Constants.messagingSenderId,
      projectId: Constants.projectId,
      // authDomain: Constants.authDomain,
      // databaseURL: Constants.databaseURL,
      // storageBucket: Constants.storageBucket,
    ),
  );
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
