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
    // TODO: sign in your user via your AuthService
    debugPrint('onPressed: sign in');
    debugPrint('email input: ${emailController.text}');
    debugPrint('password input: ${passwordController.text}');

    // TODO:
    // to start we just navigate to the canvas screen here without actual login
    // -> you need to change this
    // in your solution the AuthGate will handle this navigation, you need to remove it here
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CanvasScreen()),
    );
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
