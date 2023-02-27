import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  var totalPosted;

  final query = FirebaseFirestore.instance.collection('auction_gallery').where("author_uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('created_on', descending: true);


  @override
  Widget build(BuildContext context) {
    query.get().then((querySnapshot) {
      totalPosted = querySnapshot.size;
    });
    return SafeArea(child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          24.ph,
          CircleAvatar(
            radius: 50,
            backgroundImage: CachedNetworkImageProvider(
                FirebaseAuth.instance.currentUser!.photoURL!,
            ),
          ),
          8.ph,
          Text(FirebaseAuth.instance.currentUser!.displayName!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          Text(FirebaseAuth.instance.currentUser!.email!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          Text('Total auction posted: $totalPosted',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        SizedBox(
          height: 400,
          child: PaginateFirestore(
              isLive: true,
              onEmpty: const Center(child: Text('Empty Data'),),
              itemsPerPage: 3,
              onError: (e) => const Center(child: Text('Something went wrong'),),
              bottomLoader: const Center(child: CircularProgressIndicator.adaptive(),),
              itemBuilder: (context, snapshot, index){
                final Map<String, dynamic> json = snapshot[index].data() as Map<String,dynamic>;
                final product = ProductModel.fromJson(json);
                return PostedAuctionItem(product: product);
              },
              query: query,
                itemBuilderType: PaginateBuilderType.listView),
        ),
        ],
      ),
    ));
  }
}

class UserAvaterPlaceHolder extends StatelessWidget {
  const UserAvaterPlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(FirebaseAuth.instance.currentUser!.displayName![0],style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),);
  }
}




class PostedAuctionItem extends StatelessWidget {
  const PostedAuctionItem({Key? key,required this.product}) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image.network(product.productImgUrl,fit: BoxFit.fitWidth,height: 200,),
              CachedNetworkImage(
                  imageUrl: product.productImgUrl,fit: BoxFit.cover,height: 200,
                  placeholder:  (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.broken_image_outlined,size: 200,),
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

