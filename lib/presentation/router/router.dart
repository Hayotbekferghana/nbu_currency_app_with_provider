import 'package:flutter/material.dart';
import 'package:nbu_currency_api_project/presentation/home_screen/home_screen.dart';
import 'package:nbu_currency_api_project/presentation/users_screen/users_screen.dart';
import 'package:nbu_currency_api_project/utils/constants.dart';

class RouteGenerator {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return navigateTo(const HomeScreen());
        case usersScreen:
        return navigateTo(const UsersScreen());

      default:
        return navigateTo(const Scaffold(
          body: Center(
            child: Text(
              "404\nNOT FOUND",
              textAlign: TextAlign.center,
            ),
          ),
        ));
    }
  }
}

navigateTo(Widget widget) => MaterialPageRoute(builder: (ctx) => widget);
