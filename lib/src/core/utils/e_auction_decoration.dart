import 'package:flutter/material.dart';

import 'colorResources.dart';

class EAuctionDecorations {
  static TextStyle textFieldFocusLabelTextStyle() {
    return const TextStyle(fontSize: 16.0, color: ColorResources.ash);
  }
  static TextStyle textFieldFocusErrorLabelTextStyle() {
    return const TextStyle(fontSize: 16.0, color: ColorResources.red);
  }

  static TextStyle setTextStyle(double fontSize, Color fontColor,
      String fontfamily, FontWeight fontWeight) {
    return TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontFamily: fontfamily,
        fontWeight: fontWeight);
  }

  static OutlineInputBorder textFieldFocusOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide:
      const BorderSide(color: Colors.blue, width: 2.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  static OutlineInputBorder textFieldErrorInputBorder() {
    return OutlineInputBorder(
      borderSide:
      const BorderSide(color: ColorResources.red, width: 2.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  static OutlineInputBorder textFieldOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide:
      const BorderSide(color: ColorResources.ash, width: 2.0),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  static eAuctionInputDecoration({required String hint, required String label}){
    return InputDecoration(
      hintText: hint,
      label: Text(label),
      labelStyle: EAuctionDecorations.textFieldFocusLabelTextStyle(),
      focusedBorder: EAuctionDecorations.textFieldFocusOutlineInputBorder(),
      border: EAuctionDecorations.textFieldOutlineInputBorder(),
    );
  }
}
