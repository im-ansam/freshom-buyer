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
          fontWeight: FontWeight.w500,
          color: Colors.black87,
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

RichText appNameText(
    {text,
    FontWeight? fontWeight1,
    fontWeight2,
    Color? color,
    size,
    letterSpacing1,
    letterSpacing2}) {
  return RichText(
    text: TextSpan(
        text: "Fresh",
        style: GoogleFonts.poppins(
          letterSpacing: letterSpacing1 ?? 1.0,
          fontSize: size,
          fontWeight: fontWeight1,
          color: color ?? AppColors.nicePurple,
        ),
        children: [
          TextSpan(
              text: "'Om",
              style: GoogleFonts.poppins(
                  letterSpacing: letterSpacing2 ?? 1.0,
                  fontWeight: fontWeight2,
                  fontSize: size,
                  color: color ?? AppColors.nicePurple))
        ]),
  );
}
