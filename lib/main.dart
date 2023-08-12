import 'package:my_chat_app/views/sign_up_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF145C9E),
        scaffoldBackgroundColor: const Color(0xFF1F1F1F),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF145C9E)),
        useMaterial3: true,
      ),
      home: const SignUnScreen(),
    );
  }
}
