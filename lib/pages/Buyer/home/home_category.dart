import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/controller/product_controller.dart';
import 'package:fresh_om/pages/Buyer/detail%20page/fruits_detail.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/Reusables_functions.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_big_text.dart';
import '../../../widgets/reusable_bold_text.dart';
import '../detail page/vegetable_detail.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:intl/intl.dart' as intl;

int fruitIndex = 0;
int vegIndex = 0;

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  var controller = Get.put(ProductController());
  @override
  void initState() {
    fruitIndex;
    vegIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          //popular fruits . list text
          buildPopularText(popularText: "New Fruits", list: ". List"),
          SizedBox(
            height: Dimensions.height15,
          ),
          //VxSwiper for fruits

          StreamBuilder(
              stream: firestore
                  .collection(fruitsCollection)
                  .where('f_uploaded_date',
                      isEqualTo: intl.DateFormat('dd-MM-yyyy')
                          .format(DateTime.now())
                          .toString())
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(
                    color: AppColors.nicePurple,
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Lottie.asset('animations/noItems.json',
                            width: 150, fit: BoxFit.contain),
                        BigText(
                          fontWeight: FontWeight.w500,
                          text: "No new Fruits",
                          color: Colors.grey[600],
                          size: Dimensions.fontSize16,
                        ),
                      ],
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
                          height: Dimensions.height140,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          itemCount: popularFruits.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await controller.getCartCount();
                                Get.to(() => FruitsDetail(
                                      data: popularFruits[index],
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
                                              popularFruits[index]['f_image']),
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
                      //horizontal scroll effect container
                      DotsIndicator(
                        dotsCount: popularFruits.length,
                        position: fruitIndex.toDouble(),
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
                    ],
                  );
                }
              }),

          buildPopularText(popularText: "New Vegetables", list: ". List"),
          SizedBox(
            height: Dimensions.height15,
          ),

          //VxSwiper for Vegetables
          StreamBuilder(
              stream: firestore
                  .collection(vegetableCollection)
                  .where('v_uploaded_date',
                      isEqualTo: intl.DateFormat('dd-MM-yyyy')
                          .format(DateTime.now())
                          .toString())
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                        70.heightBox
                      ],
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
                          height: Dimensions.height140,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          itemCount: popularVeg.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await controller.getCartCount();
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
                                              popularVeg[index]['v_image']),
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
                      //horizontal scroll effect container
                      DotsIndicator(
                        dotsCount: popularVeg.length,
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

                      SizedBox(
                        height: Dimensions.height90,
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
