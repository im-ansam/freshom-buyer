import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/detail%20page/fruits_detail.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../controller/home_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/reusable_bold_text.dart';
import '../../Services/firestore_services.dart';

class FruitSearchScreen extends StatelessWidget {
  final String? title;
  const FruitSearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: AppColors.mainBackGround,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.fruitSearchController.clear();
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.mainAppColor,
          ),
        ),
        foregroundColor: AppColors.mainAppColor,
        backgroundColor: AppColors.mainBackGround,
        elevation: 0,
        title: title?.text.semiBold.size(Dimensions.fontSize18).make(),
      ),
      body: FutureBuilder(
        future: FireStoreServices.searchFruits(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.nicePurple,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No results found..."
                .text
                .size(Dimensions.fontSize20)
                .semiBold
                .color(AppColors.tealColor)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) => element['f_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            if (filtered.isEmpty) {
              return "No results found..."
                  .text
                  .size(Dimensions.fontSize20)
                  .semiBold
                  .color(AppColors.tealColor)
                  .makeCentered();
            }
            return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimensions.height10,
                    // crossAxisSpacing: Dimensions.width10,
                    mainAxisExtent: Dimensions.height120 * 2),
                children: filtered
                    .mapIndexed((currentValue, index) => Padding(
                          padding: EdgeInsets.only(
                              top: Dimensions.width10,
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: Dimensions.radius10,
                                )
                              ],
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(Dimensions.width8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  // padding: const EdgeInsets.all(8),
                                  // clipBehavior: Clip.antiAlias,
                                  height: Dimensions.height160,
                                  width: double.maxFinite,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(
                                  //       Dimensions.radius10),
                                  // ),
                                  child: Image.network(
                                    filtered[index]['f_image'],
                                    fit: BoxFit.cover,
                                  ),
                                ).onTap(() {
                                  Get.to(() => FruitsDetail(
                                        data: filtered[index],
                                      ));
                                }),
                                BoldText(
                                  fontWeight: FontWeight.w700,
                                  text: "${filtered[index]['f_name']}",
                                  color: Colors.black87,
                                  size: Dimensions.fontSize16,
                                ),
                                BoldText(
                                  fontWeight: FontWeight.w700,
                                  text: "Rs${filtered[index]['f_price']}/kg",
                                  color: AppColors.orangeRed,
                                  size: Dimensions.fontSize16,
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList());
          }
        },
      ),
    );
  }
}
