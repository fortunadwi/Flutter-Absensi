// ignore_for_file: unnecessary_string_interpolations, use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:absensimaps/pages/Update%20Profile/Controller/controller_update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileView extends StatelessWidget {
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
