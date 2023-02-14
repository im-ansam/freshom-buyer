import 'package:flutter/material.dart';

import 'colors.dart';
import 'dimensions.dart';

class ReusableButtonContainer extends StatelessWidget {
  const ReusableButtonContainer({
    Key? key,
    this.isSelected = false,
    required this.text,
    this.onPress,
    this.color,
  }) : super(key: key);
  final String text;
  final bool isSelected;
  final Function()? onPress;
  final color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        height: Dimensions.height30,
        width: Dimensions.height100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(Dimensions.radius50),
          color: color,
          boxShadow: [
            isSelected
                ? BoxShadow(color: Colors.grey, blurRadius: 6)
                : BoxShadow(
                    color: Colors.white,
                    blurRadius: 0,
                  )
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'MerriweatherSans'),
        ),
      ),
    );
    ;
  }
}
