import 'package:flutter/material.dart';
import 'package:fresh_om/controller/cart_controller.dart';
import 'package:fresh_om/pages/Buyer/home/buyer_home_page.dart';
import 'package:fresh_om/pages/Buyer/lists/list.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

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
                  orderPaymentMethod:
                      paymentMethods[controller.paymentIndex.value],
                  totalAmount: controller.totalPrice.value,
                  context: context);
              controller.placingOrder(false);
              await controller.clearCart();
              Get.offAll(BuyerHomePage());
            },
            child: Container(
                alignment: Alignment.center,
                height: Dimensions.height60,
                color: AppColors.nicePurple,
                child: controller.placingOrder.value
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : "Place my order"
                        .text
                        .semiBold
                        .color(Colors.white)
                        .size(Dimensions.fontSize20)
                        .make()),
          ),
          appBar: AppBar(
            elevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: AppColors.nicePurple,
            title: "Payment".text.semiBold.color(Colors.white).make(),
          ),
          body: Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Obx(() => Column(
                  children: List.generate(paymentMethods.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.paymentIndex(index);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            border: Border.all(
                              color: controller.paymentIndex.value == index
                                  ? AppColors.tealColor
                                  : Colors.transparent,
                              width: 4,
                            )),
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              paymentMethodImg[index],
                              width: double.infinity,
                              height: Dimensions.height60 * 2,
                              fit: BoxFit.cover,
                              colorBlendMode: controller.paymentIndex == index
                                  ? BlendMode.darken
                                  : BlendMode.color,
                              color: controller.paymentIndex == index
                                  ? Colors.black.withOpacity(0.4)
                                  : Colors.transparent,
                            ),
                            controller.paymentIndex.value == index
                                ? Transform.scale(
                                    scale: 1.3,
                                    child: Checkbox(
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius50)),
                                        value: true,
                                        onChanged: (value) {}),
                                  )
                                : SizedBox(),
                            Positioned(
                                bottom: 7,
                                right: Dimensions.width10,
                                child: "${paymentMethods[index]}"
                                    .text
                                    .semiBold
                                    .color(AppColors.lightBlue1)
                                    .size(Dimensions.fontSize16)
                                    .make())
                          ],
                        ),
                      ),
                    );
                  }),
                )),
          ),
        ));
  }
}
