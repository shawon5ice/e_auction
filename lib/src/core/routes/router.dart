import 'package:e_auction/src/features/authentication/presentation/ui/authentication_screen.dart';
import 'package:flutter/material.dart';

import '../../features/dash_board/presentation/dash_board_screen.dart';
import '../../features/splash_screen/presentation/splash_screen.dart';
import 'route_name.dart';


class RouteGenerator {
  static pushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamed(context, pageName, arguments: arguments);
  }

  static pushNamedAndRemoveAll(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushNamedAndRemoveUntil(
        context, pageName, (route) => false,
        arguments: arguments);
  }

  static pushReplacementNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.pushReplacementNamed(context, pageName,
        arguments: arguments);
  }

  static pop(BuildContext context) {
    return Navigator.of(context).pop();
  }

  static popAndPushNamed(BuildContext context, String pageName,
      {List arguments = const []}) {
    return Navigator.popAndPushNamed(context, pageName, arguments: arguments);
  }

  static popAll(BuildContext context) {
    return Navigator.of(context).popUntil((route) => false);
  }

  static popUntil(BuildContext context, String pageName) {
    return Navigator.of(context).popUntil(ModalRoute.withName(pageName));
  }

  static Route<dynamic>? onRouteGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.authenticationScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => AuthenticationScreen(),
        );

      case Routes.dashboardScreenRouteName:
        return MaterialPageRoute(
          builder: (context) => DashBoardScreen(),
        );
    }
    return null;
  }
}
