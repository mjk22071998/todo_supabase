import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/screens/home_screen.dart';
import 'package:todo_supabase/screens/signup_screen.dart';
import 'package:todo_supabase/providers/login_provider.dart';
import 'package:todo_supabase/utils/colors.dart';
import 'package:todo_supabase/widgets/text_and_button.dart';
import 'package:todo_supabase/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
      create: (_) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (context, provider, child) => Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: Container(
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
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              TodoTextField(
                                label: "Email",
                                obscureText: false,
                                inputType: TextInputType.emailAddress,
                                icon: Icons.email,
                                controller: emailController,
                              ),
                              const SizedBox(height: 10),
                              TodoTextField(
                                label: "Password",
                                obscureText: true,
                                inputType: TextInputType.text,
                                icon: Icons.password,
                                controller: passwordController,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () async {
                                  if (provider.validate(
                                      emailController.text.trim(),
                                      passwordController.text.trim())) {
                                    Set<Object> set = await provider.login(
                                        emailController.text.trim(),
                                        passwordController.text.trim());
                                    bool loggedin =
                                        bool.parse(set.first.toString());
                                    String userId = set.last.toString();
                                    if (loggedin) {
                                      Fluttertoast.showToast(
                                          msg: "User Logged In");
                                      if (context.mounted) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(
                                              userId: userId,
                                            ),
                                          ),
                                        );
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "User failed to Log in");
                                    }
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
                              TextButton(
                                onPressed: () {
                                  _showDialog(context);
                                },
                                child: const Text('Forgot Password?'),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextAndButton(
                                  text: "Don't have an account?",
                                  btnText: "Signup here",
                                  callback: toSignUpScreen)
                            ],
                          ),
                        ),
                      ),
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

  void _showDialog(BuildContext context) {
    final forgotPasswordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Forgot Password'),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TodoTextField(
              label: "Email",
              obscureText: false,
              inputType: TextInputType.emailAddress,
              icon: Icons.email,
              controller: forgotPasswordController,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (forgotPasswordController.text.isNotEmpty) {
                await supabase.auth.resetPasswordForEmail(
                    forgotPasswordController.text.trim());
                Fluttertoast.showToast(msg: "Password reset email sent");
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }

  void toSignUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }
}
