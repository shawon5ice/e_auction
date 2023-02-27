class ProductModel{
  String title;
  String description;
  String productUrl;
  String author;
  String deadline;
  double minBidAmount;
  List<Bidder> bidder;
  ProductModel({required this.title, required this.description, required this.productUrl,required this.author, required this.deadline, required this.minBidAmount,required this.bidder});

  Map<String, dynamic> toJsonMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['product_url'] = productUrl;
    data['author'] = author;
    data['deadline'] = deadline;
    data['minBid_amount'] = minBidAmount;
    data['bidder'] = bidder;
    return data;
  }
}

class Bidder {
  late final String author;
  late final double bidAmount;

  Bidder({required this.author, required this.bidAmount});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['bid_amount'] = bidAmount;
    return data;
  }
}

