import 'package:flutter/material.dart';
import 'package:fresh_om/utils/dimensions.dart';
import 'package:fresh_om/widgets/reusable_small_text.dart';

import '../utils/colors.dart';

Widget customTextField({label, hint, controller, bool obscureText = false}) {
  return TextFormField(
    obscureText: obscureText,
    decoration: InputDecoration(
      label: SmallText(text: label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius12),
        borderSide: const BorderSide(color: AppColors.tealColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius12),
        borderSide: const BorderSide(color: AppColors.tealColor),
      ),
      hintText: hint,
    ),
  );
}
