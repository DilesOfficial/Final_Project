import '../../../core/constants/app_images.dart';
import 'onboarding_model.dart';

class OnboardingData {
  static List<OnboardingModel> items = [
    OnboardingModel(
      imageUrl: AppImages.onboarding1,
      headline: 'Scan Fruits & Vegetables',
      description:
          'Quickly scan and predict the name of fruits and vegetables. The app identify it in seconds.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding2,
      headline: 'Amazing Discounts & Offers',
      description:
          'Unlock exclusive discounts and exciting offers on your favorite products in best quality.',
    ),
    OnboardingModel(
      imageUrl: AppImages.onboarding3,
      headline: 'Delivery in 30 Min',
      description:
          'Get your orders delivered to your doorstep in just 30 minutes. Fast and reliable delivery service',
    ),
  ];
}
