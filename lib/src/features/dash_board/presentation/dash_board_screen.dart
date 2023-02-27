import 'package:e_auction/src/features/create_auction_post/presentation/controller/create_auction_post_controller.dart';
import 'package:e_auction/src/features/dash_board/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';



class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);

  final DashBoardController _controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showAlert(context);
        return true;
      },
      child: Obx(
            () => Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(_controller.pageNames[_controller.selectedPageIndex.value]),
          ),
          body: _controller.children[_controller.selectedPageIndex.value],
          bottomNavigationBar: bottomBar(),
        ),
      ),
    );
  }

  _showAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Exit',
              key: Key('Exit'),
            ),
            content: const Text('Are you sure you want to exit?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.of(context).pop();
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget bottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _controller.selectedPageIndex.value,
      onTap: (val) {
        _controller.selectedPageIndex.value = val;
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(_controller.selectedPageIndex.value==0?Icons.home_filled: Icons.home_outlined),
          label: 'Gallery',
        ),
        BottomNavigationBarItem(
          icon: Icon(_controller.selectedPageIndex.value==1?Icons.add_circle:Icons.add_circle_outline),
          label: 'Add Auction',
        ),
        BottomNavigationBarItem(
          icon: Icon(_controller.selectedPageIndex.value==2?Icons.account_circle:Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}
