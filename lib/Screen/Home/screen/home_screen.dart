import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:meatzy_localareaadmin/Model/local_area_admin_livestockdetails_model.dart';
import 'package:meatzy_localareaadmin/Model/local_area_admin_model.dart';
import 'package:meatzy_localareaadmin/Service/local_area_admin_service.dart';

import 'package:provider/provider.dart';

import '../../../Constants/Global_Variables.dart';
import '../../../Constants/Utils.dart';
import '../../../Model/meat_seller_model.dart';
import '../../../Service/meat_seller_firebase_service.dart';
import '../../../Widget/horizontal_text_widget.dart';
import '../../../Widget/notificationWidget.dart';
import '../../../Widget/sliverAppbar.dart';
import '../../Notification/notification_screen.dart';
import 'detailed_product_view_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

// import '../../../Widgets/EssentialWidgets.dart';
// import '../../../Widgets/carousel_widget.dart';
// import '../../../Widgets/categoryList.dart';
// import '../../../Widgets/similarProduct_widget.dart';
// import '../../../Widgets/sliverAppbar.dart';
// import '../../../Widgets/specialOfferWidget.dart';
// import '../../../Widgets/sponsored_imageList.dart';
// import '../../../Widgets/topDeals.dart';

class HomeScreen extends StatefulWidget {
  ScrollController? controller;
  HomeScreen({Key? key, this.controller}) : super(key: key);

  static const String _route = '/Home';

  static get route => _route;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollcontroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      //controller: controller,
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          sliverAppBar(context,
              isSecondIcon: true,
              icon1: StreamBuilder<LocalAreaAdminModel>(
                stream: LocalAreaAdminService(
                        user: Provider.of<User>(context, listen: false))
                    .getLocalAreaAdminDetails(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: GlobalVariables.selectedNavBarColor,
                    ));
                  }
                  if (snapshot.hasError) {
                    return notificationWidget(
                        text: '0',
                        ontap: () {
                          print(Timestamp.fromDate(DateTime.now()));
                          showSnackBar(context, 'Error occurred');
                        });
                  }
                  if (!snapshot.hasData) {
                    return notificationWidget(
                        text: '0',
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      NotificationScreen(notification: []))));
                        });
                  }
                  if (snapshot.hasData) {
                    LocalAreaAdminModel? localAreaAdminModel = snapshot.data;
                    List<LocalAreaAdminNotification>? notification =
                        localAreaAdminModel!.notifications;
                    // List<>? sellerproducts = localAreaAdminModel.;
                    return notificationWidget(
                        text: localAreaAdminModel.notifications!.length
                            .toString(),
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => NotificationScreen(
                                      notification: notification))));
                        });
                  } else {
                    return Container();
                  }
                },
              ),
              flexibleChild: IconButton(
                icon: Container(),
                onPressed: () {},
              ))
          //   StreamBuilder<MeatSellerModel>(
          //       stream: MeatSellerService(
          //               user: Provider.of<User>(context, listen: false))
          //           .getMeatSellerDetails(context),
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return Center(
          //               child: CircularProgressIndicator(
          //             color: GlobalVariables.selectedNavBarColor,
          //           ));
          //         }
          //         if (snapshot.hasError) {
          //           return sliverAppBar(context,
          //               isSecondIcon: true,
          //               icon1: notificationWidget(
          //                   text: '',
          //                   ontap: () {
          //                     showSnackBar(context, "Error occurred");
          //                   }),
          //               flexibleChild: IconButton(
          //                 icon: Container(),
          //                 onPressed: () {},
          //               ));
          //         }
          //         if (!snapshot.hasData) {
          //           return sliverAppBar(context,
          //               isSecondIcon: true,
          //               icon1: notificationWidget(text: '0', ontap: () {}),
          //               flexibleChild: IconButton(
          //                 icon: Container(),
          //                 onPressed: () {},
          //               ));
          //         }
          //         if (snapshot.hasData) {
          //           MeatSellerModel? meatSellerModel = snapshot.data;

          //           return sliverAppBar(context,
          //               isSecondIcon: true,
          //               icon1: notificationWidget(
          //                   text:
          //                       meatSellerModel!.notifications!.length.toString(),
          //                   ontap: () {}),
          //               flexibleChild: IconButton(
          //                 icon: Container(),
          //                 onPressed: () {},
          //               ));
          //         } else {
          //           return Container();
          //         }
          //       }),
        ];
      },
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        clipBehavior: Clip.none,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  "Your LiveStocks",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      color: GlobalVariables.selectedNavBarColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
            StreamBuilder<List<LiveStockDetails>>(
              initialData: null,
              stream: LocalAreaAdminService(user: context.watch<User>())
                  .getallLiveStockDetails(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: GlobalVariables.selectedNavBarColor,
                  ));
                }
                if (snapshot.hasError) {
                  print("the data in haserr is ${snapshot.data}");

                  print("the error is ${snapshot.error.toString()}");
                  return const Center(child: Text("Error Occured"));
                }
                if (snapshot.hasData) {
                  //MeatSellerModel meatseller = snapshot.data;
                  List<LiveStockDetails> allLiveStockDetails =
                      snapshot.data.toList();
                  print("//////////////");
                  print('allLiveStockDetails is ${allLiveStockDetails}');
                  //   print("//////////////");
                  //   print("//////////////");
                  //  // print("the seller data is ${allProducts[0].sellerName}");
                  //   print("//////////////");

                  // //  print("the seller product is ${meatseller.products}");
                  //   print("//////////////");
                  // print(
                  //     "the  product length is ${meatseller.products!.length.toString()}");
                  // print("//////////////");
                  // print(
                  //     "the seller product is ${meatseller.products![1].productName}");
                  // print("//////////////");

                  return GroupedListView<LiveStockDetails, String>(
                      shrinkWrap: true,
                      elements: allLiveStockDetails.reversed.toList(),
                      groupBy: (element) {
                        // print(
                        //     "The DateFormat is ${DateFormat.yMMMd().format(element.timestamp.toDate())}");
                        return DateFormat.yMMMd()
                            .format(element.postedAt!.toDate());
                        // timeago.format(element.timestamp.toDate());
                      },
                      groupSeparatorBuilder: (value) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              color: GlobalVariables.selectedNavBarColor,
                              child: Center(
                                child: Text(
                                  value.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                      itemBuilder: (context, liveStockDetails) {
//  LiveStockDetails liveStockDetails =
//                             allLiveStockDetails[index];
//                         print("the index is ${index}");

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          DetailedProductViewScreen(
                                              liveStockDetails:
                                                  liveStockDetails))));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          GlobalVariables.selectedNavBarColor,
                                      width: 2),
                                  // color: Color.fromARGB(255, 0, 42, 22),
                                  borderRadius: BorderRadius.circular(12)),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width: MediaQuery.of(context).size.width *
                                        0.43,
                                    // padding: EdgeInsets.only(left: 1),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12)),
                                        border: Border.all(
                                            color: GlobalVariables
                                                .selectedNavBarColor)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: liveStockDetails.images![0],
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(
                                            color:
                                                GlobalVariables.secondaryColor,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.error,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        padding: EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            // color: Colors.blue,

                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12))),
                                        child: Column(
                                          children: [
                                            Text(
                                              liveStockDetails.liveStockType ??
                                                  '',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: GlobalVariables
                                                      .selectedNavBarColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            Text(
                                              liveStockDetails.description ??
                                                  '',
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  color: GlobalVariables
                                                      .secondaryColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                            // RatingBarIndicator(
                                            //   textDirection: TextDirection.ltr,
                                            //   rating:
                                            //       liveStockDetails.ratings.toDouble(),
                                            //   itemBuilder: (context, index) =>
                                            //       const Icon(
                                            //     Icons.star,
                                            //     color: Colors.amber,
                                            //   ),
                                            //   itemCount: 5,
                                            //   itemSize: 10.0,
                                            //   direction: Axis.horizontal,
                                            // ),
                                            HorizontalTitleText(
                                                title: "Price",
                                                text:
                                                    '₹ ${liveStockDetails.priceQuoted.toString()}',
                                                maxline: 1)
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });

                  // ListView.builder(
                  //     controller: scrollcontroller,
                  //     scrollDirection: Axis.vertical,
                  //     shrinkWrap: true,
                  //     itemCount: allLiveStockDetails!.length,
                  //     itemBuilder: (context, index) {
                  //       LiveStockDetails liveStockDetails =
                  //           allLiveStockDetails[index];
                  //       print("the index is ${index}");
                  //       return Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             Navigator.push(
                  //                 context,
                  //                 MaterialPageRoute(
                  //                     builder: ((context) =>
                  //                         DetailedProductViewScreen(
                  //                             liveStockDetails:
                  //                                 liveStockDetails))));
                  //           },
                  //           child: Container(
                  //             height: MediaQuery.of(context).size.height * 0.3,
                  //             width: MediaQuery.of(context).size.width * 0.9,
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                     color:
                  //                         GlobalVariables.selectedNavBarColor,
                  //                     width: 2),
                  //                 // color: Color.fromARGB(255, 0, 42, 22),
                  //                 borderRadius: BorderRadius.circular(12)),
                  //             child: Row(
                  //               children: [
                  //                 // CachedNetworkImage(
                  //                 //   imageUrl:
                  //                 //       "https://media.istockphoto.com/photos/variety-of-raw-black-angus-prime-meat-steaks-picture-id923692030?k=20&m=923692030&s=612x612&w=0&h=k-b2wtmHwBbpmSM74dN0gZzRD9oEwBUYiXdlWYD6mHY=",
                  //                 //   imageBuilder: (context, imageProvider) => Container(
                  //                 //     height: MediaQuery.of(context).size.height * 0.3,
                  //                 //     width: MediaQuery.of(context).size.width * 0.42,
                  //                 //     decoration: BoxDecoration(
                  //                 //       borderRadius: BorderRadius.only(
                  //                 //           topLeft: Radius.circular(12),
                  //                 //           bottomLeft: Radius.circular(12)),
                  //                 //       image: DecorationImage(
                  //                 //         image: imageProvider,
                  //                 //         fit: BoxFit.cover,
                  //                 //       ),
                  //                 //     ),
                  //                 //   ),
                  //                 //   placeholder: (context, url) =>
                  //                 //       CircularProgressIndicator(),
                  //                 //   errorWidget: (context, url, error) =>
                  //                 //       Icon(Icons.error),
                  //                 // ),
                  //                 Container(
                  //                   height: MediaQuery.of(context).size.height *
                  //                       0.3,
                  //                   width: MediaQuery.of(context).size.width *
                  //                       0.43,
                  //                   // padding: EdgeInsets.only(left: 1),
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.grey,
                  //                       borderRadius: const BorderRadius.only(
                  //                           topLeft: Radius.circular(12),
                  //                           bottomLeft: Radius.circular(12)),
                  //                       border: Border.all(
                  //                           color: GlobalVariables
                  //                               .selectedNavBarColor)),
                  //                   child: ClipRRect(
                  //                     borderRadius: BorderRadius.only(
                  //                         topLeft: Radius.circular(12),
                  //                         bottomLeft: Radius.circular(12)),
                  //                     child: CachedNetworkImage(
                  //                       fit: BoxFit.cover,
                  //                       imageUrl: liveStockDetails.images![0],
                  //                       placeholder: (context, url) =>
                  //                           const Center(
                  //                         child: CircularProgressIndicator(
                  //                           color:
                  //                               GlobalVariables.secondaryColor,
                  //                         ),
                  //                       ),
                  //                       errorWidget: (context, url, error) =>
                  //                           const Icon(
                  //                         Icons.error,
                  //                         color: Colors.grey,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Expanded(
                  //                   child: Container(
                  //                       height:
                  //                           MediaQuery.of(context).size.height *
                  //                               0.3,
                  //                       width:
                  //                           MediaQuery.of(context).size.width *
                  //                               0.5,
                  //                       padding: EdgeInsets.all(8),
                  //                       decoration: const BoxDecoration(
                  //                           // color: Colors.blue,

                  //                           borderRadius: BorderRadius.only(
                  //                               topRight: Radius.circular(12),
                  //                               bottomRight:
                  //                                   Radius.circular(12))),
                  //                       child: Column(
                  //                         children: [
                  //                           Text(
                  //                             liveStockDetails.liveStockType ??
                  //                                 '',
                  //                             maxLines: 1,
                  //                             style: TextStyle(
                  //                                 color: GlobalVariables
                  //                                     .selectedNavBarColor,
                  //                                 fontSize: 16,
                  //                                 fontWeight: FontWeight.w600,
                  //                                 overflow:
                  //                                     TextOverflow.ellipsis),
                  //                           ),
                  //                           Text(
                  //                             liveStockDetails.description ??
                  //                                 '',
                  //                             maxLines: 2,
                  //                             style: const TextStyle(
                  //                                 color: GlobalVariables
                  //                                     .secondaryColor,
                  //                                 fontSize: 13,
                  //                                 fontWeight: FontWeight.w300,
                  //                                 overflow:
                  //                                     TextOverflow.ellipsis),
                  //                           ),
                  //                           // RatingBarIndicator(
                  //                           //   textDirection: TextDirection.ltr,
                  //                           //   rating:
                  //                           //       liveStockDetails.ratings.toDouble(),
                  //                           //   itemBuilder: (context, index) =>
                  //                           //       const Icon(
                  //                           //     Icons.star,
                  //                           //     color: Colors.amber,
                  //                           //   ),
                  //                           //   itemCount: 5,
                  //                           //   itemSize: 10.0,
                  //                           //   direction: Axis.horizontal,
                  //                           // ),
                  //                           HorizontalTitleText(
                  //                               title: "Price",
                  //                               text:
                  //                                   '₹ ${liveStockDetails.priceQuoted.toString()}',
                  //                               maxline: 1)
                  //                         ],
                  //                       )),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     });
                }

                return const Center(child: Text("NO Data"));
              },
            )
          ],
        ),
      ),
    ));
  }
}

//  NestedScrollView(
//       //controller: controller,
//       floatHeaderSlivers: true,
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//         return [
//           sliverAppBar(context,
//               isSecondIcon: true,
//               icon1: notificationWidget('1', () {}),
//               flexibleChild: IconButton(
//                 icon: Icon(Icons.logout),
//                 onPressed: (() async {
//                   await context.read<FirebaseAuthMethods>().signOut(context);
//                 }),
//               )),
//         ];
//       },
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             //Padding(
//             //   padding: const EdgeInsets.only(left: 12.0, right: 12, top: 10),
//             //   child: CategoryList(),
//             // ),
//             // Container(
//             //     height: 200,
//             //     width: MediaQuery.of(context).size.width,
//             //     child: CarouselWidget()),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: SponsoredImageList(),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: TopDealWidget(),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: SimilarProductWidget(),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: SpecialOfferWidget(),
//             // ),
//             // SizedBox(
//             //   height: 500,
//             // )
//           ],
//         ),
//       ),
//    ));
