import 'package:e_auction/src/features/auction_gallery/data/models/auction_model.dart';
import 'package:e_auction/src/features/auction_gallery/domain/usecase/auction_gallery_usecase.dart';

class AddBidAuctionGalleryUseCase extends AuctionGalleryUseCase {
  AddBidAuctionGalleryUseCase(super.auctionGalleryRepository);

  Future<bool> call({required Bidder bidderProfile, required String docId}) async {
    var response = await auctionGalleryRepository.addNewBidAuctionGallery(bidderProfile: bidderProfile,docId:docId);
    return response;
  }
}
