import 'package:e_auction/src/core/routes/route_name.dart';
import 'package:e_auction/src/core/routes/router.dart';
import 'package:e_auction/src/features/authentication/domain/repository/authentication_repository.dart';
import 'package:e_auction/src/features/authentication/domain/usecase/check_sign_in_status.dart';
import 'package:e_auction/src/features/authentication/domain/usecase/sign_out_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/di/app_component.dart';
import '../../domain/usecase/sign_in_with_google_usecase.dart';

class AuthenticationController extends GetxController {
  var showLoading = false.obs;

  void signOut(BuildContext context) async{
    SignOutUseCase signOutUseCase = SignOutUseCase(locator<AuthenticationRepository>());
    var response = await signOutUseCase();
    if(response == true){
      RouteGenerator.pushReplacementNamed(context, Routes.authenticationScreenRouteName);
    }

  }
  void signInStatus(BuildContext context) async{
    CheckSignInStatusUseCase checkSignInStatusUseCase = CheckSignInStatusUseCase(locator<AuthenticationRepository>());
    var response = await checkSignInStatusUseCase();
    if(response == true){
      RouteGenerator.pushReplacementNamed(context, Routes.dashboardScreenRouteName);
    }else{
      RouteGenerator.pushReplacementNamed(context, Routes.authenticationScreenRouteName);
    }
  }
  void signInWithGoogle(BuildContext context) async {
    showLoading.value = true;
    GoogleSignInUseCase googleSignInUseCase =
        GoogleSignInUseCase(locator<AuthenticationRepository>());
    var response = await googleSignInUseCase();
    if (response == true) {
      showLoading.value = false;
      RouteGenerator.pushReplacementNamed(context, Routes.dashboardScreenRouteName);
    } else {
      showLoading.value = false;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No internet connection'),
          content: Text('Please check your internet connection and try again.'),
        ),
      );
    }
  }
}
