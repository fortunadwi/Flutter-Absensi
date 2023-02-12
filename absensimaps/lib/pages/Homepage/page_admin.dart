// ignore_for_file: unused_local_variable

import 'package:absensimaps/pages/Homepage/controller/BottomBar.dart';
import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import 'controller/home_controller.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class PageAdmin extends StatelessWidget {
  const PageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final pageC = Get.find<PageIndexController>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(218, 220, 255, 1),
      // Bottom Bar

      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: streamUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            Map<String, dynamic> user = snapshot.data!.data()!;

            return Stack(
              children: [
                ClipPath(
                  clipper: ClipPathClass(),
                  child: Container(
                    height: 250,
                    width: Get.width,
                    color: const Color.fromRGBO(143, 148, 251, 1),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48.0, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Hai, ",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                                children: [
                                  TextSpan(
                                      text: "${user['nama']}",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "${user['role']} ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                children: [
                                  TextSpan(
                                      text: "${user['job']}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: "",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                children: [
                                  TextSpan(
                                      text: "${user['address']}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ],
                      ),
                      //
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                // Container Divider Tengah
                Padding(
                  padding: EdgeInsets.only(top: 240),
                  child: Container(
                    width: Get.height * 0.7,
                    height: Get.height * 0.7,
                    color: Color.fromRGBO(218, 220, 255, 1),
                    child: Text(
                      textAlign: TextAlign.center,
                      "DATA SISWA",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: Expanded(
                    child: Divider(
                      height: Get.height * 0.618,
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 222.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.39,
                    child: Expanded(
                      child: Divider(
                        height: Get.height * 0.618,
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // Container Body Admin
                Padding(
                  padding: const EdgeInsets.only(top: 238.0),
                  child: StreamBuilder(
                    builder: (context, snapAll) {
                      if (snapAll.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        // print(snapAll.data.docs[0].data());
                        return ListView.builder(
                          itemCount: snapAll.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> dataA =
                                snapAll.data!.docs[index].data();

                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                // color: const Color.fromRGBO(143, 148, 251, 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dataA['nama'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // Delete User
                                          FirebaseFirestore.instance
                                              .collection('mahasiswa')
                                              .doc(dataA['uid'])
                                              .delete();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                      // Text(
                                      //   dataA['role'],
                                      //   style: const TextStyle(
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ],
                                  ),
                                  Text(
                                    dataA['role'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 1),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    stream: streamAll(),
                  ),
                ),
                Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      openWhatsapp(
                          context: context,
                          number: '6288226906520',
                          text:
                              'Halo Kak, Saya Mengalami Kendala Pada Aplikasi Smart Presence');
                    },
                    child: Image.asset("assets/images/robot.png"),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Tidak dapat memuat database user"),
            );
          }
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        index: 0,
        onTap: (index) {
          BottomBarChange(index);
        },
        backgroundColor: const Color.fromRGBO(218, 220, 255, 1),
        color: const Color.fromRGBO(143, 148, 251, 1),
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.settings, size: 30),
        ],
      ),
    );
  }
}

void openWhatsapp(
    {required BuildContext context,
    required String text,
    required String number}) async {
  var whatsapp = '6288226906420'; //+92xx enter like this
  var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=$text";
  var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
  if (Platform.isAndroid) {
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(
        whatsappURlAndroid,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Whatsapp not installed")));
    }
  } else {
    // android , web
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Whatsapp not installed")));
    }
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
