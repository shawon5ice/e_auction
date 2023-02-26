// import '../../../../core/core.dart';
// import '../../../../core/utilities/constants.dart';
// import '../model/forget_pass_model.dart';
//
// var session = locator<SessionManager>();
//
// class ForgotPasswordService {
//   final DioClient _dioClient = locator<DioClient>();
//
//   Future<Response<ForgetPassModel>?> forgetPasswordRetrieve(
//       String email, String userName) async {
//     Response<ForgetPassModel>? apiResponse;
//
//     var params = {
//       NetworkConfiguration.KEY_EMAIL_ADDRESS: email,
//       NetworkConfiguration.KEY_USER_NAME: userName
//     };
//
//     await _dioClient.post(
//       path: NetworkConfiguration.FORGET_PASSWORD_URL,
//       request: params,
//       responseCallback: (response, message) {
//         logger.i(response.toString());
//         apiResponse = Response.success(ForgetPassModel.fromJson(response));
//       },
//       failureCallback: (message, status) {
//         apiResponse = Response.error(message, status);
//       },
//     );
//
//     return apiResponse;
//   }
// }
