import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goplay/game_selection.dart';
import 'assets/colors/colors.dart' as colors;

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.height,
      centered: false,
      backgroundColor: Color(colors.violet),
      duration: 0,
      nextScreen: GameSelection(),
      splash: Stack(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 220),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(colors.green40),
                    blurRadius: 500.0,
                    spreadRadius: 150,
                  ),
                ],
              ),
              width: 0,
              height: 0
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(colors.pink40),
                      blurRadius: 500.0,
                      spreadRadius: 150,
                    ),
                  ],
                ),
                width: 0,
                height: 0
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 250),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 30),
                  child: SvgPicture.asset('assets/images/splash_screen/goplay_icon.svg',),
                ),
                Container(
                  padding: EdgeInsets.only(top: 21),
                  child: SvgPicture.asset('assets/images/splash_screen/goplay_title_image.svg'),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}