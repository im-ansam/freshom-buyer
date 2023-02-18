import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/pages/Buyer/home/buyer_home_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FireStoreServices {
  //get products from firebase

  static getVegProduct() {
    firestore.collection(vegetableCollection).snapshots();
  }

  static getCart(uid) {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  static deleteDocument(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  //get users data
  static getUser(uid) {
    return firestore
        .collection('buyerCollection')
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //getting data of user for checking whether they are buyer or seller

//get all messeges
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //get all orders
  static getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  //get all messages
  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static getCount() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('added_by', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(ordersCollection)
          .where('order_by', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  //method to get products while searching
  static searchVegetables() {
    return firestore.collection(vegetableCollection).get();
  }

  static searchFruits() {
    return firestore.collection(fruitsCollection).get();
  }

//test
  static getUploadedDate() {
    var data = firestore.collection(fruitsCollection).snapshots();
  }
}
