import 'package:flutter/material.dart';
import 'package:halves/core/styles/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final screens = const [
    OnBoardingScreenFirst(),
    OnBoardingScreenSecond(),
    OnBoardingScreenThird(),
  ];
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  r'lib\assets\images\onboarding_screens\scaffold-bg.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndexPage = index;
                    });
                  },
                  children: screens,
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: screens.length,
                effect: const WormEffect(
                  spacing: 9,
                  dotColor: Color(0xFFD9D9D9),
                  activeDotColor: Color(0xFFFF26B2),
                  dotHeight: 15,
                  dotWidth: 15,
                  type: WormType.normal,
                ),
                onDotClicked: (int index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      backgroundColor: AppThemeData.onBoardingTheme.scaffoldBackgroundColor,
    );
  }
}

class OnBoardingScreenFirst extends StatelessWidget {
  const OnBoardingScreenFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.19),
        const Image(
          width: 400,
          height: 400,
          image: AssetImage(
              r'lib\assets\images\onboarding_screens\first-screen.png'),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'There is ',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansDevanagari',
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'a halves',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansDevanagari',
                  color: Color(0xFFFF26B2),
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text:
                    ' for each\nand everyone, All you need to\n do is to find your soulmate.',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansDevanagari',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnBoardingScreenSecond extends StatelessWidget {
  const OnBoardingScreenSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.12),
        const Image(
            width: 400,
            height: 400,
            image: AssetImage(
                r'lib\assets\images\onboarding_screens\second-screen.png')),
        SizedBox(height: MediaQuery.of(context).size.height * 0.11),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text:
                    'Share every details over Chat,\n Call them, Video call and know\n them better before you',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansDevanagari',
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: ' meet.',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansDevanagari',
                  color: Color(0xFFFF26B2),
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnBoardingScreenThird extends StatelessWidget {
  const OnBoardingScreenThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
        ),
        const Image(
            width: 400,
            height: 400,
            image: AssetImage(
                r'lib\assets\images\onboarding_screens\third-screen.png')),
        SizedBox(height: MediaQuery.of(context).size.height * 0.11),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t wait anymore, Find your\n',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansDevanagari',
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: 'soulmate here',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansDevanagari',
                  color: Color(0xFFFF26B2),
                  fontSize: 24,
                ),
              ),
              TextSpan(
                text: ' right now! Just\n by swipping',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansDevanagari',
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
