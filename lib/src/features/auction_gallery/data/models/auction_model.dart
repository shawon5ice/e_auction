import 'package:cloud_firestore/cloud_firestore.dart';

class AuctionGalleryModel{
  final String title;
  final String description;
  final String productImgUrl;
  final String authorFullName;
  final String authorUID;
  final Timestamp deadline;
  final Timestamp createdOn;
  final double minBidAmount;
  final List<Bidder> bidder;
  final String winner;
  AuctionGalleryModel({required this.authorUID, required this.createdOn,required this.winner, required this.title, required this.description, required this.productImgUrl,required this.authorFullName, required this.deadline, required this.minBidAmount,required this.bidder});

  Map<String, dynamic> toJsonMap(AuctionGalleryModel model) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['winner'] = model.winner;
    data['title'] = model.title;
    data['author_uid'] = model.authorUID;
    data['description'] = model.description;
    data['product_img_url'] = model.productImgUrl;
    data['author_full_name'] = model.authorFullName;
    data['deadline'] = model.deadline;
    data['created_on'] = model.createdOn;
    data['min_bid_amount'] = model.minBidAmount;
    data['bidder'] = model.bidder;
    return data;
  }

  AuctionGalleryModel.fromJson(Map<String,dynamic>json):
      this(
        winner: json['winner'],
        title: json['title'],
        authorUID: json['author_uid'],
        description: json['description'],
        productImgUrl: json['product_img_url'],
        authorFullName: json['author_full_name'],
        deadline: json['deadline'],
        createdOn: json['created_on'],
        bidder: json['bidder']!=null?json['bidder'].map<Bidder>((doc) => Bidder.fromJson(doc)).toList():[],
        minBidAmount: json['min_bid_amount'],
      );
}

class Bidder {
  late final String bidderFullName;
  late final String bidderUID;
  late final int bidAmount;

  Bidder({required this.bidderFullName, required this.bidderUID, required this.bidAmount});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bidder_full_name'] = bidderFullName;
    data['bidder_uid'] = bidderUID;
    data['bid_amount'] = bidAmount;
    return data;
  }

  Bidder.fromJson(Map<String,dynamic>json):
        this(
        bidderFullName: json['bidder_full_name'],
        bidderUID: json['bidder_uid'],
        bidAmount: json['bid_amount'],
      );
}

