import 'package:canvas_app/authentication/auth_service.dart';
import 'package:canvas_app/screens/canvas_screen.dart';
import 'package:canvas_app/widgets/password_text_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  Future<void> signUp() async {
    // TODO:
    // check input and sign up your user via your AuthService
    // -> supabase will check if mail address input is valid and return an error if not
    // -> you need to e.g. check if both password inputs are the same
    debugPrint('onPressed: sign up');
    debugPrint('email input: ${emailController.text}');
    debugPrint('password input: ${passwordController.text}');
    debugPrint('password input: ${password2Controller.text}');

    AuthService authService = AuthService();

    bool isSignedUp = await authService.signUpNewUser(
      emailController.text,
      passwordController.text,
    );
    // TODO:
    // if the signup is successfull we want to navigate to the CanvasScreen
    // for now we just navigate to the canvas screen here without actual sign up
    // -> you need to change this
    // -> if signup is a success you use Navigator.pop(context) to remove this SignupScreen from navigation/route stack
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
              PasswordTextField(controller: password2Controller),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  fixedSize: Size.fromWidth(double.maxFinite),
                ),
                onPressed: signUp,
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
