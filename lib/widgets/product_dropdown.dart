import 'package:flutter/material.dart';
import 'package:fresh_om/widgets/reusable_small_text.dart';
import '../utils/colors.dart';

Widget productDropdown() {
  return DropdownButtonHideUnderline(
      child: Container(
    padding: EdgeInsets.only(left: 10),
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.tealColor,
    ),
    child: DropdownButton<String>(
      hint: SmallText(
        text: "Choose Category",
        color: Colors.white70,
      ),
      focusColor: Colors.grey,
      isExpanded: true,
      items: [],
      onChanged: (value) {},
      value: null,
    ),
  ));
}
