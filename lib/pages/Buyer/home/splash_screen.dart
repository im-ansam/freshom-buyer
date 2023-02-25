import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/controller/auth_controller.dart';
import 'package:fresh_om/pages/Buyer/home/buyer_home_page.dart';
import 'package:fresh_om/pages/authentication/main_registration_page.dart';
import 'package:fresh_om/utils/Reusables_functions.dart';
import 'package:fresh_om/utils/colors.dart';
import 'package:fresh_om/widgets/reusable_small_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/firebase_consts.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_big_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController controller = Get.put(AuthController());
  changeScreen() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool('isLogged');
    if (isLoggedIn != null) {
      if (isLoggedIn) {
        Future.delayed(const Duration(seconds: 4),
            () => Get.offAll(() => const BuyerHomePage()));
      } else {
        Future.delayed(const Duration(seconds: 4),
            () => Get.offAll(() => const MainRegisterPage()));
      }
    } else {
      Future.delayed(const Duration(seconds: 4),
          () => Get.offAll(() => const MainRegisterPage()));
    }
  }

  //deletes fruits after 3 days from uploaded date
  autoDeleteFruit() async {
    var collection = FirebaseFirestore.instance.collection(fruitsCollection);
    var snapshot = await collection
        .where("currentTimeStamp",
            isLessThan: DateTime.now().subtract(const Duration(days: 3)))
        .get();
    for (var doc in snapshot.docs) {
      await setDeletedFruits(doc);
      await doc.reference.delete();
    }
  }

//deletes vegetables after 3 days from uploaded date
  autoDeleteVeg() async {
    var collection = FirebaseFirestore.instance.collection(vegetableCollection);
    var snapshot = await collection
        .where("currentTimeStamp",
            isLessThan: DateTime.now().subtract(const Duration(days: 3)))
        .get();
    for (var doc in snapshot.docs) {
      await setDeletedVeg(doc);
      await doc.reference.delete();
    }
  }

  //get all field of fruits table
  setDeletedFruits(QueryDocumentSnapshot document) async {
    await firestore.collection('Deleted Fruits').doc().set({
      'f_image': document['f_image'],
      'seller_id': document['seller_id'],
      'seller_name': document['seller_name'],
      'f_name': document['f_name'],
      'f_id': document['f_id'],
      'f_uploaded_date': document['f_uploaded_date'],
    });
  }

  setDeletedVeg(QueryDocumentSnapshot document) async {
    await firestore.collection('Deleted Veg').doc().set({
      'v_image': document['v_image'],
      'seller_id': document['seller_id'],
      'seller_name': document['seller_name'],
      'v_name': document['v_name'],
      'v_uploaded_date': document['v_uploaded_date'],
    });
  }

  //deletes fruits if count is zero
  // autoDeleteZeroCountFruit() async {
  //   var collection = FirebaseFirestore.instance.collection(fruitsCollection);
  //   var snapshot = await collection.where("f_qty", isEqualTo: 0).get();
  //   for (var doc in snapshot.docs) {
  //     await doc.reference.delete();
  //   }
  // }

//deletes vegetables if count is zero
//   autoDeleteZeroCountVeg() async {
//     var collection = FirebaseFirestore.instance.collection(vegetableCollection);
//     var snapshot = await collection.where("v_qty", isEqualTo: 0).get();
//     for (var doc in snapshot.docs) {
//       await doc.reference.delete();
//     }
//   }

  @override
  void initState() {
    super.initState();
    autoDeleteFruit();
    autoDeleteVeg();
    changeScreen();
    // autoDeleteZeroCountFruit();
    // autoDeleteZeroCountVeg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Dimensions.height50.heightBox,
            Image.asset(
              'images/freshLogo.png',
              height: 130,
            ),
            Dimensions.height20.heightBox,
            appNameText(
                color: AppColors.nicePurple,
                size: Dimensions.fontSize25,
                fontWeight1: FontWeight.w500,
                fontWeight2: FontWeight.w700),
            Dimensions.height10.heightBox,
            // BoldText(
            //   fontWeight: FontWeight.bold,
            //   text: "Fresh'Om",
            //   color: AppColors.mainAppColor,
            //   size: Dimensions.fontSize30,
            // ),

            SmallText(
              text: "version 1.0.0",
              color: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
