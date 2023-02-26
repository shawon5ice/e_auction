// import '../../../../core/data/model/api_response.dart';
// import '../../domain/repository/forgot_pass_repository.dart';
// import '../model/forget_pass_model.dart';
// import '../source/forget_pass_service.dart';
//
// class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
//   ForgotPasswordRepositoryImpl(ForgotPasswordService forgotPasswordService) : super(forgotPasswordService);
//
//   @override
//   Future<Response<ForgetPassModel?>?> retrieveForgotEmailPass({required String email, required String userName}) async {
//     Response<ForgetPassModel>? apiResponse;
//     apiResponse = await forgotPasswordService.forgetPasswordRetrieve(email, userName);
//     return apiResponse;
//   }
// }
