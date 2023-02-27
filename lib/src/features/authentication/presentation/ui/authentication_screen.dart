import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/features/authentication/data/source/authentication_service.dart';
import 'package:e_auction/src/features/authentication/presentation/controller/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/assetsPath.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({super.key});

  final _authenticationController = Get.find<AuthenticationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => Stack(
          children: <Widget>[
            _mainBody(context),
            if (_authenticationController.showLoading.value)
              const Center(child: CircularProgressIndicator())
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
              child:  SvgPicture.asset(AssetsPath.authScreenSvg,width: 100,),
            ),
          ),
        ),
        Expanded(
            child: Center(
          child: ElevatedButton(
            onPressed: () {
              _authenticationController.signInWithGoogle(context);
            },
            child: const Text('Continue With goolge'),
          ),
        ))
      ],
    );
  }
}
