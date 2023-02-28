import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/Services/firestore_services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../../controller/home_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/dimensions.dart';
import '../../../../widgets/reusable_big_text.dart';
import '../../../../widgets/reusable_bold_text.dart';
import '../../detail page/vegetable_detail.dart';

class VegSearchScreen extends StatelessWidget {
  final String? title;
  const VegSearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: AppColors.mainBackGround,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
            controller.vegSearchController.clear();
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
        future: FireStoreServices.searchVegetables(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainAppColor,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('animations/searchNotFound.json', repeat: false),
                  BigText(
                    fontWeight: FontWeight.w500,
                    text: "No results found",
                    color: Colors.grey[600],
                    size: Dimensions.fontSize20,
                  ),
                ],
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            var filtered = data
                .where((element) => element['v_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase()))
                .toList();
            if (filtered.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('animations/searchNotFound.json',
                        repeat: false),
                    BigText(
                      fontWeight: FontWeight.w500,
                      text: "No results found",
                      color: Colors.grey[600],
                      size: Dimensions.fontSize20,
                    ),
                  ],
                ),
              );
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
                                Container(
                                  // padding: const EdgeInsets.all(8),
                                  // clipBehavior: Clip.antiAlias,
                                  height: Dimensions.height160,
                                  width: double.maxFinite,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(
                                  //       Dimensions.radius10),
                                  // ),
                                  child: Image.network(
                                    filtered[index]['v_image'],
                                    fit: BoxFit.cover,
                                  ),
                                ).onTap(() {
                                  Get.to(() => VegetableDetail(
                                        data: filtered[index],
                                      ));
                                }),
                                BoldText(
                                  fontWeight: FontWeight.w700,
                                  text: "${filtered[index]['v_name']}",
                                  color: Colors.black87,
                                  size: Dimensions.fontSize16,
                                ),
                                BoldText(
                                  fontWeight: FontWeight.w700,
                                  text: "Rs${filtered[index]['v_price']}/kg",
                                  color: AppColors.priceColor,
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
