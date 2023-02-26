import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/assetsPath.dart';
import '../controller/forgot_password_controller.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  // final _forgotPasswordController = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: <Widget>[
              _mainBody(context),
              // if (_forgotPasswordController.showLoaderScreen.value)
              //   const CircularProgressIndicator()
            ],
          ),
        ),
    );
  }

  Widget _mainBody(BuildContext context) {
    return Column(children: <Widget>[
      30.ph,
      Center(
        child: SvgPicture.asset(
          AssetsPath.authScreenSvg,
          width: 300,
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Text(
          "Winning starts here",
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      )
    ]);
  }
}
