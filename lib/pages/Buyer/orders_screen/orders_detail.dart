import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/orders_screen/components/order_place_details.dart';
import 'package:fresh_om/pages/Buyer/orders_screen/components/order_status.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../utils/colors.dart';
import 'package:intl/intl.dart' as intl;
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_big_text.dart';

class OrdersDetail extends StatelessWidget {
  final dynamic data;
  const OrdersDetail({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Dimensions.screenHeight);
    return Scaffold(
      backgroundColor: AppColors.mainBackGround,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.mainAppColor,
          foregroundColor: Colors.white,
          title: BigText(
            text: "Order Details",
            fontWeight: FontWeight.w600,
            size: Dimensions.fontSize18,
            color: Colors.white,
          )),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
                color: Colors.green,
                title: "Placed",
                icon: Icons.done,
                showDone: data['order_placed']),
            orderStatus(
                color: Colors.blueAccent,
                title: "Confirmed",
                icon: Icons.thumb_up,
                showDone: data['order_confirmed']),
            orderStatus(
                color: Colors.orange,
                title: "On Delivery",
                icon: Icons.delivery_dining,
                showDone: data['order_on_delivery']),
            orderStatus(
                color: AppColors.purpleColor,
                title: "Delivered",
                icon: Icons.done_all_rounded,
                showDone: data['order_delivered']),
            Divider(
              color: Colors.grey.shade300,
              thickness: 2,
              indent: Dimensions.width20,
              endIndent: Dimensions.width20,
            ),
            Dimensions.height10.heightBox,

            //center address details container
            Container(
              padding: EdgeInsets.all(Dimensions.height12),
              width: Dimensions.height350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: Dimensions.radius10,
                  )
                ],
                color: Colors.white,
              ),
              child: Column(
                children: [
                  orderPlaceDetails(
                      data: data,
                      title1: "Order By Id",
                      d1: data['order_by'],
                      title2: "Delivery Method",
                      d2: data['delivery_method']),
                  orderPlaceDetails(
                      data: data,
                      title1: "Order Date",
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format(data['order_date'].toDate()),
                      title2: "Payment Method",
                      d2: data['payment_method']),
                  orderPlaceDetails(
                    data: data,
                    title1: "Payment Status",
                    d1: data['order_delivered'] == true ? "Paid" : "Unpaid",
                    title2: "Delivery Status",
                    d2: data['order_delivered'] == true
                        ? "Delivered"
                        : data['order_on_delivery'] == true
                            ? "On Delivery"
                            : data['order_confirmed'] == true
                                ? "Order Confirmed"
                                : "Order Placed",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: "Delivery Address",
                            fontWeight: FontWeight.w700,
                            size: Dimensions.fontSize15,
                            color: AppColors.nicePurple,
                          ),
                          5.heightBox,
                          addressDetails(
                              data: data['order_by_name'],
                              leading: "Name    :"),
                          addressDetails(
                              data: data['order_by_email'],
                              leading: "Email     :"),
                          addressDetails(
                              data: data['order_by_address'],
                              leading: "Address:"),
                          addressDetails(
                              data: data['order_by_city'],
                              leading: "City        :"),
                          addressDetails(
                              data: data['order_by_phone'],
                              leading: "Phone    :"),
                          addressDetails(
                              data: data['order_by_postal'],
                              leading: "Postal    :"),
                        ],
                      ),
                      SizedBox(
                        height: Dimensions.height110,
                        width: Dimensions.height120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Total Amount",
                              fontWeight: FontWeight.w700,
                              size: Dimensions.fontSize16,
                              color: AppColors.nicePurple,
                            ),
                            Dimensions.height30.heightBox,
                            "Rs.${data['total_amount']}"
                                .text
                                .bold
                                .size(Dimensions.fontSize20)
                                .color(AppColors.orangeRed)
                                .make(),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            20.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: Dimensions.width50 * 2,
                  color: Colors.grey.shade400,
                ),
                BigText(
                  text: "Ordered Products",
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainAppColor,
                  size: Dimensions.fontSize18,
                ),
                Container(
                  height: 1,
                  width: Dimensions.width50 * 2,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
            Dimensions.height15.heightBox,

            //bottom order products container
            Container(
              alignment: Alignment.center,
              height: Dimensions.height100 * 2,
              width: Dimensions.height350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: Dimensions.radius10,
                  )
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.all(Dimensions.height15),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    children: [
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                      orderPlaceDetails(
                          data: data,
                          title1: data['orders'][index]['title'],
                          title2: "Rs .${data['orders'][index]['tPrice']}",
                          d1: "Quantity",
                          d2: "${data['orders'][index]['qty']} kg"),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Dimensions.height50.heightBox
          ],
        ),
      ),
    );
  }
}
