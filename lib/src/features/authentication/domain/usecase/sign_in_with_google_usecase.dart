import 'authentication_usecase.dart';

class GoogleSignInUseCase extends AuthenticationUseCase {
  GoogleSignInUseCase(super.authenticationRepository);

  Future<bool> call() async {
    var response = await authenticationRepository.signInWithGoogle();
    return response;
  }
}
