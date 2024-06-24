import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:meatzy_localareaadmin/Model/local_area_admin_model.dart';

import 'package:provider/provider.dart';

import '../../Constants/Global_Variables.dart';
import '../../Utils/pick_image.dart';
import '../../Widget/textformfeild_widget.dart';
import 'localareaadmin_product_details_screen.dart';

//12.0852827 , 79.8901109
class LocalAreaAdminDetailsScreen extends StatefulWidget {
  LocalAreaAdminDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LocalAreaAdminDetailsScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LocalAreaAdminDetailsScreen> {
  final TextEditingController phoneNumbercontroller = TextEditingController();
  final TextEditingController localAreaAdminNamecontroller =
      TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController aadharNumbercontroller = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController areacontroller = TextEditingController();
  final TextEditingController areaUndercontroller = TextEditingController();
  final TextEditingController liveStockTypecontroller = TextEditingController();

  bool isObscure = true;
  final formGlobalKey = GlobalKey<FormState>();

  //Time Picker
  TimeOfDay openingingTime = TimeOfDay.now();

  TimeOfDay closingTime = TimeOfDay.now();
  List<File> images = [];
  List<String> imageUrls = [];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  // void timepic(BuildContext context, TimeOfDay time) async {
  //   TimeOfDay? newtime =
  //       await showTimePicker(context: context, initialTime: time);

  //   if (newtime == null) return;
  //   setState(() {
  //     time = newtime;
  //   });
  // }

  //Date picker

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
    super.dispose();

    phoneNumbercontroller.dispose();
    localAreaAdminNamecontroller.dispose();
    addresscontroller.dispose();
    aadharNumbercontroller.dispose();
    areaUndercontroller.dispose();
    dobcontroller.dispose();
  }

  Location location = Location();

  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    UploadTask? uploadTask;
    // Future uploadFile() async {
    //   final storagereference = FirebaseStorage.instance.ref();

    //   for (int i = 0; i < images.length; i++) {
    //     final path = 'files/${firebaseUser!.uid}/${images[0].path}';
    //     final ref = storagereference.child(path);
    //     uploadTask = ref.putFile(images[i]);
    //     final snapshot = await uploadTask!.whenComplete(() {});
    //     final downloadUrl = await snapshot.ref.getDownloadURL();
    //     imageUrls.add(downloadUrl);
    //     print("the url is ${downloadUrl}");
    //     if (i >= images.length) {
    //       break;
    //     }
    //   }
    // }

    return SafeArea(
      minimum: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor:
            Colors.white, // const Color.fromARGB(255, 232, 240, 236),
        //backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
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
                              "Tell us about you",
                              style: TextStyle(
                                  // shadows: [
                                  //   Shadow(
                                  //       color:
                                  //           Color.fromARGB(255, 29, 201, 192),
                                  //       offset: Offset.zero,
                                  //       blurRadius: 4),
                                  // ],
                                  color: Color.fromARGB(255, 29, 201, 192),
                                  fontSize: 22,
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 10),
                            color: Colors.grey.withOpacity(0.2)),
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(10, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                      child: TextFormField(
                        cursorColor: const Color.fromARGB(255, 29, 201, 192),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 29, 201, 192)),
                            hintText: 'Enter your name',
                            labelText: 'LocalAreaAdminname',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: GlobalVariables.secondaryColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: GlobalVariables.selectedNavBarColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  style: BorderStyle.solid,
                                  width: 5),
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.person,
                                color: const Color.fromARGB(255, 29, 201, 192),
                              ),
                              onPressed: () {},
                            ),
                            fillColor: Colors.white,
                            filled: true),
                        controller: localAreaAdminNamecontroller,
                        validator: (name) {
                          if (name != null && name.length < 5)
                            return "The username should have atleast 5 characters ";
                          else if (name!.length >= 5) {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  // MyTextFeild(
                  //     hint: "Enter your ShopName",
                  //     label: "ShopName",
                  //     icon: Icons.location_city,
                  //     controller: meatShopNamecontroller,
                  //     type: TextInputType.name),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1, 10),
                            color: Colors.grey.withOpacity(0.2)),
                        BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(10, 1),
                            color: Colors.grey.withOpacity(0.2))
                      ]),
                      child: TextFormField(
                          cursorColor: const Color.fromARGB(255, 29, 201, 192),
                          decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color:
                                      const Color.fromARGB(255, 29, 201, 192)),
                              hintText: 'Enter your Phone.No',
                              labelText: 'Phone.No',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: GlobalVariables.secondaryColor,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                gapPadding: 10,
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: GlobalVariables.selectedNavBarColor,
                                    style: BorderStyle.solid,
                                    width: 2),
                              ),
                              focusColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    style: BorderStyle.solid,
                                    width: 5),
                              ),
                              prefixIcon: IconButton(
                                icon: const Icon(
                                  Icons.phone,
                                  color:
                                      const Color.fromARGB(255, 29, 201, 192),
                                ),
                                onPressed: () {},
                              ),
                              fillColor: Colors.white,
                              filled: true),
                          controller: phoneNumbercontroller,
                          keyboardType: TextInputType.number,
                          validator: (phoneNumber) {
                            // final re = RegExp(
                            //     r'/(\+\d{1,3}\s?)?((\(\d{3}\)\s?)|(\d{3})(\s|-?))(\d{3}(\s|-?))(\d{4})(\s?(([E|e]xt[:|.|]?)|x|X)(\s?\d+))?/g');

                            // Iterable<RegExpMatch> hasMatch =
                            //     re.allMatches(phoneNumber.toString());
                            if (phoneNumber != null &&
                                phoneNumber.length < 10) {
                              return 'Enter a valid phonenumber ';
                            } else if (phoneNumber != null &&
                                phoneNumber.length >= 10) {
                              return null;
                            }
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        maxLines: 4,
                        cursorColor: const Color.fromARGB(255, 29, 201, 192),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: const Color.fromARGB(255, 29, 201, 192)),
                            hintText: 'Enter your Address',
                            labelText: 'Address',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: GlobalVariables.secondaryColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.red,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: GlobalVariables.selectedNavBarColor,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  style: BorderStyle.solid,
                                  width: 5),
                            ),
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.map,
                                color: Color.fromARGB(255, 29, 201, 192),
                              ),
                              onPressed: () {},
                            ),
                            fillColor: Colors.white,
                            filled: true),
                        controller: addresscontroller,
                        validator: (name) {
                          if (name != null && name.length < 5)
                            return "The Address should be atleast 1 line";
                          else if (name!.length >= 5) {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  MyTextFeild(
                      hint: "Enter your Aadhar.No",
                      label: "Aadhar.No",
                      icon: Icons.pin,
                      controller: aadharNumbercontroller,
                      type: TextInputType.number),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextFeild(
                      hint: "Enter your DOB",
                      label: "Date of Birth",
                      icon: Icons.calendar_month,
                      controller: dobcontroller,
                      type: TextInputType.number),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextFeild(
                      hint: "Enter Your Area",
                      label: "Area Name",
                      icon: Icons.location_pin,
                      controller: areacontroller,
                      type: TextInputType.streetAddress),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextFeild(
                      hint: "Enter areas under supply",
                      label: "Areas under supply",
                      icon: Icons.location_pin,
                      controller: areaUndercontroller,
                      type: TextInputType.multiline),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextFeild(
                      hint: "Enter livestock types",
                      label: "LiveStock Types",
                      icon: Icons.pin,
                      controller: liveStockTypecontroller,
                      type: TextInputType.text),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const Text('Shop Opening Time',
                  //         style: TextStyle(
                  //             color: GlobalVariables.secondaryColor,
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.bold)),
                  //     const SizedBox(
                  //       height: 10,
                  //     ),
                  //     InkWell(
                  //       onTap: () async {
                  //         TimeOfDay? newtime = await showTimePicker(
                  //             context: context, initialTime: openingingTime);

                  //         if (newtime == null) return;
                  //         setState(() {
                  //           openingingTime = newtime;
                  //         });
                  //       },
                  //       child: Container(
                  //         width: MediaQuery.of(context).size.width * 0.9,
                  //         height: 50,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(12),
                  //             border: Border.all(
                  //                 color: GlobalVariables.selectedNavBarColor)),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                   color: GlobalVariables.selectedNavBarColor,
                  //                   borderRadius: BorderRadius.circular(12)),
                  //               height: 50,
                  //               width: 55,
                  //               child: const Icon(
                  //                 Icons.alarm,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //                 ' ${openinghours} :$openingmin ${openingingTime.period.name.toUpperCase()}',
                  //                 style: TextStyle(
                  //                     color:
                  //                         GlobalVariables.selectedNavBarColor,
                  //                     fontSize: 15,
                  //                     fontWeight: FontWeight.bold)),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text('Shop Closing Time',
                  //         style: TextStyle(
                  //             color: GlobalVariables.secondaryColor,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.bold)),
                  //     const SizedBox(
                  //       height: 10,
                  //     ),
                  //     InkWell(
                  //       onTap: () async {
                  //         TimeOfDay? newtime = await showTimePicker(
                  //             context: context, initialTime: closingTime);

                  //         if (newtime == null) return;
                  //         setState(() {
                  //           closingTime = newtime;
                  //         });
                  //       },
                  //       child: Container(
                  //         width: MediaQuery.of(context).size.width * 0.9,
                  //         height: 50,
                  //         alignment: Alignment.center,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(12),
                  //             border: Border.all(
                  //                 color: GlobalVariables.selectedNavBarColor)),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                   color: GlobalVariables.selectedNavBarColor,
                  //                   borderRadius: BorderRadius.circular(12)),
                  //               height: 50,
                  //               width: 55,
                  //               child: const Icon(
                  //                 Icons.alarm,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 10,
                  //             ),
                  //             Text(
                  //                 '${closinghours}:$closingmin ${closingTime.period.name.toUpperCase()}',
                  //                 style: TextStyle(
                  //                     color:
                  //                         GlobalVariables.selectedNavBarColor,
                  //                     fontSize: 15,
                  //                     fontWeight: FontWeight.bold)),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // MyTextFeild(
                  //     icon: Icons.edit_calendar,
                  //     type: TextInputType.number,
                  //     hint: "No.of Open Days",
                  //     label: "No.of Open Days",
                  //     controller: noOfOpemDayscontroller),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // images.isNotEmpty
                  //     ? CarouselSlider(
                  //         items: images.map(
                  //           (i) {
                  //             return Builder(
                  //               builder: (BuildContext context) => Image.file(
                  //                 i,
                  //                 fit: BoxFit.cover,
                  //                 height: 200,
                  //               ),
                  //             );
                  //           },
                  //         ).toList(),
                  //         options: CarouselOptions(
                  //           viewportFraction: 1,
                  //           height: 200,
                  //         ),
                  //       )
                  //     : GestureDetector(
                  //         onTap: selectImages,
                  //         child: DottedBorder(
                  //           borderType: BorderType.RRect,
                  //           radius: const Radius.circular(10),
                  //           dashPattern: const [10, 4],
                  //           strokeCap: StrokeCap.round,
                  //           child: Container(
                  //             width: double.infinity,
                  //             height: 150,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 const Icon(
                  //                   Icons.folder_open,
                  //                   size: 40,
                  //                 ),
                  //                 const SizedBox(height: 15),
                  //                 Text(
                  //                   'Select Shop Images',
                  //                   style: TextStyle(
                  //                     fontSize: 15,
                  //                     color: Colors.grey.shade400,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 0.5,
                              MediaQuery.of(context).size.height * 0.05),
                          backgroundColor: GlobalVariables.selectedNavBarColor),
                      onPressed: () async {
                        location.enableBackgroundMode(enable: true);
                        var serviceEnabled = await location.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                          if (!serviceEnabled) {
                            return;
                          }
                        }

                        _permissionGranted = await location.hasPermission();
                        if (_permissionGranted == PermissionStatus.denied) {
                          _permissionGranted =
                              await location.requestPermission();
                          if (_permissionGranted != PermissionStatus.granted) {
                            return;
                          }
                        }

                        _locationData = await location.getLocation();
                        print(
                            "The location data is ${_locationData.latitude} , ${_locationData.longitude}}");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          Text(
                            "Get Location",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Builder(builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            ),
                            style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                                shape: StadiumBorder(),
                                backgroundColor:
                                    GlobalVariables.selectedNavBarColor),
                            onPressed: () async {
                              if (formGlobalKey.currentState!.validate()) {
                                //   _locationData.latitude
                                //     .toString()
                                //     .isNotEmpty &&
                                // _locationData.longitude
                                //     .toString()
                                //     .isNotEmpty
                                formGlobalKey.currentState!.save();

                                print("data retreived successfully ");
                                List<String> areas =
                                    areaUndercontroller.text.split(',');

                                // Map<String, dynamic> values = {
                                //   "name": localAreaAdminNamecontroller.text,
                                //   "phoneNo": phoneNumbercontroller.text,
                                //   "address": addresscontroller.text,
                                //   "aadharNumber": aadharNumbercontroller.text,
                                //   "dob": dobcontroller.text,
                                //   "area": areacontroller.text,
                                //   "areaUnderControl": areas,
                                //   "totalCounts": 0,
                                //   "soldLiveStockCount": 0,
                                //   "liveStockTypes": ""
                                // };

                                LocalAreaAdminModel localAreaAdminModel =
                                    LocalAreaAdminModel(
                                  name: localAreaAdminNamecontroller.text,
                                  id: firebaseUser!.uid,
                                  phoneNo: phoneNumbercontroller.text,
                                  address: addresscontroller.text,
                                  aadharNumber:
                                      int.parse(aadharNumbercontroller.text),
                                  dob: dobcontroller.text,
                                  area: areacontroller.text,
                                  areaUnderControl: areas,
                                  totalCounts: LiveStockCount(
                                      cattle: 0, sheep: 0, goat: 0, buffalo: 0),
                                  soldLiveStockCount: 0,
                                  liveStockTypes:
                                      liveStockTypecontroller.text.split(','),
                                  localAreaEmpCount: 0,
                                  feedStock: FeedStock(
                                      type1: "",
                                      type2: "",
                                      type3: "",
                                      type4: "",
                                      type5: ""),
                                  totalInvested: 0,
                                  totalReturn: 0,
                                  buyerId: [],
                                  totalOrders: 0,
                                  advancedCattle: 0,
                                  payedCattle: 0,
                                  location: LiveStockHubLocation(
                                    address: "",
                                    coordinates: [
                                      _locationData.latitude,
                                      _locationData.longitude
                                    ],
                                    pincode: '',
                                  ),
                                  notifications: [],
                                );

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            LocalAreaAdminProductDetailsScreen(
                                                localAreaAdminDetails:
                                                    localAreaAdminModel))));
                              }
                            },
                            label: const Text(
                              "Next",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
