import 'package:flutter/material.dart';
import 'package:fresh_om/pages/authentication/reset_password_page.dart';

import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/firebase_consts.dart';
import '../../controller/auth_controller.dart';
import '../../utils/colors.dart';

import '../../utils/dimensions.dart';
import '../Buyer/home/buyer_home_page.dart';

class MainRegisterPage extends StatefulWidget {
  const MainRegisterPage({Key? key}) : super(key: key);

  @override
  State<MainRegisterPage> createState() => _MainRegisterPageState();
}

class _MainRegisterPageState extends State<MainRegisterPage> {
  final controller = Get.put(AuthController());
  bool isLoading = false;
  bool isSignUpScreen = true;
  bool isRememberMe = true;
  bool isObscure = true;

  //signup textEditing controllers
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height:
            isSignUpScreen ? Dimensions.height167 : Dimensions.height100 * 2,
        child: Column(
          children: [
            Image.asset("images/logoMain2.png"),
            Dimensions.height10.heightBox,
            "Fresh'Om"
                .text
                .bold
                .color(AppColors.nicePurple)
                .size(Dimensions.fontSize25)
                .make(),
          ],
        ),
      ),
      backgroundColor: AppColors.lightBlue1,
      body: Stack(
        alignment: Alignment.center,
        children: [
          //top background color
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height100, left: Dimensions.width20),
                height: Dimensions.height300,
                color: AppColors.nicePurple,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: isSignUpScreen ? "Welcome to" : "Welcome",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize25,
                              color: Colors.yellow[200],
                              letterSpacing: 2),
                          children: [
                            TextSpan(
                                text: isSignUpScreen ? " Fresh'Om," : " Back,",
                                style: TextStyle(
                                  fontSize: Dimensions.fontSize30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow[200],
                                ))
                          ]),
                    ),
                    5.heightBox,
                    isSignUpScreen
                        ? "Signup to Continue"
                            .text
                            .size(Dimensions.fontSize18)
                            .letterSpacing(2)
                            .color(Colors.white54)
                            .semiBold
                            .make()
                        : "Signin to Continue"
                            .text
                            .size(18)
                            .letterSpacing(2)
                            .color(Colors.white54)
                            .semiBold
                            .make()
                  ],
                ),
              )),
          buildBottomHalfContainer(true),
          //center main container
          AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              top: isSignUpScreen
                  ? Dimensions.height100 * 2
                  : Dimensions.height230,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.all(Dimensions.height25),
                height: isSignUpScreen
                    ? Dimensions.height350 + 10
                    : Dimensions.height270,
                width: Dimensions.screenWidth - Dimensions.height40,
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: Dimensions.radius15,
                          spreadRadius: 5)
                    ]),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignUpScreen = false;
                              });
                            },
                            child: Column(
                              children: [
                                "LOGIN"
                                    .text
                                    .size(Dimensions.fontSize20)
                                    .extraBold
                                    .color(isSignUpScreen
                                        ? AppColors.inactiveTextColor
                                        : AppColors.nicePurple)
                                    .make(),
                                if (!isSignUpScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: Dimensions.height55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignUpScreen = true;
                              });
                            },
                            child: Column(
                              children: [
                                "SIGNUP"
                                    .text
                                    .size(Dimensions.fontSize20)
                                    .extraBold
                                    .color(isSignUpScreen
                                        ? AppColors.nicePurple
                                        : AppColors.inactiveTextColor)
                                    .make(),
                                if (isSignUpScreen)
                                  Container(
                                    margin: const EdgeInsets.only(top: 3),
                                    height: 2,
                                    width: Dimensions.height55,
                                    color: Colors.orange,
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (isSignUpScreen) buildSignupContainer(),
                      if (!isSignUpScreen) buildLoginContainer()
                    ],
                  ),
                ),
              )),

          //bottom proceed button

          buildBottomHalfContainer(false)
        ],
      ),
    );
  }

  Container buildLoginContainer() {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height20),
      child: Column(
        children: [
          buildTextField(Icons.email_outlined, "Email", false, true,
              controller.buyerEmailController),
          buildTextField(Icons.lock, "Password", true, false,
              controller.buyerPasswordController),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Get.to(() => const ResetPassword());
                },
                child: "Forgot Password?"
                    .text
                    .semiBold
                    .size(Dimensions.fontSize16)
                    .color(AppColors.nicePurple)
                    .make()),
          )
        ],
      ),
    );
  }

  Container buildSignupContainer() {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.height20),
      child: Column(
        children: [
          buildTextField(
              Icons.person, "User name", false, false, nameController),
          buildTextField(
              Icons.email_outlined, "Email", false, true, emailController),
          TextFormField(
            controller: passwordController,
            obscureText: isObscure ? true : false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: AppColors.inactiveTextColor,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(Dimensions.radius35)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(Dimensions.radius35)),
                hintText: "Password",
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: isObscure
                      ? AppColors.inactiveTextColor
                      : AppColors.niceBlue,
                ).onTap(() {
                  setState(() {
                    if (isObscure == false) {
                      isObscure = true;
                    } else {
                      isObscure = false;
                    }
                  });
                }),
                hintStyle: TextStyle(
                    fontSize: Dimensions.fontSize15,
                    color: AppColors.inactiveTextColor)),
          ),
          8.heightBox,
          buildTextField(Icons.password, "Confirm Password", true, false,
              confirmPasswordController),
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        top: isSignUpScreen
            ? Dimensions.height495
            : Dimensions.height450 - Dimensions.height10,
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.height90,
          width: Dimensions.height90,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: Dimensions.radius10,
                      spreadRadius: 1.5,
                      offset: const Offset(0, 1))
              ]),
          child: Container(
            height: Dimensions.height60,
            width: Dimensions.height60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent,
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffFAA214),
                      Color(0xffEF5350),
                    ]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1))
                ]),
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    Icons.arrow_forward_rounded,
                    size: Dimensions.icon30,
                    color: Colors.white,
                  ),
          ),
        ).onTap(() async {
          if (isSignUpScreen) {
            if (emailController.text.isNotEmpty &&
                nameController.text.isNotEmpty &&
                passwordController.text.isNotEmpty &&
                confirmPasswordController.text == passwordController.text) {
              setState(() {
                isLoading = true;
              });
              try {
                await controller
                    .buyerSignUpMethod(
                        email: emailController.text,
                        password: passwordController.text)
                    .then((value) {
                  return controller.storeBuyerData(
                    email: emailController.text,
                    buyerName: nameController.text,
                    password: passwordController.text,
                  );
                }).then((value) {
                  Get.offAll(() => const BuyerHomePage());
                });
                setState(() {
                  isLoading = false;
                });
              } catch (e) {
                setState(() {
                  isLoading = false;
                });
                auth.signOut();
                Get.snackbar("Error", "Logged out --$e");
              }
            } else {
              VxToast.show(context, msg: "Enter correct details");
            }
          } else {
            setState(() {
              isLoading = true;
            });
            await controller.buyerSignInMethod().then((value) async {
              setState(() {
                isLoading = true;
              });
              if (value != null) {
                Get.snackbar("Logged", "Logged In Successfully");
                setState(() {
                  isLoading = false;
                });
                await Get.offAll(() => const BuyerHomePage());
              }
            });
            VxToast.show(context, msg: "Enter required fields");
          }
          setState(() {
            isLoading = false;
          });
        }));
  }

  Padding buildTextField(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.width8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            prefixIcon: Icon(
              icon,
              color: AppColors.inactiveTextColor,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(Dimensions.radius35)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(Dimensions.radius35)),
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: Dimensions.fontSize15,
                color: AppColors.inactiveTextColor)),
      ),
    );
  }
}
