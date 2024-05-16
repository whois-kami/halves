import 'package:go_router/go_router.dart';
import 'package:halves/features/auth/presentation/widgets/onboarding_screens.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnBoardingScreens(),
    ),
  ],
);
