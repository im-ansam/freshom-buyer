import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          size: Dimensions.fontSize18,
          fontWeight: FontWeight.w600,
          color: AppColors.mainAppColor,
        ),
        SizedBox(
          width: Dimensions.width10,
        ),
        BigText(
          text: list,
          size: Dimensions.fontSize14,
          color: AppColors.inactiveTextColor,
          fontWeight: FontWeight.w400,
        )
      ],
    ),
  );
}

Text appNameText(
    {text, FontWeight? fontWeight, Color? color, size, letterSpacing}) {
  return Text(
    text,
    style: GoogleFonts.lobster(
        letterSpacing: letterSpacing ?? 3.0,
        fontSize: size,
        fontWeight: fontWeight ?? FontWeight.w200,
        color: color ?? AppColors.mainAppColor),
  );
}
