import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';
import 'package:e_auction/src/features/create_auction_post/domain/usecase/create_auction_usecase.dart';

class UploadAuctionProductUseCase extends CreateAuctionUseCase {
  UploadAuctionProductUseCase(super.createAuctionRepository);

  Future<bool> call({required ProductModel product}) async {
    var response = await createAuctionRepository.createNewAuctionPost(product: product);
    return response;
  }
}
