// ignore_for_file: unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:absensimaps/controller/login_func.dart';
import 'package:absensimaps/pages/Homepage/controller/BottomBar.dart';
import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:absensimaps/pages/Sidebar%20Profile/Controller%20Profile/controller_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final pageC = Get.find<PageIndexController>();
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            "https://ui-avatars.com/api/?name=${user['nama']}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
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
                  ListTile(
                    onTap: () {
                      Get.toNamed('/updateProfile', arguments: user);
                    },
                    leading: const Icon(Icons.person),
                    title: const Text("Update Profile"),
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed('/changePassword');
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
        index: 1,
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
      // bottomNavigationBar: ConvexAppBar(
      //   style: TabStyle.fixed,
      //   backgroundColor: Colors.grey.shade900,
      //   // ignore: prefer_const_literals_to_create_immutables
      //   items: [
      //     const TabItem(icon: Icons.home, title: 'Home'),
      //     const TabItem(icon: Icons.fingerprint, title: 'Absensi'),
      //     const TabItem(icon: Icons.people, title: 'Profile'),
      //   ],
      //   initialActiveIndex: pageC.pageIndex.value,
      //   onTap: (int i) => pageC.changePage(i),
      // ),
    );
  }
}
