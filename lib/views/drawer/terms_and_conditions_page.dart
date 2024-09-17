import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import 'components/faq_item.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Terms and Conditions'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleAndParagraph(
              isTitleHeadline: false,
              title: 'General Terms and Conditions',
              paragraph: '''
                  Welcome to FRESH FIND. By using our app, you agree to comply with and be bound by the following terms and conditions. Please review them carefully before using the app.''',
            ),
            TitleAndParagraph(
              isTitleHeadline: false,
              title: '1. Agreement to Terms',
              paragraph: '''
                  By accessing and using FRESH FIND, you agree to be bound by these terms and all applicable laws and regulations. If you do not agree to any of these terms, you are prohibited from using or accessing this app.''',
            ),
            TitleAndParagraph(
              isTitleHeadline: false,
              title: '2. User Accounts',
              paragraph: '''
                  To use certain features of the app, such as purchasing fruits and vegetables or saving image classification results, you may be required to register for an account. You are responsible for maintaining the confidentiality of your account details and for all activities that occur under your account.''',
            ),
            TitleAndParagraph(
              isTitleHeadline: false,
              title: '3. Use of the App',
              paragraph: '''
                  Our app provides AI-powered fruit and vegetable identification as well as a platform to purchase fresh produce. You agree to use the app only for lawful purposes and in a manner consistent with these terms. Any misuse of the app, such as fraud or submitting false data, may result in termination of your account.''',
            ),
            TitleAndParagraph(
              isTitleHeadline: false,
              title: '4. Purchase Terms',
              paragraph: '''
                  When purchasing fruits and vegetables through the app, you agree that:
                  - All purchases are final once confirmed.
                  - You are responsible for ensuring the accuracy of your order, including the items and delivery details.
                  - We strive to deliver fresh produce, but availability and delivery timelines may vary depending on location and supply.''',
            ),
            TitleAndParagraph(
              isTitleHeadline: false,
              title: '5. Relationship with Suppliers',
              paragraph: '''
                  We collaborate with local suppliers and farmers to provide the best quality produce. However, we are not liable for any issues related to the quality of goods delivered, as this remains the responsibility of the supplier. In case of any disputes, please contact customer support.''',
            ),
            TitleAndParagraph(
              isTitleHeadline: false,
              title: '6. Limitation of Liability',
              paragraph: '''
                  The app and its features, including AI-based fruit and vegetable classification, are provided on an "as-is" basis. We do not guarantee the accuracy of classifications or the availability of certain products for purchase. We are not liable for any indirect or direct damages arising from the use of this app.''',
            ),
            TitleAndParagraph(
              isTitleHeadline: false,
              title: '7. Changes to Terms',
              paragraph: '''
                  We reserve the right to modify these terms at any time. Any changes will be effective immediately upon posting within the app. It is your responsibility to review these terms periodically to stay informed of any updates.''',
            ),
            TitleAndParagraph(
              isTitleHeadline: false,
              title: '8. Contact Us',
              paragraph: '''
                  If you have any questions or concerns regarding these terms or the app's functionality, please contact us at info@freshfind.lk/+94 (77) 123 4567.''',
            ),
          ],
        ),
      ),
    );
  }
}
