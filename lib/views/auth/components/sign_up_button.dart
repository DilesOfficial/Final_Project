import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/firestore_service.dart';
import 'package:logger/logger.dart'; // Import logger package

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';

class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  // Create a Logger instance
  final Logger _logger = Logger();

  SignUpButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
      child: Row(
        children: [
          Text(
            'Sign Up',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                // Get values from the controllers
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                if (name.isEmpty || email.isEmpty || password.isEmpty) {
                  // Show error message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill in all fields"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  _logger.e("Please fill in all fields");
                  return;
                }

                try {
                  // Create user using email and password
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password);

                  // Show success message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "User registered successfully: ${userCredential.user?.email}"),
                      backgroundColor: Colors.green,
                    ),
                  );

                  // Log success message after user registration
                  _logger.i(
                      'User registered successfully: ${userCredential.user?.email}');

                  // Save user information to Firestore (optional)
                  FirestoreService().addUser(name, email);

                  // Navigate to the next page
                  Navigator.pushNamed(context, AppRoutes.numberVerification);
                } catch (e) {
                  // Show error message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Registration failed: $e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  _logger.e('Registration failed: $e');
                }
              }
            },
            style: ElevatedButton.styleFrom(elevation: 1),
            child: SvgPicture.asset(
              AppIcons.arrowForward,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
