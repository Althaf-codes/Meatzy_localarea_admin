import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meatzy_localareaadmin/Model/local_area_admin_model.dart';

class LiveStockOrder {
  LiveStockOrder({
    required this.productPrice,
    required this.totalPrice,
    required this.orderProductImage,
    required this.productId,
    required this.orderedDate,
    required this.deliveryDate,
    required this.orderStatus,
    required this.buyerId,
    required this.deliveryLocation,
    required this.orderId,
    required this.isbutcherNeeded,
    required this.isOnSpotDelivery,
    required this.cattleIdNo,
  });

  int? productPrice;
  int? totalPrice;
  String? orderProductImage;
  String? productId;
  Timestamp? orderedDate;
  Timestamp? deliveryDate;
  String? orderStatus;
  String? buyerId;
  LiveStockHubLocation? deliveryLocation;
  String? orderId;
  bool? isbutcherNeeded;
  bool? isOnSpotDelivery;
  int? cattleIdNo;

  LiveStockOrder copyWith({
    required int? productPrice,
    required int? toalPrice,
    required String? orderProductImage,
    required String? productId,
    required Timestamp? orderedDate,
    required Timestamp? deliveryDate,
    required String? orderStatus,
    required String? buyerId,
    required LiveStockHubLocation? deliveryLocation,
    required String? orderId,
  }) =>
      LiveStockOrder(
        productPrice: productPrice,
        totalPrice: totalPrice,
        orderProductImage: orderProductImage,
        productId: productId,
        orderedDate: orderedDate,
        deliveryDate: deliveryDate,
        orderStatus: orderStatus,
        buyerId: buyerId,
        deliveryLocation: deliveryLocation,
        orderId: orderId,
        isbutcherNeeded: isbutcherNeeded ?? isbutcherNeeded,
        isOnSpotDelivery: isOnSpotDelivery ?? isOnSpotDelivery,
        cattleIdNo: cattleIdNo ?? cattleIdNo,
      );

  factory LiveStockOrder.fromJson(String str) =>
      LiveStockOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiveStockOrder.fromMap(Map<String, dynamic> json) => LiveStockOrder(
        productPrice: json["productPrice"],
        totalPrice: json["totalPrice"],
        orderProductImage: json["orderProductImage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        buyerId: json["buyerId "],
        deliveryLocation: LiveStockHubLocation.fromMap(
          json["deliveryLocation"],
        ),
        orderId: json["orderId"],
        isOnSpotDelivery: json["isOnSpotDelivery"],
        isbutcherNeeded: json["isbutcherNeeded"],
        cattleIdNo: json["cattleIdNo"],
      );

  factory LiveStockOrder.fromdocumentsnap(DocumentSnapshot json) =>
      LiveStockOrder(
        productPrice: json["productPrice"],
        totalPrice: json["totalPrice"],
        orderProductImage: json["orderProductImage"],
        productId: json["productId"],
        orderedDate: json["orderedDate"],
        deliveryDate: json["deliveryDate"],
        orderStatus: json["orderStatus"],
        buyerId: json["buyerId "],
        deliveryLocation:
            LiveStockHubLocation.fromMap(json["deliveryLocation"]),
        orderId: json["orderId"],
        isOnSpotDelivery: json["isOnSpotDelivery"],
        isbutcherNeeded: json["isbutcherNeeded"],
        cattleIdNo: json["cattleIdNo"],
      );

  Map<String, dynamic> toMap() => {
        "productPrice": productPrice,
        "totalPrice": totalPrice,
        "orderProductImage": orderProductImage,
        "productId": productId,
        "orderedDate": orderedDate,
        "deliveryDate": deliveryDate,
        "orderStatus": orderStatus,
        "buyerId": buyerId,
        "deliveryLocation": deliveryLocation!.toMap(),
        "orderId": orderId,
        "isbutcherNeeded": isbutcherNeeded,
        "isOnSpotDelivery": isOnSpotDelivery,
        "cattleIdNo": cattleIdNo,
      };
}
