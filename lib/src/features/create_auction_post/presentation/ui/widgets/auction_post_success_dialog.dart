
import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  build(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Auction Submission"),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                  "Your post have been submitted successfully!")
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Get.find<CreateAuctionPostController>().resetData();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
