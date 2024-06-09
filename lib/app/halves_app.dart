import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halves/core/routes/app_routes.dart';
import 'package:halves/core/services/service_locator.dart';
import 'package:halves/core/styles/app_theme.dart';
import 'package:halves/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:halves/features/messaging/presentation/bloc/chat_bloc.dart';
import 'package:halves/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:halves/features/searching/presentation/bloc/search_bloc.dart';

class HalvesApp extends StatelessWidget {
  const HalvesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChatBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.halvesTheme,
        routerConfig: router,
      ),
    );
  }
}
