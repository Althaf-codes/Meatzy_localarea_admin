// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

import '../Constants/Utils.dart';
import '../Model/meat_seller_model.dart';
import '../Model/user_model_meatzy.dart';

//qKpe3Pt735fz0dzr4Jcw3Y7D0Pr2

class MeatSellerService extends ChangeNotifier {
  User user;
  MeatSellerService({
    required this.user,
  });
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addNewProduct(BuildContext context,
      {required Map<String, dynamic> data, required String orderId}) async {
    try {
      CollectionReference orderCollection = _firestore
          .collection("MeatSeller")
          .doc(user.uid)
          .collection("products");
      print("the uid is ${orderId}");
      orderCollection
          .doc(orderId.toString())
          .set(data, SetOptions(merge: true))
          .then((value) => print("updated sucessfully"));
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future addMeatSellerDetails(BuildContext context,
      {required Map<String, dynamic> data,
      required String productId,
      required Product productdata}) async {
    CollectionReference _collection = _firestore.collection('MeatSeller');
    CollectionReference _productcollection = _firestore
        .collection('MeatSeller')
        .doc(user.uid)
        .collection("products");

    var batch = _firestore.batch();

    batch.set(_collection.doc(user.uid), data);
    batch.set(_productcollection.doc(productId), productdata.toMap());

    await batch
        .commit()
        .then((value) => showSnackBar(context, 'Details Added Succesfully'));
  }

  Future updateorderstatus(BuildContext context,
      {required String productID}) async {
    CollectionReference collection = _firestore.collection("MeatSeller");
    // return collection.doc(user.uid).update({
    //   "product": FieldValue.arrayUnion([""])
    // });
  }

//   Future acceptOrder(String orderId) async {
//     CollectionReference collection = _firestore.collection("MeatSeller");
//     final res = collection
//         .doc(user.uid)
//         .update({'orders'[0]: FieldValue.arrayUnion([])});
// //.where((event) => event['order']['orderId'] == orderId).where((event) => )
//   }

  Stream<MeatSellerModel> getMeatSellerDetails(BuildContext context) {
    CollectionReference collection = _firestore.collection("MeatSeller");

    return collection.doc(user.uid.trim()).snapshots().map((snapshot) {
      print("the snapshot in stream is ${snapshot['orders']}");
      return MeatSellerModel.fromMap(snapshot);
    });
  }

  Stream<List<Product>> getAllProduct() {
    CollectionReference sellerOrderCollection = _firestore
        .collection("MeatSeller")
        .doc(user.uid)
        .collection("products");

    return sellerOrderCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((documentSnapshot) =>
                Product.fromDocumentsnapshot(documentSnapshot))
            .toList());
  }

  Stream<List<SellerOrder>> getAllOrders() {
    CollectionReference sellerOrderCollection =
        _firestore.collection("MeatSeller").doc(user.uid).collection("orders");

    return sellerOrderCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((documentSnapshot) =>
                SellerOrder.fromdocumentsnap(documentSnapshot))
            .toList());
  }

  Future gettest(BuildContext context) async {
    CollectionReference collection = _firestore.collection("MeatSeller");
    return collection.where("mymap",
        arrayContains: {"productId"}, isEqualTo: 3);
  }

  // Future addTestSubcollection(Map<String, dynamic> data, String orderId) async {
  //   CollectionReference orderCollection =
  //       _firestore.collection("MeatSeller").doc(user.uid).collection("orders");

  //   orderCollection
  //       .doc(orderId)
  //       .set(data, SetOptions(merge: true))
  //       .then((value) => print("updated sucessfully"));
  // }

  // Future<String> getOrderDetails(
  //     {required String buyerId, required String orderId}) {
  //   CollectionReference sellerOrderCollection =
  //       _firestore.collection("MeatSeller").doc(user.uid).collection("orders");
  //   print("the orderId is ${orderId}");
  //   return sellerOrderCollection
  //       .doc(orderId.trim())
  //       .snapshots()
  //       .map((snapshot) {
  //     print("the getorderDetails snapshot is ${snapshot['productName']} ");
  //     // return SellerOrder.fromdocumentsnap(snapshot);
  //     return snapshot['productName'].toString();
  //   }).first;
  // }

  Future acceptUserOrder(
      {required String orderId,
      required String buyerId,
      required UserNotification userNotification,
      required String deliveryDate}) async {
    CollectionReference sellerOrderCollection =
        _firestore.collection("MeatSeller").doc(user.uid).collection("orders");
    CollectionReference userOrderCollection =
        _firestore.collection("Users").doc(buyerId).collection("orders");
    CollectionReference userCollection = _firestore.collection("Users");
    var batch = _firestore.batch();

    batch.update(sellerOrderCollection.doc(orderId), {
      "orderStatus": "Order Accepted",
      "deliveryDate": deliveryDate,
    });

    batch.update(userOrderCollection.doc(orderId), {
      "orderStatus": "Order Placed",
      "deliveryDate": deliveryDate,
    });
    batch.update(userCollection.doc(buyerId), {
      "notifications": FieldValue.arrayUnion([userNotification.toMap()])
    });
    await batch.commit().then((value) => print("Order Accepted successfully"));
    // await sellerOrderCollection
    //     .doc(orderId)
    //     .update({'orderStatus': 'Order Accepted'}).then(
    //         (value) => print("updated successfully"));
  }

  Future declineUserOrder(
      {required String orderId,
      required String buyerId,
      required UserNotification userNotification,
      required String deliveryDate}) async {
    CollectionReference sellerOrderCollection =
        _firestore.collection("MeatSeller").doc(user.uid).collection("orders");
    CollectionReference userOrderCollection =
        _firestore.collection("Users").doc(buyerId).collection("orders");
    CollectionReference userCollection = _firestore.collection("Users");
    var batch = _firestore.batch();

    batch.update(sellerOrderCollection.doc(orderId), {
      "orderStatus": "Order Declined",
    });

    batch.update(userOrderCollection.doc(orderId), {
      "orderStatus": "Order Declined",
    });
    batch.update(userCollection.doc(buyerId), {
      "notifications": FieldValue.arrayUnion([userNotification.toMap()])
    });
    await batch.commit().then((value) => print("Order Declined successfully"));
  }
}
