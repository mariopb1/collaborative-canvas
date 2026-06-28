import 'package:canvas_app/screens/canvas_screen.dart';
import 'package:canvas_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  AuthGate({super.key});
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: supabase.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          // Check if we have an active and valid session
          final session = snapshot.hasData ? snapshot.data!.session : null;
          // If yes, show the MainScreen of the App. This screen will only be available for logged in users. If not, the LoginScreen is displayed.
          if (session != null) {
            return CanvasScreen();
           // return MainScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
