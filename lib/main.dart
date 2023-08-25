import 'package:my_chat_app/helper/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/helper/helper_functions.dart';
import 'package:my_chat_app/views/chatrooms_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;
  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        isUserLoggedIn = value!;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF145C9E),
          scaffoldBackgroundColor: const Color(0xFF1F1F1F),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF145C9E)),
          useMaterial3: true,
        ),
        home: isUserLoggedIn ? ChatroomsScreen() : Authenticate());
  }
}
