import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/main.dart';
import 'package:flutter_jaring_ummat/src/views/chats/chats_screen.dart';
import 'package:flutter_jaring_ummat/src/views/galang_amal.dart';
import 'package:flutter_jaring_ummat/src/views/home.dart';
import 'package:flutter_jaring_ummat/src/views/login/login.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding/step2.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding/step3.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding/step4.dart';
import 'package:flutter_jaring_ummat/src/views/onboarding/success_register.dart';
import 'package:flutter_jaring_ummat/src/views/user_story.dart';

void App() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginView(),
        '/home': (context) => HomeView(),
        '/galang-amal': (context) => GalangAmalView(),
        '/onboarding': (context) => OnboardingView(),
        '/onboarding/step2': (context) => Step2View(),
        '/onboarding/step3': (context) => Step3View(),
        '/onboarding/step4': (context) => Step4View(),
        '/onboarding/success': (context) => SuccessRegisterView(avatarImage: null),
        '/user/story': (context) => UserStoryView(),
        '/chats': (context) => ChatScreen(),
      },
    ),
  );
}
