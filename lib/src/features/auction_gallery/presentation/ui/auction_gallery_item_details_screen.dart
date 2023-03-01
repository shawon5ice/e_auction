import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/features/auction_gallery/presentation/controller/auction_gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../core/routes/router.dart';
import '../../../../core/utils/colorResources.dart';
import '../../../../core/utils/e_auction_decoration.dart';
import '../../data/models/auction_model.dart';
import '../widgets/auction_gallery_details_widgets.dart';
import '../widgets/count_down_timer_widget.dart';

class AuctionGalleryItemDetailsScreen extends StatelessWidget {
  final String docId, title, authorUID;

  AuctionGalleryItemDetailsScreen(
      {Key? key,
      required this.docId,
      required this.title,
      required this.authorUID})
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
                  AuctionGalleryModel auctionGalleryModel = AuctionGalleryModel.fromJson(snapshot.data!);
                  int remainingTime = auctionGalleryModel.deadline.toDate().difference(DateTime.now()).inSeconds;
                  auctionGalleryController.docId = docId;
                  auctionGalleryController.bidStatus(auctionGalleryModel.bidder);
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
                            width: MediaQuery.of(context).size.width,
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Bid starts at: ${auctionGalleryModel.minBidAmount} Tk',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      remainingTime <= 0
                                          ? const Text('Expired!',style: TextStyle(color: Colors.red),)
                                          : CountDownTimer(
                                              secondsRemaining: remainingTime,
                                              whenTimeExpires:(){},
                                              color: Colors.red)
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width-32,
                                  child: Flexible(
                                    child: Text(
                                      auctionGalleryModel.description,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            16.ph,
                            remainingTime>0?ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Bid to win the auction'),
                                      content: TextField(
                                        onChanged: (val) {
                                          auctionGalleryController.bidAmount =
                                              double.parse(val);
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: EAuctionDecorations
                                            .eAuctionInputDecoration(
                                            hint: 'Enter bid amount',
                                            label: 'Bid amount'),
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
                                                auctionGalleryController.updateBidAmount(context);
                                              } else {
                                                auctionGalleryController.addNewBid(context);
                                              }
                                            },
                                            child: const Text('Submit')),
                                      ],
                                    ),
                                  );
                                },
                                child: auctionGalleryController.neverBid.value
                                    ? const BidButton(text: 'Edit your bid',icon: Icons.edit,)
                                    : const BidButton(text: 'Bid Now',icon: Icons.add,)
                            )
                                : Container(),
                            16.ph,
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                                const TableRow(
                                                  children: [
                                                    CommonTableCell(text: 'Name',isTitle: true),
                                                    CommonTableCell(text: 'Bid Amount',isTitle: true),
                                                  ],
                                                ),
                                                ...table(auctionGalleryModel.bidder)
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
    );
  }
}
