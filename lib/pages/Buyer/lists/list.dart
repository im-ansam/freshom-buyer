import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/firebase_consts.dart';
import '../../../utils/colors.dart';

const popularFruitsList = [
  "images/fruit1.jpeg",
  "images/fruit2.jpeg",
  "images/fruit3.jpeg",
  "images/fruit3.jpeg",
];

const popularVegList = [
  "images/veg1.jpeg",
  "images/veg2.jpeg",
  "images/veg3.jpeg",
];

const profileButtonsText = ["My Orders", "Email", "Address"];
const profileButtonsIcons = [
  Icon(
    Icons.list,
    color: AppColors.nicePurple,
  ),
  Icon(
    Icons.email_rounded,
    color: AppColors.nicePurple,
  ),
  Icon(
    Icons.maps_home_work_outlined,
    color: AppColors.nicePurple,
  )
];
//payment imaged list
const paymentMethodImg = [imgStripe, imgGpay, imgCod];

//payment methods

const paymentMethods = [stripe, gPay, cod];
