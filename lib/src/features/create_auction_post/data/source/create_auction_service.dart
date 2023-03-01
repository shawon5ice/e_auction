import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CreateAuctionService {


  Future<bool> createNewAuctionPost({required ProductModel product}) async {
    final productRef = FirebaseFirestore.instance.collection('auction_gallery');
    try {
      productRef.add(product.toJson()).whenComplete(() => true);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<String> uploadProductImage({required String filePath}) async {
    late String downloadUrl;
    try{
      final String fileName = FirebaseAuth.instance.currentUser!.uid.toString() + DateTime.now().toIso8601String();

      final reference = firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      logger.i(filePath);
      final uploadTask = reference.putFile(File(filePath));
      await uploadTask.whenComplete(() async{
        downloadUrl = await reference.getDownloadURL();
      });
    }catch(e){
      return "";
    }

    return downloadUrl;
  }
}
