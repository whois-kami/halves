import 'package:flutter/material.dart';
import 'package:halves/app/halves_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/services/firebase_options.dart';
import 'core/services/service_locator.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.setup();

  runApp(const HalvesApp());
}
