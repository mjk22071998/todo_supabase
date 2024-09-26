import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/providers/signup_provider.dart';
import 'package:todo_supabase/utils/colors.dart';
import 'package:todo_supabase/widgets/text_and_button.dart';
import 'package:todo_supabase/widgets/textfield.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpProvider>(
      create: (_) => SignUpProvider(),
      child: Consumer<SignUpProvider>(
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
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TodoTextField(
                          label: "Name",
                          obscureText: false,
                          inputType: TextInputType.name,
                          icon: Icons.person,
                          controller: nameController,
                        ),
                        const SizedBox(height: 10),

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
                        const SizedBox(height: 10),

                        TodoTextField(
                          label: "Confirm Password",
                          obscureText: true,
                          inputType: TextInputType.text,
                          icon: Icons.password,
                          controller: cpasswordController,
                        ),

                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (provider.validate(
                              emailController.text.trim(),
                              nameController.text.trim(),
                              passwordController.text.trim(),
                              cpasswordController.text.trim(),
                            )) {
                              bool signedup = await provider.signUpUser(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  nameController.text.trim());
                              if (signedup) {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
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
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Sign Up'),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ), 
                        TextAndButton(
                          text: "Already have an account?",
                          btnText: "Login here",
                          callback: goBack,
                        )
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

  void goBack() {
    Navigator.pop(context);
  }
}
