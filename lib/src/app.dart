import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/main.dart';
import 'views/login.dart';
import 'views/home.dart';
import 'views/intro_slider.dart';
import 'views/onboarding.dart';
import 'views/onboarding/step2.dart';
import 'views/onboarding/step3.dart';
import 'views/onboarding/step4.dart';
import 'views/onboarding/success_register.dart';
import 'views/user_story.dart';
import 'views/galang_amal.dart';
import 'views/create_news.dart';
import 'views/create_aksi_amal.dart';
import 'views/create_data_preview.dart';

void App() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginView(),
        '/home': (context) => HomeView(),
        '/intro': (context) => IntroScreen(),
        '/galang-amal': (context) => GalangAmalView(),
        '/onboarding': (context) => OnboardingView(),
        '/onboarding/step2': (context) => Step2View(),
        '/onboarding/step3': (context) => Step3View(),
        '/onboarding/step4': (context) => Step4View(),
        '/onboarding/success': (context) =>
            SuccessRegisterView(avatarImage: null),
        '/user/story': (context) => UserStoryView(),
        '/create/news': (context) => CreateNews(),
        '/create/aksi-amal': (content) => CreateAksiAmal(),
        '/preview': (content) => PreviewData(),
      },
    ),
  );
}
