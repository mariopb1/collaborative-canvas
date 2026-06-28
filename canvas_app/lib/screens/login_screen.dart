import 'package:canvas_app/authentication/auth_service.dart';
import 'package:canvas_app/screens/canvas_screen.dart';
import 'package:canvas_app/screens/signup_screen.dart';
import 'package:canvas_app/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  

  Future<void> signIn() async {

    final AuthService authService = AuthService();
    // authService.loginWithEmail prüft ob der User seine Daten richtig angegeben hat und wenn nicht, dann liefert er
    // den entsprechenden Fehler
    final loggedIn = await authService.loginWithEmail(
  emailController.text,
  passwordController.text,
);
  if (loggedIn != true) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("E-Mail-Adresse oder Passwort ist falsch.\nBitte versuchen Sie es erneut."),
    ),
  );
  return;
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'E-Mail',
                  fillColor: Colors.grey,
                  filled: true,
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              PasswordTextField(controller: passwordController),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  fixedSize: Size.fromWidth(double.maxFinite),
                ),
                onPressed: signIn,
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              // hint to sign up with link to SignUpScreen
              Row(
                children: [
                  Text('Noch keinen Account? Zum Registrieren '),
                  TextButton(
                    onPressed: () {
                      debugPrint('onPressed: register new user');

                      // navigate to signup screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    // we want this TextButton to look like a link and therefore remove it's padding
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                    ),
                    child: Text('hier klicken!'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
