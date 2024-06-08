import 'package:flutter/material.dart';
import 'package:halves/core/styles/app_theme.dart';
import 'package:halves/features/auth/presentation/widgets/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppThemeData.authTheme.scaffoldBackgroundColor,
      body: const Body(),
    );
  }
}
