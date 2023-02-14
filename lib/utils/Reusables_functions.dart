import 'package:flutter/material.dart';

import '../widgets/reusable_big_text.dart';
import 'colors.dart';
import 'dimensions.dart';

Container buildPopularText({String popularText = "", String list = ""}) {
  return Container(
    padding: EdgeInsets.only(
        top: Dimensions.height25,
        bottom: Dimensions.height30,
        left: Dimensions.width10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        BigText(
          text: popularText,
          size: Dimensions.fontSize20,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          width: Dimensions.width10,
        ),
        BigText(
          text: list,
          size: Dimensions.fontSize16,
          color: AppColors.inactiveTextColor,
          fontWeight: FontWeight.w400,
        )
      ],
    ),
  );
}
