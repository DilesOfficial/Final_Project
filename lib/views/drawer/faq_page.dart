import 'package:flutter/material.dart';

import '../../core/components/app_back_button.dart';
import 'components/faq_item.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('FAQ'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleAndParagraph(
              title: '1. How long will it take for my order to be delivered?',
              paragraph: '''
                  Delivery times vary depending on your location and the availability of the items. Typically, orders are delivered within 1-3 business days. You will receive a confirmation email or notification with your estimated delivery time after placing an order.''',
            ),
            TitleAndParagraph(
              title: '2. How does the fruit and vegetable classification work?',
              paragraph: '''
                  Our app uses advanced AI technology, powered by Convolutional Neural Networks (CNNs), to identify fruits and vegetables through image recognition. Simply upload a photo or use your device’s camera, and the app will classify the item and provide additional information such as ripeness and quality.''',
            ),
            TitleAndParagraph(
              title: '3. What is the refund policy?',
              paragraph: '''
                  If you are not satisfied with the quality of your produce, you may be eligible for a refund. Please contact our customer support within 24 hours of delivery with details of the issue, and we will guide you through the process. Refunds are typically processed within 3-5 business days.''',
            ),
            TitleAndParagraph(
              title: '4. Can I cancel my order?',
              paragraph: '''
                  Yes, you can cancel your order before it has been dispatched for delivery. Once an order is dispatched, it can no longer be canceled. To cancel, please visit the "Orders" section in your account or contact customer support.''',
            ),
            TitleAndParagraph(
              title:
                  '5. How do I know the quality of the products I’m purchasing?',
              paragraph: '''
                  We work with trusted local suppliers and farmers to ensure top-quality produce. Our AI-powered classification also helps assess the ripeness and quality of fruits and vegetables, giving you additional assurance about the product's freshness before purchase.''',
            ),
            TitleAndParagraph(
              title: '6. Is my data safe with your app?',
              paragraph: '''
                  Yes, we take data privacy and security seriously. Your personal data and images are securely stored and managed in compliance with data protection regulations, including GDPR. We use Firebase for secure authentication and data storage.''',
            ),
            TitleAndParagraph(
              title: '7. What payment methods do you accept?',
              paragraph: '''
                  We accept various payment methods, including credit cards, debit cards, and mobile payment options. All payments are securely processed through our payment gateway, ensuring your information is safe and encrypted.''',
            ),
            TitleAndParagraph(
              title: '8. Can I save my favorite products for later?',
              paragraph: '''
                  Yes, you can add products to your favorites list for easy access during your next shopping session. Simply tap the "Add to Favorites" button on the product page, and it will be saved to your account.''',
            ),
          ],
        ),
      ),
    );
  }
}
