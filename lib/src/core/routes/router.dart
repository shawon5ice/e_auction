import 'package:e_auction/src/features/auction_gallery/data/models/auction_model.dart';
import 'package:e_auction/src/features/authentication/presentation/ui/authentication_screen.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';
import 'package:flutter/material.dart';

import '../../features/auction_gallery/presentation/ui/auction_gallery_item_details_screen.dart';
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

      case Routes.auctionGalleryItemDetails:
        {
          final arguments = routeSettings.arguments as List;

          return MaterialPageRoute(
            builder: (context) {
              return AuctionGalleryItemDetailsScreen(
                  auctionGalleryModel: arguments[0] as AuctionGalleryModel,
                  docId: arguments[1] as String
              );

            }
          );
        }
    }
    return null;
  }
}
