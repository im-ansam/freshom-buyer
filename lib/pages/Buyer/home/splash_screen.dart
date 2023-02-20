import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/controller/auth_controller.dart';
import 'package:fresh_om/pages/Buyer/home/buyer_home_page.dart';
import 'package:fresh_om/pages/authentication/main_registration_page.dart';
import 'package:fresh_om/utils/Reusables_functions.dart';
import 'package:fresh_om/utils/colors.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';
import 'package:fresh_om/widgets/reusable_small_text.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/firebase_consts.dart';
import '../../../utils/dimensions.dart';

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

  autoDeleteFruit() async {
    var collection = FirebaseFirestore.instance.collection(fruitsCollection);
    var snapshot = await collection
        .where("currentTimeStamp",
            isLessThan: DateTime.now().subtract(const Duration(days: 3)))
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  autoDeleteVeg() async {
    var collection = FirebaseFirestore.instance.collection(vegetableCollection);
    var snapshot = await collection
        .where("currentTimeStamp",
            isLessThan: DateTime.now().subtract(const Duration(days: 3)))
        .get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  void initState() {
    super.initState();
    autoDeleteFruit();
    autoDeleteVeg();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.height300,
            ),
            // Container(
            //   height: Dimensions.height120,
            //   width: Dimensions.width50 * 2,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(Dimensions.radius30),
            //           topRight: Radius.circular(Dimensions.radius30)),
            //       color: Colors.white70,
            //       image: DecorationImage(
            //           image: AssetImage('images/logoMain1.png'))),
            // ),

            Image.asset(
              'images/logoMain1.png',
              height: 140,
            ),
            SizedBox(
              height: Dimensions.height10,
            ),

            appNameText(
                text: 'Fresh\'Om',
                color: AppColors.mainAppColor,
                size: 30.0,
                fontWeight: FontWeight.w500),
            // BoldText(
            //   fontWeight: FontWeight.bold,
            //   text: "Fresh'Om",
            //   color: AppColors.mainAppColor,
            //   size: Dimensions.fontSize30,
            // ),
            SizedBox(
              height: Dimensions.height10,
            ),
            SmallText(
              text: "version 1.0.0",
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
