import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/core/routes/router.dart';
import 'package:e_auction/src/core/utils/colorResources.dart';
import 'package:e_auction/src/core/utils/e_auction_decoration.dart';
import 'package:e_auction/src/features/auction_gallery/presentation/controller/auction_gallery_controller.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/models/auction_model.dart';
import '../widgets/count_down_timer_widget.dart';

class AuctionGalleryItemDetailsScreen extends StatelessWidget {
  final String docId, title,authorUID;

  AuctionGalleryItemDetailsScreen({Key? key, required this.docId,required this.title, required this.authorUID})
      : super(key: key);

  final AuctionGalleryController auctionGalleryController =
      Get.find<AuctionGalleryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("auction_gallery")
                  .doc(docId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('Loading...');
                  default:
                    if (snapshot.data == null) {
                      return const Text('Document does not exist');
                    }
                    // Access data in snapshot
                    AuctionGalleryModel  auctionGalleryModel = AuctionGalleryModel.fromSnapShot(snapshot.data!);
                    int remainingTime = auctionGalleryModel.deadline
                        .toDate()
                        .difference(DateTime.now())
                        .inSeconds;
                    auctionGalleryController.docId = docId;
                    // auctionGalleryController.bidStatus(auctionGalleryModel.bidder);
                    if (remainingTime < 0) {
                      remainingTime = 0;
                    }
                    return Column(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: auctionGalleryModel.productImgUrl,
                              fit: BoxFit.cover,
                              height: 250,
                              width: double.infinity,
                              placeholder: (context, url) =>
                                  SpinKitDancingSquare(
                                      color: Colors.deepPurple.shade900),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.broken_image_outlined,
                                size: 250,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Bid starts at: ${auctionGalleryModel.minBidAmount} Tk',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const Spacer(),
                                        CountDownTimer(
                                          secondsRemaining: remainingTime,
                                          whenTimeExpires: () {},
                                          color: Colors.red,
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Posted by: ${auctionGalleryModel.authorFullName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                  'Posted on: ${DateFormat.yMMMd().add_jm().format((auctionGalleryModel.createdOn.toDate()))}'),
                              8.ph,
                              Text(
                                auctionGalleryModel.description,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              16.ph,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.withOpacity(.5),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.yellow, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        const Text(
                                          'Bidder List:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                        4.ph,
                                        auctionGalleryModel.bidder.isNotEmpty
                                            ? Table(
                                                border: TableBorder.all(
                                                    width: 1.0,
                                                    color: Colors.black),
                                                children: [
                                                  TableRow(
                                                    children: [
                                                      TableCell(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: const Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                        ),
                                                      ),
                                                      TableCell(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: const Text(
                                                              'Bid Amount',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ...table(auctionGalleryModel
                                                      .bidder)
                                                  // Add more rows as needed
                                                ],
                                              )
                                            : const Text(
                                                'There is no bid yet!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                }
              }),
        ),
      ),
      floatingActionButton: authorUID !=
              FirebaseAuth.instance.currentUser?.uid
          ? FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Bid to win the auction'),
                    content: TextField(
                      onChanged: (val) {
                        auctionGalleryController.bidAmount = int.parse(val);
                      },
                      decoration: EAuctionDecorations.eAuctionInputDecoration(
                          hint: 'Enter bid amount', label: 'Bid amount'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          RouteGenerator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: ColorResources.ash),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                          onPressed: () {
                            RouteGenerator.pop(context);
                            if (auctionGalleryController.neverBid.value) {
                              logger.i(auctionGalleryController.bidAmount);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Opps'),
                                        content: const Text(
                                            'Update feature is not implemented'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                RouteGenerator.pop(context);
                                              },
                                              child: const Text('Ok'))
                                        ],
                                      ));
                            } else {
                              auctionGalleryController.addNewBid(context);
                            }
                          },
                          child: const Text('Submit')),
                    ],
                  ),
                );
              },
              child: Obx(() => auctionGalleryController.neverBid.value
                  ? const Icon(Icons.edit)
                  : const Icon(Icons.add)),
            )
          : Container(),
    );
  }
}

List<TableRow> table(List<Bidder> items) {
  List<TableRow> rows = items.map((rowData) {
    return TableRow(
      children: [
        TableCell(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(rowData.bidderFullName),
          ),
        ),
        TableCell(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              rowData.bidAmount.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }).toList();
  return rows;
}
