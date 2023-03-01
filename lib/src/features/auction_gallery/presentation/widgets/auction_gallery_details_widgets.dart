import 'package:e_auction/src/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../data/models/auction_model.dart';



class CommonTableCell extends StatelessWidget {
  final String text;
  final bool isTitle;
  final bool isName;
  const CommonTableCell({
    super.key, required this.text, required this.isTitle, this.isName= false,

  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            text, style: TextStyle(fontWeight: isTitle?FontWeight.bold:FontWeight.normal),
            textAlign: isName?TextAlign.left:TextAlign.center),
      ),
    );
  }
}

class BidButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const BidButton({
    super.key, required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        32.pw,
        Text(text)
      ],
    );
  }
}

List<TableRow> table(List<Bidder> items) {
  List<TableRow> rows = items.map((rowData) {
    return TableRow(
      children: [
        CommonTableCell(text: rowData.bidderFullName, isTitle: false,isName: true,),
        CommonTableCell(text: rowData.bidAmount.toString(), isTitle: false,isName: true,),
      ],
    );
  }).toList();
  return rows;
}
