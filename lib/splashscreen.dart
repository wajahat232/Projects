import 'package:calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';


class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override

  Widget build(BuildContext context){
    return AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/img.png' ,
         nextScreen: Calculator(),
         splashTransition: SplashTransition.slideTransition,
         pageTransitionType: PageTransitionType.bottomToTop,
         splashIconSize: 100,
         backgroundColor: Colors.white,

    );
  }
}