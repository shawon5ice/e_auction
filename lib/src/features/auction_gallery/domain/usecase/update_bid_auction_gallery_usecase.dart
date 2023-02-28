import 'package:e_auction/src/features/auction_gallery/data/models/auction_model.dart';
import 'package:e_auction/src/features/auction_gallery/domain/usecase/auction_gallery_usecase.dart';

class UpdateBidAuctionGalleryUseCase extends AuctionGalleryUseCase {
  UpdateBidAuctionGalleryUseCase(super.auctionGalleryRepository);

  Future<bool> call({required Bidder updatedValue, required String docId,required int index}) async {
    var response = await auctionGalleryRepository.updateBidAuctionGallery(updatedValue: updatedValue,docId:docId,index: index);
    return response;
  }
}
