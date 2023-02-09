// import 'package:absensimaps/pages/Homepage/landing_page.dart';
// ignore_for_file: unnecessary_string_interpolations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

RxBool isLoading = false.obs;
TextEditingController currPassC = TextEditingController();
TextEditingController newPassC = TextEditingController();
TextEditingController confnewPassC = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

void updatePass() async {
  if (currPassC.text.isNotEmpty &&
      newPassC.text.isNotEmpty &&
      confnewPassC.text.isNotEmpty) {
    if (newPassC.text == confnewPassC.text) {
      isLoading.value = true;
      try {
        //
        String emailUser = auth.currentUser!.email!;
        await auth.signInWithEmailAndPassword(
            email: emailUser, password: currPassC.text);
        await auth.currentUser!.updatePassword(newPassC.text);
        Get.offNamed('/landingPage');
        Get.snackbar("Success", "Berhasil Update Password");
      } on FirebaseAuthException catch (e) {
        if (e.code == "wrong-password") {
          Get.snackbar("Error",
              "Password Yang Dimasukkan Salah, Tidak Dapat Update Password");
        } else {
          //
          Get.snackbar("Terjadi Kesalahan", "${e.code.toLowerCase()}");
        }
      } catch (e) {
        Get.snackbar("Error", "Tidak Dapat Update Password");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Error", "Confirm Password Tidak Sesuai");
    }
    //
  } else {
    Get.snackbar("Error", "Semua Input Harus Diisi");
  }
}
