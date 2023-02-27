import 'authentication_usecase.dart';

class CheckSignInStatusUseCase extends AuthenticationUseCase {
  CheckSignInStatusUseCase(super.authenticationRepository);

  Future<bool?>? call() async {
    var response = await authenticationRepository.checkSignInStatus();
    return response;
  }
}
