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
    }
    return null;
  }
}
