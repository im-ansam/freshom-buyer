import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var userName = '';
  var vegSearchController = TextEditingController();
  var fruitSearchController = TextEditingController();
  getUserName() async {
    var n = await firestore
        .collection(buyerCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    userName = n;
  }
}
