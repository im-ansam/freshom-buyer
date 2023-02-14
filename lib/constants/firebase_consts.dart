import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
// User? currentUser = auth.currentUser;

//collections

const buyerCollection = "buyerCollection";
const vegetableCollection = "Vegetables";
const fruitsCollection = "Fruits";

const cartCollection = "Cart";
const chatsCollection = "Chats";
const messagesCollection = "messages";
const ordersCollection = "orders";

//payment method images
const imgStripe = "images/stripePayment.png";
const imgGpay = "images/googlePay.jpg";
const imgCod = "images/cod.png";

//payment method strings
const stripe = "Stripe", gPay = "Google Pay", cod = "Cash On Delivery";
