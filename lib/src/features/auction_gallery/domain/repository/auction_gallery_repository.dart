
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';

import '../../data/models/auction_model.dart';
import '../../data/source/auction_gallery_service.dart';

abstract class AuctionGalleryRepository {
  final AuctionGalleryService auctionGalleryService;

  AuctionGalleryRepository(this.auctionGalleryService);

  Future<QuerySnapshot<Map<String, dynamic>>> fetchAuctionGalleryData();
}
