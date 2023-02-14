import 'package:fresh_om/constants/firebase_consts.dart';
import 'package:fresh_om/utils/colors.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var f_quantity = 0.obs;

  var f_totalPrice = 0.obs;
  var v_quantity = 0.obs;

  var v_totalPrice = 0.obs;

  //fruits
  f_IncreaseQty(context, totalQuantity) {
    if (f_quantity.value < totalQuantity) {
      f_quantity.value++;
    } else {
      VxToast.show(
          // pdHorizontal: Vx.dp5,
          // bgColor: AppColors.lightBlue1,
          context,
          msg: "Only that much quantity available");
    }
  }

  f_DecreaseQty(context) {
    if (f_quantity.value > 0) {
      f_quantity.value--;
    } else {
      VxToast.show(context, msg: "You Cant decrease more");
    }
  }

  f_CalculateTotalPrice(price) {
    f_totalPrice.value = price * f_quantity.value;
  }

  //vegetable
  v_IncreaseQty(context, totalQuantity) {
    if (v_quantity.value < totalQuantity) {
      v_quantity.value++;
    } else {
      VxToast.show(
          // pdHorizontal: Vx.dp5,
          // bgColor: AppColors.lightBlue1,
          context,
          msg: "Only that much quantity available");
    }
  }

  v_DecreaseQty(context) {
    if (v_quantity.value > 0) {
      v_quantity.value--;
    } else {
      VxToast.show(context, msg: "You Cant decrease more");
    }
  }

  v_CalculateTotalPrice(price) {
    v_totalPrice.value = price * v_quantity.value;
  }

  addToCart({title, img, sellerName, qty, tPrice, context, sellerID}) async {
    if (qty > 0) {
      await firestore.collection(cartCollection).doc().set({
        'title': title,
        'img': img,
        'sellerName': sellerName,
        'qty': qty,
        'seller_id': sellerID,
        'tPrice': tPrice,
        'added_by': currentUser!.uid
      }).catchError((error) {
        VxToast.show(context, msg: error.toString());
      });
    }
  }
}
