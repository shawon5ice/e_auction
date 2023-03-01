import 'package:cloud_firestore/cloud_firestore.dart';


class ProductModel {
  final String authorFullName;
  final String authorUid;
  final List<Bidder> bidder;
  final Timestamp createdOn;
  final Timestamp deadline;
  final String description;
  final double minBidAmount;
  final String productImgUrl;
  final String title;
  final String winner;

  ProductModel({
    required this.authorFullName,
    required this.authorUid,
    required this.bidder,
    required this.createdOn,
    required this.deadline,
    required this.description,
    required this.minBidAmount,
    required this.productImgUrl,
    required this.title,
    required this.winner,
  });

  factory ProductModel.fromJson(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;

    var bidderJson = json['bidder'];
    List<Bidder> bidderList = [];
    if (bidderJson is List<dynamic>) {
      bidderList = bidderJson.map((e) => Bidder.fromJson(e)).toList();
    } else if (bidderJson !=null && bidderJson is Map<String, dynamic>) {
      bidderJson.forEach((key, value) {
        final Map<String, dynamic> bidData = value as Map<String, dynamic>;
        final Bidder bid = Bidder.fromJson(bidData);
        bidderList.add(bid);
      });
    }

    return ProductModel(
      authorFullName: json['author_full_name'],
      authorUid: json['author_uid'],
      bidder: bidderList,
      createdOn: json['created_on'],
      deadline: json['deadline'],
      description: json['description'],
      minBidAmount: json['min_bid_amount'],
      productImgUrl: json['product_img_url'],
      title: json['title'],
      winner: json['winner'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['author_full_name'] = authorFullName;
    json['author_uid'] = authorUid;
    json['bidder'] = bidder.map((e) => e.toJson()).toList();
    json['created_on'] = createdOn;
    json['deadline'] = deadline;
    json['description'] = description;
    json['min_bid_amount'] = minBidAmount;
    json['product_img_url'] = productImgUrl;
    json['title'] = title;
    json['winner'] = winner;
    return json;
  }
}


class Bidder {
  final double bidAmount;
  final String bidderUid;
  final String bidderFullName;

  Bidder({
    required this.bidAmount,
    required this.bidderUid,
    required this.bidderFullName,
  });

  factory Bidder.fromJson(Map<String, dynamic> json) {
    return Bidder(
      bidAmount: double.parse(json['bid_amount'].toString()),
      bidderUid: json['bidder_uid'],
      bidderFullName: json['bidder_full_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bid_amount'] = bidAmount;
    data['bidder_uid'] = bidderUid;
    data['bidder_full_name'] = bidderFullName;
    return data;
  }
}
