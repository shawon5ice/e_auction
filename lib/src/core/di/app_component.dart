import 'package:e_auction/src/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:e_auction/src/features/authentication/data/source/authentication_service.dart';
import 'package:e_auction/src/features/authentication/domain/repository/authentication_repository.dart';
import 'package:e_auction/src/features/create_auction_post/data/repository/create_auction_repository_impl.dart';
import 'package:e_auction/src/features/create_auction_post/data/source/create_auction_service.dart';
import 'package:e_auction/src/features/create_auction_post/domain/repository/create_auction_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<AuthenticationService>(() => AuthenticationService());
  locator.registerFactory<AuthenticationRepository>(() => AuthenticationRepositoryImpl());

  locator.registerFactory<CreateAuctionService>(() => CreateAuctionService());
  locator.registerFactory<CreateAuctionRepository>(() => CreateAuctionRepositoryImpl());
}

