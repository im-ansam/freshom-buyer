import 'package:flutter/material.dart';

import '../widgets/reusable_big_text.dart';
import '../widgets/reusable_small_text.dart';
import 'colors.dart';
import 'dimensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//horizontal scroll food function
// Container buildHorizontalScrollCont(
//     {String img = "", String title = "", String price = ""}) {
//   return Container(
//     margin: EdgeInsets.all(Dimensions.width10),
//     alignment: Alignment.center,
//     width: 130,
//     child: Column(
//       children: [
//         Container(
//           margin: EdgeInsets.only(bottom: Dimensions.height10),
//           // padding: EdgeInsets.only(right: 15),
//           height: 170,
//           width: 130,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.asset(
//               img,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         SmallText(
//           text: title,
//           color: Colors.black87,
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         SmallText(text: price, color: Colors.black87)
//       ],
//     ),
//   );
// }

Container buildPopularText({String popularText = "", String list = ""}) {
  return Container(
    padding: EdgeInsets.only(top: 25, bottom: 30, left: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        BigText(
          text: popularText,
          size: Dimensions.fontSize20,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          width: 10,
        ),
        BigText(
          text: list,
          size: Dimensions.fontSize16,
          color: AppColors.inactiveTextColor,
          fontWeight: FontWeight.w400,
        )
      ],
    ),
  );
}

//vertical scroll food function

// Padding buildVerticalScrollCont(
//     {String img = "",
//     String title = "",
//     String price = "",
//     String description = ""}) {
//   return Padding(
//     padding: EdgeInsets.only(
//       bottom: 30,
//     ),
//     child: Container(
//       padding: EdgeInsets.only(right: 10),
//       // color: Colors.red,
//       width: double.infinity,
//       child: Row(
//         children: [
//           Container(
//             height: 140,
//             width: 140,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                       blurRadius: 10,
//                       color: Colors.grey.shade300,
//                       offset: Offset(3, 5))
//                 ],
//                 image:
//                     DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.all(10),
//               height: 110,
//               decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                         blurRadius: 15,
//                         color: Colors.grey.shade300,
//                         offset: Offset(5, 5))
//                   ],
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(15),
//                       bottomRight: Radius.circular(15)),
//                   color: AppColors.mainBackGround),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   BigText(
//                     text: title,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   SmallText(text: description),
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 30,
//                       ),
//                       Icon(
//                         FontAwesomeIcons.moneyBillWave,
//                         color: Colors.green,
//                       ),
//                       // BigText(text: "Price -"),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       BigText(
//                         text: price,
//                         fontWeight: FontWeight.w400,
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
