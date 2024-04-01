import 'package:flutter/material.dart';
import 'package:project_namaa/models/onboarding_model.dart';
import 'package:project_namaa/screens/loginScreen.dart';
import 'package:project_namaa/shared/Cache_Helper/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/constant.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  PageController controller = PageController();
  bool isLast = false;

  onPageChanged(int index) {
    if (index == 2) {
      isLast = true;
    } else {
      isLast = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            onPageChanged: onPageChanged,
            controller: controller,
            itemBuilder: (context, index) {
              return SizedBox(
                child: pageWithGradient(
                  context,
                  image: "${index + 1}.jpg",
                  title: titles[index],
                  subtitle: subtitles[index],
                ),
              );
            },
            itemCount: 3,
          ),
          Positioned(
            right: 10,
            top: 30,
            child: TextButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: whiteColor,
              ),
              child: const Text('Skip'),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 30,
            child: SmoothPageIndicator(
              effect: const ExpandingDotsEffect(
                activeDotColor: secondaryColor,
                dotColor: whiteColor,
              ),
              controller: controller,
              count: 3,
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (!isLast) {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.linearToEaseOut);
                } else {
                  CacheHelper()
                      .saveData(key: 'onBoarding', value: true)
                      .then((value) {});
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                      // !here put cache
                    ),
                  );
                }
              },
              splashColor: whiteColor.withOpacity(.2),
              hoverColor: whiteColor.withOpacity(.2),
              focusColor: whiteColor.withOpacity(.2),
              backgroundColor: secondaryColor,
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageWithGradient(
    BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          'asset/images/$image',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor.withOpacity(.5),
                primaryColor.withOpacity(0),
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: whiteColor,
                        fontSize: 28,
                        fontFamily: 'Poppins')),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                      color: whiteColor.withOpacity(.7), fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
// check