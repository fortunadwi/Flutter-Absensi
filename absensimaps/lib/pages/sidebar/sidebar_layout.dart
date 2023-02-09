// ignore_for_file: unnecessary_string_interpolations, prefer_is_empty, sized_box_for_whitespace, unused_import

import 'package:absensimaps/pages/Homepage/controller/page_index_user.dart';
import 'package:absensimaps/pages/Homepage/page_admin.dart';
import 'package:absensimaps/pages/Homepage/page_user.dart';
import 'package:absensimaps/pages/sidebar/stream_role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Homepage/controller/home_controller.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SidebarLayout extends StatelessWidget {
  final pageCUser = Get.put(PageIndexControllerUser());
  SidebarLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: StreamRole(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          String role = snapshot.data!.data()!["role"];
          if (role == "admin") {
            // Ini Admin
            return Scaffold(
              body: Stack(
                children: const <Widget>[
                  PageAdmin(),
                ],
              ),
            );
          } else {
            // Ini Page User
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  PageUser(),
                ],
              ),
            );
          }
        });
  }
}
