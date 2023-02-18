import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overFlow;
  SmallText(
      {Key? key,
      this.color = const Color(0xff807c78),
      this.size = 0,
      required this.text,
      this.overFlow = TextOverflow.ellipsis,
      this.height = 1.2,
      FontWeight? fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overFlow,
        style: GoogleFonts.poppins(
          height: height,
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: size == 0 ? Dimensions.fontSize16 : size,
        ));
  }
}
