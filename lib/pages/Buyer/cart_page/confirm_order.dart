import 'package:flutter/material.dart';
import 'package:fresh_om/controller/cart_controller.dart';
import 'package:fresh_om/pages/Buyer/cart_page/payment_methods.dart';
import 'package:fresh_om/utils/colors.dart';
import 'package:fresh_om/utils/dimensions.dart';
import 'package:fresh_om/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: AppColors.mainBackGround,
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (controller.addressController.text.length < 10) {
            VxToast.show(context, msg: 'Entered detail is weak');
          } else if (controller.cityController.text.isEmpty) {
            VxToast.show(context, msg: "Enter your city");
          } else if (controller.postalCodeController.text.isEmpty) {
            VxToast.show(context, msg: "Postal code is required");
          } else if (controller.phoneController.text.isEmpty) {
            VxToast.show(context, msg: "Phone is required");
          } else {
            Get.to(() => const PaymentMethod());
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.height60,
          color: AppColors.nicePurple,
          child: "Continue".text.semiBold.color(Colors.white).size(20).make(),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.nicePurple,
        title: "Address Details".text.semiBold.color(Colors.white).make(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: Dimensions.height50,
              left: Dimensions.width10,
              right: Dimensions.width10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Your Address"
                  .text
                  .semiBold
                  .color(AppColors.tealColor)
                  .size(Dimensions.fontSize18)
                  .make(),
              Dimensions.height10.heightBox,
              TextField(
                controller: controller.addressController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black26),
                  hintText: "Enter Address",
                  contentPadding: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.width10),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: AppColors.tealColor),
                  ),
                ),
              ),
              Dimensions.height10.heightBox,
              "Home City"
                  .text
                  .semiBold
                  .color(AppColors.tealColor)
                  .size(Dimensions.fontSize18)
                  .make(),
              Dimensions.height10.heightBox,
              TextField(
                controller: controller.cityController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black26),
                  hintText: "eg. sulthan bathery",
                  contentPadding: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.width10),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: AppColors.tealColor),
                  ),
                ),
              ),
              10.heightBox,
              "Pin Code"
                  .text
                  .semiBold
                  .color(AppColors.tealColor)
                  .size(Dimensions.fontSize18)
                  .make(),
              Dimensions.height10.heightBox,
              TextField(
                controller: controller.postalCodeController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black26),
                  hintText: "Postal code",
                  contentPadding: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.width10),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: AppColors.tealColor),
                  ),
                ),
              ),
              Dimensions.height10.heightBox,
              "Contact Number"
                  .text
                  .semiBold
                  .color(AppColors.tealColor)
                  .size(Dimensions.fontSize18)
                  .make(),
              Dimensions.height10.heightBox,
              TextField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.black26),
                  hintText: "Phone",
                  contentPadding: EdgeInsets.only(
                      top: Dimensions.height20, left: Dimensions.width10),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(color: AppColors.tealColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
