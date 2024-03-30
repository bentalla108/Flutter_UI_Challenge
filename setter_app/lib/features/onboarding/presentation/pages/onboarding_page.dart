import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:setter_app/core/commons/constants/colors.dart';
import 'package:setter_app/core/commons/constants/text_constant.dart';

import '../widgets/onboarding_model.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final LiquidController liquidController = LiquidController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> onBoardingScrern = BText.onBoarding
        .asMap()
        .map((index, e) {
          print(e);
          return MapEntry(
            index,
            OnBoardingItems(
              onBoardingModel: OnBoardingModel(
                content: e['content']!,
                img: e['img']!,
                title: e['title']!,
                pageCounter: index + 1, // Utilisez l'index comme pageCounter
              ),
            ),
          );
        })
        .values
        .toList();
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
              onPageChangeCallback: (index) {
                setState(() {});
              },
              liquidController: liquidController,
              pages: onBoardingScrern),
          Positioned(
              top: 30,
              right: 30,
              child: TextButton(onPressed: () {}, child: Text('Skip'))),
        ],
      ),
    );
  }
}

class OnBoardingItems extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const OnBoardingItems({
    super.key,
    required this.onBoardingModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Spacer(),
          Image.asset(onBoardingModel.img),
          Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                (onBoardingModel.title),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(
                (onBoardingModel.content),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              )
            ],
          ),
          const Spacer(),
          CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: BColors.primaryColor,
            value: onBoardingModel.pageCounter / 3,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
