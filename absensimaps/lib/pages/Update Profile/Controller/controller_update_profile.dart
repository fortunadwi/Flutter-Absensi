// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxBool isLoading = false.obs;
TextEditingController nimUC = TextEditingController();
TextEditingController namaUC = TextEditingController();
TextEditingController emailUC = TextEditingController();

FirebaseFirestore firestore = FirebaseFirestore.instance;
Future<void> UpdateProfile(String uid) async {
  if (nimUC.text.isNotEmpty &&
      namaUC.text.isNotEmpty &&
      emailUC.text.isNotEmpty) {
    isLoading.value = true;
    try {
      await firestore.collection("mahasiswa").doc(uid).update({
        "nama": namaUC.text,
      });
      isLoading.value = false;
      Get.snackbar("Berhasil", "Berhasil Update Profile");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Gagal Update Profile");
    } finally {
      // isLoading.value = true;
    }
  }
}
