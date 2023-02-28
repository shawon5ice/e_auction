import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/features/auction_gallery/presentation/widgets/count_down_timer_widget.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:intl/intl.dart';

import 'src/features/create_auction_post/data/models/auction_model.dart';
import 'package:logger/logger.dart';

class AuctionGalleryScreen extends StatelessWidget {
  AuctionGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginateFirestore(
        isLive: true,
        onEmpty: const Center(child: Text('Empty Data'),),
        itemsPerPage: 3,
        onError: (e) => const Center(child: Text('Something went wrong'),),
        bottomLoader: const Center(child: CircularProgressIndicator.adaptive(),),
        itemBuilder: (context, snapshot, index){
          final Map<String, dynamic> json = snapshot[index].data() as Map<String,dynamic>;
          final product = ProductModel.fromJson(json);
          return GalleryItem(product: product);
        },
        query: FirebaseFirestore.instance.collection('auction_gallery').orderBy('created_on',descending: true),
        itemBuilderType: PaginateBuilderType.listView);
  }
}


class GalleryItem extends StatelessWidget {
  const GalleryItem({Key? key,required this.product}) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    int remainingTime = product.deadline.toDate().difference(DateTime.now()).inSeconds;
    if(remainingTime<0) {
      remainingTime = 0;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(child: Text(product.authorFullName[0]),),
                    20.pw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.authorFullName,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        Text(DateFormat.yMMMd().add_jm().format((product.createdOn.toDate())),),
                      ],
                    )
                  ],
                ),
              ),
              // Image.network(product.productImgUrl,fit: BoxFit.fitWidth,height: 200,),
              Stack(
                children: [
                  CachedNetworkImage(
                      imageUrl: product.productImgUrl,fit: BoxFit.cover,height: 200, width: double.infinity,
                      placeholder:  (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined,size: 200,)
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepPurple
                      ),
                      child: Text('Bid starts at: ${product.minBidAmount}',style: const TextStyle(color: Colors.white),),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepPurple
                      ),
                      child: CountDownTimer(secondsRemaining:remainingTime,whenTimeExpires: (){
                      },),
                    ),
                  )
                ],
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8,),child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(product.title),
                Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

