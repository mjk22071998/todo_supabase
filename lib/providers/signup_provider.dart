import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:todo_supabase/utils/constants.dart';

class SignUpProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<bool> signUpUser(String email, String password, String name) async {
    AuthResponse authResponse =
        await supabase.auth.signUp(password: password, email: email);
    if (authResponse.user != null) {
      try {
        _user = UserModel(id: authResponse.user!.id, name: name, email: email);
        final response = await supabase.from("users").insert({
          "id": _user!.id,
          "email": _user!.email,
          "name": _user!.name
        }).select();
        log(response.toString());
      } catch (e) {
        notifyListeners();
        log(e.toString());
        Fluttertoast.showToast(msg: "Failed to upload user data to database");
        return false;
      }
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: "Failed to sign up user");
      notifyListeners();
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
