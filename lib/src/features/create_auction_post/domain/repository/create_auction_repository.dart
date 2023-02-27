
import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';

import '../../data/source/create_auction_service.dart';

abstract class CreateAuctionRepository {
  final CreateAuctionService createAuctionService;

  CreateAuctionRepository(this.createAuctionService);

  Future<bool> createNewAuctionPost({required ProductModel product});
  Future<String> uploadProductImage({required String filePath});
}
