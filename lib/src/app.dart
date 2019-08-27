import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/main.dart';
import 'package:flutter_jaring_ummat/src/views/chats/chats_screen.dart';
import 'package:flutter_jaring_ummat/src/views/chats/list_account.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';
import 'package:flutter_jaring_ummat/src/views/home.dart';
import 'package:flutter_jaring_ummat/src/views/login/login.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding.dart';
import 'package:flutter_jaring_ummat/src/views/page_program-amal/create_program_amal.dart';
import 'package:flutter_jaring_ummat/src/views/page_register/step1.dart';
import 'package:flutter_jaring_ummat/src/views/user_story.dart';

void App() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Sofia-Pro'),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/register/step1': (context) => StepOne(),
        '/home': (context) => HomeView(),
        '/galang-amal': (context) => GalangAmalView(),
        '/create/galang-amal': (context) => CreateProgramAmal(),
        '/onboarding': (context) => OnboardingView(),
        '/user/story': (context) => UserStoryView(),
        '/list/account/chats': (context) => ListAccountChat(),
        '/chats': (context) => ChatScreen(),
      },
    ),
  );
}
