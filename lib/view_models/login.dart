import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/users.dart';
import 'package:todo_supabase/session/session_manager.dart';

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
        try {
          final dbResponse = await _supabase
              .from("users")
              .select("*")
              .eq("id", response.user!.id);
          log(dbResponse.toString());
          SessionManager.saveUser(UserModel.fromMap(dbResponse[0]));
        } on PostgrestException catch (e) {
          log(e.toString()); // handle the error
        }
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
