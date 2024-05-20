import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/features/auth/presentation/auth_screen.dart';
import 'package:halves/features/auth/presentation/widgets/signup_screen.dart';
import 'package:halves/features/auth/presentation/widgets/onboarding_screens.dart';
import 'package:halves/features/searching/presentation/widgets/fill_profile_screen.dart';
import 'package:halves/features/searching/presentation/widgets/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) {
          return FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return throw ('${snapshot.error}');
              } else {
                final prefs = snapshot.data;
                final isFirstLaunch = prefs?.getBool('isFirstLaunch') ?? true;
                if (isFirstLaunch) {
                  prefs?.setBool('isFirstLaunch', false);
                  return const OnBoardingScreens();
                } else {
                  return const AuthScreen();
                }
              }
            },
          );
        }),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
      routes: [
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignUpScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainSearchScreen(),
      routes: [
        GoRoute(
          path: 'fillProfile',
          builder: (context, state) => const FillProfileScreen(),
        ),
      ],
    ),
  ],
);
