import 'package:flutter/cupertino.dart';

import '../Model/meat_seller_model.dart';

class MeatSellerProvider extends ChangeNotifier {
  MeatSellerModel _meatSellerModel = MeatSellerModel(
      shopimage: "",
      sellerName: "",
      contactNumber: 0,
      meatShopName: "",
      location: SellerLocation(
        address: "",
        coordinates: [],
        pincode: '',
      ),
      isNewMeatSeller: true,
      isActive: true,
      timings: Timings(
        closingTime: "",
        noOfOpenDays: 0,
        openingTime: '',
      ),
      products: [
        Product(
            productId: "",
            categoryName: "",
            productName: "",
            maxKg: 0,
            minKg: 0,
            maxKgLimitPerDay: 0,
            description: "",
            highlightedDescription: "",
            images: [""],
            isHavingStock: true,
            stockInKg: 0,
            pricePerKg: 0,
            isVerified: true,
            buyerId: [],
            isDiscountable: false,
            discountInPercentage: 0,
            ratings: 0,
            sellerId: "")
      ],
      orders: [
        SellerOrder(
            buyerId: "",
            deliveryDate: '',
            deliveryLocation: SellerLocation(
              address: "",
              coordinates: [],
              pincode: '',
            ),
            discountPercentage: 0,
            isDiscount: false,
            orderStatus: '',
            orderedDate: '',
            productId: '',
            quantityInKg: 0,
            image: '',
            price: 0,
            orderId: '')
      ],
      ratings: 0,
      notifications: []);

  MeatSellerModel get meatSellerModel => _meatSellerModel;

  void setMeatSeller(String meatSeller) {
    _meatSellerModel = MeatSellerModel.fromJson(meatSeller);
    notifyListeners();
  }

  void setUserFromModel(MeatSellerModel meatSellerModel) {
    _meatSellerModel = meatSellerModel;
    notifyListeners();
  }

  void addProductProvider({required Product product}) {
    _meatSellerModel.products!.add(product);
    notifyListeners();
  }

  void deleteProductProvider({required Product product, required int index}) {
    _meatSellerModel.products
        ?.removeWhere((element) => element.productId == index);
  }
}
