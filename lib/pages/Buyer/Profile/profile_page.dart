import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/pages/Buyer/Profile/profile_controller.dart';
import 'package:fresh_om/pages/Buyer/Services/firestore_services.dart';
import 'package:fresh_om/pages/Buyer/lists/list.dart';
import 'package:fresh_om/pages/Buyer/messages/messages_list.dart';
import 'package:fresh_om/pages/Buyer/orders_screen/orders_screen.dart';
import 'package:fresh_om/pages/authentication/main_registration_page.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../controller/auth_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_big_text.dart';
import 'edit_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AuthController>();
    var profileController = Get.put(BuyerProfileController());
    return Scaffold(
        backgroundColor: AppColors.mainBackGround,
        body: StreamBuilder(
          stream: FireStoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.tealColor,
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];

              return Stack(
                children: [
                  //background teal color
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: AppColors.tealColor,
                        height: Dimensions.height450,
                      )),

                  //center white container
                  Positioned(
                    top: Dimensions.height300,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      height: Dimensions.height300,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 0.2,
                                blurRadius: Dimensions.radius10,
                                color: Colors.black26,
                                offset: const Offset(-1, 5))
                          ],
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius10),
                          color: Colors.white),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => const MyOrders());
                                    break;
                                  case 1:
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: BoldText(
                                              overFlow: TextOverflow.visible,
                                              fontWeight: FontWeight.w500,
                                              text: "${data['email']}",
                                              // text: controller.profileData['email'],
                                              size: Dimensions.fontSize18,
                                            ),
                                            title: const BoldText(
                                              fontWeight: FontWeight.bold,
                                              text: "Your Email",
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        fontSize: Dimensions
                                                            .fontSize20),
                                                  ))
                                            ],
                                          );
                                        });
                                    break;
                                  case 2:
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: BoldText(
                                              overFlow: TextOverflow.visible,
                                              fontWeight: FontWeight.w500,
                                              text: "${data['address']}",
                                              size: Dimensions.fontSize18,
                                            ),
                                            title: const BoldText(
                                              fontWeight: FontWeight.bold,
                                              text: "Your Address",
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        fontSize: Dimensions
                                                            .fontSize20),
                                                  ))
                                            ],
                                          );
                                        });
                                    break;
                                }
                              },
                              leading: profileButtonsIcons[index],
                              title: profileButtonsText[index].text.make(),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            );
                          },
                          itemCount: profileButtonsText.length),
                    ),
                  ),

                  //top user details
                  Positioned(
                      top: 70,
                      child: Container(
                        padding: EdgeInsets.only(left: Dimensions.width20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: Dimensions.height300),
                              child: GestureDetector(
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  profileController.nameController.text =
                                      data['name'];
                                  Get.to(() => EditBuyerProfile(
                                        userData: data,
                                      ));
                                  // controller.profileDetails();
                                },
                              ),
                            ),
                            Row(
                              children: [
                                //user image
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: Dimensions.height70,
                                  width: Dimensions.height70,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: data['imageUrl'] == ''
                                      ? Image.asset(
                                          "images/cameraLogo2.png",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          data['imageUrl'],
                                          fit: BoxFit.cover,
                                        ),
                                ),

                                SizedBox(
                                  width: Dimensions.width20,
                                ),

                                //user name and email
                                SizedBox(
                                  width: Dimensions.width150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BoldText(
                                        fontWeight: FontWeight.w500,
                                        text: "${data['name']}",
                                        // text: controller.profileData['name'],
                                        size: Dimensions.fontSize18,
                                        color: Colors.white70,
                                      ),
                                      BigText(
                                        text: '${data['email']}',
                                        // text: controller.profileData['email'],
                                        fontWeight: FontWeight.w100,
                                        size: Dimensions.fontSize14,
                                        color: Colors.redAccent,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width30,
                                ),

                                //logout button
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        visualDensity:
                                            const VisualDensity(vertical: 1),
                                        side: const BorderSide(
                                            color: Colors.white70)),
                                    onPressed: () async {
                                      // final ref =
                                      //     await SharedPreferences.getInstance();
                                      // ref.remove('email');
                                      await controller.signOutMethod(context);
                                      Get.offAll(() => MainRegisterPage());
                                    },
                                    child: BigText(
                                      text: "Logout",
                                      fontWeight: FontWeight.w400,
                                      size: Dimensions.fontSize16,
                                      color: Colors.white70,
                                    ))
                              ],
                            ),
                            FutureBuilder(
                              future: FireStoreServices.getCount(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                } else {
                                  var countData = snapshot.data;
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: Dimensions.height30),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius10),
                                              color: Colors.white),
                                          height: Dimensions.height70,
                                          width: Dimensions.height100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              BoldText(
                                                fontWeight: FontWeight.w800,
                                                text: '${countData[0]}',
                                                // text: controller.profileData['cart_count'],
                                                size: Dimensions.fontSize18,
                                                color: Colors.teal,
                                              ),
                                              BoldText(
                                                fontWeight: FontWeight.w500,
                                                text: "In Your Cart",
                                                size: Dimensions.fontSize12,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width30,
                                        ),
                                        Container(
                                          height: Dimensions.height70,
                                          width: Dimensions.height100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius10),
                                              color: Colors.white),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              BoldText(
                                                fontWeight: FontWeight.w800,
                                                text: '${countData[1]}',
                                                // text: controller.profileData['order_count'],
                                                size: Dimensions.fontSize18,
                                                color: Colors.teal,
                                              ),
                                              BoldText(
                                                fontWeight: FontWeight.w500,
                                                text: "Your Orders",
                                                size: Dimensions.fontSize12,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.width30,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(
                                                () => const AllMessageList());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius10),
                                                color: Colors.white),
                                            height: Dimensions.height70,
                                            width: Dimensions.height100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.message_rounded,
                                                  color: Colors.teal,
                                                ),
                                                BoldText(
                                                  fontWeight: FontWeight.w500,
                                                  text: "Messages",
                                                  size: Dimensions.fontSize12,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ))
                ],
              );
            }
          },
        ));
  }
}
