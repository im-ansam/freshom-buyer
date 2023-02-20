import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/controller/cart_controller.dart';
import 'package:fresh_om/pages/Buyer/home/buyer_home_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_big_text.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(() => Scaffold(
          backgroundColor: AppColors.mainBackGround,
          bottomNavigationBar: GestureDetector(
            onTap: () async {
              await controller.placeMyOrder(
                  orderPaymentMethod: cod,
                  totalAmount: controller.totalPrice.value,
                  context: context);
              controller.placingOrder(false);
              await controller.clearCart();
              Get.offAll(const BuyerHomePage());
            },
            child: Container(
                alignment: Alignment.center,
                height: Dimensions.height60,
                color: AppColors.mainAppColor,
                child: controller.placingOrder.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : BigText(
                        text: "Place my order",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        size: Dimensions.fontSize18,
                      )),
          ),
          appBar: AppBar(
              elevation: 0,
              foregroundColor: Colors.white,
              backgroundColor: AppColors.mainAppColor,
              title: BigText(
                text: "Payment",
                fontWeight: FontWeight.w600,
                size: Dimensions.fontSize18,
                color: Colors.white,
              )),
          body: Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      border: Border.all(
                        strokeAlign: StrokeAlign.outside,
                        color: AppColors.mainAppColor,
                        width: 4,
                      )),
                  margin: EdgeInsets.only(bottom: Dimensions.height10),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        imgCod,
                        width: double.infinity,
                        height: Dimensions.height60 * 2,
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.darken,
                        color: Colors.black.withOpacity(0.4),
                      ),
                      Transform.scale(
                        scale: 1.3,
                        child: Checkbox(
                            activeColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius50)),
                            value: true,
                            onChanged: (value) {}),
                      ),
                      Positioned(
                          bottom: 7,
                          right: Dimensions.width10,
                          child: cod.text.semiBold
                              .color(AppColors.lightBlue1)
                              .size(Dimensions.fontSize16)
                              .make())
                    ],
                  ),
                ),
                Dimensions.height20.heightBox,
                "Provided details"
                    .text
                    .semiBold
                    .size(Dimensions.fontSize16)
                    .color(Colors.grey[600])
                    .make()
                    .box
                    .alignCenterLeft
                    .padding(EdgeInsets.only(left: Dimensions.width10))
                    .width(Dimensions.screenWidth - 30)
                    .height(Dimensions.height40)
                    .color(Colors.grey.shade300)
                    .shadowSm
                    .roundedSM
                    .make(),
                Dimensions.height30.heightBox,
                Container(
                  padding: EdgeInsets.all(20),
                  width: Dimensions.screenWidth - 30,
                  height: 350,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                        )
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildAddressRow(
                          title: "Address     :",
                          detail: controller.addressController.text,
                        ),
                        buildAddressRow(
                          title: "Home city :",
                          detail: controller.cityController.text,
                        ),
                        buildAddressRow(
                          title: "Pin Code   :",
                          detail: controller.postalCodeController.text,
                        ),
                        buildAddressRow(
                          title: "Phone        :",
                          detail: controller.phoneController.text,
                        ),
                        buildAddressRow(
                            title: "Payable \nAmount    :",
                            detail:
                                "Rs:${controller.totalPrice.value.toString()}"),
                        buildAddressRow(
                          title: "Payment \nMethod:",
                          detail: cod,
                        )
                      ]),
                )
              ],
            ),

            // Obx(() => Column(
            //       children: List.generate(paymentMethods.length, (index) {
            //         return GestureDetector(
            //           onTap: () {
            //             controller.paymentIndex(index);
            //           },
            //           child: Container(
            //             clipBehavior: Clip.antiAlias,
            //             decoration: BoxDecoration(
            //                 borderRadius:
            //                     BorderRadius.circular(Dimensions.radius15),
            //                 border: Border.all(
            //                   color: controller.paymentIndex.value == index
            //                       ? AppColors.tealColor
            //                       : Colors.transparent,
            //                   width: 4,
            //                 )),
            //             margin: EdgeInsets.only(bottom: Dimensions.height10),
            //             child: Stack(
            //               alignment: Alignment.topRight,
            //               children: [
            //                 Image.asset(
            //                   paymentMethodImg[index],
            //                   width: double.infinity,
            //                   height: Dimensions.height60 * 2,
            //                   fit: BoxFit.cover,
            //                   colorBlendMode:
            //                       controller.paymentIndex.value == index
            //                           ? BlendMode.darken
            //                           : BlendMode.color,
            //                   color: controller.paymentIndex == index
            //                       ? Colors.black.withOpacity(0.4)
            //                       : Colors.transparent,
            //                 ),
            //                 controller.paymentIndex.value == index
            //                     ? Transform.scale(
            //                         scale: 1.3,
            //                         child: Checkbox(
            //                             activeColor: Colors.green,
            //                             shape: RoundedRectangleBorder(
            //                                 borderRadius: BorderRadius.circular(
            //                                     Dimensions.radius50)),
            //                             value: true,
            //                             onChanged: (value) {}),
            //                       )
            //                     : SizedBox(),
            //                 Positioned(
            //                     bottom: 7,
            //                     right: Dimensions.width10,
            //                     child: paymentMethods[index]
            //                         .text
            //                         .semiBold
            //                         .color(AppColors.lightBlue1)
            //                         .size(Dimensions.fontSize16)
            //                         .make())
            //               ],
            //             ),
            //           ),
            //         );
            //       }),
            //     )),
          ),
        ));
  }

  Row buildAddressRow({title, detail}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: GoogleFonts.poppins(
            color: AppColors.mainAppColor,
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(
        width: 170,
        child: Text(
          detail,
          style: GoogleFonts.poppins(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
    ]);
  }
}
