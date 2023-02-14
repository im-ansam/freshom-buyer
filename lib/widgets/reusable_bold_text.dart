import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/dimensions.dart';

class BoldText extends StatelessWidget {
  final FontWeight fontWeight;
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  const BoldText(
      {Key? key,
      required this.fontWeight,
      this.color,
      required this.text,
      this.size = 0,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: GoogleFonts.roboto(
        color: color,
        fontSize: size == 0 ? Dimensions.fontSize23 : size,
        fontWeight: fontWeight,
      ),
    );
    ;
  }
}
