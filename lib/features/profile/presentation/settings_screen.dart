import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:halves/core/constants/text_constants.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => context.go('/profile'),
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 36,
          ),
        ),
        title: Text(
          AppTextConstants.settingsText,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(LoginOutEvent());
            context.go('/auth/login');
          },
          child: Text(AppTextConstants.settingsLogoutText),
        ),
      ),
    );
  }
}
