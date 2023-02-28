import 'dart:io';

import 'package:e_auction/src/features/auction_gallery/domain/repository/auction_gallery_repository.dart';
import 'package:e_auction/src/features/auction_gallery/domain/usecase/fetch_auction_gallery_data_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../../../../core/di/app_component.dart';
import '../../data/models/auction_model.dart';

class AuctionGalleryController extends GetxController{
  var updateIndicator = false.obs;
  var neverBid = false.obs;

  void bidStatus(List<Bidder> bidder){
    for (var value in bidder) {
      if(value.bidderUID == FirebaseAuth.instance.currentUser?.uid){
        neverBid.value = true;
      }
    }
  }
}