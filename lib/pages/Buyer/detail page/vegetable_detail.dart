import 'package:flutter/material.dart';
import 'package:fresh_om/controller/product_controller.dart';
import 'package:fresh_om/utils/colors.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';
import 'package:fresh_om/widgets/reusable_small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/dimensions.dart';

import '../../../widgets/expandable_text.dart';
import '../messages/message_screen.dart';

class VegetableDetail extends StatelessWidget {
  final dynamic data;
  const VegetableDetail({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController());
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          //head background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(data['v_image']))),
              // child: Image.asset('images/veg2.jpeg'),
            ),
          ),
          //buttons
          Positioned(
              top: Dimensions.height55,
              left: Dimensions.height20,
              right: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: Dimensions.icon30,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: Dimensions.icon30,
                  )
                ],
              )),
          //food detail
          Positioned(
            bottom: 0,
            top: Dimensions.height350,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height50,
                  left: Dimensions.height25,
                  right: Dimensions.height25),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade600,
                        blurRadius: 20,
                        spreadRadius: 1)
                  ],
                  color: AppColors.mainBackGround,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius25),
                      topRight: Radius.circular(Dimensions.radius25))),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${data['v_name']}",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize30,
                              fontWeight: FontWeight.w500),
                        ),
                        BoldText(
                          fontWeight: FontWeight.bold,
                          text: "Rs ${data['v_price']}/Kg",
                          size: Dimensions.fontSize20,
                          color: Colors.redAccent,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: "Quantity Available  -",
                          size: Dimensions.fontSize18,
                          color: AppColors.tealColor,
                        ),
                        Text(
                          "${data['v_qty']}kg left",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize20,
                              color: Colors.redAccent),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    //message seller
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width15),
                      height: Dimensions.height70,
                      width: Dimensions.screenWidth,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                          color: Colors.grey.shade400),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SmallText(
                                  text: "Seller Name",
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                                SmallText(
                                  text: "Ansam CD",
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const MessageSeller(), arguments: [
                                data['seller_name'],
                                data['seller_id']
                              ]);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message_rounded,
                                color: AppColors.tealColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),

                    //Product Uploaded date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldText(
                          fontWeight: FontWeight.bold,
                          text: "Product Uploaded Date :",
                          size: 20,
                          color: AppColors.tealColor,
                        ),
                        BoldText(
                          fontWeight: FontWeight.bold,
                          text: "",
                          size: 16,
                          color: Colors.redAccent,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: Dimensions.fontSize23,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    ExpadableText(
                      text: "${data['v_desc']}",
                    ),
                    SizedBox(
                      height: Dimensions.height100,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            top: Dimensions.height15,
            left: Dimensions.height15,
            bottom: Dimensions.height15,
            right: Dimensions.height15),
        height: Dimensions.height90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius30),
                topLeft: Radius.circular(Dimensions.radius30)),
            color: Colors.grey.shade300),
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  // height: Dimensions.height90,
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.height15,
                      right: Dimensions.height15,
                      bottom: Dimensions.height15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  //quantity selection
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.remove,
                          color: Colors.grey.shade900,
                        ),
                        onTap: () {
                          productController.v_DecreaseQty(context);
                          productController.v_CalculateTotalPrice(
                              int.parse(data['v_price']));
                        },
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      Text(
                        "${productController.v_quantity.value} kg",
                        style: TextStyle(
                            fontSize: Dimensions.fontSize18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      GestureDetector(
                        onTap: () {
                          productController.v_IncreaseQty(
                              context, int.parse(data['v_qty']));
                          productController.v_CalculateTotalPrice(
                              int.parse(data['v_price']));
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (productController.v_quantity.value > 0) {
                      productController.addToCart(
                          title: data['v_name'],
                          img: data['v_image'],
                          qty: productController.v_quantity.value,
                          sellerName: data['seller_name'],
                          sellerID: data['seller_id'],
                          tPrice: productController.v_totalPrice.value,
                          context: context);
                      VxToast.show(context, msg: "Added To Cart");
                    } else {
                      return VxToast.show(context,
                          msg: "Your quantity is zero");
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: Dimensions.height15,
                        left: Dimensions.height15,
                        right: Dimensions.height15,
                        bottom: Dimensions.height15),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.buttonColor),
                    child: Text(
                      'Rs ${productController.v_totalPrice.value.numCurrency} | Add to cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.fontSize16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
