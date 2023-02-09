// import 'dart:ffi';

// ignore_for_file: sort_child_properties_last, avoid_print

import 'dart:async';

import 'package:absensimaps/controller/login_func.dart';
import 'package:absensimaps/pages/Sidebar%20Profile/Controller%20Profile/controller_profile.dart';
// import 'package:absensimaps/pages/Sidebar%20Profile/Controller%20Profile/gak%20kepake.dart';
// import 'package:absensimaps/pages/Homepage/landing_page.dart';
import 'package:absensimaps/pages/sidebar/menu_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

User? user = FirebaseAuth.instance.currentUser;

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  //
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  // final bool isSidebarOpened = false;
  final _animatedDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    streamUser();
    _animationController =
        AnimationController(vsync: this, duration: _animatedDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }

  void onIconPressed() {
    //
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      //
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      //
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
        initialData: false,
        stream: isSidebarOpenedStream,
        builder: (context, isSidebarOpenedAsync) {
          return AnimatedPositioned(
            duration: _animatedDuration,
            top: 0,
            bottom: 0,
            left: isSidebarOpenedAsync.data! ? 0 : -screenWidth,
            right: isSidebarOpenedAsync.data! ? 0 : screenWidth - 35,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // color: Color.fromRGBO(143, 148, 251, 1),
                    color: Colors.grey.shade900,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        const Kadal(),
                        const Divider(
                          height: 34,
                          thickness: 0.5,
                          color: Colors.white,
                          indent: 2,
                          endIndent: 4,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MenuItem(
                          onPress: () {
                            isSidebarOpenedSink.add(false);
                            Get.offNamed('/landingPage');
                          },
                          icon: Icons.home,
                          title: "Beranda",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 34,
                          thickness: 0.5,
                          color: Colors.white,
                          indent: 2,
                          endIndent: 4,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MenuItem(
                          onPress: () {
                            Get.toNamed('/updateProfile', arguments: user);
                            // print("object");
                          },
                          icon: Icons.person,
                          title: "Update Data",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MenuItem(
                          onPress: () {
                            Get.toNamed('/changePassword');
                            // print("object");
                          },
                          icon: Icons.key,
                          title: "Ganti Password",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MenuItem(
                          onPress: () {
                            SignOut();
                            Get.offNamed('/');
                            // print("object");
                          },
                          icon: Icons.logout_outlined,
                          title: "Logout",
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 0),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 100,
                        color: Colors.grey.shade900,
                        alignment: Alignment.center,
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_home,
                          progress: _animationController.view,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // ignore: todo
    // TODO: implement getClip
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // ignore: todo
    // TODO: implement shouldReclip
    return true;
  }
}

class Kadal extends StatelessWidget {
  const Kadal({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("mahasiswa")
            .doc(user!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListTile(
              title: Text(
                "${snapshot.data!['nama']}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              subtitle: Text(
                "${snapshot.data!['role']}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              leading: const CircleAvatar(
                child: Icon(
                  Icons.perm_identity,
                  color: Colors.white,
                ),
                radius: 40,
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
