import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/Profile/profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_bold_text.dart';

class EditBuyerProfile extends StatelessWidget {
  final dynamic userData;
  const EditBuyerProfile({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isLoading = false.obs;
    var controller = Get.find<BuyerProfileController>();

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () async {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          foregroundColor: AppColors.nicePurple,
          elevation: 0,
          backgroundColor: AppColors.nicePurple,
          title: BoldText(
            text: "Edit Profile",
            fontWeight: FontWeight.bold,
            color: Colors.white,
            size: Dimensions.fontSize20,
          ),
        ),
        backgroundColor: AppColors.mainBackGround,
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: AppColors.nicePurple,
                  height: Dimensions.height260,
                )),
            Positioned(
                top: Dimensions.height50,
                left: Dimensions.width10,
                right: Dimensions.width10,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.height20),
                  height: Dimensions.height500,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: Dimensions.radius10,
                            offset: const Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                      color: Colors.white),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: Dimensions.height90,
                            width: Dimensions.height90,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child:
                                //if imageUrl of database and profile image path is empty
                                userData['imageUrl'] == "" &&
                                        controller.profileImgPath.isEmpty

                                    //default asset image will show
                                    ? Image.asset(
                                        "images/cameraLogo2.png",
                                        fit: BoxFit.cover,
                                      )

                                    //else if imageUrl of database is not empty but profile image path is empty
                                    : userData['imageUrl'] != "" &&
                                            controller.profileImgPath.isEmpty

                                        //
                                        ? Image.network(
                                            userData['imageUrl'],
                                            fit: BoxFit.cover,
                                          )

                                        //else selected image will show
                                        : Image.file(
                                            File(controller
                                                .profileImgPath.value),
                                            fit: BoxFit.cover,
                                          ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.changeImg(context);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                height: Dimensions.height40,
                                width: Dimensions.height90 * 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5),
                                    color: AppColors.nicePurple),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: Dimensions.icon20,
                                      ),
                                      Text(
                                        'Change Image',
                                        style: GoogleFonts.alata(
                                            fontWeight: FontWeight.w500,
                                            fontSize: Dimensions.fontSize18,
                                            color: Colors.white),
                                      )
                                    ])),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoldText(
                                fontWeight: FontWeight.bold,
                                text: "Name",
                                size: Dimensions.fontSize18,
                                color: AppColors.nicePurple,
                              ),
                              Dimensions.height10.heightBox,
                              TextField(
                                controller: controller.nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: Dimensions.height20,
                                      left: Dimensions.width10),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5),
                                    borderSide: const BorderSide(
                                        color: AppColors.nicePurple),
                                  ),
                                ),
                              ),
                              10.heightBox,
                              BoldText(
                                fontWeight: FontWeight.bold,
                                text: "Old Password",
                                size: Dimensions.fontSize18,
                                color: AppColors.nicePurple,
                              ),
                              Dimensions.height10.heightBox,
                              TextField(
                                obscureText: true,
                                controller: controller.oldPassController,
                                decoration: InputDecoration(
                                  hintText: "Old Password",
                                  contentPadding: EdgeInsets.only(
                                      top: Dimensions.height20,
                                      left: Dimensions.width10),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5),
                                    borderSide: const BorderSide(
                                        color: AppColors.nicePurple),
                                  ),
                                ),
                              ),
                              10.heightBox,
                              BoldText(
                                fontWeight: FontWeight.bold,
                                text: "New Password",
                                size: Dimensions.fontSize18,
                                color: AppColors.nicePurple,
                              ),
                              Dimensions.height10.heightBox,
                              TextField(
                                obscureText: true,
                                controller: controller.newPassController,
                                decoration: InputDecoration(
                                  hintText: "New password",
                                  contentPadding: EdgeInsets.only(
                                      top: Dimensions.height20,
                                      left: Dimensions.width10),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5),
                                    borderSide: const BorderSide(
                                        color: AppColors.nicePurple),
                                  ),
                                ),
                              ),
                              Dimensions.height20.heightBox,
                              GestureDetector(
                                onTap: () async {
                                  isLoading(true);

                                  //if user doesn't choose any file then the link present in database will again pasted in side that
                                  if (controller
                                      .profileImgPath.value.isNotEmpty) {
                                    await controller.uploadProfileImg();
                                  } else {
                                    controller.profileImgLink =
                                        userData['imageUrl'];
                                  }

                                  //if the entering oldPassword matches the old password in database then only user can change it

                                  if (userData['password'] ==
                                      controller.oldPassController.text) {
                                    await controller.changeAuthPassword(
                                        email: userData['email'],
                                        password:
                                            controller.oldPassController.text,
                                        newPassword:
                                            controller.newPassController.text);
                                    await controller.updateProfile(
                                        imageUrl: controller.profileImgLink,
                                        password:
                                            controller.newPassController.text,
                                        name: controller.nameController.text);
                                    VxToast.show(context, msg: "Updated");
                                    isLoading(false);
                                  } else {
                                    VxToast.show(context,
                                        msg: "Old Password Entered is wrong");
                                  }
                                  isLoading(false);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: Dimensions.height40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius5),
                                      color: AppColors.nicePurple),
                                  child: isLoading.value == true
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const BoldText(
                                          fontWeight: FontWeight.w700,
                                          text: "Save",
                                          color: Colors.white,
                                        ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                ))
          ],
        ));
  }
}
