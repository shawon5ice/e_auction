import 'package:e_auction/src/features/create_auction_post/domain/usecase/create_auction_usecase.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';

class UploadProductImageUseCase extends CreateAuctionUseCase {
  UploadProductImageUseCase(super.createAuctionRepository);

  Future<String> call({required String filePath}) async {
    return await createAuctionRepository.uploadProductImage(filePath: filePath);
  }
}
