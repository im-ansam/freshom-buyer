import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/Services/firestore_services.dart';
import 'package:fresh_om/pages/Buyer/orders_screen/orders_detail.dart';
import 'package:fresh_om/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/firebase_consts.dart';
import '../../../utils/colors.dart';
import 'package:intl/intl.dart' as intl;

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBackGround,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainBackGround,
        foregroundColor: AppColors.tealColor,
        title: "My Orders"
            .text
            .semiBold
            .size(Dimensions.fontSize18)
            .color(AppColors.tealColor)
            .semiBold
            .make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.tealColor,
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No orders yet!"
                .text
                .semiBold
                .color(AppColors.tealColor)
                .size(Dimensions.fontSize20)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: Dimensions.width8),
                    child: ListTile(
                      tileColor: Colors.grey.shade200,
                      leading: "${index + 1}"
                          .text
                          .color(Colors.black54)
                          .size(Dimensions.fontSize18)
                          .make(),
                      title: Row(
                        children: [
                          auth.currentUser!.email
                              // data[index]['order_code']
                              .toString()
                              .text
                              .semiBold
                              .overflow(TextOverflow.ellipsis)
                              .color(AppColors.tealColor)
                              .make()
                              .box
                              .width(Dimensions.height100)
                              .make(),
                          Dimensions.height10.widthBox,
                          "(${intl.DateFormat().add_yMd().format(data[index]['order_date'].toDate())})"
                              .text
                              .color(Colors.black54)
                              .semiBold
                              .make(),
                        ],
                      ),
                      subtitle: "Rs ${data[index]['total_amount']}"
                          .text
                          .bold
                          .color(AppColors.priceColor)
                          .make(),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(() => OrdersDetail(data: data[index]));
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
