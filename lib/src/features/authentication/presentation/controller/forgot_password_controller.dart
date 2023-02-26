// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../core/core.dart';
// import '../../../../core/routes/router.dart';
// import '../../../../core/utilities/utils.dart';
// import '../../../../core/validator/validator.dart';
// import '../../../login/presentation/ui/login_screen.dart';
// import '../../domain/repository/forgot_pass_repository.dart';
// import '../../domain/usecase/retrive_forgot_pass.dart';
// import '../ui/forgot_pass_send_email_success_screen.dart';
// import '../ui/forgot_pass_user_list_screen.dart';
//
// class ForgotPasswordController extends GetxController {
//   var showLoaderScreen = false.obs;
//   var emailError = "".obs;
//   var email = "".obs;
//   var activateSubmitButton = false.obs;
//   var userList = <String>[];
//   var userName = "".obs;
//   var userNameRadioClickStatus = "".obs;
//   var currentRadioButtonClick = -1.obs;
//
//   returnToSign(BuildContext context) {
//     RouteGenerator.pushReplacementNamed(context, Routes.loginScreenRouteName);
//   }
//
//   submitForRetrievePassword(BuildContext context) async {
//     showLoaderScreen.value = true;
//     RetrieveForgotPassUseCase retrieveForgotPassUseCase =
//     RetrieveForgotPassUseCase(locator<ForgotPasswordRepository>());
//     try {
//       var response = await retrieveForgotPassUseCase(
//           email: email.value.trim(), userName: userName.value.trim());
//
//       if (response?.data?.data[0].dataMessage == "Success") {
//         RouteGenerator.pushReplacementNamed(context, Routes.forgotPasswordEmailSuccessScreenRouteName);
//       } else if (response?.data?.data[0].dataMessage ==
//           "Multiple User Found!") {
//         userList = response!.data!.data[0].dataUser;
//         RouteGenerator.pushNamed(context, Routes.forgotPasswordEmailMultipleUserListScreenRouteName);
//       } else {
//         emailError.value = response!.data!.data[0].dataMessage;
//       }
//     } catch (e) {
//       CommonMethods.showToast(e.toString());
//     } finally {
//       showLoaderScreen.value = false;
//     }
//   }
//
//   shouldActivate() {
//     emailError.value = emailValidator(email.value) ?? "";
//     if (emailError.value.isEmpty) {
//       activateSubmitButton.value = true;
//     } else {
//       activateSubmitButton.value = false;
//     }
//   }
// }
