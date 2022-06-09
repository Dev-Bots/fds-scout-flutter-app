import 'dart:ffi';

import 'package:dev_scout_fds/Presentation/screens/screens.dart';
import 'package:flutter/material.dart';

import '../screens/games/field_pitch.dart';

class RouteGenerator {
  static const String loginPage = "/login";
  static const String homePage = "/home"; //default page
  static const String registerPage = "/register";
  static const String gamesPage = "/games";
  static const String attendedPage = "/attended";
  static const String profilePage = "/profile";
  static const String errorRoute = "/event";
  static const String splashPage = "/";
  static const String pitchPage = "/field";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case splashPage:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case pitchPage:
        TeamsArgument argument = args as TeamsArgument;

        return MaterialPageRoute(
            builder: (_) => Field(
                team1: argument.team1,
                team2: argument.team2,
                paramterId: argument.paramterId));
      case gamesPage:
        int arg = args as int;
        return MaterialPageRoute(builder: (_) => GamesList(arg));
      default:
        throw const FormatException("Route was not found");
    }
  }
}

// If we need to pass argument to the next screen, we can use the below
// We can create a Route<dynamic> classed error handler like in Flutter Routes & Navigation – Parameters, Named Routes, onGenerateRoute video on Reso Coder


  // static Route<dynamic> generateRouteWithArgs(RouteSettings settings) {
  //   switch (settings.name) {
  //     case loginPage:
  //       return MaterialPageRoute(
  //           builder: (_) => const LoginPage(
  //                 user: settings.arguments,
  //               ));
  //     case homePage:
  //       return MaterialPageRoute(
  //           builder: (_) => const HomePage(
  //                 user: settings.arguments,
  //               ));
  //     case registerPage:
  //       return MaterialPageRoute(
  //           builder: (_) => const RegisterPage(
  //                 user: settings.arguments,
  //               ));
  //     default:
  //       throw const FormatException("Route was not found");
  //   }
  // }
