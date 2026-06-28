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
      // TODO: Implement Error Handling!
      // Erledigt: Falls wir eine Fehlermeldung beim Einlogen haben, dann zeigen wir, dass die E-Mail-Adresse oder Password falsch ist
      return "E-Mail-Adresse oder Passwort ist falsch.";
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
  debugPrint(error.message); 
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
