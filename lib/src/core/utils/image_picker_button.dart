import 'dart:io';

import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends StatefulWidget {
  const ImagePickerButton({super.key});

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  final CreateAuctionPostController _createAuctionPostController =
      Get.find<CreateAuctionPostController>();
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Choose an option"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      PickerButton(
                          pickerType: false,
                          controller: _createAuctionPostController),
                      16.ph,
                      PickerButton(
                          pickerType: true,
                          controller: _createAuctionPostController)
                    ],
                  ),
                ),
              ),
            );
          },
          child: Container(
              height: 150,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
              style: BorderStyle.solid,
              strokeAlign: BorderSide.strokeAlignCenter,
              width:2),
          ),
          child: Obx(
            () => _createAuctionPostController.imageFilePath.value.isNotEmpty
                ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Center(
                            child: Image.file(
                              File(_createAuctionPostController
                                  .imageFilePath.value),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                _createAuctionPostController
                                    .imageFilePath.value = "";
                              },
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.black.withOpacity(.8),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: 16,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                  )
                : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera),
                      10.ph,
                      const Text('Tap to pick \nan image',textAlign: TextAlign.center,),
                    ],
                  ),
                ),
          ),
          ),
        ),
      ],
    );
  }
}

class PickerButton extends StatelessWidget {
  ///
  /// pickerType == true for gallery and false for camera
  ///
  final bool pickerType;

  const PickerButton({
    super.key,
    required CreateAuctionPostController controller,
    required this.pickerType,
  }) : _createAuctionPostController = controller;

  final CreateAuctionPostController _createAuctionPostController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          _createAuctionPostController
              .getImage(pickerType ? ImageSource.gallery : ImageSource.camera);
          Navigator.of(context).pop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(pickerType ? Icons.photo : Icons.camera_alt),
            16.pw,
            Text(pickerType ? "Gallery" : "Camera"),
          ],
        ));
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
