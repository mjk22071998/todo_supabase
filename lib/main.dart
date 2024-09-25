import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/users.dart';
import 'package:todo_supabase/screens/home_screen.dart';
import 'package:todo_supabase/screens/login_screen.dart';
import 'package:todo_supabase/session/session_manager.dart';

const supabaseUrl = 'https://kvjtrrupyptymklnvkow.supabase.co';
const supabaseKey =
    'API KEY';

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  UserModel user = await SessionManager.getUser();
  runApp(MyApp(user: user,));
}

class MyApp extends StatelessWidget {
  UserModel user;
  MyApp({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: user.id==""? const LoginScreen(): HomeScreen(userId: user.id),
    );
  }
}
