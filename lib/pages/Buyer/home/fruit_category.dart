import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/pages/Buyer/detail%20page/fruits_detail.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/Reusables_functions.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_bold_text.dart';

class FruitCategory extends StatefulWidget {
  const FruitCategory({Key? key}) : super(key: key);

  @override
  State<FruitCategory> createState() => _FruitCategoryState();
}

class _FruitCategoryState extends State<FruitCategory> {
  int fruitIndex = 0;

  @override
  void initState() {
    fruitIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //popular fruits . list text
        buildPopularText(popularText: "Popular Fruits", list: ". List"),
        StreamBuilder(
            stream: firestore
                .collection(fruitsCollection)
                .where('f_isPopular', isEqualTo: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: BoldText(
                    fontWeight: FontWeight.bold,
                    text: "No Items",
                  ),
                );
              } else {
                var popularData = snapshot.data!.docs;

                return Column(
                  children: [
                    VxSwiper.builder(
                        onPageChanged: (int index) {
                          setState(() {
                            fruitIndex = index;
                          });
                        },
                        aspectRatio: 16 / 9,
                        reverse: false,
                        initialPage: 0,
                        height: Dimensions.height160,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        itemCount: popularData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => FruitsDetail(
                                    data: popularData[index],
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width8),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        popularData[index]['f_image']),
                                    fit: BoxFit.cover),
                              ),
                              // child: Image.asset(
                              //   popularFruitsList[index],
                              //   fit: BoxFit.fitHeight,
                              // ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: Dimensions.height30,
                    ),

                    //horizontal scroll effect dots
                    Center(
                      child: DotsIndicator(
                        dotsCount: popularData.length,
                        position: fruitIndex.toDouble(),
                        decorator: DotsDecorator(
                          activeColor: AppColors.buttonColor,
                          size: Size.square(Dimensions.width8 + 1),
                          activeSize:
                              Size(Dimensions.height18, Dimensions.width8 + 1),
                          activeShape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius5)),
                        ),
                      ),
                    )
                  ],
                );
              }
            }),

        buildPopularText(popularText: "All Product", list: ". List"),

        //All Products list

        StreamBuilder(
            stream: firestore.collection(fruitsCollection).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.tealColor,
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: BoldText(
                    fontWeight: FontWeight.bold,
                    text: "No Items",
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
                        onTap: () {
                          Get.to(() => FruitsDetail(
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
                                child: Image.network(
                                  "${data[index]['f_image']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              BoldText(
                                fontWeight: FontWeight.w700,
                                text: "${data[index]['f_name']}",
                                color: Colors.black87,
                                size: Dimensions.fontSize16,
                              ),
                              BoldText(
                                fontWeight: FontWeight.w700,
                                text: "Rs ${data[index]['f_price']}/kg",
                                color: AppColors.priceColor,
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
    );
  }
}
