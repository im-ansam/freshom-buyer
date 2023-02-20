import 'package:flutter/material.dart';
import 'package:fresh_om/widgets/reusable_big_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class DrawerRow extends StatelessWidget {
  const DrawerRow(
      {Key? key,
      required this.icon,
      required this.text,
      this.fontColor = Colors.black})
      : super(key: key);

  final IconData icon;
  final String text;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.mainAppColor,
                radius: Dimensions.radius18,
                child: Icon(
                  icon,
                  size: Dimensions.icon25,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: Dimensions.width20,
              ),
              BigText(
                text: text,
                color: fontColor,
                fontWeight: FontWeight.w600,
                size: Dimensions.fontSize16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
