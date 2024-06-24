import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meatzy_localareaadmin/Model/local_area_admin_model.dart';

import 'package:provider/provider.dart';

import '../../Constants/Global_Variables.dart';
import '../../Model/meat_seller_model.dart';
import '../../Model/user_model_meatzy.dart';
import '../../Service/meat_seller_firebase_service.dart';
import '../Order/order_display_screen.dart';

class NotificationScreen extends StatelessWidget {
  List<LocalAreaAdminNotification>? notification;
  NotificationScreen({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = Provider.of<User>(context, listen: false);
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: GlobalVariables.secondaryColor,
          leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              })),
      body: SingleChildScrollView(
        controller: scrollController,
        clipBehavior: Clip.none,
        child: Column(children: [
          notification!.isEmpty
              ? const Center(
                  child: Text('No Notifications'),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: notification!.length,
                  itemBuilder: ((context, index) {
                    LocalAreaAdminNotification singleNotification =
                        notification![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Hero(
                                tag: index,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      singleNotification.productImage),
                                  radius: 40,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                                child: VerticalDivider(),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 5, right: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        singleNotification.message,
                                        maxLines: 4,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  // fixedSize: Size(200, 40),
                                                  backgroundColor:
                                                      GlobalVariables
                                                          .secondaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15))),
                                              onPressed: () async {
                                                // await MeatSellerService(
                                                //         user: Provider.of<User>(
                                                //             context,
                                                //             listen: false))
                                                //     .acceptOrder(
                                                //         singleNotification.orderId);

                                                MeatSellerService
                                                    meatSellerService =
                                                    MeatSellerService(
                                                        user: firebaseUser);

                                                await meatSellerService.acceptUserOrder(
                                                    orderId: singleNotification
                                                        .orderId,
                                                    buyerId: singleNotification
                                                        .buyerId,
                                                    userNotification: UserNotification(
                                                        message:
                                                            "Dear User, Your Order ID No : ${singleNotification.orderId} has been placed successfully and will be delivered within ${DateTime.now().add(Duration(hours: 2))}",
                                                        sellerId:
                                                            firebaseUser.uid,
                                                        productId:
                                                            singleNotification
                                                                .productId,
                                                        timeStamp:
                                                            DateTime.now()
                                                                .toString(),
                                                        isSeen: false,
                                                        productImage:
                                                            singleNotification
                                                                .productImage,
                                                        orderId:
                                                            singleNotification
                                                                .orderId),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          ElevatedButton.icon(
                                              style: ElevatedButton.styleFrom(
                                                  // fixedSize: Size(200, 40),
                                                  backgroundColor:
                                                      GlobalVariables
                                                          .selectedNavBarColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15))),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CurrentOrderDisplay(),
                                                    ));
                                              },
                                              icon: Icon(
                                                Icons.ads_click_outlined,
                                                size: 14,
                                              ),
                                              label: Text(
                                                'View',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  }))
        ]),
      ),
    );
  }
}
