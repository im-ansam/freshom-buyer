import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/utils/dimensions.dart';
import '../widgets/reusable_big_text.dart';

import 'package:intl/intl.dart' as intl;

import 'colors.dart';

Widget chatBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h,mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(Dimensions.height12),
      margin: EdgeInsets.only(bottom: Dimensions.width8),
      decoration: BoxDecoration(
        color: AppColors.nicePurple,
        borderRadius: data['uid'] == currentUser!.uid
            ? BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20),
                topLeft: Radius.circular(Dimensions.radius20),
                bottomLeft: Radius.circular(Dimensions.radius20))
            : BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20),
                topLeft: Radius.circular(Dimensions.radius20),
                bottomRight: Radius.circular(Dimensions.radius20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            size: Dimensions.fontSize16,
            color: Colors.white,
            text: "${data['msg']}",
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          BigText(
              size: Dimensions.fontSize14,
              color: Colors.white,
              text: time,
              fontWeight: FontWeight.w500)
        ],
      ),
    ),
  );
}
