import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../pages/Buyer/home/buyer_home_page.dart';

class AuthController extends GetxController {
  var loading = false.obs;
  var buyerEmailController = TextEditingController();

  var buyerPasswordController = TextEditingController();

  //buyer==============================================================

  //login
  Future<UserCredential?> buyerSignInMethod() async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: buyerEmailController.text,
          password: buyerPasswordController.text);
      loading.value = false;
      buyerEmailController.clear();
      buyerPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return userCredential;
  }

  //signup method

  Future<UserCredential?> buyerSignUpMethod({email, password}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await verifyEmail();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return userCredential;
  }

  //reset password

  resetPassword({emailController, context}) async {
    await auth.sendPasswordResetEmail(email: emailController);
  }

  //storing user data
  storeBuyerData({
    buyerName,
    password,
    email,
  }) async {
    DocumentReference store = firestore
        .collection(buyerCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid);
    store.set({
      'name': buyerName,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': FirebaseAuth.instance.currentUser!.uid,
    });
  }

//SignOut method
  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  verifyEmail() async {
    await auth.currentUser!.sendEmailVerification();
    Get.snackbar('email', 'send');
  }

  checkUserInCollection() async {
    int checkUser = 0;
    var collection = firestore.collection(buyerCollection);
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      if (data['email'] == auth.currentUser!.email) {
        checkUser = 1;
      }
    }

    if (checkUser == 0) {
      auth.signOut();
      Get.snackbar('Error', "your are not a user");
      buyerEmailController.clear();
      buyerPasswordController.clear();
      return;
    } else {
      Get.snackbar("Logged", "Logged In Successfully");
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool('isLogged', true);
      await Get.offAll(() => const BuyerHomePage());
    }
  }
}
