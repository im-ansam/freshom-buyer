import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_om/widgets/reusable_big_text.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';

import '../utils/colors.dart';

Widget exitDialog(context) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.lightBlue1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BoldText(
            fontWeight: FontWeight.w800,
            text: "Confirm",
            color: Colors.black54,
            size: 25,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          BoldText(
            fontWeight: FontWeight.w600,
            text: "Are you sure you want to exit?",
            color: Colors.black54,
            size: 16,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.tealColor)),
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: BoldText(
                  fontWeight: FontWeight.w600,
                  text: "Yes",
                  color: Colors.white,
                  size: 14,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.tealColor)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: BoldText(
                  fontWeight: FontWeight.w600,
                  text: "No",
                  color: Colors.white,
                  size: 14,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}