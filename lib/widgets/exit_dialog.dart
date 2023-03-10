import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_om/utils/dimensions.dart';
import 'package:fresh_om/widgets/reusable_big_text.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';

import '../utils/colors.dart';

Widget exitDialog(context) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      padding: EdgeInsets.all(Dimensions.height12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: AppColors.lightGreen2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BigText(
            fontWeight: FontWeight.w600,
            text: "Confirm",
            color: AppColors.mainAppColor,
            size: Dimensions.fontSize25,
          ),
          const Divider(),
          SizedBox(
            height: Dimensions.height10,
          ),
          BigText(
            fontWeight: FontWeight.w600,
            text: "Are you sure you want to exit?",
            color: Colors.black54,
            size: Dimensions.fontSize16,
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.mainAppColor)),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: BoldText(
                  fontWeight: FontWeight.w600,
                  text: "Yes",
                  color: Colors.white,
                  size: Dimensions.fontSize14,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.mainAppColor)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: BoldText(
                  fontWeight: FontWeight.w600,
                  text: "No",
                  color: Colors.white,
                  size: Dimensions.fontSize14,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
