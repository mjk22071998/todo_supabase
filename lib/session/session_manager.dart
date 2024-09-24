import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_supabase/models/users.dart';

class SessionManager {
  static const String NAME = "name";
  static const String EMAIL = "email";
  static const String ID = "id";

  static void saveUser(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(NAME, user.name);
    sharedPreferences.setString(EMAIL, user.email);
    sharedPreferences.setString(ID, user.id);
  }

  static Future<UserModel> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserModel user = UserModel(
        id: sharedPreferences.getString(ID)!,
        name: sharedPreferences.getString(NAME)!,
        email: sharedPreferences.getString(EMAIL)!);
    return user;
  }
}
