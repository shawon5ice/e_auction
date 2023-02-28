import 'dart:io';

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
  var bidAmount = 0;
  int index = 0;
  String docId = "";

  void bidStatus(List<Bidder> bidder) {
    for (var value in bidder) {
      index++;
      if (value.bidderUID == FirebaseAuth.instance.currentUser?.uid) {
        logger.e(neverBid.value);
        neverBid.value = true;
        break;
      }
    }
  }

  void addNewBid(BuildContext context) async {
    updateIndicator.value = true;
    CommonMethod.loaderScreen(context);

    Bidder bidderInfo = Bidder(
        bidderFullName: FirebaseAuth.instance.currentUser!.displayName??"Unknown",
        bidderUID: FirebaseAuth.instance.currentUser!.uid,
        bidAmount: bidAmount);

    AddBidAuctionGalleryUseCase addBidAuctionGalleryUseCase = AddBidAuctionGalleryUseCase(locator<AuctionGalleryRepository>());

    var response = await addBidAuctionGalleryUseCase(bidderProfile: bidderInfo,docId: docId);

    if (response == true) {
      updateIndicator.value = false;
      Navigator.pop(context);
      // const SuccessDialog();
    }
  }

  // void updateBidAmount(BuildContext context) async{
  //   updateIndicator.value = true;
  //   CommonMethod.loaderScreen(context);
  //   Bidder bidderInfo = Bidder(
  //       bidderFullName: FirebaseAuth.instance.currentUser!.displayName??"Unknown",
  //       bidderUID: FirebaseAuth.instance.currentUser!.uid,
  //       bidAmount: bidAmount);
  //   UpdateBidAuctionGalleryUseCase updateBidAuctionGalleryUseCase = UpdateBidAuctionGalleryUseCase(locator<AuctionGalleryRepository>());
  //   var response = await updateBidAuctionGalleryUseCase(docId: docId,index: index,updatedValue: bidderInfo);
  //
  //   if (response == true) {
  //     updateIndicator.value = false;
  //     Navigator.pop(context);
  //     // const SuccessDialog();
  //   }
  // }
}
