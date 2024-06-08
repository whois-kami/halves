import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/features/auth/presentation/widgets/login_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    if (FirebaseAuth.instance.currentUser != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.go('/search');
      });
      return const SizedBox.shrink();
    } else {
      return const LoginScreen();
    }
  }
}
