import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginModel with ChangeNotifier {
  SupabaseClient _supabase = Supabase.instance.client;
  


  Future<bool> login(String email, String password) async {
    notifyListeners();
    try {
      AuthResponse response = await _supabase.auth.signInWithPassword(
        password: password.trim(),
        email: email.trim(),
      );
      if (response.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      notifyListeners();
    }
  }
}
