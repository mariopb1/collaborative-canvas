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
    // if the signup is successfull we want to navigate to the CanvasScreen
    // for now we just navigate to the canvas screen here without actual sign up
    // -> you need to change this
    // -> if signup is a success you use Navigator.pop(context) to remove this SignupScreen from navigation/route stack

    //Erledigt: Wir prüfen für jeden einzelnen Fall was der "error" ist und geben was entsprechend zurück.

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        password2Controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bitte füllen Sie alle Felder aus.")),
      );
      return;
    }
    if (passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Das Kennwort muss mindestens 6 Zeichen enthalten."),
        ),
      );
      return;
    }

    if (!emailController.text.contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Bitte geben Sie eine gültige E-Mail-Adresse ein."),
        ),
      );
      return;
    }
    ;

    if (passwordController.text != password2Controller.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Die Passwörter stimmen nicht überein.")),
      );
      return;
    }
    ;

    final AuthService authService = AuthService();

    final registered = await authService.signUpNewUser(
      emailController.text,
      passwordController.text,
    );
    if (registered == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registrierung erfolgreich.")));
      final login = await authService.loginWithEmail(
        emailController.text,
        passwordController.text,
      );
      // Prüft, ob der automatische Login nach der Registrierung erfolgreich war
      if (login == true) {
        Navigator.pop(context);
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(registered)));
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
