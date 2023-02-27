import 'authentication_usecase.dart';

class SignOutUseCase extends AuthenticationUseCase {
  SignOutUseCase(super.authenticationRepository);

  Future<bool?>? call() async {
    var response = await authenticationRepository.checkSignInStatus();
    return response;
  }
}
