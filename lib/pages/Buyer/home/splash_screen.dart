import 'package:flutter/material.dart';
import 'package:fresh_om/controller/auth_controller.dart';
import 'package:fresh_om/pages/authentication/main_registration_page.dart';
import 'package:fresh_om/utils/colors.dart';
import 'package:fresh_om/widgets/reusable_bold_text.dart';
import 'package:fresh_om/widgets/reusable_small_text.dart';
import 'package:get/get.dart';

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
    Future.delayed(
        const Duration(seconds: 3), () => Get.off(() => MainRegisterPage()));
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.niceBlue,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.height300,
            ),
            Container(
              height: Dimensions.height120,
              width: Dimensions.width50 * 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.radius30),
                      topRight: Radius.circular(Dimensions.radius30)),
                  color: Colors.white70,
                  image: DecorationImage(
                      image: AssetImage('images/logoMain1.png'))),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            BoldText(
              fontWeight: FontWeight.bold,
              text: "Fresh'Om",
              color: Colors.white,
              size: Dimensions.fontSize30,
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            SmallText(
              text: "version 1.0.0",
              color: Colors.white70,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.height10),
              child: Text(
                "@ansamcd",
                style: TextStyle(
                    color: Colors.white, fontSize: Dimensions.fontSize15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
