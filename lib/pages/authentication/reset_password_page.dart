import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/controller/auth_controller.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
                  padding: EdgeInsets.only(top: Dimensions.height100, left: 20),
                  height: Dimensions.height300,
                  color: AppColors.niceBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Fresh\'Om"
                          .text
                          .extraBold
                          .color(Colors.white)
                          .size(50)
                          .makeCentered(),
                      10.heightBox,
                      RichText(
                        text: TextSpan(
                            text: "Reset your",
                            style: TextStyle(
                                fontSize: Dimensions.fontSize25,
                                color: Colors.yellow[200],
                                letterSpacing: 2),
                            children: [
                              TextSpan(
                                  text: " Password,",
                                  style: TextStyle(
                                    fontSize: Dimensions.fontSize30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow[200],
                                  ))
                            ]),
                      ),
                    ],
                  ),
                )),
            buildBottomHalfContainer(true),
            //center reset password container
            Positioned(
                top: 250,
                left: 30,
                right: 30,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  height: Dimensions.height190,
                  width: Dimensions.screenWidth - 40,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Email"
                          .text
                          .size(16)
                          .semiBold
                          .color(AppColors.niceBlue)
                          .make()
                          .paddingOnly(left: 10, bottom: 10),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColors.inactiveTextColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(35.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(35.0)),
                            hintText: "Recovery email",
                            hintStyle: TextStyle(
                                fontSize: Dimensions.fontSize15,
                                color: AppColors.inactiveTextColor)),
                      ),
                    ],
                  ).paddingOnly(top: 30),
                )),

            //bottom proceed button
            buildBottomHalfContainer(false),
            //bottom back button
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                height: Dimensions.height60,
                width: Dimensions.height60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                    gradient: LinearGradient(
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
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 30,
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
        top: 380,
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.height90,
          width: Dimensions.height90,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 10,
                      spreadRadius: 1.5,
                      offset: Offset(0, 1))
              ]),
          child: Container(
                  height: Dimensions.height60,
                  width: Dimensions.height60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                      gradient: LinearGradient(
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
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.arrow_forward_rounded,
                          size: 30,
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
