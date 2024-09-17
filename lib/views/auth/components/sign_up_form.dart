import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/validators.dart';
import 'already_have_accout.dart';
import 'sign_up_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  // Use TextEditingController for each field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: AppDefaults.boxShadow,
          borderRadius: AppDefaults.borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Name"),
            const SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              validator: Validators.requiredWithFieldName('Name').call,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Email"),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              validator: Validators.required.call,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Password"),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              validator: Validators.required.call,
              textInputAction: TextInputAction.next,
              obscureText: true,
            ),
            const SizedBox(height: AppDefaults.padding),
            SignUpButton(
              formKey: _formKey, // Pass the form key
              nameController: _nameController,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const AlreadyHaveAnAccount(),
            const SizedBox(height: AppDefaults.padding),
          ],
        ),
      ),
    );
  }
}
