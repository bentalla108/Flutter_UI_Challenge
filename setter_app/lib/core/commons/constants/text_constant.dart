class BText {
  BText._();

  static String otpTitle = "OTP Verification";
  static String otpContent =
      "Nous vous enverrons un mot de passe à usage unique sur ce numéro de portable";

  static List<Map<String, String>> onBoarding = [
    {
      'title': 'Où que vous soyez',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been',
      'img': 'assets/images/onboarding1.png'
    },
    {
      'title': 'À tout moment',
      'content':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been',
      'img': 'assets/images/onboarding2.png'
    },
    {
      'title': 'Welcome',
      'content': 'Have a better sharing experience',
      'img': 'assets/images/onboarding3.png'
    },
  ];
}
