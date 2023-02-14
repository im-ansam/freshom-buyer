import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/pages/Buyer/detail%20page/fruits_detail.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/Reusables_functions.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_bold_text.dart';
import '../detail page/vegetable_detail.dart';
import 'package:dots_indicator/dots_indicator.dart';

int fruitIndex = 0;
int vegIndex = 0;

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  void initState() {
    fruitIndex;
    vegIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //popular fruits . list text
        buildPopularText(popularText: "Popular Fruits", list: ". List"),
        SizedBox(
          height: Dimensions.height20,
        ),
        //VxSwiper for fruits

        StreamBuilder(
            stream: firestore
                .collection(fruitsCollection)
                .where('f_isPopular', isEqualTo: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  color: AppColors.tealColor,
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: BoldText(
                    fontWeight: FontWeight.bold,
                    text: "No Items",
                  ),
                );
              } else {
                var popularFruits = snapshot.data!.docs;
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
                        itemCount: popularFruits.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => FruitsDetail(
                                    data: popularFruits[index],
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
                                        popularFruits[index]['f_image']),
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
                    //horizontal scroll effect container
                    DotsIndicator(
                      dotsCount: popularFruits.length,
                      position: fruitIndex.toDouble(),
                      decorator: DotsDecorator(
                        activeColor: AppColors.buttonColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius5)),
                      ),
                    ),
                  ],
                );
              }
            }),

        buildPopularText(popularText: "Popular Vegetables", list: ". List"),
        SizedBox(
          height: Dimensions.height20,
        ),

        //VxSwiper for Vegetables
        StreamBuilder(
            stream: firestore
                .collection(vegetableCollection)
                .where('v_isPopular', isEqualTo: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: BoldText(
                    fontWeight: FontWeight.bold,
                    text: "No Items",
                  ),
                );
              } else {
                var popularVeg = snapshot.data!.docs;
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
                        height: Dimensions.height160,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        itemCount: popularVeg.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => VegetableDetail(
                                    data: popularVeg[index],
                                  ));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width8),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          popularVeg[index]['v_image']),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        }),

                    SizedBox(
                      height: Dimensions.height30,
                    ),
                    //horizontal scroll effect container
                    DotsIndicator(
                      dotsCount: popularVeg.length,
                      position: vegIndex.toDouble(),
                      decorator: DotsDecorator(
                        activeColor: AppColors.buttonColor,
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius5)),
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.height90,
                    ),
                  ],
                );
              }
            }),
      ],
    );
  }
}
