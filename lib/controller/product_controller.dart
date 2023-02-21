import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om/constants/firebase_consts.dart';
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

  addToCart(
      {title, img, sellerName, qty, tPrice, context, sellerID, pId}) async {
    if (qty > 0) {
      await firestore.collection(cartCollection).doc().set({
        'title': title,
        'img': img,
        'sellerName': sellerName,
        'qty': qty,
        'seller_id': sellerID,
        'tPrice': tPrice,
        'added_by': FirebaseAuth.instance.currentUser!.uid,
        'p_id': pId
      }).catchError((error) {
        VxToast.show(context, msg: error.toString());
      });
    }
  }

  resetValues() {
    f_quantity.value = 0;

    f_totalPrice.value = 0;
    v_quantity.value = 0;

    v_totalPrice.value = 0;
  }

  var cartCount = 0.obs;
  getCartCount() async {
    cartCount.value = 0;
    var data = await firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    cartCount.value = data.docs.length;
  }

  //decrease quantity on fireStore while adding to cart

  setNewVegQty({newQty, docId}) async {
    var collection = firestore.collection(vegetableCollection);
    var querySnapshots = await collection.where('v_id', isEqualTo: docId).get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({
        'v_qty': newQty,
      });
    }
  }
  //decrease quantity on fireStore while adding to cart

  setNewFruitQty({newQty, docId}) async {
    var collection = firestore.collection(fruitsCollection);
    var querySnapshots = await collection.where('f_id', isEqualTo: docId).get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({
        'f_qty': newQty,
      });
    }
  }

  //reset the quantity of vegetable while removing from cart

  resetFruitQty({newQty, docId}) async {
    var collection = firestore.collection(fruitsCollection);
    var querySnapshots = await collection.where('f_id', isEqualTo: docId).get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({'f_qty': doc['f_qty'] + newQty});
    }
  }

//reset the quantity of vegetable while removing from cart
  resetVegQty({newQty, docId}) async {
    var collection = firestore.collection(vegetableCollection);
    var querySnapshots = await collection.where('v_id', isEqualTo: docId).get();
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({'v_qty': doc['v_qty'] + newQty});
    }
  }
}
