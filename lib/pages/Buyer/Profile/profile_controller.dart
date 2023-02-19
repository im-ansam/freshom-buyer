import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class BuyerProfileController extends GetxController {
  var profileImgPath = "".obs;
  var profileImgLink = "";
  //text-field
  var nameController = TextEditingController();
  var newPassController = TextEditingController();
  var oldPassController = TextEditingController();

  changeImg(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImg() async {
    var fileName = basename(profileImgPath.value);
    var destination =
        'buyerImages/${FirebaseAuth.instance.currentUser?.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));

    profileImgLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imageUrl}) async {
    var store = firestore
        .collection(buyerCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imageUrl},
        SetOptions(merge: true));

    // isLoading.value = false;
  }

  //update Authentication password
  changeAuthPassword({email, password, newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(cred)
        .then((value) {
      FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      print(error.toString());
    });
  }

  // // get buyer profile data from database
  // late Map<String, dynamic> profileData;
  // profileDetails() async {
  //   var collection = firestore.collection(buyerCollection);
  //   var querySnapshot = await collection.get();
  //   for (var queryDocumentSnapshot in querySnapshot.docs) {
  //     Map<String, dynamic> data = queryDocumentSnapshot.data();
  //     if (data['email'] == auth.currentUser!.email) {
  //       profileData = data;
  //     }
  //   }
  // }
}
