import 'package:e_auction/src/features/authentication/data/repository/forgot_pass_repository_impl.dart';
import 'package:e_auction/src/features/authentication/data/source/authentication_service.dart';
import 'package:e_auction/src/features/authentication/domain/repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<AuthenticationService>(() => AuthenticationService());
  locator.registerFactory<AuthenticationRepository>(() => AuthenticationRepositoryImpl());
}

