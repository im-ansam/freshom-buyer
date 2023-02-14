import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/detail%20page/vegetable_detail.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/firebase_consts.dart';
import '../../../utils/Reusables_functions.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class VegCategory extends StatefulWidget {
  const VegCategory({Key? key}) : super(key: key);

  @override
  State<VegCategory> createState() => _VegCategoryState();
}

class _VegCategoryState extends State<VegCategory> {
  int vegIndex = 0;

  @override
  void initState() {
    vegIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //popular fruits . list text
        buildPopularText(popularText: "Popular Veggies", list: ". List"),
        StreamBuilder(
            stream: firestore
                .collection(vegetableCollection)
                .where('v_isPopular', isEqualTo: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            vegIndex = index;
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
                              Get.to(() => VegetableDetail(
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
                                        popularData[index]['v_image']),
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
                    //horizontal Dots indicator
                    Center(
                      child: DotsIndicator(
                        dotsCount: popularData.length,
                        position: vegIndex.toDouble(),
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
                    ),
                  ],
                );
              }
            }),

        buildPopularText(popularText: "All Products", list: ". List"),

        //All Products list

        StreamBuilder(
            stream: firestore.collection(vegetableCollection).snapshots(),
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
                    physics: NeverScrollableScrollPhysics(),
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
                                child: Image.network(
                                  data[index]['v_image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              BoldText(
                                fontWeight: FontWeight.w700,
                                text: "${data[index]['v_name']}",
                                color: Colors.black87,
                                size: Dimensions.fontSize16,
                              ),
                              BoldText(
                                fontWeight: FontWeight.w700,
                                text: "Rs${data[index]['v_price']}/kg",
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
