import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/user_model.dart';
import 'package:todo_supabase/session/session_manager.dart';
import 'package:todo_supabase/utils/constants.dart';

class LoginModel with ChangeNotifier {

  Future<Set<Object>> login(String email, String password) async {
    notifyListeners();
    try {
      AuthResponse response = await supabase.auth.signInWithPassword(
        password: password.trim(),
        email: email.trim(),
      );
      if (response.user != null) {
        try {
          final postgrestResponse = await supabase
              .from("users")
              .select("*")
              .eq("id", response.user!.id);
          log(postgrestResponse.toString());
          SessionManager.saveUser(UserModel.fromMap(postgrestResponse[0]));
        } on PostgrestException catch (e) {
          log(e.toString());
          return {false,""}; // handle the error
        }
        return {true, response.user!.id};
      } else {
        return {false,""};
      }
    } catch (e) {
      log(e.toString());
      return {false,""};
    } finally {
      notifyListeners();
    }
  }
}

