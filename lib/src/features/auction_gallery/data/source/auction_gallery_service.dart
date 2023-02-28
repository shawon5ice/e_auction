import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class AuctionGalleryService {


  Future<QuerySnapshot<Map<String, dynamic>>> fetchAuctionGalleryData() async {
    return await FirebaseFirestore.instance.collection('auction_gallery').orderBy('created_on',descending: true).get();
  }
}
