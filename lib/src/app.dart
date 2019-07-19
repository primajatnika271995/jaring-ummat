import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/main.dart';
import 'views/login.dart';
import 'views/home.dart';
import 'views/onboarding.dart';
import 'views/onboarding/step2.dart';
import 'views/onboarding/step3.dart';
import 'views/onboarding/step4.dart';
import 'views/onboarding/success_register.dart';
import 'views/user_story.dart';
import 'views/galang_amal.dart';

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
        '/onboarding/success': (context) =>SuccessRegisterView(avatarImage: null),
        '/user/story': (context) => UserStoryView(),
      },
    ),
  );
}
