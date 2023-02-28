import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/features/auction_gallery/data/source/auction_gallery_service.dart';

import '../../domain/repository/auction_gallery_repository.dart';
import '../models/auction_model.dart';


class AuctionGalleryRepositoryImpl implements AuctionGalleryRepository {
  @override
  AuctionGalleryService get auctionGalleryService => AuctionGalleryService();

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> fetchAuctionGalleryData() async{
    return await auctionGalleryService.fetchAuctionGalleryData();
  }

  // @override
  // Future<List<AuctionGalleryModel>> fetchMoreAuctionGalleryData({required AuctionGalleryModel lastItem}) async {
  //   return await auctionGalleryService.fetchMoreAuctionGalleryData(lastItem: lastItem);
  // }

}
