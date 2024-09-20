import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/models/users.dart';
import 'package:todo_supabase/widgets/textfields.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SupabaseClient supabase = Supabase.instance.client;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        if (validate(context)) {
                          bool signedup = await signUpUser(
                              emailController.text.trim(),
                              passwordController.text.trim());
                          if (signedup) {
                            Users user = Users(
                              name: nameController.text,
                              email: emailController.text,
                            );
                            supabase.from("users").insert(user.toMap());
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
    );
  }

  bool validate(BuildContext context) {
    if (emailController.text.isEmpty ||
        !EmailValidator.validate(emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter your email"),
        ),
      );
      return false;
    } else if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter your name"),
        ),
      );
      return false;
    } else if (passwordController.text.isEmpty ||
        passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter a strong password"),
        ),
      );
      return false;
    } else if (cpasswordController.text != passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords does not match"),
        ),
      );
      return false;
    } else {
      return true;
    }
  }

  Future<bool> signUpUser(String email, String password) async {
    AuthResponse authResponse =
        await supabase.auth.signUp(password: password, email: email);
    if (authResponse.user != null) {
      Fluttertoast.showToast(msg: "User Signed Up");
      return true;
    } else {
      Fluttertoast.showToast(msg: "User Sign up failed");
      return false;
    }
  }
}
