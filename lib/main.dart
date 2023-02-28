import 'package:e_auction/src/core/di/app_component.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'src/core/routes/router.dart';
import 'src/core/utils/colorResources.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Auction',
      theme: ThemeData(
        primarySwatch: ColorResources.deepBlueSwatch,
      ),
      // home: const SplashScreen(),
      onGenerateRoute: RouteGenerator.onRouteGenerate,
    );
  }
}