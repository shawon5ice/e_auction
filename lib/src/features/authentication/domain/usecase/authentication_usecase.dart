import '../repository/authentication_repository.dart';

abstract class AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;
  AuthenticationUseCase(this.authenticationRepository);
}