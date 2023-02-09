// ignore_for_file: unused_import, avoid_print, prefer_const_constructors_in_immutables

import 'package:absensimaps/controller/login_func.dart';
import 'package:absensimaps/gak%20kepake/auth_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  // void signUserOut() {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              // ignore: prefer_const_literals_to_create_immutables
              child: Column(children: [
                const Text("Ini Landing Page,"),
              ]),
            ),
          ),
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixed,
          backgroundColor: Colors.grey.shade900,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const TabItem(icon: Icons.home, title: 'Home'),
            const TabItem(icon: Icons.fingerprint, title: 'Add'),
            const TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: 1,
          onTap: (int i) => print('click index=$i'),
        ));
  }
}
