import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    title: Divider(
      color: Colors.grey.shade200,
      thickness: 2,
      endIndent: Dimensions.width15,
    ),
    leading: Icon(
      icon,
      size: Dimensions.fontSize23,
      color: color,
    ).box.roundedSM.p4.border(color: color, width: 3).make(),
    trailing: SizedBox(
      height: Dimensions.height100,
      width: Dimensions.height120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$title"
              .text
              .semiBold
              .size(Dimensions.fontSize15)
              .color(Colors.grey.shade700)
              .make(),
          showDone
              ? const Icon(
                  Icons.done,
                  color: Colors.green,
                )
              : Container()
        ],
      ),
    ),
  );
}
