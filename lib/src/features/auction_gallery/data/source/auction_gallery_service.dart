import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/features/auction_gallery/data/models/auction_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuctionGalleryService {
  Future<bool> addNewBidAuctionGallery(
      {required Bidder bidderProfile, required String docId}) async {
    final collectionReference =
        FirebaseFirestore.instance.collection('auction_gallery');
    DocumentReference documentReference = collectionReference.doc(docId);
    try {
      documentReference.update({
        'bidder': FieldValue.arrayUnion([bidderProfile.toJson()])
      }).whenComplete(() => true);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> updateBidAuctionGallery(
      {required Bidder updatedValue,
      required String docId,
      required int index}) async {
    final collectionReference =
        FirebaseFirestore.instance.collection('auction_gallery');
    DocumentReference documentReference = collectionReference.doc(docId);
    try {
      documentReference.update(
        {
          'bidder.$index': {
            'bidder_full_name': "abc",
            'bidder_uid':"asdkfjalsf",
            'bid_amount':123
          },
        },
      ).whenComplete(() => true);
    } catch (e) {
      return false;
    }

    return true;
  }
}
