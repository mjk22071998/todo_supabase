import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_supabase/models/user_model.dart';

class SessionManager {
  static const String name = "name";
  static const String email = "email";
  static const String id = "id";

  static void saveUser(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(name, user.name);
    await sharedPreferences.setString(email, user.email);
    await sharedPreferences.setString(id, user.id);
  }

  static Future<UserModel> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    UserModel user = UserModel(
        id: sharedPreferences.getString(id)?? "",
        name: sharedPreferences.getString(name)?? "",
        email: sharedPreferences.getString(email)?? "");
    return user;
  }
  
  static Future<void> logoutUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    
    await sharedPreferences.setString(name, "");
    await sharedPreferences.setString(email, "");
    await sharedPreferences.setString(id, "");
    
  }
}
