import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  final FontWeight fontWeight;
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  final double? letterSpacing;
  const BigText(
      {Key? key,
      this.color = Colors.black,
      this.size = 0,
      required this.text,
      this.overFlow = TextOverflow.ellipsis,
      required this.fontWeight,
      this.letterSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: GoogleFonts.poppins(
        letterSpacing: letterSpacing,
        color: color,
        fontSize: size == 0 ? Dimensions.fontSize23 : size,
        fontWeight: fontWeight,
      ),
    );
  }
}
