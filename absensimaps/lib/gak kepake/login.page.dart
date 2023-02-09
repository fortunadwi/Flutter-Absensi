// // import 'dart:js';

// import 'package:absensimaps/pages/page_user.dart';
// import 'package:absensimaps/pages/register_page.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../animation/FadeAnimation.dart';

// // Login Page Styling
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => LoginPageState();
// }

// FirebaseAuth auth = FirebaseAuth.instance;

// class LoginPageState extends State<LoginPage> {
//   // final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // ignore: non_constant_identifier_names
//   void SignInUser() async {
//     // showDialog(
//     //     context: context,
//     //     builder: (context) {
//     //       return const Center(
//     //         child: CircularProgressIndicator(),
//     //       );
//     //     });
//     Navigator.pushNamed(context, 'pageAdmin');
//     // try {
//     //   UserCredential userCredential = await auth.signInWithEmailAndPassword(
//     //       email: emailController.text, password: passwordController.text);
//     //   if (userCredential.user != null) {
//     //     //
//     //     Navigator.pushNamed(context, 'pageAdmin');
//     //   }
//     // } on FirebaseAuthException catch (e) {
//     //   Navigator.pop(context);
//     //   if (e.code == 'user-not-found') {
//     //     showDialog(
//     //       context: context,
//     //       builder: (context) {
//     //         return const AlertDialog(
//     //           backgroundColor: Colors.red,
//     //         );
//     //       },
//     //     );
//     //   } else if (e.code == 'wrong-password') {
//     //     showDialog(
//     //       context: context,
//     //       builder: (context) {
//     //         return const AlertDialog(
//     //           backgroundColor: Colors.green,
//     //         );
//     //       },
//     //     );
//     //   }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: 400,
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('assets/images/background.png'),
//                         fit: BoxFit.fill)),
//                 child: Stack(
//                   children: <Widget>[
//                     Positioned(
//                       left: 30,
//                       width: 80,
//                       height: 200,
//                       child: FadeAnimation(
//                           1,
//                           Container(
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/light-1.png'))),
//                           )),
//                     ),
//                     Positioned(
//                       left: 140,
//                       width: 80,
//                       height: 150,
//                       child: FadeAnimation(
//                           1.3,
//                           Container(
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'assets/images/light-2.png'))),
//                           )),
//                     ),
//                     Positioned(
//                       right: 40,
//                       top: 40,
//                       width: 80,
//                       height: 150,
//                       child: FadeAnimation(
//                           1.5,
//                           Container(
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     image:
//                                         AssetImage('assets/images/clock.png'))),
//                           )),
//                     ),
//                     Positioned(
//                       child: FadeAnimation(
//                           1.6,
//                           Container(
//                             margin: const EdgeInsets.only(top: 50),
//                             child: const Center(
//                               child: Text(
//                                 "Login",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 40,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(30.0),
//                 child: Column(
//                   children: <Widget>[
//                     FadeAnimation(
//                         1.8,
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               // ignore: prefer_const_literals_to_create_immutables
//                               boxShadow: [
//                                 const BoxShadow(
//                                     color: Color.fromRGBO(143, 148, 251, .2),
//                                     blurRadius: 20.0,
//                                     offset: Offset(0, 10))
//                               ]),
//                           child: Column(
//                             children: <Widget>[
//                               Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                         bottom: BorderSide(
//                                             color: Colors.grey.shade100))),
//                                 child: TextField(
//                                   controller: emailController,
//                                   decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: "Email or Phone number",
//                                       hintStyle:
//                                           TextStyle(color: Colors.grey[400])),
//                                 ),
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: TextField(
//                                   obscureText: true,
//                                   controller: passwordController,
//                                   decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: "Password",
//                                       hintStyle:
//                                           TextStyle(color: Colors.grey[400])),
//                                 ),
//                               )
//                             ],
//                           ),
//                         )),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     FadeAnimation(
//                         2,
//                         InkWell(
//                           onTap: () async {
//                             SignInUser();
//                           },
//                           child: Container(
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 gradient: const LinearGradient(colors: [
//                                   Color.fromRGBO(143, 148, 251, 1),
//                                   Color.fromRGBO(143, 148, 251, .6),
//                                 ])),
//                             child: const Center(
//                               child: Text(
//                                 "Logins",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         )),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't Have Account? "),
//                         FadeAnimation(
//                             1.5,
//                             InkWell(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => RegisterPage(),
//                                 ));
//                               },
//                               child: const Text(
//                                 "Register Here",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(143, 148, 251, 1),
//                                     fontSize: 12),
//                               ),
//                             )),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }

// // End Of Login Page Styling
