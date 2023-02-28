import 'package:e_auction/src/features/auction_gallery/presentation/ui/auction_gallery_screen.dart';
import 'package:e_auction/src/features/authentication/presentation/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../create_auction_post/presentation/ui/create_auction_post_screen.dart';



class DashBoardController extends GetxController {
  var selectedPageIndex = 0.obs;

  final List<Widget> children = [
    AuctionGalleryScreen(),
    CreateAuctionScreen(),
    ProfileScreen(),
  ];

  final List<String> pageNames = [
    "Auction Gallery",
    "Create new auction",
    "Profile",
  ];

}
