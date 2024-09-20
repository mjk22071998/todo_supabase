import 'package:flutter/material.dart';
import 'package:todo_supabase/layouts/signup.dart';
import 'package:todo_supabase/widgets/textfields.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:const EdgeInsets.all(10.0),
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

                    // Login button
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
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
                        print('Forgot password link clicked!');
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
                          MaterialPageRoute(builder: (context) =>const SignUpPage()),
                        );
                      },
                      child: const Text('Already have account? Sign up here'),
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
