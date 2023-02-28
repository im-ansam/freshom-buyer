import 'package:flutter/material.dart';
import 'package:fresh_om/pages/authentication/reset_password_page.dart';
import 'package:fresh_om/widgets/reusable_big_text.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/firebase_consts.dart';
import '../../controller/auth_controller.dart';
import '../../utils/Reusables_functions.dart';
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
            Image.asset("images/freshLogo.png", height: Dimensions.height70),
            Dimensions.height10.heightBox,
            appNameText(
              letterSpacing1: 0.0,
              letterSpacing2: 0.0,
              fontWeight1: FontWeight.w500,
              fontWeight2: FontWeight.w700,
              size: Dimensions.fontSize23,
              color: AppColors.nicePurple,
            ),
            BigText(
              letterSpacing: 0.0,
              text: "version 1.0.0",
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
              size: Dimensions.fontSize14,
            ),
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
                color: AppColors.mainAppColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: isSignUpScreen ? "Welcome to" : "Welcome",
                          style: GoogleFonts.poppins(
                              fontSize: Dimensions.fontSize25,
                              color: Colors.white,
                              letterSpacing: 1),
                          children: [
                            TextSpan(
                              text: isSignUpScreen ? " Fresh'Om," : " Back,",
                              style: GoogleFonts.poppins(
                                  fontSize: Dimensions.fontSize27,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                    5.heightBox,
                    isSignUpScreen
                        ? BigText(
                            text: "Signup to Continue",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: Colors.white54,
                            size: Dimensions.fontSize18,
                          )
                        : BigText(
                            text: "SignIn to Continue",
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                            color: Colors.white54,
                            size: Dimensions.fontSize18,
                          )
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
                    ? Dimensions.height350 + Dimensions.height10
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
                          spreadRadius: Dimensions.width5)
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
                                BigText(
                                  text: "LOGIN",
                                  fontWeight: FontWeight.bold,
                                  color: isSignUpScreen
                                      ? AppColors.inactiveTextColor
                                      : AppColors.nicePurple,
                                  size: Dimensions.fontSize20,
                                ),
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
                                BigText(
                                  text: "SIGNUP",
                                  fontWeight: FontWeight.bold,
                                  color: isSignUpScreen
                                      ? AppColors.nicePurple
                                      : AppColors.inactiveTextColor,
                                  size: Dimensions.fontSize20,
                                ),
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
              child: BigText(
                text: "Forgot Password?",
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
                size: Dimensions.fontSize15,
              ),
            ),
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: Dimensions.width5),
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
          height: Dimensions.height80,
          width: Dimensions.height80,
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
            height: Dimensions.height50,
            width: Dimensions.height50,
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
                }).then((value) async {
                  //setting value to shared preference

                  var sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool('isLogged', true);

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
                setState(() {
                  isLoading = false;
                });
                await controller.checkUserInCollection();
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
            contentPadding: EdgeInsets.symmetric(vertical: Dimensions.width5),
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
