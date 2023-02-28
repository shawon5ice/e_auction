import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/core/utils/colorResources.dart';
import 'package:e_auction/src/features/authentication/data/source/authentication_service.dart';
import 'package:e_auction/src/features/authentication/presentation/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/assetsPath.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});

  final _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: <Widget>[
              _mainBody(context),
              if (_authenticationController.showLoading.value)
                const Center(child: SpinKitDancingSquare(color: Colors.white,))
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Hero(
              tag: 'imageHero',
              child: SvgPicture.asset(
                AssetsPath.authScreenSvg,
                width: 200,
              ),
            ),
          ),
        ),
        Expanded(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Continue with',style: TextStyle(fontSize: 18,color: Colors.white),),
                48.ph,
                ElevatedButton(
                  onPressed: () {
                    _authenticationController.signInWithGoogle(context);
                  },
                  style: TextButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          AssetsPath.googleIcon,
                          height: 36,
                        ),
                        const Text('Goolge'),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
      ],
    );
  }
}
