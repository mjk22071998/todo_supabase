import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/screens/home_screen.dart';
import 'package:todo_supabase/screens/signup_screen.dart';
import 'package:todo_supabase/providers/login_provider.dart';
import 'package:todo_supabase/utils/colors.dart';
import 'package:todo_supabase/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<_LoginScreenState> key = GlobalKey();
  SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, provider, child) => Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [blueGradientTop, blueGradientBottom],
              ),
            ),
            child: Center(
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Person avatar
                        Icon(Icons.person, size: 50, color: Colors.blue[500]),
                        const SizedBox(height: 10),
                        // Username input field
                        TodoTextField(
                          label: "Email",
                          obscureText: false,
                          inputType: TextInputType.emailAddress,
                          icon: Icons.email,
                          controller: emailController,
                        ),
                        const SizedBox(height: 10),
                        // Password input field
                        TodoTextField(
                          label: "Password",
                          obscureText: true,
                          inputType: TextInputType.text,
                          icon: Icons.password,
                          controller: passwordController,
                        ),

                        // Login button
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            Set<Object> set = await provider.login(
                                emailController.text, passwordController.text);
                            bool loggedin = bool.parse(set.first.toString());
                            String userId = set.last.toString();
                            if (loggedin) {
                              Fluttertoast.showToast(msg: "User Logged In");
                              Navigator.pushReplacement(
                                  key.currentContext!,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                            userId: userId,
                                          )));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "User failed to Log in");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[500],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('LOGIN'),
                        ),

                        // Forgot password link
                        TextButton(
                          onPressed: () {
                            // Forgot password logic goes here
                          },
                          child: const Text('Forgot Password?'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            // Forgot password logic goes here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                            );
                          },
                          child:
                              const Text('Already have account? Sign up here'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
