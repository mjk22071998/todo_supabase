import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/view_models/signup.dart';
import 'package:todo_supabase/widgets/textfields.dart';
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
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (_) => SignUpViewModel(),
      child: Consumer<SignUpViewModel>(
        builder:(context, provider, child)=> Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 100, 181, 246),
                  Color.fromARGB(255, 33, 150, 243)
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
                        // Heading
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
        
                        // Name input field
                        MyTextField(
                          label: "Name",
                          obscureText: false,
                          inputType: TextInputType.name,
                          icon: Icons.person,
                          controller: nameController,
                        ),
                        const SizedBox(height: 10),
        
                        // Email input field
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
                        const SizedBox(height: 10),
        
                        // Confirm password input field
                        MyTextField(
                          label: "Confirm Password",
                          obscureText: true,
                          inputType: TextInputType.text,
                          icon: Icons.password,
                          controller: cpasswordController,
                        ),
        
                        // Sign Up button
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
                                Navigator.pop(context);
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
                        // Already have an account? Log In link
                        TextButton(
                          onPressed: () {
                            // Log In link logic goes here
                            Navigator.pop(context);
                          },
                          child: const Text('Already have an account? Log In'),
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

/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_supabase/viewmodels/sign_up_view_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpViewModel(),
      child: Scaffold(
        // ... rest of the UI code remains the same ...
        ElevatedButton(
          onPressed: () async {
            if (Provider.of<SignUpViewModel>(context, listen: false)
                .validate(
                    _emailController.text.trim(),
                    _nameController.text.trim(),
                    _passwordController.text.trim(),
                    _cpasswordController.text.trim())) {
              bool signedup = await Provider.of<SignUpViewModel>(context, listen: false)
                  .signUpUser(
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      _nameController.text.trim());
              if (signedup) {
                Navigator.pop(context);
              }
            }
          },
          // ... rest of the button code remains the same ...
        ),
      ),
    );
  }
}
*/