import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var products = [];
  var sellers = [];

  var placingOrder = false.obs;
  calculate(data) {
    totalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value =
          totalPrice.value + int.parse(data[i]['tPrice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value == index;
  }

  placeMyOrder(
      {required orderPaymentMethod, required totalAmount, context}) async {
    placingOrder(true);
    await getProductDetails();
    try {
      await firestore.collection(ordersCollection).doc().set({
        'order_code': "233911400",
        'order_date': FieldValue.serverTimestamp(),
        'order_by': FirebaseAuth.instance.currentUser!.uid,
        'order_by_name': Get.find<HomeController>().userName,
        'order_by_email': FirebaseAuth.instance.currentUser!.email,
        'order_by_address': addressController.text,
        'order_by_city': cityController.text,
        'order_by_postal': postalCodeController.text,
        'order_by_phone': phoneController.text,
        'delivery_method': "Home Delivery",
        'payment_method': orderPaymentMethod,
        'order_placed': true,
        'order_confirmed': false,
        'order_delivered': false,
        'order_on_delivery': false,
        'total_amount': totalAmount,
        'orders': FieldValue.arrayUnion(products),
        'sellers': FieldValue.arrayUnion(sellers)
      });
      placingOrder(false);
      VxToast.show(context, msg: 'Order Placed Successfully');
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      placingOrder(false);
    }
  }

  //get all details of product in cart

  getProductDetails() {
    products.clear();
    sellers.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'img': productSnapshot[i]['img'],
        'seller_id': productSnapshot[i]['seller_id'],
        'tPrice': productSnapshot[i]['tPrice'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title']
      });
      sellers.add(productSnapshot[i]['seller_id']);
    }
  }

  //this function clears products in cart after order is placed

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      //productSnapshot has list of all products of current user in cart
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
