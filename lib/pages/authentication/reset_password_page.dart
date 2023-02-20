import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/controller/auth_controller.dart';
import 'package:fresh_om/utils/Reusables_functions.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isLoading = false;
  var controller = Get.put(AuthController());

  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainBackGround,
        body: Stack(
          alignment: Alignment.center,
          children: [
            //top teal background container
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height90, left: Dimensions.width20),
                  height: Dimensions.height300,
                  color: AppColors.mainAppColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: appNameText(
                            text: 'Fresh\'Om',
                            color: Colors.white,
                            size: Dimensions.fontSize50,
                            fontWeight: FontWeight.w500),
                      ),
                      Dimensions.height10.heightBox,
                      RichText(
                        text: TextSpan(
                            text: "Reset your",
                            style: TextStyle(
                                fontSize: Dimensions.fontSize25,
                                color: Colors.white,
                                letterSpacing: 2),
                            children: [
                              TextSpan(
                                  text: " Password,",
                                  style: TextStyle(
                                    fontSize: Dimensions.fontSize30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ))
                            ]),
                      ),
                    ],
                  ),
                )),
            buildBottomHalfContainer(true),
            //center reset password container
            Positioned(
                top: Dimensions.height230,
                left: 20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width10,
                      bottom: Dimensions.height20),
                  height: Dimensions.height167,
                  width: Dimensions.screenWidth - 40,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: Dimensions.radius15,
                            spreadRadius: 5)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Email"
                          .text
                          .size(Dimensions.fontSize16)
                          .semiBold
                          .color(AppColors.mainAppColor)
                          .make()
                          .paddingOnly(
                              left: Dimensions.width10,
                              bottom: Dimensions.width10),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Dimensions.width5),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: AppColors.inactiveTextColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius35)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius35)),
                            hintText: "Recovery email",
                            hintStyle: TextStyle(
                                fontSize: Dimensions.fontSize15,
                                color: AppColors.inactiveTextColor)),
                      ),
                    ],
                  ).paddingOnly(top: Dimensions.height30),
                )),

            //bottom proceed button
            buildBottomHalfContainer(false),
            //bottom back button
            Positioned(
              bottom: Dimensions.height20,
              left: Dimensions.height20,
              child: Container(
                height: Dimensions.height50,
                width: Dimensions.height50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xffFAA214),
                          Color(0xffEF5350),
                        ]),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1))
                    ]),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: Dimensions.icon30,
                  color: Colors.white,
                ),
              ).onTap(() {
                emailController.clear();
                Get.back();
              }),
            )
          ],
        ));
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    // var controller = Get.find<AuthController>();
    return Positioned(
        top: Dimensions.height350,
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.height80,
          width: Dimensions.height80,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: Dimensions.radius10,
                      spreadRadius: 1.5,
                      offset: Offset(0, 1))
              ]),
          child: Container(
                  height: Dimensions.height50,
                  width: Dimensions.height50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xffFAA214),
                            Color(0xffEF5350),
                          ]),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  child: isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.arrow_forward_rounded,
                          size: Dimensions.icon30,
                          color: Colors.white,
                        ))
              .onTap(() async {
            setState(() {
              isLoading = true;
            });
            try {
              await controller.resetPassword(
                  context: context, emailController: emailController.text);
              setState(() {
                isLoading = false;
              });
              VxToast.show(context, msg: "Email Send Successfully");
            } on FirebaseAuthException catch (e) {
              setState(() {
                isLoading = false;
              });
              Get.snackbar('Unable to reset password', e.toString());
            }
          }),
        ));
  }
}
