import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // Get a reference your Supabase client
  final supabase = Supabase.instance.client;

  Future<dynamic> signUpNewUser(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (res.user != null && res.user?.aud == 'authenticated') {
        return true;
      }
    } on AuthApiException catch (error) {
      debugPrint(error.message + "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

      if (error.message.contains("should")) {
        return "Das Kennwort muss mindestens 6 Zeichen enthalten.";
      }

      // TODO: Implement Error Handling!
      // Erledigt
      return "Die Registrierung ist fehlgeschlagen.";
    }
    return null;
  }

  // Meldet einen Benutzer mit E-Mail und Passwort an.
  Future<dynamic> loginWithEmail(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      //res.session ist die aktuelle Login-Sitzung.
      if (res.user != null && res.session != null) {
        return true;
      }
    } on AuthApiException catch (error) {
      return "E-Mail-Adresse oder Passwort ist falsch.";
    }

    return null;
  }

  // Methode, die den User ausloggt
  Future<dynamic> signOut() async {
    try {
      await supabase.auth.signOut();
      return true;
    } on AuthApiException catch (error) {
      debugPrint(error.message);
    }

    return null;
  }
}
