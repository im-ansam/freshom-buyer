import 'package:flutter/material.dart';
import 'package:fresh_om/controller/product_controller.dart';
import 'package:fresh_om/pages/Buyer/cart_page/cart_page.dart';
import 'package:fresh_om/widgets/reusable_big_text.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/expandable_text.dart';
import '../../../widgets/reusable_bold_text.dart';
import '../../../widgets/reusable_small_text.dart';
import '../messages/message_screen.dart';

class FruitsDetail extends StatelessWidget {
  final dynamic data;
  const FruitsDetail({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
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
                        fit: BoxFit.cover,
                        image: NetworkImage(data['f_image']))),
                // child: Image.asset('images/veg2.jpeg'),
              ),
            ),

            //buttons
            Positioned(
                top: Dimensions.height60,
                left: Dimensions.height20,
                right: Dimensions.height20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: CircleAvatar(
                            radius: Dimensions.radius15,
                            backgroundColor: AppColors.lightGreen1,
                            child: Icon(
                              Icons.clear,
                              color: AppColors.nicePurple,
                              size: Dimensions.icon20,
                            )).onTap(() {
                      Get.back();
                      controller.resetValues();
                    })),
                    CircleAvatar(
                      radius: Dimensions.radius15,
                      backgroundColor: AppColors.lightGreen1,
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.nicePurple,
                        size: Dimensions.icon20,
                      ),
                    ).onTap(() {
                      Get.to(() => const CartPage());
                    })
                  ],
                )),
            //top cart count circle
            controller.cartCount.value == 0
                ? Container()
                : Positioned(
                    top: Dimensions.height50,
                    right: Dimensions.width15,
                    child: CircleAvatar(
                      radius: Dimensions.radius10,
                      backgroundColor: Colors.yellow,
                      child: "${controller.cartCount.value}"
                          .text
                          .color(Colors.black)
                          .make(),
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
                          blurRadius: Dimensions.radius20,
                          spreadRadius: 1)
                    ],
                    color: AppColors.mainBackGround,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius25),
                        topRight: Radius.circular(Dimensions.radius25))),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        textBaseline: TextBaseline.alphabetic,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: "${data['f_name']}",
                            size: Dimensions.fontSize25,
                            fontWeight: FontWeight.w600,
                            color: AppColors.nicePurple,
                          ),
                          BoldText(
                            fontWeight: FontWeight.bold,
                            text: "Rs ${data['f_price']}/Kg",
                            size: Dimensions.fontSize20,
                            color: AppColors.orangeRed,
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(
                            text: "Quantity Available  -",
                            size: Dimensions.fontSize18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                          Text(
                            "${data['f_qty']}kg left",
                            style: TextStyle(
                                fontSize: Dimensions.fontSize20,
                                color: AppColors.orangeRed),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //message seller
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width15),
                        height: Dimensions.height60,
                        width: Dimensions.screenWidth,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            color: Colors.grey.shade300),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SmallText(
                                    text: "Seller Name",
                                    color: AppColors.mainAppColor,
                                  ),
                                  SizedBox(
                                    height: Dimensions.height5,
                                  ),
                                  SmallText(
                                    size: Dimensions.fontSize14,
                                    text: "${data['seller_name']}",
                                    color: AppColors.nicePurple,
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
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.message_rounded,
                                  color: AppColors.mainAppColor,
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
                          BigText(
                            fontWeight: FontWeight.w600,
                            text: "Product Uploaded Date :",
                            size: Dimensions.fontSize18,
                            color: Colors.black87,
                          ),
                          BoldText(
                            fontWeight: FontWeight.bold,
                            text: data['f_uploaded_date'],
                            size: Dimensions.fontSize16,
                            color: AppColors.orangeRed,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      BigText(
                          text: "Description",
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize20,
                          color: Colors.black87),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      ExpadableText(
                        text: "${data['f_desc']}",
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
              top: Dimensions.height10,
              left: Dimensions.height15,
              bottom: Dimensions.height15,
              right: Dimensions.height15),
          height: Dimensions.height80,
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
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
                            controller.f_DecreaseQty(context);
                            controller.f_CalculateTotalPrice(
                                int.parse(data['f_price']));
                          },
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        Text(
                          "${controller.f_quantity.value} kg",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.f_IncreaseQty(context, data['f_qty']);
                            controller.f_CalculateTotalPrice(
                                int.parse(data['f_price']));
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
                    onTap: () async {
                      if (controller.f_quantity.value > 0) {
                        controller.addToCart(
                            pId: data['f_id'],
                            title: data['f_name'],
                            img: data['f_image'],
                            qty: controller.f_quantity.value,
                            sellerID: data['seller_id'],
                            sellerName: data['seller_name'],
                            tPrice: controller.f_totalPrice.value,
                            context: context);
                        await controller.setNewFruitQty(
                            docId: data['f_id'],
                            newQty:
                                data['f_qty'] - controller.f_quantity.value);
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
                          color: AppColors.mainAppColor),
                      child: Text(
                        'Rs ${controller.f_totalPrice.value.numCurrency} | Add to cart',
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
      ),
    );
  }
}
