// ignore_for_file: use_key_in_widget_constructors

import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:absensimaps/pages/Update%20Password/Controller/controller_change_password.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatelessWidget {
  final pageC = Get.find<PageIndexController>();
// class ChangePasswordView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text(
                    (isLoading.isFalse) ? "Change Password" : "Loading..."),
              ),
            )
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.fixed,
          backgroundColor: Colors.grey.shade900,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const TabItem(icon: Icons.home, title: 'Home'),
            const TabItem(icon: Icons.fingerprint, title: 'Absensi'),
            const TabItem(icon: Icons.people, title: 'Profile'),
          ],
          initialActiveIndex: pageC.pageIndex.value,
          onTap: (int i) => pageC.changePage(i),
        ));
  }
}
