import 'package:e_auction/src/core/di/app_component.dart';
import 'package:e_auction/src/features/create_auction_post/data/models/auction_model.dart';
import 'package:e_auction/src/features/create_auction_post/domain/repository/create_auction_repository.dart';
import 'package:e_auction/src/features/create_auction_post/domain/usecase/upload_auction_product.dart';
import 'package:e_auction/src/features/create_auction_post/domain/usecase/upload_product_image_usecase.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/ui/widgets/auction_post_success_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../ui/widgets/permission_warning_widget.dart';
import 'package:logger/logger.dart';

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
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context, initialTime: TimeOfDay.now(),);
      if (time != null) {
        auctionEndDateTime.value = DateTime(
          picked.year, picked.month, picked.day, time.hour, time.minute,);
      }
    }
  }

  void postNewAuction() async {
    String uploadUrl = "";
    if (imageFilePath.value.isNotEmpty) {
      UploadProductImageUseCase uploadProductImageUseCase = UploadProductImageUseCase(locator<CreateAuctionRepository>());
      uploadUrl = await uploadProductImageUseCase(filePath: imageFilePath.value);
      if(uploadUrl.isEmpty){
        const GetSnackBar(
          title: 'Failure',
          message: 'Failed to upload Image',
        );
      }
    }

    ProductModel product = ProductModel(
        title: title.value.trim(),
        description: description.value.trim(),
        author: FirebaseAuth.instance.currentUser!.email!,
        bidder: <Bidder>[],
        productUrl: uploadUrl,
        deadline: auctionEndDateTime.value.toIso8601String(),
        minBidAmount: bidPrice.value);

    UploadAuctionProductUseCase uploadAuctionProductUseCase = UploadAuctionProductUseCase(locator<CreateAuctionRepository>());
    var response = await uploadAuctionProductUseCase(product: product);

    if(response == true){
      const SuccessDialog();
    }
  }

  void getImage(ImageSource source) async {
    final picker = ImagePicker();
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();
    PermissionStatus galleryPermissionStatus = await Permission.storage
        .request();

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
    loading = false.obs;
    title = "".obs;
    description = "".obs;
    bidPrice = 0.0.obs;
    auctionEndDateTime = DateTime
        .now()
        .obs;
    imageFilePath = "".obs;
    isDatePicked = false.obs;
  }
}
