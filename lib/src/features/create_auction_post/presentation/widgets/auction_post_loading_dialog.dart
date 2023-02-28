import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:e_auction/src/core/utils/colorResources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CreateAuctionLoadingDialog extends StatelessWidget {
  const CreateAuctionLoadingDialog({Key? key}) : super(key: key);

  @override
  build(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) => Card(
        child: Row(
          children: [
            const SpinKitPianoWave(color: ColorResources.deepBlue, itemCount: 5,),
            16.pw,
            const Text('Please Wait...')
          ],
        ),
      ),
    );
  }
}

class CommonMethod {
  static loaderScreen(BuildContext context) {
    showDialog(
      barrierDismissible: false,
        context: context, builder: (context)=> Dialog(
      elevation: 5,
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitPianoWave(color: ColorResources.deepBlue, itemCount: 5,),
            16.pw,
            const Text('Please Wait...')
          ],
        ),
      ),
    ));
  }
}
