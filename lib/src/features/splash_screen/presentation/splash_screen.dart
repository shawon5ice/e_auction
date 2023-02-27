import 'package:e_auction/src/core/utils/assetsPath.dart';
import 'package:e_auction/src/features/authentication/presentation/controller/authentication_controller.dart';
import 'package:e_auction/src/features/authentication/presentation/ui/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  final AuthenticationController _authenticationController = Get.put(AuthenticationController());

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation =
        Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward().whenComplete(() {
      _authenticationController.signInStatus(context);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: SlideTransition(
            position: _animation,
            child: SvgPicture.asset(
              AssetsPath.authScreenSvg,
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}
