import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateAuctionPostController extends GetxController {
  var loading = false.obs;
  var title = "".obs;
  var description = "".obs;
  var bidPrice = 0.0.obs;
  var deadline = "".obs;
  var auctionEndDateTime = DateTime.now();
  var imageFilePath = "".obs;




  Future<void> uploadImage() async {
    final fileName = 'shawon5ice${DateTime.now().toIso8601String()}';
    final reference = firebase_storage.FirebaseStorage.instance.ref().child(fileName);
    final uploadTask = reference.putFile(File(imageFilePath.value));
    await uploadTask.whenComplete(() async{
      final downloadURL = await reference.getDownloadURL();
      updateProductDocument(downloadURL);
    });
    // updateProductDocument(downloadURL);
  }

  Future<void> updateProductDocument(String downloadURL) async {
    final productRef = FirebaseFirestore.instance.collection('auction_gallery');
    productRef.add(
      {
        'title': title.value,
        'description':description.value,
        'bid_rate':bidPrice.value,
        'deadline':DateTime.now().toIso8601String(),
        'author':FirebaseAuth.instance.currentUser?.email,
        'bidder': [

        ],
        'product_url': downloadURL,
      }
    );
    loading.value = false;
  }

  void getImage(ImageSource source) async {
    final picker = ImagePicker();
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();
    PermissionStatus galleryPermissionStatus = await Permission.storage.request();

    if (cameraPermissionStatus.isGranted || galleryPermissionStatus.isGranted) {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFilePath.value = pickedFile.path;
      }
    } else {
      const PermissionWarning();
    }
  }

  void submitData() {
    loading.value = true;
    if(imageFilePath.value.isEmpty){
      updateProductDocument('');
    }else{
      uploadImage();
    }
  }
}

class PermissionWarning extends StatelessWidget {
  const PermissionWarning({Key? key}) : super(key: key);

  @override
  build(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Permission Request"),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                  "Camera and storage permission are required to use this feature.")
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
