class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnboardingModel> onboarding = [
    OnboardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Discover the Latest Tech',
      description:
          'Your gateway to smartphones, laptops, tablets & headphones.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Shop Top Brands',
      description:
          'Browse leading global brands with a clean and modern experience.',
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Fast Delivery & Secure Payment',
      description: 'Enjoy quick delivery and safe, trusted payment methods.',
    ),
  ];
}
