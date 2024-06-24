import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../Constants/Global_Variables.dart';
import '../../Model/meat_seller_model.dart';
import '../../Service/meat_seller_firebase_service.dart';
import '../../Widget/horizontal_text_widget.dart';
import 'order_status_update_screen.dart';

class CurrentOrderDisplay extends StatelessWidget {
  const CurrentOrderDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: BackButton(color: Colors.white),
        //   backgroundColor: GlobalVariables.secondaryColor,
        // ),
        body: StreamBuilder<List<SellerOrder>>(
            stream: MeatSellerService(
                    user: Provider.of<User>(context, listen: false))
                .getAllOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: GlobalVariables.selectedNavBarColor,
                ));
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Error Occured"));
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text(
                    "No Orders Yet",
                  ),
                );
              }
              if (snapshot.hasData) {
                print("the stream data is ${snapshot.data}");
                //  MeatSellerModel? meatSellerModel = snapshot.data;

                // print("the user model is ${meatSellerModel}");

                List<SellerOrder>? orderlist = snapshot.data!.reversed.toList();
                print('//////////////////');

                //   print("the order list is ${orderlist![0].orderStatus}");
                print('//////////////////');

                if (orderlist!.isEmpty) {
                  return Center(
                    child: Text(
                      "No Orders For Now",
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: orderlist.length,
                      itemBuilder: (context, index) {
                        SellerOrder orderdata = orderlist[index];

                        return orderdata.orderStatus != "Order Delivered"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // MeatSellerService(
                                    //         user: Provider.of<User>(context,
                                    //             listen: false))
                                    //     .addTestSubcollection(orderdata.toMap(),
                                    //         orderdata.orderId);

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return OrderStatusUpdateScreen(
                                        order: orderdata,
                                      );
                                    })));
                                    // Navigator.
                                    //   print("its coming");
                                    //  push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: ((context) =>
                                    //             DetailedProductViewScreen(
                                    //                 product: product))));
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: GlobalVariables
                                                .selectedNavBarColor,
                                            width: 2),
                                        // color: Color.fromARGB(255, 0, 42, 22),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      children: [
                                        // CachedNetworkImage(
                                        //   imageUrl:
                                        //       "https://media.istockphoto.com/photos/variety-of-raw-black-angus-prime-meat-steaks-picture-id923692030?k=20&m=923692030&s=612x612&w=0&h=k-b2wtmHwBbpmSM74dN0gZzRD9oEwBUYiXdlWYD6mHY=",
                                        //   imageBuilder: (context, imageProvider) => Container(
                                        //     height: MediaQuery.of(context).size.height * 0.3,
                                        //     width: MediaQuery.of(context).size.width * 0.42,
                                        //     decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.only(
                                        //           topLeft: Radius.circular(12),
                                        //           bottomLeft: Radius.circular(12)),
                                        //       image: DecorationImage(
                                        //         image: imageProvider,
                                        //         fit: BoxFit.cover,
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   placeholder: (context, url) =>
                                        //       CircularProgressIndicator(),
                                        //   errorWidget: (context, url, error) =>
                                        //       Icon(Icons.error),
                                        // ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.43,
                                          // padding: EdgeInsets.only(left: 1),
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12)),
                                              border: Border.all(
                                                  color: GlobalVariables
                                                      .selectedNavBarColor)),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                bottomLeft:
                                                    Radius.circular(12)),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: orderdata.image,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: GlobalVariables
                                                      .secondaryColor,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              padding: EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                  // color: Colors.blue,

                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  12),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  12))),
                                              child: Column(
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Ordered Quantity :",
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: GlobalVariables
                                                            .selectedNavBarColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '${orderdata.quantityInKg.toString()} KG',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: GlobalVariables
                                                            .secondaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),

                                                  Text(
                                                    "Order Status :",
                                                    maxLines: 2,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: GlobalVariables
                                                            .selectedNavBarColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),

                                                  Text(
                                                    orderdata.orderStatus,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        color: GlobalVariables
                                                            .secondaryColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                  // RatingBarIndicator(
                                                  //   textDirection: TextDirection.ltr,
                                                  //   rating:
                                                  //       orderdata.discountPercentage.t,
                                                  //   itemBuilder: (context, index) =>
                                                  //       const Icon(
                                                  //     Icons.star,
                                                  //     color: Colors.amber,
                                                  //   ),
                                                  //   itemCount: 5,
                                                  //   itemSize: 10.0,
                                                  //   direction: Axis.horizontal,
                                                  // ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  HorizontalTitleText(
                                                      title: "Price",
                                                      text:
                                                          '₹ ${orderdata.price.toString()}',
                                                      maxline: 1)
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Container();
                      });
                }
                ;
              } else {
                return const Center(child: Text("No data"));
              }
            }));
  }
}
