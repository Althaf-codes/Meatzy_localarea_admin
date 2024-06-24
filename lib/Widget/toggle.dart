import 'package:flutter/material.dart';

import '../Screen/Auth/meat_seller_sign_in.dart';
import '../Screen/Auth/meat_seller_signup.dart';

class Toggle extends StatefulWidget {
  const Toggle({Key? key}) : super(key: key);

  @override
  State<Toggle> createState() => _AuthState();

  static String _route = '/toggle';

  static get route => _route;
}

class _AuthState extends State<Toggle> {
  bool showSignIn = true;

  void toggleview() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return MeatSellerSignUpScreen(toggleView: toggleview);
    } else {
      return MeatSellerSignInPage(toggleView: toggleview);
    }
  }
}
