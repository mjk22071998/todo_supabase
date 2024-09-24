import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/layouts/homescreen.dart';

import 'package:todo_supabase/layouts/login_screen.dart';
import 'package:todo_supabase/models/users.dart';
import 'package:todo_supabase/session/session_manager.dart';

const supabaseUrl = 'https://kvjtrrupyptymklnvkow.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt2anRycnVweXB0eW1rbG52a293Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyNjgxMTk0MywiZXhwIjoyMDQyMzg3OTQzfQ.d9qIejsduKM9GuL81UMBYz48NrWqArfd2tR4oXTsiGs';

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
      home: user.id==""? const LoginPage(): HomeScreen(userId: user.id),
    );
  }
}
