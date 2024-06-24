import 'package:flutter/material.dart';

String uri = 'http://localhost:8080';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216)
    ],
    stops: [0.5, 1.0],
  );

  static const shadowList = [
    BoxShadow(color: Colors.grey, blurRadius: 30, offset: Offset(0, 10))
  ];
  static const secondaryColor = const Color.fromARGB(255, 29, 201, 192);
  static const backgroundColor = Colors.white;
  static const greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    "https://expressmeatmart.com/wp-content/uploads/elementor/thumbs/Web-5-banner-min-ph9szgvus6aih1qfehwyh1ns9c3ay5huikc3ebi5mo.jpg",
    "https://lh5.googleusercontent.com/p/AF1QipMReynA1U_aPbNS22wGeKQd1MivN8cSKJON3LM",

    // 'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    // 'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    // 'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    // 'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    // 'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Pets',
      'image': 'assets/category/dog.png',
    },
    {
      'title': 'Farm Cattle',
      'image': 'assets/category/cow.png',
    },
    {
      'title': 'Meat',
      'image': 'assets/category/chicken-leg.png',
    },
    {
      'title': 'Feed',
      'image': 'assets/category/dog-food.png',
    },
    {
      'title': 'Accessories',
      'image': 'assets/category/collar.png',
    },
    {
      'title': 'Medicine',
      'image': 'assets/category/medicine.png',
    },
  ];

  // static List<PetImgName> allPet = [
  //   PetImgName(imgUrl: '', name: 'Dog'),
  //   PetImgName(imgUrl: '', name: 'Cattle'),
  //   PetImgName(imgUrl: '', name: 'Cow'),
  //   PetImgName(imgUrl: '', name: 'Rabbit'),
  //   PetImgName(imgUrl: '', name: 'Hamster'),
  //   PetImgName(imgUrl: '', name: 'Parrot'),
  //   PetImgName(imgUrl: '', name: 'Mouse'),
  //   PetImgName(imgUrl: '', name: 'Pigeon'),
  //   PetImgName(imgUrl: '', name: 'Fish'),
  //   PetImgName(imgUrl: '', name: 'Repiles'),
  //   PetImgName(imgUrl: '', name: 'Horse'),
  //   PetImgName(imgUrl: '', name: 'Donkey'),
  //   PetImgName(imgUrl: '', name: 'Others'),
  // ];
}
