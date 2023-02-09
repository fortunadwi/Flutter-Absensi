// ignore_for_file: unused_local_variable

import 'package:absensimaps/pages/All%20Absensi/Controller/controller_all_absensi.dart';
import 'package:absensimaps/pages/All%20Absensi/View/view_all_absensi.dart';
import 'package:absensimaps/pages/Detail%20Absensi/View/view_detail_absensi.dart';
import 'package:absensimaps/pages/Homepage/controller/page_index_admin.dart';
import 'package:absensimaps/pages/Homepage/page_admin.dart';
import 'package:absensimaps/pages/Homepage/page_user.dart';
import 'package:absensimaps/pages/Profile%20Page/View/profile_page_user.dart';
import 'package:absensimaps/pages/Update%20Password/View/view_change_password.dart';
import 'package:absensimaps/pages/Update%20Profile/View/view_update_profile.dart';
import 'package:absensimaps/pages/Login/login_page_real.dart';
import 'package:absensimaps/pages/Register/register_page.dart';
import 'package:absensimaps/pages/sidebar/sidebar_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:absensimaps/pages/Profile Page/View/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pageC = Get.put(PageIndexController(), permanent: true);
  final pageD = Get.put(ControllerAllAbsensi(), permanent: true);

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPageReal(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const LoginPageReal(),
        ), // Login
        GetPage(name: "/register", page: () => RegisterPage()),
        GetPage(name: "/landingPage", page: () => SidebarLayout()),
        GetPage(
            name: '/pageUser',
            page: () => PageUser(),
            transition: Transition.fadeIn),
        GetPage(
            name: '/pageAdmin',
            page: () => const PageAdmin(),
            transition: Transition.fadeIn),
        GetPage(
            name: '/profilPage',
            page: () => ProfilePage(),
            transition: Transition.fadeIn),
        GetPage(
            name: '/profilPageUser',
            page: () => ProfilePageUser(),
            transition: Transition.fadeIn),
        GetPage(name: '/changePassword', page: () => ChangePasswordView()),
        GetPage(name: '/updateProfile', page: () => UpdateProfileView()),
        GetPage(name: '/detailAbsensi', page: () => ViewDetailAbsensi()),
        GetPage(name: '/allAbsensi', page: () => ViewAllAbsensi()),

        // GetPage(name: "/landingPage", page: () => LandingPage()),
      ]));
}
