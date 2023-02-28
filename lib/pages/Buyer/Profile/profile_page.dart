import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/Profile/profile_controller.dart';
import 'package:fresh_om/pages/Buyer/Services/firestore_services.dart';
import 'package:fresh_om/pages/Buyer/lists/list.dart';
import 'package:fresh_om/pages/Buyer/messages/messages_list.dart';
import 'package:fresh_om/pages/Buyer/orders_screen/orders_screen.dart';
import 'package:fresh_om/pages/authentication/main_registration_page.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    print(Dimensions.screenHeight);
    var controller = Get.put(AuthController());
    var profileController = Get.put(BuyerProfileController());
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: AppColors.mainAppColor,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          actions: [
            const Icon(
              Icons.edit,
              color: Colors.white,
            ).paddingOnly(right: Dimensions.width20).onTap(() {
              profileController.nameController.text =
                  profileController.name['name'];
              Get.to(() => EditBuyerProfile(
                    userData: profileController.name,
                  ));
            })

            // controller.profileDetails();
            //     },,
          ],
        ),
        backgroundColor: AppColors.mainBackGround,
        body: StreamBuilder(
          stream:
              FireStoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.tealColor,
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              profileController.name = data;
              return Stack(
                children: [
                  //top background color
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          color: AppColors.mainAppColor,
                          height: Dimensions.height330)),

                  //center white container
                  Positioned(
                    top: 200,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: Container(
                      height: Dimensions.height270,
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
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            content: BigText(
                                              letterSpacing: 1,
                                              overFlow: TextOverflow.visible,
                                              fontWeight: FontWeight.w600,
                                              text: "${data['email']}",
                                              // text: controller.profileData['email'],
                                              size: Dimensions.fontSize18,
                                            ),
                                            title: Column(
                                              children: const [
                                                BigText(
                                                  fontWeight: FontWeight.bold,
                                                  text: "Your Email",
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                )
                                              ],
                                            ),
                                            actions: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        AppColors.mainAppColor),
                                                alignment: Alignment.center,
                                                width: Dimensions.height90,
                                                height: Dimensions.height40,
                                                child: BigText(
                                                  text: "OK",
                                                  size: Dimensions.fontSize20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              )
                                                  .paddingOnly(
                                                      right:
                                                          Dimensions.height15,
                                                      bottom:
                                                          Dimensions.height15)
                                                  .onTap(() {
                                                Get.back();
                                              })
                                            ],
                                          );
                                        });
                                    break;
                                  case 2:
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            content: BigText(
                                              overFlow: TextOverflow.visible,
                                              fontWeight: FontWeight.w500,
                                              text:
                                                  "Ansam CD\nAlan\nBasil\nArchana",
                                              size: Dimensions.fontSize18,
                                            ),
                                            title: Column(
                                              children: const [
                                                BigText(
                                                  fontWeight: FontWeight.bold,
                                                  text: "Developed by",
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                )
                                              ],
                                            ),
                                            actions: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        AppColors.mainAppColor),
                                                alignment: Alignment.center,
                                                width: Dimensions.height90,
                                                height: Dimensions.height40,
                                                child: BigText(
                                                  text: "OK",
                                                  size: Dimensions.fontSize20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              )
                                                  .paddingOnly(
                                                      right:
                                                          Dimensions.height15,
                                                      bottom:
                                                          Dimensions.height15)
                                                  .onTap(() {
                                                Get.back();
                                              })
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
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.height25),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //user image
                            Container(
                              clipBehavior: Clip.antiAlias,
                              height: Dimensions.height60,
                              width: Dimensions.height60,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                    text: "${data['name']}",
                                    // text: controller.profileData['name'],
                                    size: Dimensions.fontSize18,
                                    color: Colors.white,
                                  ),
                                  BigText(
                                    letterSpacing: 1,
                                    text: '${data['email']}',
                                    // text: controller.profileData['email'],
                                    fontWeight: FontWeight.w400,
                                    size: Dimensions.fontSize14,
                                    color: Colors.white54,
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
                                  await controller.signOutMethod(context);
                                  var sharedPref =
                                      await SharedPreferences.getInstance();
                                  sharedPref.setBool("isLogged", false);

                                  Get.offAll(() => const MainRegisterPage());
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
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              var countData = snapshot.data;
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: Dimensions.height30),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
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
                                            color: AppColors.mainAppColor,
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
                                      width: Dimensions.width20,
                                    ),
                                    Container(
                                      height: Dimensions.height70,
                                      width: Dimensions.height100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
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
                                            color: AppColors.mainAppColor,
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
                                      width: Dimensions.width20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => const AllMessageList());
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius10),
                                            color: Colors.white),
                                        height: Dimensions.height70,
                                        width: Dimensions.height100,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.message_rounded,
                                              color: AppColors.mainAppColor,
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
                  )
                ],
              );
            }
          },
        ));
  }
}
