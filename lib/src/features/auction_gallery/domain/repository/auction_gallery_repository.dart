import '../../data/models/auction_model.dart';
import '../../data/source/auction_gallery_service.dart';

abstract class AuctionGalleryRepository {
  final AuctionGalleryService auctionGalleryService;

  AuctionGalleryRepository(this.auctionGalleryService);

  Future<bool> addNewBidAuctionGallery({required Bidder bidderProfile,required String docId});
  Future<bool> updateBidAuctionGallery({required Bidder updatedValue,required String docId, required int index});
}
