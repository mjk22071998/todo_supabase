import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/layouts/signup_screen.dart';
import 'package:todo_supabase/view_models/login.dart';
import 'package:todo_supabase/widgets/textfields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Consumer<LoginModel>(
        builder: (context, provider, child) => Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 90, 180, 253),
                  Color.fromARGB(255, 28, 153, 255)
                ],
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
                        MyTextField(
                          label: "Email",
                          obscureText: false,
                          inputType: TextInputType.emailAddress,
                          icon: Icons.alternate_email,
                          controller: emailController,
                        ),
                        const SizedBox(height: 10),
                        // Password input field
                        MyTextField(
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
                            bool loggedin = await provider.login(
                                emailController.text, passwordController.text);
                            if (loggedin) {
                              Fluttertoast.showToast(msg: "User Logged In");
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
                                  builder: (context) => const SignUpPage()),
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
