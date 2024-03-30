import 'package:flutter/material.dart';

import 'features/onboarding/presentation/widgets/next_page_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BNext(
        totalPages: 4,
      ),
    );
  }
}
