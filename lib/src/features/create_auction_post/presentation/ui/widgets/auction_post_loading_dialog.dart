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
  static Widget loaderScreen() {
    return AbsorbPointer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          elevation: 10,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitDancingSquare(color: ColorResources.deepBlue,),
                16.pw,
                const Text('Please Wait...')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
