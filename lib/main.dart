import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:neevigatorv2/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.greenAccent,
      ),
      home: const WelcomeScreen(),
    );
  }
}
