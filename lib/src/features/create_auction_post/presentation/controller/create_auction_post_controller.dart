import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_auction/src/core/di/app_component.dart';
import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';
import 'package:e_auction/src/features/create_auction_post/domain/repository/create_auction_repository.dart';
import 'package:e_auction/src/features/create_auction_post/domain/usecase/upload_auction_product.dart';
import 'package:e_auction/src/features/create_auction_post/domain/usecase/upload_product_image_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

import '../widgets/auction_post_loading_dialog.dart';
import '../widgets/permission_warning_widget.dart';

Logger logger = Logger();

class CreateAuctionPostController extends GetxController {
  var loading = false.obs;
  var title = "".obs;
  var description = "".obs;
  var bidPrice = 0.0.obs;
  var auctionEndDateTime = DateTime.now().obs;
  var imageFilePath = "".obs;
  var isDatePicked = false.obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        DateTime date = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        auctionEndDateTime.value = date;
      }
    }
  }

  void postNewAuction(BuildContext context) async {
    loading.value = true;
    CommonMethod.loaderScreen(context);
    String uploadUrl = "";
    if (imageFilePath.value.isNotEmpty) {
      UploadProductImageUseCase uploadProductImageUseCase =
          UploadProductImageUseCase(locator<CreateAuctionRepository>());
      uploadUrl =
          await uploadProductImageUseCase(filePath: imageFilePath.value);
      if (uploadUrl.isEmpty) {
        const GetSnackBar(
          title: 'Failure',
          message: 'Failed to upload Image',
        );
      }
    }

    ProductModel product = ProductModel(
        title: title.value.trim(),
        winner: '',
        authorUid: FirebaseAuth.instance.currentUser!.uid,
        description: description.value.trim(),
        authorFullName: FirebaseAuth.instance.currentUser!.displayName!,
        bidder: <Bidder>[],
        productImgUrl: uploadUrl,
        createdOn: Timestamp.fromDate(DateTime.now()),
        deadline: Timestamp.fromDate(auctionEndDateTime.value),
        minBidAmount: bidPrice.value);

    UploadAuctionProductUseCase uploadAuctionProductUseCase = UploadAuctionProductUseCase(locator<CreateAuctionRepository>());
    var response = await uploadAuctionProductUseCase(product: product);

    if (response == true) {
      loading.value = false;
      resetData();
      Navigator.pop(context);
      // const SuccessDialog();
    }
  }

  void getImage(ImageSource source) async {
    final picker = ImagePicker();
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();
    PermissionStatus galleryPermissionStatus =
        await Permission.storage.request();

    if (cameraPermissionStatus.isGranted || galleryPermissionStatus.isGranted) {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFilePath.value = pickedFile.path;
      }
    } else {
      const PermissionWarning();
    }
  }

  void resetData() {
    loading.value = false;
    title.value = "";
    description.value = "";
    bidPrice.value = 0.0;
    auctionEndDateTime.value = DateTime.now();
    imageFilePath.value = "";
    isDatePicked.value = false;
  }
}
