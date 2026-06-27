import 'package:canvas_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xwmbqeueyunbhcwmnzqw.supabase.co',
    anonKey: 'sb_publishable_oeZ8_EraDEGtHORv7Z864Q_R7QC_xQq',
  );
  runApp(MyApp());
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
