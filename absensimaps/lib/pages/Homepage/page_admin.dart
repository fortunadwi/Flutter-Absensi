// ignore_for_file: unused_local_variable

import 'package:absensimaps/pages/Homepage/controller/BottomBar.dart';
import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageAdmin extends StatelessWidget {
  const PageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final pageC = Get.find<PageIndexController>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(218, 220, 255, 1),
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

      // appBar: AppBar(
      //   backgroundColor: Colors.amber,
      //   title: Text("Page Admin"),
      // ),
      body: FloatingActionButton(
        onPressed: () => Get.offNamed('/'),
      ),
      // bottomNavigationBar: ConvexAppBar(
      //   style: TabStyle.fixed,
      //   backgroundColor: Colors.grey.shade900,
      //   // ignore: prefer_const_literals_to_create_immutables
      //   items: [
      //     const TabItem(icon: Icons.home, title: 'Homes'),
      //     const TabItem(icon: Icons.fingerprint, title: 'Absensi'),
      //     const TabItem(icon: Icons.people, title: 'Profile'),
      //   ],
      //   initialActiveIndex: pageC.pageIndex.value,
      //   onTap: (int i) => pageC.changePage(i),
      // ),
    );
  }
}
