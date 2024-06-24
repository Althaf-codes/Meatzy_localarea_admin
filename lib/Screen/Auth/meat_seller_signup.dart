import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/Global_Variables.dart';
import '../../Service/firebase_auth_service.dart';
import '../../Widget/gradient_icon_widget.dart';
import '../Details/local_area_admin_details_screen.dart';

class MeatSellerSignUpScreen extends StatefulWidget {
  Function toggleView;
  MeatSellerSignUpScreen({Key? key, required this.toggleView})
      : super(key: key);

  @override
  State<MeatSellerSignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<MeatSellerSignUpScreen> {
  final TextEditingController phoneNumbercontroller = TextEditingController();

  bool isObscure = true;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    phoneNumbercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  //   TextField(controller: usernamecontroller),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.30,
                  //   width: MediaQuery.of(context).size.width * 0.90,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(12), color: pinkcolor),
                  // ),
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
                              "Hello !,",
                              style: TextStyle(
                                  // shadows: [
                                  //   Shadow(
                                  //       color:
                                  //           Color.fromARGB(255, 29, 201, 192),
                                  //       offset: Offset.zero,
                                  //       blurRadius: 4),
                                  // ],
                                  color: Color.fromARGB(255, 29, 201, 192),
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
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 15.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(boxShadow: [
                  //       BoxShadow(
                  //           blurRadius: 10,
                  //           spreadRadius: 7,
                  //           offset: Offset(1, 10),
                  //           color: Colors.grey.withOpacity(0.2))
                  //     ]),
                  //     child: TextFormField(
                  //       cursorColor: const Color.fromARGB(255, 29, 201, 192),
                  //       decoration: InputDecoration(
                  //           labelStyle: const TextStyle(
                  //               color: Color.fromARGB(255, 29, 201, 192)),
                  //           hintText: 'Enter your name',
                  //           labelText: 'Username',
                  //           enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(20),
                  //               borderSide: BorderSide.none),
                  //           focusedErrorBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color: Colors.red,
                  //                 style: BorderStyle.solid,
                  //                 width: 2),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color:
                  //                     const Color.fromARGB(255, 29, 201, 192),
                  //                 style: BorderStyle.solid,
                  //                 width: 1),
                  //           ),
                  //           focusColor: Colors.white,
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color: Colors.transparent,
                  //                 style: BorderStyle.solid,
                  //                 width: 5),
                  //           ),
                  //           prefixIcon: IconButton(
                  //             icon: const Icon(
                  //               Icons.person,
                  //               color: const Color.fromARGB(255, 29, 201, 192),
                  //             ),
                  //             onPressed: () {},
                  //           ),
                  //           fillColor: Colors.white,
                  //           filled: true),
                  //       controller: usernamecontroller,
                  //       validator: (name) {
                  //         if (name != null && name.length < 5)
                  //           return "The username should have atleast 5 characters ";
                  //         else if (name!.length >= 5) {
                  //           return null;
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
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
                              hintText: 'Enter your PhoneNumber',
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
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 15.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(boxShadow: [
                  //       BoxShadow(
                  //           blurRadius: 10,
                  //           spreadRadius: 7,
                  //           offset: Offset(1, 10),
                  //           color: Colors.grey.withOpacity(0.2))
                  //     ]),
                  //     child: TextFormField(
                  //       cursorColor: const Color.fromARGB(255, 29, 201, 192),
                  //       decoration: InputDecoration(
                  //           labelStyle: const TextStyle(
                  //               color: const Color.fromARGB(255, 29, 201, 192)),
                  //           hintText: 'Enter your Email',
                  //           labelText: 'Email',
                  //           enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(20),
                  //               borderSide: BorderSide.none),
                  //           focusedErrorBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color: Colors.red,
                  //                 style: BorderStyle.solid,
                  //                 width: 2),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color:
                  //                     const Color.fromARGB(255, 29, 201, 192),
                  //                 style: BorderStyle.solid,
                  //                 width: 1),
                  //           ),
                  //           focusColor: Colors.white,
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color: Colors.transparent,
                  //                 style: BorderStyle.solid,
                  //                 width: 5),
                  //           ),
                  //           prefixIconColor:
                  //               const Color.fromARGB(255, 29, 201, 192),
                  //           prefixIcon: IconButton(
                  //             icon: const Icon(
                  //               Icons.email,
                  //               color: Color.fromARGB(255, 29, 201, 192),
                  //             ),
                  //             onPressed: () {},
                  //           ),
                  //           fillColor: Colors.white,
                  //           filled: true),
                  //       controller: emailcontroller,
                  //       keyboardType: TextInputType.emailAddress,
                  //       validator: (email) {
                  //         if (email!.isEmpty) {
                  //           return "This Feild is required";
                  //         } else if (!RegExp(
                  //                 r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  //             .hasMatch(email.toString())) {
                  //           return "Enter a valid email address";
                  //         } else {
                  //           return null;
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 15.0, right: 15.0, top: 15.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(boxShadow: [
                  //       BoxShadow(
                  //           blurRadius: 10,
                  //           spreadRadius: 7,
                  //           offset: Offset(1, 10),
                  //           color: Colors.grey.withOpacity(0.2))
                  //     ]),
                  //     child: TextFormField(
                  //       cursorColor: const Color.fromARGB(255, 29, 201, 192),
                  //       decoration: InputDecoration(
                  //           labelStyle: const TextStyle(
                  //               color: const Color.fromARGB(255, 29, 201, 192)),
                  //           hintText: 'Enter your password',
                  //           labelText: 'Password',
                  //           enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(20),
                  //               borderSide: BorderSide.none),
                  //           focusedErrorBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color: Colors.red,
                  //                 style: BorderStyle.solid,
                  //                 width: 2),
                  //           ),
                  //           focusedBorder: OutlineInputBorder(
                  //             gapPadding: 10,
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color:
                  //                     const Color.fromARGB(255, 29, 201, 192),
                  //                 style: BorderStyle.solid,
                  //                 width: 1),
                  //           ),
                  //           focusColor: Colors.white,
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //             borderSide: const BorderSide(
                  //                 color: Colors.transparent,
                  //                 style: BorderStyle.solid,
                  //                 width: 5),
                  //           ),
                  //           prefixIconColor:
                  //               const Color.fromARGB(255, 29, 201, 192),
                  //           prefixIcon: IconButton(
                  //             icon: const Icon(
                  //               Icons.lock,
                  //               color: Color.fromARGB(255, 29, 201, 192),
                  //             ),
                  //             onPressed: () {},
                  //           ),
                  //           suffixIcon: IconButton(
                  //             icon: Icon(
                  //               isObscure
                  //                   ? Icons.visibility_off_outlined
                  //                   : Icons.remove_red_eye,
                  //               color: const Color.fromARGB(255, 29, 201, 192),
                  //             ),
                  //             onPressed: () {
                  //               setState(() {
                  //                 isObscure = isObscure == true ? false : true;
                  //               });
                  //             },
                  //           ),
                  //           fillColor: Colors.white,
                  //           filled: true),
                  //       controller: passwordcontroller,
                  //       obscureText: isObscure ? true : false,
                  //       validator: (password) {
                  //         if (password != null && password.length >= 5) {
                  //           return null;
                  //         } else {
                  //           return "password must atleast have 5 character";
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),

                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.70,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary:   Color.fromARGB(255, 29, 201, 192),
                  //           shadowColor: darkbluecolor,
                  //           shape: StadiumBorder(side: BorderSide.none)),
                  //       onPressed: () {},
                  //       child: Text("Sign in with Google")),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.70,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary:   Color.fromARGB(255, 29, 201, 192),
                  //           shadowColor: darkbluecolor,
                  //           shape: StadiumBorder(side: BorderSide.none)),
                  //       onPressed: () {},
                  //       child: Text("Sign in with FaceBook")),
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.70,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary:   Color.fromARGB(255, 29, 201, 192),
                  //           shadowColor: darkbluecolor,
                  //           shape: StadiumBorder(side: BorderSide.none)),
                  //       onPressed: () {},
                  //       child: Text("Sign in with Github")),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  GestureDetector(
                    onTap: () async {
                      await context
                          .read<FirebaseAuthMethods>()
                          .signInWithGoogle(context)
                          .then((value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) {
                          return LocalAreaAdminDetailsScreen();
                        })));
                      });
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Color.fromARGB(255, 29, 201, 192))),
                      child: Row(
                        children: [
                          const GradientIcon(
                            icon: FontAwesomeIcons.google,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Sign Up with Google",
                            style: TextStyle(
                                color: GlobalVariables.selectedNavBarColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Builder(builder: (context) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                GlobalVariables.selectedNavBarColor),
                        onPressed: () async {
                          if (formGlobalKey.currentState!.validate()) {
                            formGlobalKey.currentState!.save();
                            // final prefs = await SharedPreferences.getInstance();
                            // await prefs.setString("x-phnNum",
                            //     phoneNumbercontroller.text.toString());
                            // await prefs.setString("x-userName",
                            //     usernamecontroller.text.toString());
                            // final testName =
                            //     await prefs.getString("x-userName");
                            // final testphnum =
                            //     await prefs.getString("x-phoneNumber");
                            // print(
                            //     'testName id ${testName}, testphnum is ${testphnum}');

                            // print("The validation finished Successfully");
                            // print(
                            //     "the phnNum is ${phoneNumbercontroller.text.toString()}");
                            // print(
                            //     "the phnNum is ${usernamecontroller.text.toString()}");
                            // final args = LogInArguments(
                            //     userName: usernamecontroller.text.toString(),
                            //     phnNum: phoneNumbercontroller.text.toString());

                            await context
                                .read<FirebaseAuthMethods>()
                                .phoneSignIn(
                                  context,
                                  phoneNumber: phoneNumbercontroller.text,
                                )
                                .then((value) {
                              print("the value is ${value}");
                              if (value == true) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return LocalAreaAdminDetailsScreen();
                                })));
                              }
                            });
                            // .then((value) => context
                            //     .read<FirebaseAuthMethods>()
                            //     .signUpWithEmail(
                            //         email: emailcontroller.text,
                            //         password: passwordcontroller.text,
                            //         context: context));
                            // print('the is verified is $isVerified');
                            // if (isVerified == false) {
                            //   showSnackBar(
                            //       context, 'Phone authentication failed');
                            // }
                            // if (isVerified == true) {
                            //   print(
                            //       "The phone validation finished Successfully");

                            //
                            // }
                          }
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ));
                  }),

                  // Container(
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
                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.70,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary: Color.fromARGB(255, 29, 201, 192),
                  //           shadowColor: GlobalVariables.selectedNavBarColor,
                  //           shape: StadiumBorder(side: BorderSide.none)),
                  //       onPressed: () {},
                  //       child: Text("Sign in with FaceBook")),
                  // ),

                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.70,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary: Color.fromARGB(255, 29, 201, 192),
                  //           shadowColor: GlobalVariables.selectedNavBarColor,
                  //           shape: StadiumBorder(side: BorderSide.none)),
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, PhoneSignInScreen.route);
                  //       },
                  //       child: Text("Sign in with Phone Number")),
                  // ),

                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          wordSpacing: 2,
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
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
                          //         builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 29, 201, 192)),
                        ),
                      )
                    ],
                  )

                  // TextField(
                  //   controller: passwordcontroller,
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
