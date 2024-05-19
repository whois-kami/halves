import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/core/routes/app_routes.dart';
import 'package:halves/core/services/service_locator.dart';
import 'package:halves/core/styles/app_theme.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';

class HalvesApp extends StatelessWidget {
  const HalvesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        theme: AppThemeData.halvesTheme,
        routerConfig: router,
      ),
    );
  }
}