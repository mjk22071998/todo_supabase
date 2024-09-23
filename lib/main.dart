import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/layouts/login_screen.dart';

const supabaseUrl = 'https://kvjtrrupyptymklnvkow.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt2anRycnVweXB0eW1rbG52a293Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyNjgxMTk0MywiZXhwIjoyMDQyMzg3OTQzfQ.d9qIejsduKM9GuL81UMBYz48NrWqArfd2tR4oXTsiGs';


Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const LoginPage(),
    );
  }
}