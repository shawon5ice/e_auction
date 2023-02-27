import '../../data/source/authentication_service.dart';

abstract class AuthenticationRepository {
  final AuthenticationService authenticationService;

  AuthenticationRepository(this.authenticationService);

  Future<bool> signInWithGoogle();

  Future<bool?>? checkSignInStatus() {}
  Future<bool?>? signOut() {}

}
