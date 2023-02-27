import 'package:e_auction/src/features/create_auction_post/domain/repository/create_auction_repository.dart';

abstract class CreateAuctionUseCase {
  final CreateAuctionRepository createAuctionRepository;
  CreateAuctionUseCase(this.createAuctionRepository);
}