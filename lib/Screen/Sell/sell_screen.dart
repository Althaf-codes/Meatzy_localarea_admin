import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Constants/Global_Variables.dart';
import '../../Constants/Utils.dart';
import '../../Model/local_area_admin_livestockdetails_model.dart';
import '../../Service/local_area_admin_service.dart';
import '../../Utils/pick_image.dart';
import '../../Widget/textformfeild_widget.dart';
import '../MainHomePage.dart';

class LocalAreaAdminLiveStockSellingScreen extends StatefulWidget {
  const LocalAreaAdminLiveStockSellingScreen({super.key});

  @override
  State<LocalAreaAdminLiveStockSellingScreen> createState() =>
      _LocalAreaAdminLiveStockSellingScreenState();
}

class _LocalAreaAdminLiveStockSellingScreenState
    extends State<LocalAreaAdminLiveStockSellingScreen> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController approxLiveStockKgController =
      TextEditingController();
  final TextEditingController boughtPriceController = TextEditingController();
  final TextEditingController boughtOwnerPhoneController =
      TextEditingController();
  final TextEditingController boughtOwnerNameController =
      TextEditingController();
  final TextEditingController boughtOwnerAddressController =
      TextEditingController();
////////////////////////////////////////////////////////////////////
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController highlightedDescriptionController =
      TextEditingController();

  final TextEditingController soldPriceController = TextEditingController(); //

  final TextEditingController priceQuotedController = TextEditingController();

  final TextEditingController deadlinePayTimeController =
      TextEditingController();
  final TextEditingController cattleIdNoController = TextEditingController();

  // deliveryDateAndTime
  // deliveryLocation
  // isDelivered
  // images
  //isSold

  bool isFullyPaid = false;
  bool isSold = false;
  bool isDelivered = false;
  bool isAdvanced = false;
  bool isOnSpotDelivery = false;
  bool isButcherNeeded = false;

  final formGlobalKey = GlobalKey<FormState>();

  // bool isHavingStock = false;
  // bool isDiscountable = false;
  // bool isDeliverable = false;

  List<File> images = [];
  List<String> imageUrls = [];

  String? dropdownval = 'cattle';
  final livestocktypes = ["cattle", "sheep", "goat", "buffalo"];

  void selectImages() async {
    setState(() {
      images = [];
      imageUrls = [];
    });
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void addMoreImages() async {
    var res = await pickImages();
    setState(() {
      images.addAll(res);
    });
  }

  bool isloading = false;

  DateTime date = DateTime.now();
  void datepic(BuildContext context) async {
    DateTime? newdate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100));

    if (newdate == null) return;
    setState(() {
      date = newdate;
    });
  }

  @override
  void dispose() {
    ageController.dispose();
    approxLiveStockKgController.dispose();

    boughtPriceController.dispose();
    boughtOwnerPhoneController.dispose();

    boughtOwnerNameController.dispose();

    boughtOwnerAddressController.dispose();
    descriptionController.dispose();
    highlightedDescriptionController.dispose();

    soldPriceController.dispose();
    priceQuotedController.dispose();
    deadlinePayTimeController.dispose();
    cattleIdNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prefs;

    // void initalizeShared() async {
    //   prefs = await SharedPreferences.getInstance();
    // }

    // final firebaseUser = context.read<User?>();
    final firebaseUser = Provider.of<User>(context, listen: false);
    UploadTask? uploadTask;
    Future uploadFile({required String productId}) async {
      final storagereference = FirebaseStorage.instance.ref();

      for (int i = 0; i < images.length; i++) {
        final path = 'files/${firebaseUser.uid}/$productId/$i';
        final ref = storagereference.child(path);
        uploadTask = ref.putFile(images[i]);
        final snapshot = await uploadTask!.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrls.add(downloadUrl);
        print("the url is ${downloadUrl}");
        if (i >= images.length) {
          break;
        }
      }
    }

    return Scaffold(
        body: SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor:
            Colors.white, // const Color.fromARGB(255, 232, 240, 236),
        //backgroundColor: Colors.grey[300],
        body: isloading
            ? Center(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Uploading Product",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(
                        color: GlobalVariables.selectedNavBarColor),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add Product",
                                    style: TextStyle(
                                        // shadows: [
                                        //   Shadow(
                                        //       color:
                                        //           Color.fromARGB(255, 29, 201, 192),
                                        //       offset: Offset.zero,
                                        //       blurRadius: 4),
                                        // ],
                                        color:
                                            Color.fromARGB(255, 29, 201, 192),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          alignment: Alignment.center,
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.90,
                          decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              border: Border.all(
                                  color: GlobalVariables.secondaryColor),
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    GlobalVariables.secondaryColor,
                                    //  Color.fromARGB(255, 22, 100, 164),
                                    GlobalVariables.selectedNavBarColor
                                  ])),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Divider(
                                  color: GlobalVariables.selectedNavBarColor),
                              elevation: 0,
                              value: dropdownval,
                              iconSize: 20,
                              icon: Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: GlobalVariables.secondaryColor,
                              ),
                              items: livestocktypes.map(buildMenuItem).toList(),
                              onChanged: (newValue) async {
                                setState(() {
                                  dropdownval = newValue;
                                });
                              },
                            ),
                          ),
                        ),

                        MyTextFeild(
                            type: TextInputType.number,
                            hint: "i.e. 2, 2.5",
                            label: "LiveStock age",
                            controller: ageController),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: MyTextFeild(
                                    hint: "i.e. 20, 40 ",
                                    label: "Approx weight in Kg",
                                    icon: Icons.location_city,
                                    controller: approxLiveStockKgController,
                                    type: TextInputType.number),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15, right: 15),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color:
                                          GlobalVariables.selectedNavBarColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  height: 50,
                                  width: 55,
                                  child: Text(
                                    "KG",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ]),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Expanded(
                        //           child: MyTextFeild(
                        //               hint: "i.e. 0.5",
                        //               label: "Min buying Kg/person",
                        //               icon: Icons.location_city,
                        //               controller: minKgController,
                        //               type: TextInputType.number)),
                        //       Padding(
                        //         padding: EdgeInsets.only(top: 15, right: 15),
                        //         child: Container(
                        //           alignment: Alignment.center,
                        //           decoration: BoxDecoration(
                        //               color: GlobalVariables.selectedNavBarColor,
                        //               borderRadius: BorderRadius.circular(12)),
                        //           height: 50,
                        //           width: 55,
                        //           child: Text(
                        //             "KG",
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         ),
                        //       )
                        //     ]),
                        MyTextFeild(
                            hint: "Enter Bought Price",
                            label: "Bought Price",
                            icon: Icons.location_city,
                            controller: boughtPriceController,
                            type: TextInputType.number),
                        MyTextFeild(
                            hint: "Enter bought Owner Ph.no",
                            label: "Bought Owner Ph.no",
                            icon: Icons.phone_outlined,
                            controller: boughtOwnerPhoneController,
                            type: TextInputType.number),
                        MyTextFeild(
                            hint: "Enter bought OwnerName",
                            label: "Bought OwnerName",
                            icon: Icons.person_outline,
                            controller: boughtOwnerNameController,
                            type: TextInputType.name),
                        MyTextFeild(
                            hint: "Enter bought OwnerAddress",
                            label: "Bought OwnerAddress",
                            icon: Icons.person_outline,
                            controller: boughtOwnerAddressController,
                            type: TextInputType.streetAddress),
                        MyTextFeild(
                            hint: "Enter Quoted price in Rs",
                            label: "Price Quoted",
                            icon: Icons.money,
                            controller: priceQuotedController,
                            type: TextInputType.number),
                        MyTextFeild(
                            hint: "Enter the descritpion",
                            label: "Description",
                            icon: Icons.time_to_leave,
                            controller: descriptionController,
                            type: TextInputType.text),
                        MyTextFeild(
                            hint: "Enter highlighted description",
                            label: "Highlighted Description",
                            icon: Icons.time_to_leave,
                            controller: highlightedDescriptionController,
                            type: TextInputType.text),
                        MyTextFeild(
                            hint: "Enter Deadline Paytime",
                            label: "Deadline Paytime",
                            icon: Icons.time_to_leave,
                            controller: deadlinePayTimeController,
                            type: TextInputType.text),
                        MyTextFeild(
                            hint: "Enter Cattle ID",
                            label: "Cattle ID",
                            icon: Icons.perm_identity,
                            controller: cattleIdNoController,
                            type: TextInputType.number),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: GlobalVariables.secondaryColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'IS Advance Payed ?',
                                  style: TextStyle(
                                      color: GlobalVariables.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Switch(
                                  value: isAdvanced,
                                  onChanged: (value) {
                                    setState(() {
                                      isAdvanced = value;
                                      print(isAdvanced);
                                    });
                                  },
                                  activeTrackColor:
                                      GlobalVariables.secondaryColor,
                                  activeColor:
                                      GlobalVariables.selectedNavBarColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: GlobalVariables.secondaryColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'IS Full Amount Payed ?',
                                  style: TextStyle(
                                      color: GlobalVariables.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Switch(
                                  value: isFullyPaid,
                                  onChanged: (value) {
                                    setState(() {
                                      isFullyPaid = value;
                                      print(isFullyPaid);
                                    });
                                  },
                                  activeTrackColor:
                                      GlobalVariables.secondaryColor,
                                  activeColor:
                                      GlobalVariables.selectedNavBarColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: GlobalVariables.secondaryColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'IS Sold ?',
                                  style: TextStyle(
                                      color: GlobalVariables.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Switch(
                                  value: isSold,
                                  onChanged: (value) {
                                    setState(() {
                                      isSold = value;
                                      print(isSold);
                                    });
                                  },
                                  activeTrackColor:
                                      GlobalVariables.secondaryColor,
                                  activeColor:
                                      GlobalVariables.selectedNavBarColor,
                                ),
                              ],
                            ),
                          ),
                        ),

                        isSold
                            ? Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: MyTextFeild(
                                                type: TextInputType.number,
                                                hint: "Sold Price",
                                                label: "Enter Sold Price",
                                                controller:
                                                    soldPriceController)),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, right: 15),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: GlobalVariables
                                                    .selectedNavBarColor,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            height: 50,
                                            width: 55,
                                            child: const Text(
                                              "Rs",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('Delivery Date ',
                                          style: TextStyle(
                                              color: GlobalVariables
                                                  .secondaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          datepic(context);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                  color: GlobalVariables
                                                      .selectedNavBarColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: GlobalVariables
                                                        .selectedNavBarColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                height: 50,
                                                width: 55,
                                                child: const Icon(
                                                  Icons.alarm,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  ' ${date.day}/ ${date.month}/ ${date.year} ',
                                                  style: TextStyle(
                                                      color: GlobalVariables
                                                          .selectedNavBarColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 15.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color:
                                                GlobalVariables.secondaryColor,
                                            style: BorderStyle.solid,
                                            width: 2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'IS OnSpotDelivery ?',
                                            style: TextStyle(
                                                color: GlobalVariables
                                                    .secondaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Switch(
                                            value: isOnSpotDelivery,
                                            onChanged: (value) {
                                              setState(() {
                                                isOnSpotDelivery = value;
                                                print(isOnSpotDelivery);
                                              });
                                            },
                                            activeTrackColor:
                                                GlobalVariables.secondaryColor,
                                            activeColor: GlobalVariables
                                                .selectedNavBarColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, top: 15.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color:
                                                GlobalVariables.secondaryColor,
                                            style: BorderStyle.solid,
                                            width: 2),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'IS ButcherNeeded ?',
                                            style: TextStyle(
                                                color: GlobalVariables
                                                    .secondaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Switch(
                                            value: isButcherNeeded,
                                            onChanged: (value) {
                                              setState(() {
                                                isButcherNeeded = value;
                                                print(isButcherNeeded);
                                              });
                                            },
                                            activeTrackColor:
                                                GlobalVariables.secondaryColor,
                                            activeColor: GlobalVariables
                                                .selectedNavBarColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 15.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: GlobalVariables.secondaryColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'IS Delivered ?',
                                  style: TextStyle(
                                      color: GlobalVariables.secondaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Switch(
                                  value: isDelivered,
                                  onChanged: (value) {
                                    setState(() {
                                      isDelivered = value;
                                      print(isDelivered);
                                    });
                                  },
                                  activeTrackColor:
                                      GlobalVariables.secondaryColor,
                                  activeColor:
                                      GlobalVariables.selectedNavBarColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // isHavingStock
                        //     ? Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //             Expanded(
                        //                 child: MyTextFeild(
                        //                     type: TextInputType.number,
                        //                     hint: "Stock quantity",
                        //                     label: "Stocks In KG",
                        //                     controller: stockInKgController)),
                        //             Padding(
                        //               padding:
                        //                   const EdgeInsets.only(top: 15, right: 15),
                        //               child: Container(
                        //                 alignment: Alignment.center,
                        //                 decoration: BoxDecoration(
                        //                     color:
                        //                         GlobalVariables.selectedNavBarColor,
                        //                     borderRadius: BorderRadius.circular(12)),
                        //                 height: 50,
                        //                 width: 55,
                        //                 child: const Text(
                        //                   "KG",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 18,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //             )
                        //           ])
                        //     : Container(),
                        // Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       Expanded(
                        //           child: MyTextFeild(
                        //               type: TextInputType.number,
                        //               hint: "Enter your price",
                        //               label: "Price/KG",
                        //               controller: pricePerKgController)),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 15, right: 15),
                        //         child: Container(
                        //           alignment: Alignment.center,
                        //           decoration: BoxDecoration(
                        //               color: GlobalVariables.selectedNavBarColor,
                        //               borderRadius: BorderRadius.circular(12)),
                        //           height: 50,
                        //           width: 55,
                        //           child: const Text(
                        //             "KG",
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //         ),
                        //       )
                        //     ]),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       left: 15.0, right: 15.0, top: 15.0),
                        //   child: Container(
                        //     padding: const EdgeInsets.all(8),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(15),
                        //       border: Border.all(
                        //           color: GlobalVariables.secondaryColor,
                        //           style: BorderStyle.solid,
                        //           width: 2),
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               'Will you offer discount?',
                        //               style: TextStyle(
                        //                   color: GlobalVariables.secondaryColor,
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //             Switch(
                        //               value: isDiscountable,
                        //               onChanged: (value) {
                        //                 setState(() {
                        //                   isDiscountable = value;
                        //                   print(isDiscountable);
                        //                 });
                        //               },
                        //               activeTrackColor:
                        //                   GlobalVariables.secondaryColor,
                        //               activeColor:
                        //                   GlobalVariables.selectedNavBarColor,
                        //             ),
                        //           ],
                        //         ),
                        //         isDiscountable
                        //             ? const Padding(
                        //                 padding: EdgeInsets.all(3.0),
                        //                 child: Text(
                        //                   'Note: The dicount amount will be deducted from the original price',
                        //                   style: TextStyle(
                        //                       color: Colors.red,
                        //                       fontSize: 15,
                        //                       fontWeight: FontWeight.w400),
                        //                 ),
                        //               )
                        //             : Container(),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // isDiscountable
                        //     ? Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //         children: [
                        //             Expanded(
                        //                 child: MyTextFeild(
                        //                     type: TextInputType.number,
                        //                     hint: "i.e.  2 %, 5% ..",
                        //                     label: "Discount Percentage",
                        //                     controller:
                        //                         discountInPercentageController)),
                        //             Padding(
                        //               padding:
                        //                   const EdgeInsets.only(top: 15, right: 15),
                        //               child: Container(
                        //                 alignment: Alignment.center,
                        //                 decoration: BoxDecoration(
                        //                     color:
                        //                         GlobalVariables.selectedNavBarColor,
                        //                     borderRadius: BorderRadius.circular(12)),
                        //                 height: 50,
                        //                 width: 55,
                        //                 child: const Text(
                        //                   "%",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontSize: 18,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //             )
                        //           ])
                        //     : Container(),
                        const SizedBox(
                          height: 40,
                        ),
                        images.isNotEmpty
                            ? Column(
                                children: [
                                  GestureDetector(
                                    onTap: addMoreImages,
                                    child: CarouselSlider(
                                      items: images.map(
                                        (i) {
                                          return Builder(
                                            builder: (BuildContext context) =>
                                                Column(
                                              children: [
                                                Image.file(
                                                  i,
                                                  fit: BoxFit.cover,
                                                  height: 200,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                ),
                                                Center(
                                                  child: IconButton(
                                                      color: Colors.blue,
                                                      onPressed: () {
                                                        images.remove(i);
                                                        setState(() {});
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          // reverse: true,
                                          viewportFraction: 0.6,
                                          height: 300,
                                          aspectRatio: 1 / 2),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                        backgroundColor: GlobalVariables
                                            .selectedNavBarColor),
                                    onPressed: () async {
                                      images = [];
                                      imageUrls = [];
                                      setState(() {});
                                    },
                                    child: Text("Remove all images"),
                                  )
                                ],
                              )
                            : GestureDetector(
                                onTap: selectImages,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  dashPattern: const [10, 4],
                                  strokeCap: StrokeCap.round,
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.folder_open,
                                          size: 40,
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          'Select Product Images',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor:
                                    GlobalVariables.selectedNavBarColor),
                            onPressed: () async {
                              // MeatSellerService meatSellerService =
                              //     MeatSellerService(user: firebaseUser!);

                              if (formGlobalKey.currentState!.validate()) {
                                formGlobalKey.currentState!.save();
                                setState(() {
                                  isloading = true;
                                });
                                const uid = Uuid();
                                final productUid = uid.v4();

                                uploadFile(productId: productUid).then((value) {
                                  LiveStockDetails liveStockDetails =
                                      LiveStockDetails(
                                    productId: productUid,
                                    age: ageController.text,
                                    liveStockType: dropdownval,
                                    approxLiveStockKg:
                                        approxLiveStockKgController.text,
                                    boughtPrice:
                                        int.parse(boughtPriceController.text),
                                    boughtOwnerPhone:
                                        boughtOwnerPhoneController.text,
                                    boughtOwnerName:
                                        boughtOwnerNameController.text,
                                    boughtOwnerAddress:
                                        boughtOwnerAddressController.text,
                                    soldPrice: isSold
                                        ? int.parse(soldPriceController.text)
                                        : 0,
                                    priceQuoted:
                                        int.parse(priceQuotedController.text),
                                    isFullyPaid: isFullyPaid,
                                    isAdvanced: isAdvanced,
                                    deadlinePayTime:
                                        deadlinePayTimeController.text,
                                    buyerId: "",
                                    orderId: "",
                                    deliveryDateAndTime: isSold
                                        ? DateFormat.yMMMEd().format(date)
                                        : '',
                                    deliveryLocation: DeliveryLocation(
                                        address: "",
                                        coordinates: [],
                                        pincode: ""),
                                    isDelivered: isDelivered,
                                    images: imageUrls,
                                    isSold: isSold,
                                    description: descriptionController.text,
                                    highlightedDescription:
                                        highlightedDescriptionController.text,
                                    postedAt:
                                        Timestamp.fromDate(DateTime.now()),
                                    isOnSpotDelivery: isOnSpotDelivery,
                                    isbutcherNeeded: isButcherNeeded,
                                    cattleIdNo:
                                        int.parse(cattleIdNoController.text),
                                    liveStockSellerId: firebaseUser.uid,
                                  );

                                  LocalAreaAdminService localAreaAdminService =
                                      LocalAreaAdminService(user: firebaseUser);

                                  localAreaAdminService
                                      .addNewLiveStock(context,
                                          data: liveStockDetails,
                                          productId: productUid)
                                      .then((value) async {
                                    setState(() {
                                      isloading = false;
                                    });
                                    Navigator.pushReplacementNamed(
                                        context, MainHomePage.route);
                                  }).then((value) => showSnackBar(context,
                                          "Product Posted Successfully"));
                                });
                              }
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            )),
                        const SizedBox(
                          height: 300,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    ));
  }
}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1),
        //  textAlign: TextAlign.center,
      ));
}


/*   MeatSellerService meatSellerService =
                                  MeatSellerService(user: firebaseUser);

                              if (formGlobalKey.currentState!.validate()) {
                                formGlobalKey.currentState!.save();
                                setState(() {
                                  isloading = true;
                                });
                                uploadFile().then((value) async {
                                  const uid = Uuid();
                                  final productUid = uid.v4();
                                  Product product = Product(
                                      productId: productUid.toString(),
                                      categoryName: categoryNameController.text,
                                      productName: productNameController.text,
                                      maxKg: int.parse(maxKgController.text),
                                      minKg: double.parse(minKgController.text),
                                      maxKgLimitPerDay:
                                          int.parse(maxKgController.text),
                                      description: descriptionController.text,
                                      highlightedDescription:
                                          highlightedDescriptionController.text,
                                      images: imageUrls,
                                      isHavingStock: isHavingStock,
                                      stockInKg:
                                          int.parse(stockInKgController.text),
                                      pricePerKg:
                                          int.parse(pricePerKgController.text),
                                      isVerified: false,
                                      buyerId: [],
                                      isDiscountable: isDiscountable,
                                      discountInPercentage: int.parse(
                                          discountInPercentageController.text),
                                      ratings: 0,
                                      sellerId: firebaseUser.uid);

                                  await meatSellerService
                                      .addNewProduct(context,
                                          data: product.toMap(),
                                          orderId: productUid.toString())
                                      .then((value) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    Navigator.pushReplacementNamed(
                                        context, MainHomePage.route);
                                  }).then((value) => showSnackBar(context,
                                          "Product Posted Successfully"));*/