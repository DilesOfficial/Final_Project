import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/constants.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            // Set form fields from Firestore (if applicable)
            _firstNameController.text = userDoc.get('firstName') ?? '';
            _lastNameController.text = userDoc.get('lastName') ?? '';
            _phoneController.text = userDoc.get('phoneNumber') ?? '';
            _genderController.text = userDoc.get('gender') ?? '';
            _birthdayController.text = userDoc.get('birthday') ?? '';
          });
        } else {
          print('User document does not exist in Firestore');
        }
      }
    } catch (e) {
      print('Failed to fetch user profile: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveUserProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'firstName': _firstNameController.text.trim(),
            'lastName': _lastNameController.text.trim(),
            'phoneNumber': _phoneController.text.trim(),
            'gender': _genderController.text.trim(),
            'birthday': _birthdayController.text.trim(),
          }, SetOptions(merge: true));
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')));
        }
      } catch (e) {
        print('Failed to save user profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save profile')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Profile'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(AppDefaults.padding),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding,
                  vertical: AppDefaults.padding * 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: AppDefaults.borderRadius,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* <---- First Name -----> */
                      const Text("First Name"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your first name'
                            : null,
                      ),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Last Name -----> */
                      const Text("Last Name"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your last name'
                            : null,
                      ),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Phone Number -----> */
                      const Text("Phone Number"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        validator: (value) => value!.isEmpty
                            ? 'Please enter your phone number'
                            : null,
                      ),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Gender -----> */
                      const Text("Gender"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _genderController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Birthday -----> */
                      const Text("Birthday"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _birthdayController,
                        keyboardType: TextInputType.datetime,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: AppDefaults.padding),

                      /* <---- Save Button -----> */
                      const SizedBox(height: AppDefaults.padding),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: saveUserProfile,
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }
}
