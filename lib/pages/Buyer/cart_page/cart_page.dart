import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/controller/cart_controller.dart';
import 'package:fresh_om/pages/Buyer/Services/firestore_services.dart';
import 'package:fresh_om/pages/Buyer/cart_page/confirm_order.dart';
import 'package:fresh_om/widgets/reusable_big_text.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';
import 'package:fresh_om/widgets/reusable_small_text.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_basket,
              color: Colors.white,
              size: Dimensions.icon25,
            ),
            SizedBox(
              width: Dimensions.width20,
            ),
            BigText(
              text: "Your Items",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              size: Dimensions.fontSize20,
            ),
          ],
        ),
        backgroundColor: AppColors.nicePurple,
      ),
      backgroundColor: AppColors.mainBackGround,
      body: StreamBuilder(
        stream:
            FireStoreServices.getCart(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.nicePurple,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: BoldText(
                fontWeight: FontWeight.bold,
                text: "Cart Is Empty",
                color: AppColors.nicePurple,
                size: Dimensions.fontSize20,
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width8,
                  bottom: Dimensions.height80),
              child: Column(
                children: [
                  //cart item heading

                  //list of cart items
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              // visualDensity: VisualDensity(vertical: 2),
                              leading: Container(
                                width: Dimensions.height90,
                                height: Dimensions.height100,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius10)),
                                child: Image.network(
                                  "${data[index]['img']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title:
                                  "${data[index]['title']}  (x${data[index]['qty']}kg)"
                                      .text
                                      .semiBold
                                      .size(Dimensions.fontSize16)
                                      .make(),
                              subtitle: "${data[index]['tPrice']}"
                                  .numCurrency
                                  .text
                                  .semiBold
                                  .color(AppColors.priceColor)
                                  .size(14)
                                  .make(),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.priceColor,
                                ),
                                onPressed: () {
                                  FireStoreServices.deleteDocument(
                                      data[index].id);
                                },
                              ),
                            );
                          }),
                    ),
                  ),
                  Container(
                    width: Dimensions.screenWidth - 60,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                        color: AppColors.darkCream),
                    padding: EdgeInsets.all(Dimensions.height12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldText(
                          fontWeight: FontWeight.w700,
                          text: "Total Price",
                          size: Dimensions.fontSize18,
                          color: Colors.black87,
                        ),
                        Obx(() => "${controller.totalPrice.value}"
                            .text
                            .semiBold
                            .color(AppColors.priceColor)
                            .size(Dimensions.fontSize16)
                            .make())
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ConfirmOrder());
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: Dimensions.height50,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                            color: AppColors.nicePurple),
                        width: Dimensions.screenWidth - 60,
                        child: SmallText(
                          text: "Place Order",
                          color: Colors.white,
                          size: Dimensions.fontSize20,
                        )),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
