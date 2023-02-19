import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

//collections
const buyerCollection = "buyerCollection";
const vegetableCollection = "Vegetables";
const fruitsCollection = "Fruits";

const cartCollection = "Cart";
const chatsCollection = "Chats";
const messagesCollection = "messages";
const ordersCollection = "orders";

//payment method images

const imgCod = "images/cod.png";

//payment method strings
const cod = "Cash On Delivery";
