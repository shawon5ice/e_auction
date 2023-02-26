import 'package:flutter/material.dart';


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
}
