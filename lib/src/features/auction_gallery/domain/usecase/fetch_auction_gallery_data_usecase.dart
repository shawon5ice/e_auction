import 'package:cloud_firestore/cloud_firestore.dart';
import 'auction_gallery_usecase.dart';

class FetchAuctionGalleryDataUseCase extends AuctionGalleryUseCase {
  FetchAuctionGalleryDataUseCase(super.auctionGalleryRepository);

  Future<QuerySnapshot<Map<String, dynamic>>> call() async {
    return await auctionGalleryRepository.fetchAuctionGalleryData();
  }
}
