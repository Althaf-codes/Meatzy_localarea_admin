// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_localareaadmin/Model/local_area_admin_livestockdetails_model.dart';

import '../Constants/Utils.dart';
import '../Model/local_area_admin_model.dart';

class LocalAreaAdminService extends ChangeNotifier {
  User user;
  LocalAreaAdminService({
    required this.user,
  });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addLocalAreaAdminDetails(
    BuildContext context, {
    required LocalAreaAdminModel localAreaAdminModeldata,
    required String productId,
    required LiveStockDetails liveStockdetails,
  }) async {
    CollectionReference _collection = _firestore.collection('LocalAreaAdmins');
    CollectionReference _liveStokCollection = _firestore
        .collection('LocalAreaAdmins')
        .doc(user.uid)
        .collection("LiveStockDetails");

    var batch = _firestore.batch();

    batch.set(_collection.doc(user.uid), localAreaAdminModeldata.toMap());
    batch.update(_collection.doc(user.uid), {
      "totalCounts": {
        "${liveStockdetails.liveStockType}": FieldValue.increment(1)
      }
    });
    batch.set(_liveStokCollection.doc(productId), liveStockdetails.toMap());
    // batch.set(_liveStokCollection.doc(productId),
    //     {"timestamp": FieldValue.serverTimestamp}, SetOptions(merge: true));

    await batch
        .commit()
        .then((value) => showSnackBar(context, 'Details Added Succesfully'));
  }

  Stream<List<LiveStockDetails>> getallLiveStockDetails() {
    CollectionReference localAreaAdminLiveStockCollection = _firestore
        .collection("LocalAreaAdmins")
        .doc(user.uid)
        .collection("LiveStockDetails");

    return localAreaAdminLiveStockCollection
        .orderBy("postedAt", descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) =>
                LiveStockDetails.fromMap(documentSnapshot))
            .toList());
  }

  Stream<LocalAreaAdminModel> getLocalAreaAdminDetails(BuildContext context) {
    CollectionReference collection = _firestore.collection("LocalAreaAdmins");

    return collection.doc(user.uid.trim()).snapshots().map((snapshot) {
      print("the snapshot in stream is ${snapshot['LiveStockDetails']}");
      return LocalAreaAdminModel.fromMap(snapshot);
    });
  }

  Future addNewLiveStock(
    BuildContext context, {
    required LiveStockDetails data,
    required String productId,
  }) async {
    try {
      CollectionReference _collection =
          _firestore.collection('LocalAreaAdmins');

      CollectionReference liveStockCollection = _firestore
          .collection("LocalAreaAdmins")
          .doc(user.uid)
          .collection("LiveStockDetails");
      print("the uid is ${productId}");
      await liveStockCollection
          .doc(productId.toString())
          .set(data.toMap(), SetOptions(merge: true))
          .then((value) async {
        // await liveStockCollection.doc().set(
        //     {"timestamp": FieldValue.serverTimestamp()},
        //     SetOptions(merge: true));

        await _collection.doc(user.uid).set({
          "totalCounts": {"${data.liveStockType}": FieldValue.increment(1)}
        }, SetOptions(merge: true));
      }).then((value) => print('updated successfully'));

      // // await liveStockCollection.doc(productId.toString()).set({
      // //   "timestamp": FieldValue.serverTimestamp()
      // // }, SetOptions(merge: true))
      // .then((value) => print("Timestamp added succesfully"));
    } on FirebaseException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  // Future transferdocData(BuildContext context) async {
  //   // DocumentReference collection =
  //   //     _firestore.collection("MeatSeller").doc(user.uid);
  //   // LocalAreaAdminModel localAreadetail = await collection
  //   //     .snapshots()
  //   //     .map((event) => LocalAreaAdminModel.fromMap(event))
  //   //     .first;

  //   DocumentReference localAreaAdminCollection =
  //       _firestore.collection("LocalAreaAdmins").doc(user.uid);

  //   // await localAreaAdminLiveStockCollection.set(localAreadetail.toMap());
  //   CollectionReference liveStockCollection = _firestore
  //       .collection("LocalAreaAdmins")
  //       .doc(user.uid)
  //       .collection("LiveStockDetails");

  //   await localAreaAdminCollection.set({
  //     "totalCounts": {"cattle": FieldValue.increment(1)}
  //   }, SetOptions(merge: true));
  //   await liveStockCollection.doc("67c843d5-689c-4b14-9df4-a06009e3ab9d").set(
  //       {"timestamp": FieldValue.serverTimestamp()}, SetOptions(merge: true));
  // }
}
