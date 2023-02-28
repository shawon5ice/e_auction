
import 'package:flutter/material.dart';

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
