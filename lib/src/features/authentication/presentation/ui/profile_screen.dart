import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/authentication_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var totalPosted;

  final _authenticationController = Get.find<AuthenticationController>();

  final query = FirebaseFirestore.instance
      .collection('auction_gallery')
      .where("author_uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy('created_on', descending: true);

  @override
  Widget build(BuildContext context) {
    query.get().then((querySnapshot) {
      totalPosted = querySnapshot.size;
    });
    return SafeArea(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        24.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(
                  FirebaseAuth.instance.currentUser!.photoURL!,
                ),
              ),
              16.pw,
              Expanded(
                child: Column(
                  children: [
                    Text(
                      FirebaseAuth.instance.currentUser!.displayName!,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(onPressed: ()=> _authenticationController.signOut(context), child: const Text('Sign Out')),
                    10.ph,
                    Text(
                      'Total auction posted: $totalPosted',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        8.ph,

        Expanded(
          child: PaginateFirestore(
              isLive: true,
              onEmpty: const Center(
                child: Text('Empty Data'),
              ),
              itemsPerPage: 3,
              onError: (e) => const Center(
                    child: Text('Something went wrong'),
                  ),
              bottomLoader: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              itemBuilder: (context, snapshot, index) {
                final Map<String, dynamic> json =
                    snapshot[index].data() as Map<String, dynamic>;
                final product = ProductModel.fromJson(json);
                return PostedAuctionItem(product: product);
              },
              query: query,
              itemBuilderType: PaginateBuilderType.listView),
        ),
      ],
    ));
  }
}

class UserAvaterPlaceHolder extends StatelessWidget {
  const UserAvaterPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      FirebaseAuth.instance.currentUser!.displayName![0],
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class PostedAuctionItem extends StatelessWidget {
  const PostedAuctionItem({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(4),
        leading: CachedNetworkImage(
          imageUrl: product.productImgUrl,
          fit: BoxFit.cover,
          height: 50,
          width: 80,
          placeholder: (context, url) => SpinKitDancingSquare(
            color: Colors.deepPurple.shade900,
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.broken_image_outlined,
            size: 50,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(product.title),
            Text(
              'Deadline: ${DateFormat.yMMMd().add_jm().format((product.deadline.toDate()))}',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        subtitle: Text(
          product.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: Colors.yellow,
          child: Text("${product.minBidAmount}Tk"),
        ),
      ),
    );
  }
}
