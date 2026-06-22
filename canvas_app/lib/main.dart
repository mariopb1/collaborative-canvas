import 'package:canvas_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // TODO: here you will need to initialize your connection to the supabase backend

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // TODO:
      // for now we will start our app with the login screen
      // you will need to change this to your AuthGate
      home: const LoginScreen(),
    );
  }
}
