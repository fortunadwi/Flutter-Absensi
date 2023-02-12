// ignore_for_file: unnecessary_string_interpolations, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:absensimaps/pages/Update%20Profile/Controller/controller_update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import '../../Homepage/controller/BottomBar.dart';

class UpdateProfileViewUser extends StatelessWidget {
  final pageC = Get.find<PageIndexController>();
  // final AsyncSnapshot<dynamic> user = Get.arguments;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // namaUC.text = user["nama"];
    // emailUC.text = user["email"];

    // ignore: todo
    // TODO: implement build
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("mahasiswa")
          .doc(user!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (user != null) {
          nimUC.text = "${snapshot.data!['nim']}";
          namaUC.text = "${snapshot.data!['nama']}";
          emailUC.text = "${snapshot.data!['email']}";

          const CircularProgressIndicator();
          if (snapshot.hasData) {
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
              //   title: const Text("Update Profile"),
              //   centerTitle: true,
              // ),
              body: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  TextField(
                    readOnly: true,
                    autocorrect: false,
                    controller: nimUC,
                    decoration: const InputDecoration(
                      labelText: "Nim",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    autocorrect: false,
                    controller: namaUC,
                    decoration: const InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Text(
                    "*You can only change your name",
                    style: TextStyle(fontSize: 11),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    readOnly: true,
                    autocorrect: false,
                    controller: emailUC,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(() => ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade900)),
                        onPressed: () async {
                          if (isLoading.isFalse) {
                            await UpdateProfile("${user!.uid}");
                          }
                        },
                        child: Text(isLoading.isFalse
                            ? "Update Profile"
                            : "Loading..."),
                      ))
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
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
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
