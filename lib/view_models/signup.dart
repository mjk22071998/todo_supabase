import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/users.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? _user;

  UserModel? get user => _user;

  Future<bool> signUpUser(String email, String password, String name) async {
    AuthResponse authResponse =
        await _supabase.auth.signUp(password: password, email: email);
    if (authResponse.user != null) {
      try {
        _user = UserModel(id: authResponse.user!.id, name: name, email: email);
        final response = await _supabase.from("users").insert({
          "id": _user!.id,
          "email": _user!.email,
          "name": _user!.name
        }).select();
        log(response.toString());
        log(_user!.toJson());
      } catch (e) {
        log(e.toString());
        return false;
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool validate(String email, String name, String password, String cpassword) {
    if (email.isEmpty || !EmailValidator.validate(email)) {
      return false;
    } else if (name.isEmpty) {
      return false;
    } else if (password.isEmpty || password.length < 8) {
      return false;
    } else if (cpassword != password) {
      return false;
    } else {
      return true;
    }
  }
}
