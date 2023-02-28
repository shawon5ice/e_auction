import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'assetsPath.dart';
import 'colorResources.dart';

class CommonMethods{
  static Widget notFound() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          SvgPicture.asset(
            AssetsPath.emptySvg,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(right: 22),
            child: const Text(
              "No applicant found",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: ColorResources.deepBlue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}