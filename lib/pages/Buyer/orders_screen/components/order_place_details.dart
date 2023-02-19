import 'package:flutter/material.dart';
import 'package:fresh_om/widgets/reusable_big_text.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';

Widget orderPlaceDetails({data, title1, title2, d1, d2}) {
  return Padding(
    padding: EdgeInsets.only(bottom: Dimensions.width8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1"
                .text
                .size(Dimensions.fontSize16)
                .semiBold
                .color(AppColors.tealColor)
                .make(),
            BigText(
              text: "$d1",
              fontWeight: FontWeight.w700,
              size: Dimensions.fontSize16,
              color: AppColors.priceColor,
              overFlow: TextOverflow.ellipsis,
            ).box.width(Dimensions.height120).make()
          ],
        ),
        SizedBox(
          width: Dimensions.height60 * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2"
                  .text
                  .size(Dimensions.fontSize16)
                  .semiBold
                  .color(AppColors.tealColor)
                  .make(),
              "$d2"
                  .text
                  .size(Dimensions.fontSize15)
                  .semiBold
                  .color(Colors.grey.shade800)
                  .make(),
            ],
          ),
        )
      ],
    ),
  );
}

Widget addressDetails({data, leading}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      "$leading".text.semiBold.color(Colors.grey.shade800).make(),
      Dimensions.height10.widthBox,
      SizedBox(
        width: Dimensions.height110,
        child: "$data".text.semiBold.color(Colors.grey.shade800).make(),
      )
    ],
  );
}
