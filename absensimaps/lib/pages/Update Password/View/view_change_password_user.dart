// ignore_for_file: use_key_in_widget_constructors

import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:absensimaps/pages/Update%20Password/Controller/controller_change_password.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import '../../Homepage/controller/BottomBar.dart';

class ChangePasswordViewUser extends StatelessWidget {
  final pageC = Get.find<PageIndexController>();
// class ChangePasswordView {
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
      //   title: const Text("Ganti Password"),
      //   centerTitle: true,
      // ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: currPassC,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Current Password", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autocorrect: false,
            controller: newPassC,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "New Password", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            autocorrect: false,
            controller: confnewPassC,
            obscureText: true,
            decoration: const InputDecoration(
                labelText: "Confirm New Password",
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.grey.shade900)),
              onPressed: () {
                if (isLoading.isFalse) {
                  updatePass();
                }
              },
              child:
                  Text((isLoading.isFalse) ? "Change Password" : "Loading..."),
            ),
          )
        ],
      ),
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
