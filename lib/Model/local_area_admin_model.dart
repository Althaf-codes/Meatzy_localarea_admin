// / To parse this JSON data, do
//
//     final localAreaAdminModel = localAreaAdminModelFromMap(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LocalAreaAdminModel {
  String? name;
  String? id;
  String? phoneNo;
  String? address;
  int? aadharNumber;
  String? dob;
  String? area;
  List<String>? areaUnderControl;
  LiveStockCount totalCounts;
  int? soldLiveStockCount;
  List<String>? liveStockTypes;
  int? localAreaEmpCount;
  FeedStock? feedStock;
  int? totalInvested;
  int? totalReturn;
  List<BuyerId>? buyerId;
  int? totalOrders;
  int? advancedCattle;
  int? payedCattle;
  LiveStockHubLocation? location;
  List<LocalAreaAdminNotification>? notifications;

  LocalAreaAdminModel({
    required this.name,
    required this.id,
    required this.phoneNo,
    required this.address,
    required this.aadharNumber,
    required this.dob,
    required this.area,
    required this.areaUnderControl,
    required this.totalCounts,
    required this.soldLiveStockCount,
    required this.liveStockTypes,
    required this.localAreaEmpCount,
    required this.feedStock,
    required this.totalInvested,
    required this.totalReturn,
    required this.buyerId,
    required this.totalOrders,
    required this.advancedCattle,
    required this.payedCattle,
    required this.location,
    required this.notifications,
  });

  LocalAreaAdminModel copyWith({
    String? name,
    String? id,
    String? phoneNo,
    String? address,
    int? aadharNumber,
    String? dob,
    String? area,
    List<String>? areaUnderControl,
    LiveStockCount? totalCounts,
    int? soldLiveStockCount,
    List<String>? liveStockTypes,
    int? localAreaEmpCount,
    FeedStock? feedStock,
    int? totalInvested,
    int? totalReturn,
    List<BuyerId>? buyerId,
    int? totalOrders,
    int? advancedCattle,
    int? payedCattle,
    LiveStockHubLocation? location,
    List<LocalAreaAdminNotification>? notifications,
  }) =>
      LocalAreaAdminModel(
        name: name ?? this.name,
        id: id ?? this.id,
        phoneNo: phoneNo ?? this.phoneNo,
        address: address ?? this.address,
        aadharNumber: aadharNumber ?? this.aadharNumber,
        dob: dob ?? this.dob,
        area: area ?? this.area,
        areaUnderControl: areaUnderControl ?? this.areaUnderControl,
        totalCounts: totalCounts ?? this.totalCounts,
        soldLiveStockCount: soldLiveStockCount ?? this.soldLiveStockCount,
        liveStockTypes: liveStockTypes ?? this.liveStockTypes,
        localAreaEmpCount: localAreaEmpCount ?? this.localAreaEmpCount,
        feedStock: feedStock ?? this.feedStock,
        totalInvested: totalInvested ?? this.totalInvested,
        totalReturn: totalReturn ?? this.totalReturn,
        buyerId: buyerId ?? this.buyerId,
        totalOrders: totalOrders ?? this.totalOrders,
        advancedCattle: advancedCattle ?? this.advancedCattle,
        payedCattle: payedCattle ?? this.payedCattle,
        location: location ?? this.location,
        notifications: notifications ?? this.notifications,
      );

  factory LocalAreaAdminModel.fromJson(String str) =>
      LocalAreaAdminModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocalAreaAdminModel.fromMap(DocumentSnapshot json) =>
      LocalAreaAdminModel(
          name: json["name"],
          id: json["id"],
          phoneNo: json["phoneNo"],
          address: json["address"],
          aadharNumber: json["aadharNumber"],
          dob: json["DOB"],
          area: json["area"],
          areaUnderControl:
              List<String>.from(json["areaUnderControl"].map((x) => x)),
          totalCounts: LiveStockCount.fromMap(json["totalCounts"]),
          soldLiveStockCount: json["soldLiveStockCount"],
          liveStockTypes:
              List<String>.from(json["liveStockTypes"].map((x) => x)),
          localAreaEmpCount: json["localAreaEmpCount"],
          feedStock: FeedStock.fromMap(json["feedStock"]),
          totalInvested: json["totalInvested"],
          totalReturn: json["totalReturn"],
          buyerId: List<BuyerId>.from(
              json["buyerId"].map((x) => BuyerId.fromMap(x))),
          totalOrders: json["totalOrders"],
          advancedCattle: json["advancedCattle"],
          payedCattle: json["PayedCattle"],
          location: LiveStockHubLocation.fromMap(json["location"]),
          notifications: List<LocalAreaAdminNotification>.from(
              json["notifications"]
                  .map((x) => LocalAreaAdminNotification.fromMap(x))));

  Map<String, dynamic> toMap() => {
        "name": name,
        "id": id,
        "phoneNo": phoneNo,
        "address": address,
        "aadharNumber": aadharNumber,
        "DOB": dob,
        "area": area,
        "areaUnderControl": List<dynamic>.from(areaUnderControl!.map((x) => x)),
        "totalCounts": totalCounts.toMap(),
        "soldLiveStockCount": soldLiveStockCount,
        "liveStockTypes": List<dynamic>.from(liveStockTypes!.map((x) => x)),
        "localAreaEmpCount": localAreaEmpCount,
        "feedStock": feedStock?.toMap(),
        "totalInvested": totalInvested,
        "totalReturn": totalReturn,
        "buyerId": List<dynamic>.from(buyerId!.map((x) => x.toMap())),
        "totalOrders": totalOrders,
        "advancedCattle": advancedCattle,
        "PayedCattle": payedCattle,
        "location": location?.toMap(),
        "notifications":
            List<dynamic>.from(notifications!.map((x) => x.toMap()))
      };
}

class BuyerId {
  String id;
  String productId;

  BuyerId({
    required this.id,
    required this.productId,
  });

  BuyerId copyWith({
    String? id,
    String? productId,
  }) =>
      BuyerId(
        id: id ?? this.id,
        productId: productId ?? this.productId,
      );

  factory BuyerId.fromJson(String str) => BuyerId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BuyerId.fromMap(Map<String, dynamic> json) => BuyerId(
        id: json["id"],
        productId: json["productId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "productId": productId,
      };
}

class FeedStock {
  String type1;
  String type2;
  String type3;
  String type4;
  String type5;

  FeedStock({
    required this.type1,
    required this.type2,
    required this.type3,
    required this.type4,
    required this.type5,
  });

  FeedStock copyWith({
    String? type1,
    String? type2,
    String? type3,
    String? type4,
    String? type5,
  }) =>
      FeedStock(
        type1: type1 ?? this.type1,
        type2: type2 ?? this.type2,
        type3: type3 ?? this.type3,
        type4: type4 ?? this.type4,
        type5: type5 ?? this.type5,
      );

  factory FeedStock.fromJson(String str) => FeedStock.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedStock.fromMap(Map<String, dynamic> json) => FeedStock(
        type1: json["type1"],
        type2: json["type2"],
        type3: json["type3"],
        type4: json["type4"],
        type5: json["type5"],
      );

  Map<String, dynamic> toMap() => {
        "type1": type1,
        "type2": type2,
        "type3": type3,
        "type4": type4,
        "type5": type5,
      };
}

class LiveStockHubLocation {
  String address;
  List<dynamic> coordinates;
  String pincode;

  LiveStockHubLocation({
    required this.address,
    required this.coordinates,
    required this.pincode,
  });

  LiveStockHubLocation copyWith({
    String? address,
    List<dynamic>? coordinates,
    String? pincode,
  }) =>
      LiveStockHubLocation(
        address: address ?? this.address,
        coordinates: coordinates ?? this.coordinates,
        pincode: pincode ?? this.pincode,
      );

  factory LiveStockHubLocation.fromJson(String str) =>
      LiveStockHubLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiveStockHubLocation.fromMap(Map<String, dynamic> json) =>
      LiveStockHubLocation(
        address: json["address"],
        coordinates: List<dynamic>.from(json["coordinates"].map((x) => x)),
        pincode: json["pincode"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "pincode": pincode,
      };
}

class LocalAreaAdminNotification {
  LocalAreaAdminNotification({
    required this.message,
    required this.buyerId,
    required this.productId,
    required this.timeStamp,
    required this.isSeen,
    required this.productImage,
    required this.orderId,
    required this.productType,
  });

  String message;
  String buyerId;
  String productId;
  String timeStamp;
  bool isSeen;
  String productImage;
  String orderId;
  String productType;

  LocalAreaAdminNotification copyWith({
    required String message,
    required String buyerId,
    required String productId,
    required String timeStamp,
    required bool isSeen,
    required String productImage,
    required String orderId,
    required String productType,
  }) =>
      LocalAreaAdminNotification(
          message: message,
          buyerId: buyerId,
          productId: productId,
          timeStamp: timeStamp,
          isSeen: isSeen,
          productImage: productImage,
          orderId: orderId,
          productType: productType);

  factory LocalAreaAdminNotification.fromJson(String str) =>
      LocalAreaAdminNotification.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocalAreaAdminNotification.fromMap(Map<String, dynamic> json) =>
      LocalAreaAdminNotification(
        message: json["message"],
        buyerId: json["buyerId"],
        productId: json["productId"],
        timeStamp: json["timeStamp"],
        isSeen: json["isSeen"],
        productImage: json["productImage"],
        orderId: json["orderId"],
        productType: json["productType"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "buyerId": buyerId,
        "productId": productId,
        "timeStamp": timeStamp,
        "isSeen": isSeen,
        "productImage": productImage,
        "orderId": orderId,
        "productType": productType,
      };
}

class LiveStockCount {
  int cattle;
  int sheep;
  int goat;
  int buffalo;

  LiveStockCount({
    required this.cattle,
    required this.sheep,
    required this.goat,
    required this.buffalo,
  });

  LiveStockCount copyWith({
    int? cattle,
    int? sheep,
    int? goat,
    int? buffalo,
  }) =>
      LiveStockCount(
        cattle: cattle ?? this.cattle,
        sheep: sheep ?? this.sheep,
        goat: goat ?? this.goat,
        buffalo: buffalo ?? this.buffalo,
      );

  factory LiveStockCount.fromJson(String str) =>
      LiveStockCount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LiveStockCount.fromMap(Map<String, dynamic> json) => LiveStockCount(
        cattle: json["cattle"],
        sheep: json["sheep"],
        goat: json["goat"],
        buffalo: json["buffalo"],
      );

  Map<String, dynamic> toMap() => {
        "cattle": cattle,
        "sheep": sheep,
        "goat": goat,
        "buffalo": buffalo,
      };
}
