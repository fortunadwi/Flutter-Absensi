// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace, unused_import

import 'package:absensimaps/controller/login_func.dart';
import 'package:absensimaps/pages/Homepage/controller/BottomBar.dart';
import 'package:absensimaps/pages/Homepage/controller/page_index_user.dart';
import 'package:absensimaps/pages/Sidebar%20Profile/Controller%20Profile/controller_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class ProfilePageUser extends StatelessWidget {
  final pageCUser = Get.put(PageIndexControllerUser());
  ProfilePageUser({super.key});

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
      // appBar: AppBar(
      //   title: Text("Page Profile"),
      //   backgroundColor: Colors.grey.shade900,
      //   centerTitle: true,
      // ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              Map<String, dynamic> user = snapshot.data!.data()!;
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3),
                          child: Initicon(
                            text: "${user['nama']}",
                            backgroundColor: Colors.green,
                            size: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${user['nama'].toString().toUpperCase()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${user['email']}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed('/updateProfileUser', arguments: user);
                    },
                    leading: const Icon(Icons.person),
                    title: const Text("Update Profile"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed('/changePasswordUser');
                    },
                    leading: const Icon(Icons.vpn_key),
                    title: const Text("Change Password"),
                  ),
                  if (user['role'] == "admin")
                    ListTile(
                      onTap: () {
                        Get.offNamed('/register');
                      },
                      leading: const Icon(Icons.person_add),
                      title: const Text("Add Mahasiswa"),
                    ),
                  ListTile(
                    onTap: () {
                      SignOut();
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("Tidak Dapat Memuat Data User"),
              );
            }
          }),

      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.slowMiddle,
        index: 2,
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
