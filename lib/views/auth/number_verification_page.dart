import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';
import 'dialogs/verified_dialogs.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDefaults.padding),
                  margin: const EdgeInsets.all(AppDefaults.margin),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: AppDefaults.borderRadius,
                  ),
                  child: const Column(
                    children: [
                      EmailVerificationHeader(),
                      SizedBox(height: AppDefaults.padding * 3),
                      ResendButton(),
                      SizedBox(height: AppDefaults.padding),
                      VerifyButton(),
                      SizedBox(height: AppDefaults.padding),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerifyButton extends StatelessWidget {
  const VerifyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // Check if email is verified
          User? user = FirebaseAuth.instance.currentUser;
          await user?.reload(); // Reload to get the latest info

          if (user != null && user.emailVerified) {
            // If verified, show success dialog or navigate to the next page
            showGeneralDialog(
              barrierLabel: 'Dialog',
              barrierDismissible: true,
              context: context,
              pageBuilder: (ctx, anim1, anim2) => const VerifiedDialog(),
              transitionBuilder: (ctx, anim1, anim2, child) => ScaleTransition(
                scale: anim1,
                child: child,
              ),
            );
          } else {
            // Show an error if email is not verified yet
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email not verified yet!')),
            );
          }
        },
        child: const Text('Verify'),
      ),
    );
  }
}

class ResendButton extends StatelessWidget {
  const ResendButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Didn\'t get the email?'),
        TextButton(
          onPressed: () async {
            User? user = FirebaseAuth.instance.currentUser;

            if (user != null && !user.emailVerified) {
              // Resend email verification
              await user.sendEmailVerification();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Verification email resent!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Email already verified or user not logged in')),
              );
            }
          },
          child: const Text('Resend'),
        ),
      ],
    );
  }
}

class EmailVerificationHeader extends StatelessWidget {
  const EmailVerificationHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDefaults.padding),
        Text(
          'Check Your Email for a Verification Link',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppDefaults.padding * 3),
      ],
    );
  }
}
