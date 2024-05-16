import 'package:flutter/material.dart';
import 'package:halves/core/routes/app_routes.dart';

class HalvesApp extends StatelessWidget {
  const HalvesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
