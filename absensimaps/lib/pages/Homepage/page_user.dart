// ignore_for_file: unused_import, avoid_print, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, prefer_if_null_operators, unrelated_type_equality_checks, unnecessary_null_comparison, prefer_is_empty, unused_local_variable, sized_box_for_whitespace

import 'package:absensimaps/controller/login_func.dart';
import 'package:absensimaps/gak%20kepake/auth_page.dart';
import 'package:absensimaps/pages/Homepage/controller/BottomBar.dart';
import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:absensimaps/pages/Homepage/controller/page_index_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'controller/home_controller.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class PageUser extends StatelessWidget {
  final pageCUser = Get.put(PageIndexControllerUser());
  PageUser({super.key});

  // void signUserOut() {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openWhatsapp(
              context: context,
              number: '6288226906520',
              text:
                  'Halo Kak, Saya Mengalami Kendala Pada Aplikasi Smart Presence');
        },
        child: Image.asset("assets/images/robot.png"),
      ),
      backgroundColor: const Color.fromRGBO(218, 220, 255, 1),
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
            // String defaulImage =
            //     "https://ui-avatars.com/api/?name=${user['nama']}";

            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Container 1
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(3),
                        child: Initicon(
                          text: "${user['nama']}",
                          backgroundColor: Colors.green,
                          size: 60,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Welcome, ${user['nama']}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 200,
                            child: Text(user["address"] != null
                                ? "${user['address']}"
                                : "Belum ada lokasi"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(143, 148, 251, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        "${user['nama'].toString().toUpperCase()}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${user['nim']}",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${user['job']}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(143, 148, 251, 1),
                  ),
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: streamTodayAbsensi(),
                      builder: (context, snapToday) {
                        if (snapToday.connectionState ==
                            ConnectionState.waiting) {
                          //
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        Map<String, dynamic>? dataToday =
                            snapToday.data?.data();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text("Masuk"),
                                Text(dataToday?['Masuk'] == null
                                    ? "-"
                                    : "${DateFormat.jms().format(DateTime.parse(dataToday!['Masuk']['date']))}"),
                              ],
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.black,
                            ),
                            Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text("Keluar"),
                                Text(dataToday?['Keluar'] == null
                                    ? "-"
                                    : "${DateFormat.jms().format(DateTime.parse(dataToday!['Keluar']['date']))}"),
                              ],
                            )
                          ],
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Divider(
                //   color: Colors.black,
                //   thickness: 2,
                // ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "Last 5 Days",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed("/allAbsensi");
                        },
                        child: const Text("See more")),
                  ],
                ),
                const SizedBox(height: 10),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: streamLastAbsensi(),
                  builder: (context, snapAbsensi) {
                    if (snapAbsensi.connectionState ==
                        ConnectionState.waiting) {
                      //
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      //
                    }
                    if (snapAbsensi.data?.docs.length == 0 ||
                        snapAbsensi.data == null) {
                      //
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: Text("Belum Ada Riwayat Absensi"),
                        ),
                      );
                    }

                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapAbsensi.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              snapAbsensi.data!.docs[index].data();
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Material(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed("/detailAbsensi",
                                      arguments: data);
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(143, 148, 251, 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Masuk',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${DateFormat.yMMMEd().format(DateTime.parse(data['date']))}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Text(data['Masuk']?['date'] == null
                                          ? "-"
                                          : "${DateFormat.jms().format(DateTime.parse(data['Masuk']!['date']))}"),
                                      // Text(
                                      //     "${DateFormat.jms().format(DateTime.tryParse(data['Masuk']?['date']) ?? )}"),
                                      const SizedBox(height: 10),
                                      const Text(
                                        "Keluar",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(data['Keluar']?['date'] == null
                                          ? "-"
                                          : "${DateFormat.jms().format(DateTime.parse(data['Keluar']!['date']))}"),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                )
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
        animationCurve: Curves.slowMiddle,
        index: 0,
        onTap: (index) {
          BottomBarChangeUser(index);
        },
        backgroundColor: const Color.fromRGBO(218, 220, 255, 1),
        color: const Color.fromRGBO(143, 148, 251, 1),
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.fingerprint, size: 30),
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
