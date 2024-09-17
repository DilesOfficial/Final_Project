import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import '../../core/constants/app_defaults.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text(
                '''Welcome to FRESH FIND, your smart assistant for identifying fresh produce and purchasing fruits and vegetables online. Our app uses advanced AI-powered image recognition technology to help you identify a wide variety of fruits and vegetables with just a photo. Whether you're at the market or at home, our app makes it easy to recognize unfamiliar produce, learn about its ripeness, and get recommendations.

In addition to helping you identify fresh produce, we offer a seamless shopping experience where you can browse, purchase, and have fresh fruits and vegetables delivered right to your doorstep. With [Your App Name], you get access to top-quality produce, combined with the convenience of online shopping—all in one place.

Our mission is to make healthy eating and sustainable shopping easier by using the latest AI technology to empower consumers and support local farmers and retailers. Thank you for choosing [Your App Name]—your trusted companion for all things fresh and healthy!''')
          ],
        ),
      ),
    );
  }
}
