import 'package:e_auction/src/features/authentication/data/source/authentication_service.dart';
import 'package:e_auction/src/features/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {

  @override
  AuthenticationService get authenticationService => AuthenticationService();

  @override
  Future<bool> signInWithGoogle() {
    return authenticationService.signInWithGoogle();
  }

  @override
  Future<bool> checkSignInStatus() {
    return authenticationService.checkSignInStatus();
  }

  @override
  Future<bool?>? signOut() {
    return authenticationService.signOut();
  }



}
