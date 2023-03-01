import 'dart:io';

import 'package:e_auction/src/core/routes/router.dart';
import 'package:e_auction/src/features/auction_gallery/domain/repository/auction_gallery_repository.dart';
import 'package:e_auction/src/features/auction_gallery/domain/usecase/add_bid_auction_gallery_usecase.dart';
import 'package:e_auction/src/features/auction_gallery/domain/usecase/update_bid_auction_gallery_usecase.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/di/app_component.dart';
import '../../../create_auction_post/presentation/widgets/auction_post_loading_dialog.dart';
import '../../data/models/auction_model.dart';

class AuctionGalleryController extends GetxController {
  var updateIndicator = false.obs;
  var neverBid = false.obs;
  var bidAmount = 0.0;
  int index = 0;
  String docId = "";
  var remainingTime = 0.obs;

  void bidStatus(List<Bidder> bidder) {
    for (var value in bidder) {
      index++;
      if (value.bidderUid == FirebaseAuth.instance.currentUser?.uid) {
        neverBid.value = true;
        break;
      }
    }
  }

  void addNewBid(BuildContext context) async {

    Bidder bidderInfo = Bidder(
        bidderFullName: FirebaseAuth.instance.currentUser!.displayName??"Unknown",
        bidderUid: FirebaseAuth.instance.currentUser!.uid,
        bidAmount: bidAmount);

    AddBidAuctionGalleryUseCase addBidAuctionGalleryUseCase = AddBidAuctionGalleryUseCase(locator<AuctionGalleryRepository>());
    await addBidAuctionGalleryUseCase(bidderProfile: bidderInfo,docId: docId);
  }

  void updateBidAmount(BuildContext context) async{
    Bidder bidderInfo = Bidder(
        bidderFullName: FirebaseAuth.instance.currentUser!.displayName??"Unknown",
        bidderUid: FirebaseAuth.instance.currentUser!.uid,
        bidAmount: bidAmount);
    UpdateBidAuctionGalleryUseCase updateBidAuctionGalleryUseCase = UpdateBidAuctionGalleryUseCase(locator<AuctionGalleryRepository>());
    await updateBidAuctionGalleryUseCase(docId: docId,index: index,updatedValue: bidderInfo);

  }
}
