import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';
import 'package:e_auction/src/features/create_auction_post/data/source/create_auction_service.dart';
import 'package:e_auction/src/features/create_auction_post/domain/repository/create_auction_repository.dart';

import '../../presentation/controller/create_auction_post_controller.dart';

class CreateAuctionRepositoryImpl implements CreateAuctionRepository {
  @override
  CreateAuctionService get createAuctionService => CreateAuctionService();

  @override
  Future<bool> createNewAuctionPost({required ProductModel product}) async{
    return await createAuctionService.createNewAuctionPost(product: product);
  }

  @override
  Future<String> uploadProductImage({required String filePath}) async{
    var res =  await createAuctionService.uploadProductImage(filePath: filePath);
    logger.i(res);
    return res;
  }
}
