import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/features/auction_gallery/data/models/auction_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import '../../../create_auction_post/presentation/controller/create_auction_post_controller.dart';

class AuctionGalleryService {
  Future<bool> addNewBidAuctionGallery(
      {required Bidder bidderProfile, required String docId}) async {
    final documentReference = FirebaseFirestore.instance.collection('auction_gallery').doc(docId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot = await documentReference.get();

    if (!snapshot.exists) {
      return false;
    }

    final AuctionGalleryModel auctionGalleryModel =
    AuctionGalleryModel.fromJson(snapshot);

    final List<Bidder> bidderList = auctionGalleryModel.bidder;
    bidderList.add(bidderProfile);

    try {
      final Map<String, dynamic> updatedData = auctionGalleryModel.toJson();

      documentReference.update(updatedData).whenComplete(() => true);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> updateBidAuctionGallery(
      {required Bidder updatedValue,
      required String docId,
      required int index}) async {
    final documentReference = FirebaseFirestore.instance.collection('auction_gallery').doc(docId);

    final DocumentSnapshot<Map<String, dynamic>> snapshot = await documentReference.get();

    if (!snapshot.exists) {
      return false;
    }

    final AuctionGalleryModel auctionGalleryModel =
    AuctionGalleryModel.fromJson(snapshot);

    final List<Bidder> bidderList = auctionGalleryModel.bidder;

    final int index = bidderList.indexWhere(
            (Bidder bidder) => bidder.bidderUid == updatedValue.bidderUid);

    if (index == -1) {
      return false;
    }

    bidderList[index] = updatedValue;

    final Map<String, dynamic> updatedData = auctionGalleryModel.toJson();

    await documentReference.update(updatedData);

    return true;
  }
}
