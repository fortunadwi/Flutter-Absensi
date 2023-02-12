// ignore_for_file: prefer_const_constructors_in_immutables

// import 'package:absensimaps/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../animation/FadeAnimation.dart';
import '../../controller/register_func.dart';

// Login Page Styling
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  // final TextEditingController namaController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();
  // final TextEditingController usernameController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    "REGISTER",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 280,
                  height: 270,
                  margin: const EdgeInsets.only(top: 30),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          opacity: 68.0,
                          fit: BoxFit.fill)),
                  // child: Stack(
                  //   children: <Widget>[
                  //     Positioned(
                  //       left: 30,
                  //       width: 80,
                  //       height: 200,
                  //       child: FadeAnimation(
                  //           1,
                  //           Container(
                  //             decoration: const BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image: AssetImage(
                  //                         'assets/images/light-1.png'))),
                  //           )),
                  //     ),
                  //     Positioned(
                  //       left: 140,
                  //       width: 80,
                  //       height: 150,
                  //       child: FadeAnimation(
                  //           1.3,
                  //           Container(
                  //             decoration: const BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image: AssetImage(
                  //                         'assets/images/light-2.png'))),
                  //           )),
                  //     ),
                  //     Positioned(
                  //       right: 40,
                  //       top: 40,
                  //       width: 80,
                  //       height: 150,
                  //       child: FadeAnimation(
                  //           1.5,
                  //           Container(
                  //             decoration: const BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image:
                  //                         AssetImage('assets/images/clock.png'))),
                  //           )),
                  //     ),
                  //     Positioned(
                  //       child: FadeAnimation(
                  //           1.6,
                  //           Container(
                  //             margin: const EdgeInsets.only(top: 50),
                  //             child: const Center(
                  //               child: Text(
                  //                 "Register",
                  //                 textAlign: TextAlign.center,
                  //                 style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontSize: 40,
                  //                     fontWeight: FontWeight.bold),
                  //               ),
                  //             ),
                  //           )),
                  //     )
                  //   ],
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: usernameR,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Input Your Username",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: emailR,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Input Your Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: passR,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Input Your Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      FadeAnimation(
                          2,
                          InkWell(
                            onTap: () async {
                              RegisterUser();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: const Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text("Have Account? "),
                          FadeAnimation(
                              1.5,
                              InkWell(
                                onTap: () {
                                  Get.offNamed("/landingPage");
                                  // Get.back();
                                },
                                child: const Text(
                                  "Back",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                      fontSize: 12),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

// End Of Login Page Styling