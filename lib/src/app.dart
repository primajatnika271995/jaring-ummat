import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/main.dart';
import 'package:flutter_jaring_ummat/src/views/chats/chats_screen.dart';
import 'package:flutter_jaring_ummat/src/views/chats/list_account.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';
import 'package:flutter_jaring_ummat/src/views/home.dart';
import 'package:flutter_jaring_ummat/src/views/login/login.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding.dart';
import 'package:flutter_jaring_ummat/src/views/page_register/step1.dart';
import 'package:flutter_jaring_ummat/src/views/user_story.dart';

void App() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Open-Sans'),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/home': (context) => HomeView(),
        '/register/step1': (context) => StepOne(),
        '/galang-amal': (context) => GalangAmalView(),
        '/onboarding': (context) => OnboardingView(),
        '/list/account/chats': (context) => ListAccountChat(),
        '/chats': (context) => ChatScreen(),
      },
    ),
  );
}
