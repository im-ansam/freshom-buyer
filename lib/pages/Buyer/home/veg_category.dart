import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/controller/product_controller.dart';
import 'package:fresh_om/pages/Buyer/detail%20page/vegetable_detail.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/firebase_consts.dart';
import '../../../utils/Reusables_functions.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:intl/intl.dart' as intl;

import '../../../widgets/reusable_big_text.dart';

class VegCategory extends StatefulWidget {
  const VegCategory({Key? key}) : super(key: key);

  @override
  State<VegCategory> createState() => _VegCategoryState();
}

class _VegCategoryState extends State<VegCategory> {
  var controller = Get.put(ProductController());
  int vegIndex = 0;

  @override
  void initState() {
    vegIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //popular fruits . list text
          buildPopularText(popularText: "New Veggies", list: ". List"),
          StreamBuilder(
              stream: firestore
                  .collection(vegetableCollection)
                  .where('v_uploaded_date',
                      isEqualTo: intl.DateFormat('dd-MM-yyyy')
                          .format(DateTime.now())
                          .toString())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Lottie.asset('animations/noItems.json', width: 150),
                        BigText(
                          fontWeight: FontWeight.w500,
                          text: "No new vegetables",
                          color: Colors.grey[600],
                          size: Dimensions.fontSize16,
                        ),
                      ],
                    ),
                  );
                } else {
                  var popularData = snapshot.data!.docs;
                  return Column(
                    children: [
                      VxSwiper.builder(
                          onPageChanged: (int index) {
                            setState(() {
                              vegIndex = index;
                            });
                          },
                          aspectRatio: 16 / 9,
                          reverse: false,
                          initialPage: 0,
                          height: Dimensions.height140,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          itemCount: popularData.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await controller.getCartCount();
                                Get.to(() => VegetableDetail(
                                      data: popularData[index],
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: Dimensions.width8),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        left: 0,
                                        bottom: 0,
                                        child: FadeInImage(
                                          fit: BoxFit.cover,
                                          placeholder: const AssetImage(
                                              'animations/imgLoading.gif'),
                                          image: NetworkImage(
                                              popularData[index]['v_image']),
                                        )),
                                    Positioned(
                                        top: 5,
                                        left: 5,
                                        child: Lottie.asset(
                                            'animations/new1.json',
                                            fit: BoxFit.cover,
                                            repeat: true,
                                            reverse: true,
                                            height: Dimensions.height50))
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //horizontal Dots indicator
                      Center(
                        child: DotsIndicator(
                          dotsCount: popularData.length,
                          position: vegIndex.toDouble(),
                          decorator: DotsDecorator(
                            activeColor: AppColors.mainAppColor,
                            size: Size.square(Dimensions.width8),
                            activeSize:
                                Size(Dimensions.height15, Dimensions.width8),
                            activeShape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius5)),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),

          buildPopularText(popularText: "All Products", list: ". List"),

          //All Products list

          StreamBuilder(
              stream: firestore.collection(vegetableCollection).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.tealColor,
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Lottie.asset('animations/noItems.json', width: 140),
                        BigText(
                          fontWeight: FontWeight.w500,
                          text: "No items",
                          color: Colors.grey[600],
                          size: Dimensions.fontSize16,
                        ),
                        70.heightBox
                      ],
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: Dimensions.height10,
                          crossAxisSpacing: Dimensions.width20,
                          mainAxisExtent: Dimensions.height270),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await controller.getCartCount();
                            Get.to(() => VegetableDetail(
                                  data: data[index],
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.all(Dimensions.width8),
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    clipBehavior: Clip.antiAlias,
                                    height: Dimensions.height90 * 2,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius10),
                                    ),
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      placeholder: const AssetImage(
                                          'animations/imgLoading.gif'),
                                      image:
                                          NetworkImage(data[index]['v_image']),
                                    )),
                                BoldText(
                                  fontWeight: FontWeight.w700,
                                  text: "${data[index]['v_name']}",
                                  color: Colors.black87,
                                  size: Dimensions.fontSize16,
                                ),
                                BoldText(
                                  fontWeight: FontWeight.w700,
                                  text: "Rs${data[index]['v_price']}/kg",
                                  color: AppColors.orangeRed,
                                  size: Dimensions.fontSize16,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),

          SizedBox(
            height: Dimensions.height20,
          ),
        ],
      ),
    );
  }
}
