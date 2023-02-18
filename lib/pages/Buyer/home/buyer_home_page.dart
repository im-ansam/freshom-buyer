import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fresh_om/pages/Buyer/home/search_screens/fruit_search_screen.dart';
import 'package:fresh_om/pages/Buyer/home/search_screens/veg_search_screen.dart';
import 'package:fresh_om/pages/Buyer/home/veg_category.dart';
import 'package:fresh_om/pages/Buyer/messages/messages_list.dart';
import 'package:fresh_om/pages/Buyer/orders_screen/orders_screen.dart';
import 'package:fresh_om/pages/authentication/main_registration_page.dart';
import 'package:fresh_om/utils/colors.dart';
import 'package:fresh_om/utils/reusable_text_button.dart';
import 'package:fresh_om/widgets/exit_dialog.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/firebase_consts.dart';
import '../../../controller/home_controller.dart';
import '../../../drawer/drawer_details.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/reusable_big_text.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../Profile/profile_page.dart';
import '../Services/firestore_services.dart';
import '../cart_page/cart_page.dart';
import 'fruit_category.dart';
import 'home_category.dart';

bool categoryIsClicked1 = true;
bool categoryIsClicked2 = false;
bool categoryIsClicked3 = false;

class BuyerHomePage extends StatefulWidget {
  const BuyerHomePage({Key? key}) : super(key: key);

  @override
  State<BuyerHomePage> createState() => _BuyerHomePageState();
}

class _BuyerHomePageState extends State<BuyerHomePage> {
  var homeController = Get.put(HomeController());

  int selectedIndex = 0;

  final screens = [
    const BuyerHomeBody(),
    const CartPage(),
    const UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Dimensions.height10),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: Dimensions.radius15)
                ],
                color: AppColors.buttonBackGroundColor,
                borderRadius: BorderRadius.circular(Dimensions.radius50)
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(Dimensions.radius25),
                //   topRight: Radius.circular(Dimensions.radius25),
                // ),
                ),
            padding: const EdgeInsets.all(4),
            child: GNav(
              onTabChange: (index) => setState(() => selectedIndex = index),
              selectedIndex: selectedIndex,
              tabBorderRadius: Dimensions.radius20,
              tabMargin: EdgeInsets.all(Dimensions.height5),
              padding: EdgeInsets.all(Dimensions.height10),
              activeColor: Colors.white,
              tabBackgroundColor: AppColors.nicePurple,
              tabShadow: [
                BoxShadow(
                    color: AppColors.buttonBackGroundColor,
                    blurRadius: Dimensions.radius10,
                    spreadRadius: 1)
              ],
              gap: Dimensions.height5,
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.shopping_cart_outlined,
                  text: "Cart",
                ),
                GButton(
                  icon: Icons.person_outline,
                  text: "Account",
                )
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.mainBackGround,
        extendBody: true,
        body: screens[selectedIndex],
      ),
    );
  }
}

class BuyerHomeBody extends StatefulWidget {
  const BuyerHomeBody({Key? key}) : super(key: key);

  @override
  State<BuyerHomeBody> createState() => _BuyerHomeBodyState();
}

class _BuyerHomeBodyState extends State<BuyerHomeBody> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.mainBackGround,
      drawer: Container(
        width: Dimensions.screenWidth / 1.4,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20),
              bottomRight: Radius.circular(Dimensions.radius20),
            ),
            color: Colors.white),
        child: Column(
          children: [
            //top small detail container
            StreamBuilder(
                stream: FireStoreServices.getUser(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.nicePurple,
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];
                    return Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height80, left: Dimensions.width30),
                      width: double.infinity,
                      height: Dimensions.height300,
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue1,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.fontSize20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            height: Dimensions.height100,
                            width: Dimensions.height100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius50),
                            ),
                            child: data['imageUrl'] == ''
                                ? Image.asset(
                                    "images/cameraLogo2.png",
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    data['imageUrl'],
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          Text(
                            "${data['name']}",
                            // controller.profileData['name'],
                            style: TextStyle(
                                fontSize: Dimensions.fontSize23,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Text(
                            "${data['email']}",
                            // controller.profileData['email'],
                            style: TextStyle(
                                fontSize: Dimensions.fontSize16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  }
                }),
            //bottom detail container
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height40,
                  left: Dimensions.width30,
                  right: Dimensions.width30),
              child: Column(
                children: [
                  const DrawerRow(
                    icon: Icons.list_alt_outlined,
                    text: 'My Orders',
                  ).onTap(() {
                    Get.to(() => const MyOrders());
                  }),
                  SizedBox(
                    height: Dimensions.height40,
                  ),
                  const DrawerRow(
                    icon: Icons.message_rounded,
                    text: 'Messages',
                  ).onTap(() {
                    Get.to(() => const AllMessageList());
                  }),
                  SizedBox(
                    height: Dimensions.height40,
                  ),
                  GestureDetector(
                      onTap: () async {
                        await auth.signOut();
                        Get.offAll(() => const MainRegisterPage());
                      },
                      child: const DrawerRow(
                        icon: Icons.logout,
                        text: 'Logout',
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: Dimensions.height70,
        elevation: 0,
        backgroundColor: AppColors.mainBackGround,
        leading: Builder(builder: (context) {
          return IconButton(
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              onPressed: () {
                // await controller.profileDetails();
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.sort,
                size: Dimensions.icon28,
                color: Colors.black,
              ));
        }),
        actions: [
          Container(
              alignment: Alignment.center,
              width: Dimensions.width330,
              height: Dimensions.height20,
              margin: EdgeInsets.only(
                  top: Dimensions.height10,
                  right: Dimensions.height10,
                  bottom: Dimensions.height10),
              padding: EdgeInsets.only(
                  left: Dimensions.height10, right: Dimensions.height10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  color: categoryIsClicked1 == true
                      ? Colors.transparent
                      : categoryIsClicked2 == true
                          ? Colors.white
                          : Colors.white),
              child: categoryIsClicked2 == true
                  ? TextFormField(
                      style: TextStyle(
                          fontFamily: "Michroma",
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimensions.fontSize16),
                      controller: controller.vegSearchController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        suffixIcon: const Icon(
                          Icons.search_rounded,
                          color: Colors.black,
                        ).onTap(() {
                          if (controller
                              .vegSearchController.text.isNotEmptyAndNotNull) {
                            Get.to(() => VegSearchScreen(
                                  title: controller.vegSearchController.text,
                                ));
                          }
                        }),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search Veg Here..",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.fontSize16,
                        ),
                      ),
                    )
                  : categoryIsClicked1 == true
                      ? const SizedBox()
                      : TextFormField(
                          style: TextStyle(
                              fontFamily: "Michroma",
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          controller: controller.fruitSearchController,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            suffixIcon: const Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                            ).onTap(() {
                              if (controller.fruitSearchController.text
                                  .isNotEmptyAndNotNull) {
                                Get.to(() => FruitSearchScreen(
                                      title:
                                          controller.fruitSearchController.text,
                                    ));
                              }
                            }),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search Fruits Here..",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.fontSize16,
                            ),
                          ),
                        ))
        ],
      ),
      body: Column(
        children: [
          //main heading text
          Row(
            children: [
              SizedBox(
                width: Dimensions.width20,
              ),
              Text(
                "Shop",
                style: TextStyle(fontSize: Dimensions.fontSize23),
              ),
              const BigText(
                  text: " Fruits And Vegetables", fontWeight: FontWeight.w600)
            ],
          ),
          SizedBox(
            height: Dimensions.height20,
          ),

          //Top three category buttons
          Container(
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableButtonContainer(
                  text: "Home Items",
                  onPress: () {
                    setState(() {
                      categoryIsClicked1 = true;
                      categoryIsClicked2 = false;
                      categoryIsClicked3 = false;
                    });
                  },
                  color: categoryIsClicked1 == true
                      ? AppColors.nicePurple
                      : AppColors.inactiveTextColor,
                  isSelected: categoryIsClicked1 ? true : false,
                ),
                ReusableButtonContainer(
                  text: "Vegetables",
                  onPress: () {
                    setState(() {
                      categoryIsClicked1 = false;
                      categoryIsClicked2 = true;
                      categoryIsClicked3 = false;
                    });
                  },
                  color: categoryIsClicked2 == true
                      ? AppColors.nicePurple
                      : AppColors.inactiveTextColor,
                  isSelected: categoryIsClicked2 ? true : false,
                ),
                ReusableButtonContainer(
                  text: "Fruits",
                  onPress: () {
                    setState(() {
                      categoryIsClicked1 = false;
                      categoryIsClicked2 = false;
                      categoryIsClicked3 = true;
                    });
                  },
                  color: categoryIsClicked3 == true
                      ? AppColors.nicePurple
                      : AppColors.inactiveTextColor,
                  isSelected: categoryIsClicked3 ? true : false,
                )
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.height5),
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.height20, right: Dimensions.height20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      // spreadRadius: 1,
                      blurRadius: 5,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius30),
                    topRight: Radius.circular(Dimensions.radius30),
                  ),
                ),
                child: categoryIsClicked1
                    ? const HomeCategory()
                    : categoryIsClicked2
                        ? const VegCategory()
                        : const FruitCategory(),
              ),
            ),
          )
          // parent container
        ],
      ),
    );
  }
}
