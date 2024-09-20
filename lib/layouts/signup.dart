import 'package:flutter/material.dart';
import 'package:todo_supabase/widgets/textfields.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                    const MyTextField(
                      label: "Name",
                      obscureText: false,
                      inputType: TextInputType.name,
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 10),

                    // Email input field
                    const MyTextField(
                      label: "Email",
                      obscureText: false,
                      inputType: TextInputType.emailAddress,
                      icon: Icons.alternate_email,
                    ),
                    const SizedBox(height: 10),

                    // Password input field
                    const MyTextField(
                      label: "Password",
                      obscureText: true,
                      inputType: TextInputType.text,
                      icon: Icons.password,
                    ),
                    const SizedBox(height: 10),

                    // Confirm password input field
                    const MyTextField(
                      label: "Confirm Password",
                      obscureText: true,
                      inputType: TextInputType.text,
                      icon: Icons.password,
                    ),

                    // Sign Up button
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Sign up logic goes here
                        print('Sign Up button clicked!');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[500],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Sign Up'),
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
}
