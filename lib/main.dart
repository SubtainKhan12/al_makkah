import 'package:al_makkah/Utilities/Colors/colors.dart';
import 'package:flutter/material.dart';

import 'LoginPages/loginscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorsUtils.baigeColor),
        useMaterial3: true,
      ),
      home: const LoginUI(),
    );
  }
}


