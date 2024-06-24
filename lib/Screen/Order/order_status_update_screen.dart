// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Constants/Global_Variables.dart';
import '../../Model/meat_seller_model.dart';
import '../../Model/user_model_meatzy.dart';
import '../../Service/meat_seller_firebase_service.dart';
import '../../Widget/carousel_widget.dart';

class OrderStatusUpdateScreen extends StatelessWidget {
  SellerOrder order;

  OrderStatusUpdateScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    User firebaseUser = Provider.of<User>(context, listen: false);
    const textStyle = TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        wordSpacing: 3);

    const seeAllStyle = TextStyle(
        color: Color.fromARGB(255, 6, 81, 143),
        fontSize: 14,
        fontWeight: FontWeight.w800);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: GlobalVariables.secondaryColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: (() {
                Navigator.pop(context);
              }),
            )),
        body: ListView(children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: 250,
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   child: CarouselSlider(
              //     items: order.images.map(
              //       (i) {
              //         return Builder(
              //           builder: (BuildContext context) => Image.network(
              //             i,
              //             fit: BoxFit.cover,
              //             height: 200,
              //           ),
              //         );
              //       },
              //     ).toList(),
              //     options: CarouselOptions(
              //       enlargeCenterPage: true,
              //       viewportFraction: 1,
              //       height: 200,
              //     ),
              //   ),
              // ),
              Container(child: CarouselWidget(imgUrls: [order.image])),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, //Color.fromARGB(255, 175, 217, 252),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        order.orderedDate,
                        style: textStyle,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Description",
                          style: TextStyle(
                            color: GlobalVariables.selectedNavBarColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: order.deliveryDate,
                                style: TextStyle(
                                    color: GlobalVariables.selectedNavBarColor,
                                    fontWeight: FontWeight.bold))
                          ],
                          text: order.deliveryLocation.address,
                          style: TextStyle(
                              color: GlobalVariables.selectedNavBarColor,
                              wordSpacing: 2,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("Quanitiy  :   ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Expanded(
                                child: Text(order.quantityInKg.toString(),
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 131, 130, 130),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Is Discount:   ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Expanded(
                                child: Text(
                                    '${order.isDiscount == true ? "Yes" : "No"}  ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 131, 130, 130),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text("Price  :   ",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Row(
                                children: [
                                  Text(
                                    "₹",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(order.price.toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 131, 130, 130),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      GlobalVariables.selectedNavBarColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                MeatSellerService meatSellerService =
                                    MeatSellerService(user: firebaseUser);

                                await meatSellerService.acceptUserOrder(
                                    orderId: order.orderId,
                                    buyerId: order.buyerId,
                                    userNotification: UserNotification(
                                        message:
                                            "Dear User, Your Order ID No : ${order.orderId} has been placed successfully and will be delivered within ${DateTime.now().add(Duration(hours: 2))}",
                                        sellerId: firebaseUser.uid,
                                        productId: order.productId,
                                        timeStamp: DateTime.now().toString(),
                                        isSeen: false,
                                        productImage: order.image,
                                        orderId: order.orderId),
                                    deliveryDate: DateTime.now()
                                        .add(Duration(hours: 2))
                                        .toString());
                              },
                              icon: Icon(
                                Icons.ads_click_outlined,
                                size: 14,
                              ),
                              label: Text(
                                'Accept Order ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                MeatSellerService meatSellerService =
                                    MeatSellerService(user: firebaseUser);

                                await meatSellerService.declineUserOrder(
                                    orderId: order.orderId,
                                    buyerId: order.buyerId,
                                    userNotification: UserNotification(
                                        message:
                                            "Dear User, Sorry to inform that your Order ID No : ${order.orderId} has NOT PLACED/ NOT ACCEPTED by the shop",
                                        sellerId: firebaseUser.uid,
                                        productId: order.productId,
                                        timeStamp: DateTime.now().toString(),
                                        isSeen: false,
                                        productImage: order.image,
                                        orderId: order.orderId),
                                    deliveryDate: DateTime.now()
                                        .add(Duration(hours: 2))
                                        .toString());
                              },
                              icon: Icon(
                                Icons.delete_forever_outlined,
                                size: 14,
                              ),
                              label: Text(
                                'Decline',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}

        // ElevatedButton.icon(
        //     onPressed: () {},
        //     icon: Icon(Icons.ads_click_outlined),
        //     label: Text(
        //       "Accept order",
        //       style: TextStyle(color: Colors.white),
        //     ))