import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Global_Variables.dart';
import '../../Service/firebase_auth_service.dart';

class LoginScreen extends StatefulWidget {
  Function toggleView;
  LoginScreen({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isObscure = true;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 232, 240, 236),
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
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Hello There,",
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color:
                                            Color.fromARGB(255, 29, 201, 192),
                                        offset: Offset.zero,
                                        blurRadius: 4),
                                  ],
                                  color: Color.fromARGB(255, 29, 201, 192),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Welcome Back !",
                              style: TextStyle(
                                  shadows: [
                                    Shadow(
                                        color:
                                            Color.fromARGB(255, 29, 201, 192),
                                        offset: Offset.zero,
                                        blurRadius: 4.0),
                                  ],
                                  color: Color.fromARGB(255, 29, 201, 192),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900),
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
                      decoration: const BoxDecoration(),
                      child: TextFormField(
                        cursorColor: const Color.fromARGB(255, 29, 201, 192),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: const Color.fromARGB(255, 29, 201, 192),
                            ),
                            hintText: 'Enter your phoneNumber',
                            labelText: 'PhoneNumber',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
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
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 29, 201, 192),
                                  style: BorderStyle.solid,
                                  width: 1),
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
                                color: const Color.fromARGB(255, 29, 201, 192),
                              ),
                              onPressed: () {},
                            ),
                            fillColor: Colors.white,
                            filled: true),
                        controller: phoneNumberController,
                        validator: (phoneNumber) {
                          // final re = RegExp(
                          //     r'/(\+\d{1,3}\s?)?((\(\d{3}\)\s?)|(\d{3})(\s|-?))(\d{3}(\s|-?))(\d{4})(\s?(([E|e]xt[:|.|]?)|x|X)(\s?\d+))?/g');

                          // Iterable<RegExpMatch> hasMatch =
                          //     re.allMatches(phoneNumber.toString());
                          if (phoneNumber != null && phoneNumber.length < 10) {
                            return 'Enter a valid phonenumber ';
                          } else if (phoneNumber != null &&
                              phoneNumber.length >= 10) {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15.0),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: TextFormField(
                        cursorColor: const Color.fromARGB(255, 29, 201, 192),
                        decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 29, 201, 192),
                            ),
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none),
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
                              borderSide: const BorderSide(
                                  color:
                                      const Color.fromARGB(255, 29, 201, 192),
                                  style: BorderStyle.solid,
                                  width: 1),
                            ),
                            focusColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  style: BorderStyle.solid,
                                  width: 5),
                            ),
                            prefixIconColor:
                                const Color.fromARGB(255, 29, 201, 192),
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 29, 201, 192),
                              ),
                              onPressed: () {},
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.remove_red_eye,
                                color: const Color.fromARGB(255, 29, 201, 192),
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscure = isObscure == true ? false : true;
                                });
                              },
                            ),
                            fillColor: Colors.white,
                            filled: true),
                        controller: passwordController,
                        obscureText: isObscure ? true : false,
                        validator: (password) {
                          if (password != null && password.length >= 5) {
                            return null;
                          } else {
                            return "password must atleast have 5 character";
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                color: Color.fromARGB(255, 29, 201, 192),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Builder(builder: (context) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: GlobalVariables.selectedNavBarColor),
                        onPressed: () async {
                          if (formGlobalKey.currentState!.validate()) {
                            formGlobalKey.currentState!.save();
                            final prefs = await SharedPreferences.getInstance();
                            // await prefs.setString("x-phnNum",
                            //     phoneNumbercontroller.text.toString());

                            // final testName =
                            //     await prefs.getString("x-userName");
                            // final testphnum = await prefs.getString("x-phnNum");
                            // print(
                            //     'testName id ${testName}, testphnum is ${testphnum}');

                            // print("The validation finished Successfully");
                            // print(
                            //     "the phnNum is ${phoneNumbercontroller.text.toString()}");

                            await context
                                .read<FirebaseAuthMethods>()
                                .loginWithEmail(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context);
                          }
                        },
                        child: const Text("Submit"));
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Divider(),
                      Text(
                        'OR',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w300),
                      ),
                      Divider()
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           shape: BoxShape.rectangle,
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(
                  //               color:
                  //                   const Color.fromARGB(255, 29, 201, 192))),
                  //       child: const GradientIcon(
                  //         icon: FontAwesomeIcons.google,
                  //         size: 30,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           shape: BoxShape.rectangle,
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(
                  //               color:
                  //                   const Color.fromARGB(255, 29, 201, 192))),
                  //       child: const GradientIcon(
                  //         icon: FontAwesomeIcons.phone,
                  //         size: 30,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     // Container(
                  //     //   padding: EdgeInsets.all(8),
                  //     //   decoration: BoxDecoration(
                  //     //       color: Colors.white,
                  //     //       shape: BoxShape.rectangle,
                  //     //       borderRadius: BorderRadius.circular(12),
                  //     //       border: Border.all(
                  //     //           color: Color.fromARGB(255, 29, 201, 192))),
                  //     //   child: const GradientIcon(
                  //     //     icon: FontAwesomeIcons.facebook,
                  //     //     size: 30,
                  //     //   ),
                  //     // ),
                  //     // const SizedBox(
                  //     //   width: 10,
                  //     // ),
                  //     // Container(
                  //     //   padding: EdgeInsets.all(8),
                  //     //   decoration: BoxDecoration(
                  //     //       color: Colors.white,
                  //     //       shape: BoxShape.rectangle,
                  //     //       borderRadius: BorderRadius.circular(12),
                  //     //       border: Border.all(
                  //     //           color: Color.fromARGB(255, 29, 201, 192))),
                  //     //   child: const GradientIcon(
                  //     //     icon: FontAwesomeIcons.github,
                  //     //     size: 30,
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  // // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.70,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary: Color.fromARGB(255, 29, 201, 192),
                  //           shadowColor: GlobalVariables.selectedNavBarColor,
                  //           shape: StadiumBorder(side: BorderSide.none)),
                  //       onPressed: () {},
                  //       child: Text("Sign in with Google")),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // // Container(
                  // //   height: 50,
                  // //   width: MediaQuery.of(context).size.width * 0.70,
                  // //   child: ElevatedButton(
                  // //       style: ElevatedButton.styleFrom(
                  // //           primary: Color.fromARGB(255, 29, 201, 192),
                  // //           shadowColor: GlobalVariables.selectedNavBarColor,
                  // //           shape: StadiumBorder(side: BorderSide.none)),
                  // //       onPressed: () {},
                  // //       child: Text("Sign in with FaceBook")),
                  // // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.70,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary: Color.fromARGB(255, 29, 201, 192),
                  //           shadowColor: GlobalVariables.selectedNavBarColor,
                  //           shape: StadiumBorder(side: BorderSide.none)),
                  //       onPressed: () {},
                  //       child: Text("Sign in with Phone Number")),
                  // ),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          widget.toggleView();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const SignUpScreen()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 29, 201, 192),
                          ),
                        ),
                      )
                    ],
                  ),

                  // TextField(
                  //   controller: passwordController,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
